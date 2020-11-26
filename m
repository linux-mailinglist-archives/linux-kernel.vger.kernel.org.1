Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA62C5982
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403971AbgKZQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391550AbgKZQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:45:44 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561E2C061A48
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 08:45:42 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so3019581wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=satiAp7q7vxp1zQmeNmE59ZD3HlYoTJcGcwpTzuEPC0=;
        b=fgliAF2Sz+QGPKBp4FiAzSvtfZOF7X/v9rcdOtzOseupTGyRIbwNAS4OUUle3/h8+l
         rk7N6gZ4JrwfofolDrrcTiS52Hrx8X6IEIM4b1cpxPNZafVYRM1E1LxRvOUN4y6/skLV
         yvw76LTXAJ3qK4WEUPs1J/Ff67cswZgDrv7z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=satiAp7q7vxp1zQmeNmE59ZD3HlYoTJcGcwpTzuEPC0=;
        b=eEkYCdbNXnc7goAhBBmE4JEFlYIY3CnjL2rD7S+Dtak8jv12SzHMNTc0brNF2BnQDK
         Z+cxpyxCyz6hnZO0mc2MXLTItmJjaXFHCrERha1y2yZbq1ma6k5cIoxViMhKg3xSU/gd
         JH4D/LlwXsr0NYgJcdwKYEVIdQONLZu8hiY/SNnxYxDsswdJEmuLfLOWMFHZHzuGdvdB
         6N1LQCDvoThH5n8aBoYBa2HVATlrn9CVhHDu3ZNCHjJU6M5Gw+27Hsj4/nJm43Iw2Acu
         wRp3AuSlZar/coO+hrKvonxXMHIkIoQh2hH5zSc9mxcEiXN/FZxEzC5oY321LV5zJEG5
         6KWA==
X-Gm-Message-State: AOAM5309E20Q8JgQCtrpDFymgJgDyb/mhOU1jcLpJc7TzfQzyogsOlc0
        QqAPXTr8J1SP0No+rfXrmudc5w==
X-Google-Smtp-Source: ABdhPJxro2BM0uV+9MCG3jYYWVG89Rgp+wglSySpeJeHg6JxH5CR3TLj4hTfoXxWpnJZJSyuO0BkBg==
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr4437025wmh.88.1606409141127;
        Thu, 26 Nov 2020 08:45:41 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id f17sm8805824wmh.10.2020.11.26.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 08:45:40 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 3/6] bpf: Expose bpf_sk_storage_* to iterator programs
Date:   Thu, 26 Nov 2020 17:44:46 +0100
Message-Id: <20201126164449.1745292-3-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126164449.1745292-1-revest@google.com>
References: <20201126164449.1745292-1-revest@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iterators are currently used to expose kernel information to userspace
over fast procfs-like files but iterators could also be used to
manipulate local storage. For example, the task_file iterator could be
used to initialize a socket local storage with associations between
processes and sockets or to selectively delete local storage values.

Signed-off-by: Florent Revest <revest@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/bpf_sk_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a32037daa933..4edd033e899c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -394,6 +394,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 	 * use the bpf_sk_storage_(get|delete) helper.
 	 */
 	switch (prog->expected_attach_type) {
+	case BPF_TRACE_ITER:
 	case BPF_TRACE_RAW_TP:
 		/* bpf_sk_storage has no trace point */
 		return true;
-- 
2.29.2.454.gaff20da3a2-goog


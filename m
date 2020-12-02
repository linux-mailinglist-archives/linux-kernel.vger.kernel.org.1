Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F6A2CC874
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbgLBU5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgLBU5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:57:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9748C061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:55:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g14so5505551wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4beLIa3KJ8+MUkP/0+ZlqhuHQAr4Y2kV+lpaUplNzE=;
        b=e+PPU1x0oI1ydxbhlMsNEEWpMzZy+NBUCct8cTNT47jwZfmkBcR00W2FIeVEZC/t4Q
         EBOXpVe13FBkxnKrGaQvlGYPcT6fMO5Cz6Cd09yWDt/L/1dpXHQG/ZWKJ2Feovzb1uWr
         uJQs+7TcBo9I0GNsyVBnn0fC38wB2/uL2JR+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4beLIa3KJ8+MUkP/0+ZlqhuHQAr4Y2kV+lpaUplNzE=;
        b=pcglqJbYn94DvG1jANhSunVKHpv8H/2LK/Q2UeWyVsliiLsILclFRSY8mC4ZclTzAK
         s4vVBAf399qSoxuLgMT6KL7iImvRgvwKh0k3Vl/qQlIXdTjPUEb2QXDM6gq8NAN0F4cz
         Z9EP0N8cddPowU6X+mY/T3xr4I9m5kY10j7MYjSFwbH6rMd3SAnqTa47WoxhvOZAOalp
         V+X7Cl7pJ/eE4ifcWxMyxaUG42LmzN0MzBs0XxHnaLKYoc3OH1yat8qTE9UyQmAk5flg
         VosMNlPDszX0xWlZ9AvE9v4EoUq2hlKHzhJ9UHJKkiFX3mJKakLnjSawoqU8tywmLDU8
         cU4w==
X-Gm-Message-State: AOAM532pMMoEryRBPMocUmQ6q0U2wfqgkb+2LhiquGhwaSGZIs8xvMRp
        1BiWnuF2aAKsnrEJqWtg2R0otQ==
X-Google-Smtp-Source: ABdhPJw2S8DkFi9xJHuGpcygik9qGwFOKDt2nDTyCfPY0UXodM1/fRNXpZLIP6cLRjuyPFRnt6AxPw==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr5848300wru.260.1606942551727;
        Wed, 02 Dec 2020 12:55:51 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id d2sm3438486wrn.43.2020.12.02.12.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:55:51 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        KP Singh <kpsingh@google.com>
Subject: [PATCH bpf-next v4 3/6] bpf: Expose bpf_sk_storage_* to iterator programs
Date:   Wed,  2 Dec 2020 21:55:24 +0100
Message-Id: <20201202205527.984965-3-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201202205527.984965-1-revest@google.com>
References: <20201202205527.984965-1-revest@google.com>
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
Acked-by: KP Singh <kpsingh@google.com>
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


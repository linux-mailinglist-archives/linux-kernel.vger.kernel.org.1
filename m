Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17802A8A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbgKEW6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbgKEW6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:58:34 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF06C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:58:34 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w14so3594151wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=AfUyQ0GCER1kiz7y6Er5a1XrBzRmWwQCRun4Q/B9r1TDkD2nUEKBjTGy1TPuorkFl0
         A7uaOrPmRVGcBIOh/PdHDQ0IIzPmTh0CI8qQj5+5Vtb1Ey5bnQo3alrLKWw9/WneLLiH
         jT6fUjsyzTE6pnSt9h21AStcAzVSyyplBxSTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=ugwkz6eCzkKbIrn+hO467nm8+jm+JTQhVIxJ7+1Z9Wm9e2ekW0feFazvOftV8TAjWY
         tLsyVJ26oc4VpNex0VfnYQeNpGPWBPVIbUDLJyYTnPFDoAubUU+8Q0p8Tfeq/trghjAG
         cCKyk29uZ9mIqqW+k/eIxAF6/Pc3so5h/BUJD8XAJJH/qbVXQUzDE36QeLfPV8iimNe3
         q9OrC/yVhWEXq5YXzBl4D1d0wXGieI7y8Uvq+dCE2LX250ocDj57q3AAQ2tn+LsaGViM
         OylwQIbUu8nm8bKYhjFmKA85igGzkbU8HW8+p49lkw57PAimUgaM2WZbxWd4p1yKIn8r
         XJqQ==
X-Gm-Message-State: AOAM530H/UWPg/JS1n+XGC9nDnR0TCWMj5pEnQNXq9Vm0CrS4W9KkqdQ
        P0aJvZhfhdbnzMULt6TlE2TRj0kw14Tsks7d
X-Google-Smtp-Source: ABdhPJyjHaHvfqN5Y2NQXokSE81fyWCQfq4G9DExZPFwX3NWsRso7D5U9KJBjPOH3fh/6tf0ePei2A==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr5487937wrr.343.1604617113044;
        Thu, 05 Nov 2020 14:58:33 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f19sm3977366wml.21.2020.11.05.14.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:58:32 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v5 3/9] libbpf: Add support for task local storage
Date:   Thu,  5 Nov 2020 22:58:21 +0000
Message-Id: <20201105225827.2619773-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105225827.2619773-1-kpsingh@chromium.org>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Updates the bpf_probe_map_type API to also support
BPF_MAP_TYPE_TASK_STORAGE similar to other local storage maps.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..ecaae2927ab8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -230,6 +230,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.1.341.ge80a0c044ae-goog


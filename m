Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA62A948B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgKFKia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgKFKhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:54 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2252C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:37:53 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so894204wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=j/C2zcYC4D+GfLAzIhkvRR6L8uPmphnnzDvPzLQqul0mdudVnCKPs+1Iw/lcztSu/u
         ehSnM1Y1dlPRi1V3+rCJtl6a4bRayalim8Q84El78bG5UPxlGowvU8s+KsEaDy+B9CYY
         WTNlI+86Rcs/FiRdn3tS4dmaepXXPMG4doBlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=AZjmickgn1iYRCvYvTgfq04qOqT2zI3+JGI4UpXW3F9BtkyK6mBPQK4kV+o3/7g7Es
         edA2cFyoBl5rEbSuHyae0ouhL31h2Tg7RvEEyJt64IaMi4N9hf++4Fa812pTI9psZWPO
         GU/6aF2N0zWH5FkU1qHGThTkIGMlQ8kpsDD7uRuxdwGrO7+fcgC2QRqXZ+8Hxmcr4E4m
         ak2ciSaNiKd2zjBKHXxEMGDtkNbj0Y2nMfqYddv1DM4+zewr09zV77S6TMF3HOesWhpS
         HwwRiRT8kgqa5OaBK0oIZs2e0GimhZdWKN3bSYlNvLtX5HZuxVAcokwAD5h0SUEzc85s
         B83g==
X-Gm-Message-State: AOAM532WHMDfV1WRp8gy2ixPG4W0iXaWCcAht/U6puQf7vYCYi3d2t2F
        ibgj9Guld8Ns09CGgnc+nVE6VNfaFFtnKMxT
X-Google-Smtp-Source: ABdhPJxqxJxJ05Nq1CUl1iDZ+iYqb1g80guta6CJa2B4QY+4vCFDZ4/oMFjb34vtf7/N8tL0/rreQQ==
X-Received: by 2002:a1c:2108:: with SMTP id h8mr1716760wmh.63.1604659072052;
        Fri, 06 Nov 2020 02:37:52 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:51 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 3/9] libbpf: Add support for task local storage
Date:   Fri,  6 Nov 2020 10:37:41 +0000
Message-Id: <20201106103747.2780972-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
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


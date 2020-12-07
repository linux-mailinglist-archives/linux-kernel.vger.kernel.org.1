Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429FA2D1A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgLGUHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLGUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:07:03 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E2C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 12:06:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so14008950wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 12:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZY6PnXSHmnL1clMEjidFbJWKwSKFrnJjIARjAjV0kbg=;
        b=b+meLkYgvmiATHtHLcWUsdmN0/mHnVCOxiHjWZHNuyFjU3/PY+INCbBCbNkm5IJbCH
         mNSCVoYGRJqnLv+bysls9E7m60/hzpqZH1SarTqhaOIX1DjJdbRpz4nfIQ3vxFejr9IC
         4iIhBMXCvWGi5+sITzyzL44c5z9cfd6D26JzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZY6PnXSHmnL1clMEjidFbJWKwSKFrnJjIARjAjV0kbg=;
        b=k/woXbf6vNUuOAxYyhkCaKwII6IFscO0sHyqbKLrONZ/v4IxKJO5mP2zcnSIdrsPZw
         vQaVxMkHPQn492cpvSkcDEYw/dvf4oMrDleENSRSeyWw0AzN6MISosONIHlTRv61iOPc
         FUuEaZLf15ZfyHGAGREpNIAjolXoXUZvtZzLy2NM8s0yZv8HaUmq9p/b2YcoWHtGb5Wm
         RUMvBPK6rZL0t6FKs4JdV/i4BUY4a3/XEuHgio9KuJkKltv3fpz1FQQtbz6o+HnYzNVT
         Swowe1GJaKn7APS1jYcdN9EBkbK+yTNMR1Wq7KN1id1yglxuB7efK7p3Gun+8tOe6IVw
         Z9dA==
X-Gm-Message-State: AOAM531ruHF/VZ8jBQBcgZIt/qI7Ofs0dQ4USM+ga9HLvsDehwQNdW3S
        Qga5N0MJuCLRiKjlFkwp7Dfv4w==
X-Google-Smtp-Source: ABdhPJxOTR7AmaDvUsAyDUxKnDlaqCuaYmt3uGcpEHsJb7fK9T+mjbkJ7bKRTyaGXCDlkqpnzKZyFg==
X-Received: by 2002:adf:eb08:: with SMTP id s8mr21529516wrn.12.1607371576062;
        Mon, 07 Dec 2020 12:06:16 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id m4sm9863145wrw.16.2020.12.07.12.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 12:06:15 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, rdunlap@infradead.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2] bpf: Only call sock_from_file with CONFIG_NET
Date:   Mon,  7 Dec 2020 21:06:05 +0100
Message-Id: <20201207200605.650192-1-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids
  ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
  bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
When compiling a kernel with BPF and without NET.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0cf0a6331482..29ec2b3b1cc4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1272,7 +1272,11 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
+#ifdef CONFIG_NET
 	return (unsigned long) sock_from_file(file);
+#else
+	return 0;
+#endif
 }
 
 BTF_ID_LIST(bpf_sock_from_file_btf_ids)
-- 
2.29.2.576.ga3fc446d84-goog


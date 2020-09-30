Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0727F459
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgI3Vqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgI3Vqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:46:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EF7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:46:46 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a3so4218203ejy.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=39+8RWVqTuiI4YbhiNQA70SbucYKvdxenXv8hFTp1HA=;
        b=V5CB/+LOsnfXawz2Sm4PJvs3LO5gnsrkEtbG1UZh8QrpqrOvrXVz0YIw1v+Vaa4XPF
         AzjR3pGi/OypMuxRr89e9CMEaaf3d9oUUDXQDU1PGfZkdpeaQuv1ZBV7f0Fk5GOyZ0rg
         2TYWp/B4sJl0zJFkcLEF1RGiTnavDWkonI+DQwWYOmzQrUTHpzIWc2NkbaO9seuDgjox
         NBZ4oWdCahkQrCeL9vx/Pmd7LQJwA+VtuKRS2UqQlmlUpq2i2wS6/BMr0WHW/Qd+mebg
         8mW7sGHOjK2l36pV2X8N5BTGQvOCPc7Tuu9ndtw3a9LRmFIb5X+XQDKoA3OhBlZWlH7b
         rrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=39+8RWVqTuiI4YbhiNQA70SbucYKvdxenXv8hFTp1HA=;
        b=BODSKKtkSwX3SPkgRNYEzLunrcMJxGTV3NaYjmRHnRipiGWHAUXc2OLFi9Nda4lMS+
         kyHETg5whFfUjJsvFY1rqlTNzoySKd6h1DyDW+idvPPKoxVZZv1D6G2A4dYLHwBJGAkQ
         r8SCclYMB1e4JD30iGJNiSSk2FhlAOOOG29aU+jHCKv3M75giINiy5zlzfSU4MGLFXGr
         68+YUV2KckoZohD7FUCwoJLfm6c9H7f9pjQdGYusDE+/8+dxuPvw76BWlW1D1i/iGO2M
         J+7scDYozq1LnbaSTJtNZCkMNfgJTa0mepM5c/HrUWEXWqlPfqiP4NvnhfhW584JXW7m
         Zlmw==
X-Gm-Message-State: AOAM531uVBeaNabZZU4rHHgHN1VLdEIOfBBOUlixFer1By3PEZib1cNR
        gbcLDJBsWdb29RLfaEUIu52JlGWKJ1uzSQ==
X-Google-Smtp-Source: ABdhPJxCevERVTVerZpNwXvM6hNFRcCcPWecPa1l2DZNLGuQX1euHwtRP8Tsyvm12RNKLsOrSkQxfg==
X-Received: by 2002:a17:906:2ac5:: with SMTP id m5mr4928287eje.210.1601502404725;
        Wed, 30 Sep 2020 14:46:44 -0700 (PDT)
Received: from localhost.localdomain ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id c5sm2418383edt.24.2020.09.30.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:46:44 -0700 (PDT)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>, musl@lists.openwall.com
Subject: [PATCH 1/1] linux/sysinfo.h: Add guarder for struct sysinfo
Date:   Wed, 30 Sep 2020 23:46:36 +0200
Message-Id: <20200930214636.186132-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for all but glibc libc.

This fixes redefinition on MUSL which also defines struct sysinfo when
including <linux/netlink.h> (which includes <linux/sysinfo.h> via
<linux/kernel.h>) and <sys/sysinfo.h>.

glibc loads <linux/sysinfo.h> in <sys/sysinfo.h>.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 include/uapi/linux/sysinfo.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
index 435d5c23f0c0..c8ab18cd36b2 100644
--- a/include/uapi/linux/sysinfo.h
+++ b/include/uapi/linux/sysinfo.h
@@ -5,6 +5,8 @@
 #include <linux/types.h>
 
 #define SI_LOAD_SHIFT	16
+
+#if defined(__KERNEL__) || defined(__GLIBC__)
 struct sysinfo {
 	__kernel_long_t uptime;		/* Seconds since boot */
 	__kernel_ulong_t loads[3];	/* 1, 5, and 15 minute load averages */
@@ -21,5 +23,6 @@ struct sysinfo {
 	__u32 mem_unit;			/* Memory unit size in bytes */
 	char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];	/* Padding: libc5 uses this.. */
 };
+#endif
 
 #endif /* _LINUX_SYSINFO_H */
-- 
2.27.0.rc0


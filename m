Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645AE2AE3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbgKJXCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKJXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:02:37 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F38C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:02:36 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s30so519417lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNsAfjoum/ECMnsGE64A54uy2y5Ui6ws81Td7nOjh3M=;
        b=JRj8+DFCH8RhrpArNUqCqUWr74HQkgGurc5nLjU+kRzJyhBUdEGtPixxiwIfy4pFep
         PbbJZbs3lbcE9Ev29ZzYBeTpZJwHzUmBb+CtbSzvV2er3ZQw2EwDPpdweoW0nHh+Uxr2
         OCFqCiQUdjHnpAnw8lFsY2tmcjcWiCskfdzjx23h1L8MFy1sRRYrx0tjjV3/l+umx1So
         yEmWsEfUBV9bBdpno4tFrQPdFGS+Tt/OCUo5KY2xOh9uB0nfqaXVj/kKczxoUIzk9g1j
         o+ivQ+1lOiF8VVpLkTXDYmVwQ4SMn0G+bneoAutFulNNdPHyCfyDzoNbEGzm5L3h1a31
         FZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNsAfjoum/ECMnsGE64A54uy2y5Ui6ws81Td7nOjh3M=;
        b=RLCAS77POyUcRH6Iq2MsixuPIA49CjCS7aWSgQKjfstNLgQkSX3eeosicTeb/S08uK
         pLV6AOxs0wHa3mLBoYtjdKtQ6nczYRTDxfQMaZeW96/FrhDthE53ZBzppB3M6WKmJ9fY
         P0jCh4aApOBMDPpx8FvufnZRBcIVoCZBKsqCsLpRn3+adWoS/3ilHnoN7Z5xSkCLZ6Gx
         N/+d6sxZHPCS76O87QHzmfGwLDRdbVAM1tX0LzFWoXOK9/j9+JdayM4yopzw5KR+JzWe
         YFStgyIYVSLZCmmQF66fNdYw57PuImMXVoId2SmL+8FDfUM8rl1UQyOTCr0qEm+Jyfxt
         sU8g==
X-Gm-Message-State: AOAM530WALCg2BFLDWJDhaTPeovxAd6syJO+L5pSh6cykf7jeJ9qqYgS
        u4wPfsTiKS0RsfO4+SK/XCQ=
X-Google-Smtp-Source: ABdhPJzIy9ipxUgFn024urGqgPqRV4rxO6TrHwOTocboFF7Ajd2VviZcwCppnrXQuawq5pnvUbpCYA==
X-Received: by 2002:a19:e059:: with SMTP id g25mr6560702lfj.584.1605049355344;
        Tue, 10 Nov 2020 15:02:35 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-149.NA.cust.bahnhof.se. [155.4.221.149])
        by smtp.gmail.com with ESMTPSA id u9sm30780lfu.54.2020.11.10.15.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:02:34 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] x86/resctrl: Constify kernfs_ops
Date:   Wed, 11 Nov 2020 00:02:28 +0100
Message-Id: <20201110230228.801785-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of the kf_ops field in the rftype struct is to pass it as
argument to __kernfs_create_file(), which accepts a pointer to const.
Make it a pointer to const. This makes it possible to make
rdtgroup_kf_single_ops and kf_mondata_ops const, which allows the
compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6cb068fcf501..5540b025880c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -264,7 +264,7 @@ void __exit rdtgroup_exit(void);
 struct rftype {
 	char			*name;
 	umode_t			mode;
-	struct kernfs_ops	*kf_ops;
+	const struct kernfs_ops	*kf_ops;
 	unsigned long		flags;
 	unsigned long		fflags;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index af323e2e3100..78dcbb8e0172 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -240,13 +240,13 @@ static ssize_t rdtgroup_file_write(struct kernfs_open_file *of, char *buf,
 	return -EINVAL;
 }
 
-static struct kernfs_ops rdtgroup_kf_single_ops = {
+static const struct kernfs_ops rdtgroup_kf_single_ops = {
 	.atomic_write_len	= PAGE_SIZE,
 	.write			= rdtgroup_file_write,
 	.seq_show		= rdtgroup_seqfile_show,
 };
 
-static struct kernfs_ops kf_mondata_ops = {
+static const struct kernfs_ops kf_mondata_ops = {
 	.atomic_write_len	= PAGE_SIZE,
 	.seq_show		= rdtgroup_mondata_show,
 };
-- 
2.29.2


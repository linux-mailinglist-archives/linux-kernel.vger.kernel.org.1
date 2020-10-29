Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506DD29E48B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgJ2Hlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbgJ2HlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:41:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34A9C0613CF;
        Thu, 29 Oct 2020 00:41:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c20so1631359pfr.8;
        Thu, 29 Oct 2020 00:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Vpp+HUKX2G0CTRBW0THMyJXaRX90+/dwTILuzGEDZE=;
        b=RFrm1H8IQ/Ka9gT1ihvecXKUFg7s3ojEEHzdRnvfvM2oNlfjqHET5WldQJI3rstPAV
         Bp2f/KDX6pOser3HhHFx/0q+zInOPMSceUe4DTMk68/zIiBi/YaYXxaSvoT9aT8aOEEG
         uG3ee8f1etjIwERawtfdM6YkdNoLbKZF02YzrGyFROMm5dXf11ZhFqdTqT4vAg6lx4We
         GdRnszuyn77fKrn2PWnb9NNN0zkXIih7I4TN24zzQL8WtUmOpTxD82XT49nwkX2MpVge
         VSpLQVZRTrr1mkHUCJu6DrX6z97CYbRv+VQZji5IjDlGgIHtZKH9s9kRcee+QcRG68kD
         Dx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Vpp+HUKX2G0CTRBW0THMyJXaRX90+/dwTILuzGEDZE=;
        b=epS8Dhmt9jZyjoM2rhumd5mLderdZU862otUl8vHcvgmR1cy9/tfc7C9oxdLMpkZ5F
         OiqOKE//WB8sgbNp/zFQ8XC8o9HY4W4atJCjVwMmeCZeRlU5iALDpAE7IPHmUrkY+bHB
         4kLiqj20kOfWmDLEUhfZ9KaSXfuvadw1bn3E7wSmbmBh1YrDrb2Ojtt+/XKW6fgEPHyp
         fkaxaf8jpHdCq/qLSkfc74ZOayhEeriUOtvc1/2kSN6gi4YPBD61KWAKz8e2UQqeZdqh
         gq5fNkd/GHDK89AcKiDqFMMoM5rETGE374r71Q8QfwuFnSZcWAeUgjnmWVNRkKP661E+
         pYWA==
X-Gm-Message-State: AOAM5314hpD2ryLIQi6UOD/g1jLfHa0yWs112XVVkcVSapHO4xc7cJhy
        EQPR7rbXKjmjs/y7jVZdHS0=
X-Google-Smtp-Source: ABdhPJwokR+l+q7fMl6idL8y936Krk+diLmOUCh7zQvKxfOMJfWByZEOUIKAP1hJd1KgPETyazdxtw==
X-Received: by 2002:a63:e513:: with SMTP id r19mr2860126pgh.309.1603957278485;
        Thu, 29 Oct 2020 00:41:18 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id bx24sm1812198pjb.20.2020.10.29.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:41:18 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andy@infradead.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS -
        ARCH),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] power: supply: olpc_battery: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:41:00 +0800
Message-Id: <20201029074100.225806-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 85f4638764d6..716eefd735a4 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -192,7 +192,6 @@ static int xo15_sci_remove(struct acpi_device *device)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int xo15_sci_resume(struct device *dev)
 {
 	/* Enable all EC events */
@@ -204,7 +203,6 @@ static int xo15_sci_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(xo15_sci_pm, NULL, xo15_sci_resume);
 
-- 
2.28.0


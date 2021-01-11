Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D222F1880
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbhAKOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbhAKOme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:42:34 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F3C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:41:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x18so9625560pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYFu24nVYvY+pIKwPceOfPrlJQ1+zx3VFGQdb0xO/D4=;
        b=hrXEC8niJgIPUBf1S9ho8fcxf5sX6HiadQIfNv5/dkHAAycD+47j23b3n6QW/XWZJH
         CIWJalLDkwrhh7jNKaK1ZR6rzwveg/A6232Euf7Zge/KUnCZ1ZUmF9q19enwTUTheLw0
         rL/huU6feFjZta2Dj2OqwrOW1/iM90c/27LKeopxWdMmciGRwgUM61IZpeYa//1hZaxS
         5/Yu6B+9pkEVrickr78LcNAmMwaO0OWK/8vLgMOsBs0Rc005WzTgZZjxrAluWKracrqK
         waBm0fJRIOIUGvR5BEY9/rrBWDuOjzBT3XrRSPfxGLo/UReR0SxCtYZ25swuNkNOzZrH
         qvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYFu24nVYvY+pIKwPceOfPrlJQ1+zx3VFGQdb0xO/D4=;
        b=F9bElh1MpR5z9OrUZwO6AbG54x3PAr8l20qdNov+nhKO0tNhH8Zz4NPt2+zYMRd6XL
         PMovfv+Zplh0g3YPdp2G55JOhOQc9M1LkZzyRXNnTJ3ZTma6U/6KSJUqjmQD+geVbq5b
         kOdOUpjPTtCshndGl7FRXck1Bqowx6ylH8s8LvruwWfABtxVxrxnXETi2Wb/Tx1u1hS5
         6gVd3hBcMl9C24a33XBBxNRiyQc9dCmV5DCPZ79YM5MfU0c/HFqdfGkG3Rppypmd76nm
         XevnF2O4b92xtRpj96nQ+s0ONqjEyyaAPf2DNDhy0pWDhXmh1mwBq+J+b5gNedmsj6/K
         DcwQ==
X-Gm-Message-State: AOAM532ML2NNRJGVp8+bmTYGnGg2SCikJRJnpTgJM5ehQHUqygUUlMxS
        vQpOL2FPXEqxO7hlKbWuHeY=
X-Google-Smtp-Source: ABdhPJwjCK64tzC9T8mUkvCb0CVi/573TEsrZgU2Xo+voxaE5OOJhZrvCC6YMrxYeoEtafLZZQp+yA==
X-Received: by 2002:a17:90a:7e90:: with SMTP id j16mr18101965pjl.163.1610376113760;
        Mon, 11 Jan 2021 06:41:53 -0800 (PST)
Received: from masabert (oki-109-236-4-100.jptransit.net. [109.236.4.100])
        by smtp.gmail.com with ESMTPSA id p3sm18594950pjg.53.2021.01.11.06.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:41:52 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id 7D51D23603FA; Mon, 11 Jan 2021 23:41:45 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, kaloz@openwrt.org,
        linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org,
        linusw@kernel.org, khalasa@piap.pl, linux@armlinux.org.uk
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH/v2] ARM: ixp4xx: Fix typos in Kconfig
Date:   Mon, 11 Jan 2021 23:41:41 +0900
Message-Id: <20210111144141.387064-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <5581e105-3967-c9b4-cb2c-12640eb1a2c8@infradead.org>
References: <5581e105-3967-c9b4-cb2c-12640eb1a2c8@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/arm/mach-ixp4xx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index f7211b57b1e7..affee2e0ff55 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -7,7 +7,7 @@ comment "IXP4xx Platforms"
 
 config MACH_IXP4XX_OF
 	bool
-	prompt "Devce Tree IXP4xx boards"
+	prompt "Device Tree IXP4xx boards"
 	default y
 	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
 	select I2C
@@ -115,7 +115,7 @@ config ARCH_PRPMC1100
 	bool "PrPMC1100"
 	help
 	  Say 'Y' here if you want your kernel to support the Motorola
-	  PrPCM1100 Processor Mezanine Module. For more information on
+	  PrPMC1100 Processor Mezzanine Module. For more information on
 	  this platform, see <file:Documentation/arm/ixp4xx.rst>.
 
 config MACH_NAS100D
-- 
2.25.0


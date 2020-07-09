Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60721ABC9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgGIXsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgGIXsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:48:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53426C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 16:48:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so4060915ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4xu/k9KIUZy/F6SCVHcHGIjUpI7dLkyDH+p59q0O9WM=;
        b=vZUhq/Z4uZvslDYIAquT+iNsmF1DpdZK2XMlkWehxx6gmbNDOUQDUSeY5jzYOpYfE6
         1KvvnHRk8Hf6Sydug+levQZeaA7x1dqrxjKwiAnkV4po3alJoSmR+1TqXuq5R0uJ5nfn
         4WzfNNxOP2aFN8/hWuecfvF6PhDEjXXFtgy9W98YqzT4rxAaTKib642tOvvj2ovvOdjF
         f/OWxp9GU8GmK2daZ4z/+hGTopbImIbsV3mWGm3h9AefDufwgZ4kj5cCziyc3O59j2R1
         XLuIjqKiAs2LBoyTqWEd9ZEOOuxasDwcn8W8Ksi+8rpM0r/gHkEPanpbOa0XaAYyH4OJ
         suEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4xu/k9KIUZy/F6SCVHcHGIjUpI7dLkyDH+p59q0O9WM=;
        b=bRQR2bLQCWMV2xtwK48/x8IkWlu2zATuxEBQRM2/4o/gShX4JwvfGGZUph2lQSOJR0
         2agqMYbDTKEMQeaHuo8Li8NGCKya9Ju4SO1PkCd9e7ghdIu9AFI6i4uNLRnG5SwWE0HG
         alH6Dy87MZLBc1r+459dtVH1UClzJjyZILOJb5ZzBEJ7EoYGw87D1L/WP3Qlxg5bjjom
         U9JlXlnuE422goOZL0iQolM93TjJ27hSLTYRtT93gLgWhp6vAojf4TFW9+ElrYCIqpWo
         dbtrUvgyX1rZS6XlHVbH4lhG6xv8XPcaJafTl6tCOsiebEjnA+eBwpt2gcR2OfuRrBJw
         lgfg==
X-Gm-Message-State: AOAM532K4S0C/aPLJtEn+qcxq9x9E0jwIr3DtGBZHfTMh5hUbqKBJDB0
        fcF/2rDRUprEo+pMmTpmvOE=
X-Google-Smtp-Source: ABdhPJzZKQVNqdGfySAXmjjI14KqFO2pZ+lN9NOmBQY5T6A42NwmOA6yf/BXIyuPxngBexv1BMVPfA==
X-Received: by 2002:a17:906:2e83:: with SMTP id o3mr55641867eji.261.1594338489042;
        Thu, 09 Jul 2020 16:48:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x19sm2874426eds.43.2020.07.09.16.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:48:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: bcm: Enable BCM7038_L1_IRQ for ARCH_BRCMSTB
Date:   Thu,  9 Jul 2020 16:45:56 -0700
Message-Id: <20200709234557.5380-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_BRCMSTB makes use of the irq-bcm7038-l1.c irqchip driver, enable
it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 6aa938b949db..52ce6febf6ea 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -207,6 +207,7 @@ config ARCH_BRCMSTB
 	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
+	select BCM7038_L1_IRQ
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
-- 
2.17.1


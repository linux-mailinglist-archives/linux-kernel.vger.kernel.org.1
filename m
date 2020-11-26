Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06EE2C5158
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgKZJgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgKZJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:36:32 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF96C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:36:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so1405913wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VNTdg6uSFyVYv0FKJ+yGxhaNjehS8G/rV5edZ4pYTiI=;
        b=pZuWw9w7rVcJMYBmZ/6gy0ZUhOd7j0c3RHq1Vd9a/HHbmMPrN4jIXdpxJmJwobp7GC
         mxURWBCirtUl0coDUoUCJiV7iHFodMnYSUcolj+eGBvv8j/EUKM/bY/rIaBSrlIiAJz2
         oRWGH/Jf3MlaHfvJTtWEKaLIBKuz6tBhffVMYVcuh/rCdame0rDgv0389MA0gZqKzfiS
         S+SW72FQs+e8NDdfEGGPlFrSCc/OI5R01K2KDIqgCU5s5Ha5N2OgGw4r/EUll57tnJnr
         vFeTY2axQtcOgpmQLaTFZuUxyI+mzZjmln+OhrdmUSRyRji3Mnk3rRBukxnFuiM2xKu7
         s7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VNTdg6uSFyVYv0FKJ+yGxhaNjehS8G/rV5edZ4pYTiI=;
        b=DFaB1MAnDinvaTc1otcK3c02ugfk2uGp3ll2FFJZ5r8kHYjhTV1GwJIzzO8H/TyOH0
         zEGfMKzy2lQhbxgbL+boW9hqQWT5TvZYZ5/FeD5quORlHQSrIALwDP1a1SHChy3ThMdK
         Bt5aGLn+yjYT4x/mDPHbedb8B27h6dZoNAzxzi6d69SzcW7txh1nIEr78OZW5V5xC2a0
         ZEE4Rz1zmOQIT9SY7OkPj6DXOLrY2VTBlMGv7CmJi1N5tKSTWS6S0rTJEvjttJmszifB
         puDyVM6iUeSOtGTncs0pKk+z8keJX/BVqZCLbAMt9he8Ht3mgMpvPs4q/pWpyM5XG1Kw
         5+bg==
X-Gm-Message-State: AOAM533R1ELeWjIuRN4ThPsDUyAkZpFji20tlIldW3k3ycJpOSvFRvfX
        D4MqPfONRRHIXXKIjDOZqi+PCROhmxlo+ZBd
X-Google-Smtp-Source: ABdhPJziLLHTjlCheIGft72jKItK/SD8v+6hBiWGcPZzZbG7sP4TLb47T4jUL8kvroQiNBktUNxGXQ==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr2773267wru.260.1606383389033;
        Thu, 26 Nov 2020 01:36:29 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id o2sm8102710wrv.4.2020.11.26.01.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 01:36:28 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:36:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 31/36] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's
 prototype to shared location
Message-ID: <20201126093626.GC2455276@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-32-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104193549.4026187-32-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for ‘hvc_vio_init_early’ [-Wmissing-prototypes]
 385 | void __init hvc_vio_init_early(void)
 | ^~~~~~~~~~~~~~~~~~

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---

v2:
- Removed 'extern' keyword

 arch/powerpc/include/asm/hvconsole.h     | 3 +++
 arch/powerpc/platforms/pseries/pseries.h | 3 ---
 arch/powerpc/platforms/pseries/setup.c   | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/asm/hvconsole.h
index 999ed5ac90531..ccb2034506f0f 100644
--- a/arch/powerpc/include/asm/hvconsole.h
+++ b/arch/powerpc/include/asm/hvconsole.h
@@ -24,5 +24,8 @@
 extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
 extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
 
+/* Provided by HVC VIO */
+void hvc_vio_init_early(void);
+
 #endif /* __KERNEL__ */
 #endif /* _PPC64_HVCONSOLE_H */
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 593840847cd3d..693f58d784b5b 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -43,9 +43,6 @@ extern void pSeries_final_fixup(void);
 /* Poweron flag used for enabling auto ups restart */
 extern unsigned long rtas_poweron_auto;
 
-/* Provided by HVC VIO */
-extern void hvc_vio_init_early(void);
-
 /* Dynamic logical Partitioning/Mobility */
 extern void dlpar_free_cc_nodes(struct device_node *);
 extern void dlpar_free_cc_property(struct property *);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 090c13f6c8815..b5513eefd12c9 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -71,6 +71,7 @@
 #include <asm/swiotlb.h>
 #include <asm/svm.h>
 #include <asm/dtl.h>
+#include <asm/hvconsole.h>
 
 #include "pseries.h"
 #include "../../../../drivers/pci/pci.h"
-- 
2.25.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B182B0388
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgKLLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgKLK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:59:05 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA3C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:05 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so5499844wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRCHYBSKer/DhncW1LEqcraDTStImfNIgO1yubNFQNU=;
        b=PMDgKOJWARNDQAWKNjRWYyoUhnMr4/vfaysnBsAvVrYhOuX0ypHnP4JUPS4NhD7PXc
         hQsqSt+b46W0Xpoq0cOZxSaAuu20SdmNs9imxHtYqpbpZ1NXvUFwkTQxfL5JLpSAVQjF
         569qusdZm7VtmkYdzj5mcQqnwm76DJU+02N4QdLb0fUcHPAQrmTUjy+irar9ChsRs6du
         E7xJ+fUHg63fDmQeSl/W3BWW2WK++L3Txca+rIuBSchDbjosc8FwRvVStmqtmULmr5Pa
         BejSG1IJQIweIMaelH78uIkLz9CRa1zFuvsGcKyIHgAnt1QesDmtsDOKedzeBgYFIm8W
         vDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRCHYBSKer/DhncW1LEqcraDTStImfNIgO1yubNFQNU=;
        b=PPLGaDcELVh347bEpttXig9BHlpyyAQljoEwHiQJFGtnQ6V/hRyzPfGTLpEOQO9zoR
         DgnZVOmjHbA+7dbADKeSVmKDbdTTT6iRtGDcFR4yuIQENed1+gGwEmkQP1g/6AXxVMeU
         JJfJ6Zeqt8WdpCVc9Jh5AtupoMkAwXYByy9kHE4dkNqDAkvtqkUyM51INh0yhBWTRa2L
         Cd9v/iE1EJsW1Aqjg+PaEEQ/3ACAy2EMe0Fk95XcsTgamXhDx4byQM9F57flaAKlZwk8
         qGk649+YOhCJ/b/QMnfWcN5CErHINw91HH0Hr9G+S/ibRl7w9c+hbrvyKE3IMHW4O/+U
         iyRQ==
X-Gm-Message-State: AOAM533KWEaFq9VUbS+B9gre+m9BRWkvCQecHhr4mHFtu/B4qj79sS8K
        GLfWtJyhFMpOruNVHxgbW1PXLA==
X-Google-Smtp-Source: ABdhPJyXxqSXwVkg2Ox5pxokrrElCxJ+dBD6xraCAU1vuEAqBAeCpJrjRyun+5dKCvYm5QU1CHa0JQ==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr34746566wru.405.1605178743922;
        Thu, 12 Nov 2020 02:59:03 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id u5sm1167239wro.56.2020.11.12.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:59:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/4] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to shared location
Date:   Thu, 12 Nov 2020 10:58:56 +0000
Message-Id: <20201112105857.2078977-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112105857.2078977-1-lee.jones@linaro.org>
References: <20201112105857.2078977-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
index 13fa370a87e4e..7be5b054dfc36 100644
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
index 633c45ec406da..6999b83f06612 100644
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


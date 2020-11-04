Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506BE2A6E22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbgKDThM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbgKDTgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:47 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9B0C0401C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:45 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so3500365wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sW45qqqQ6addDuh9wJMdphmMJUrhr2wEdPzjio8U9Vc=;
        b=wQEUFgF4ft5oi40ft9oy0bhvwfOdzDGjDBQ2fN+SdQlJfJkX4r7TwxYmkN+KP3GKDd
         LsgCPgefHaUlqOeA/qv4qxZDrkGs5AiQ0cWMRRVNnjniTVbXT62KAywGPD5My9rthOSm
         Wrixjs4a/HrBE+15gf2Y1suPR4vriY31mY8VmG4H4PLLx9rD4L7b+F9R4CbJaVbOXru0
         uRPRENrjej+ej4wW8TpmeUl6Ux3P3uRoJzL3kIeasmK0vn/SO0n47mgK9Ck3ed8n4bSo
         JgtLWi13TuJIt4UfgUH6hOkpEPoycwlNj0hjAKUL1eHeBEHdo0lIovfcLeONIUAllXhT
         LBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sW45qqqQ6addDuh9wJMdphmMJUrhr2wEdPzjio8U9Vc=;
        b=Aq/w4qrt99/VLdNhOrkNbVxlMepx1+Xzo2NgIVkoQJVtvvZJME5L4/09y28owBG6ea
         06MOlm9laJuu4i4N1eLhjRBV2v4C8U7Pky72/bTD70Lm9/QAXZrhX9Udaegy1X/Bmm0D
         vU4wGlcw7sWxpMeJFb5zfqOP46j6AvqK5+m76ChQznynKror/MTOyfbuYCRvJNkJqjSo
         PysffZejsvxh6dOV5ypMIJjkcsbVLxr2mhgEqVksaYlsRj9AT3e+t/feSQZVV8lvxhze
         lgMUSMRxpqtqIei5bJJJihjsmg6e+M+QQDMIVx8a55cXgH/usKQdRVHz/7JPq6YCUjxL
         Tu+Q==
X-Gm-Message-State: AOAM5301Te+iD8hWLo59OL/3Ms/OvEtS0b2PecXP9ICyoCTmIg83WFRp
        rcoyF44dsS3s71Q6RJjPP9Bke/d+vPs+69N4
X-Google-Smtp-Source: ABdhPJzS1GNCL1q4lGL4YRttHLZ6psOrCrvvSmz+bUeyN+dq8yTpxhmAygyPOyuFG9pbUEAALMHMXw==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr6094659wmh.72.1604518604614;
        Wed, 04 Nov 2020 11:36:44 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 31/36] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to shared location
Date:   Wed,  4 Nov 2020 19:35:44 +0000
Message-Id: <20201104193549.4026187-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
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
---
 arch/powerpc/include/asm/hvconsole.h     | 3 +++
 arch/powerpc/platforms/pseries/pseries.h | 3 ---
 arch/powerpc/platforms/pseries/setup.c   | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/asm/hvconsole.h
index 999ed5ac90531..936a1ee1ac786 100644
--- a/arch/powerpc/include/asm/hvconsole.h
+++ b/arch/powerpc/include/asm/hvconsole.h
@@ -24,5 +24,8 @@
 extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
 extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
 
+/* Provided by HVC VIO */
+extern void hvc_vio_init_early(void);
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


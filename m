Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1668F2954FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507000AbgJUXCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 19:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439276AbgJUXCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:02:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C968C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:02:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so5012899wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jGdInkciuraxCObjCq4PSMBKIp6zsKH4I8SuIMPE9Zk=;
        b=AAwAXUqN9gjf8RPzGGH/2ISx8DmBKTgBggHLY5b5tASJHU3avDG/ZnOAgMDElULgSm
         T59Fu6WCOszK9oyWkgbYKoOWswNWQ+Z9l2j7qey19J70mNdDorIuL37GTd3c9iho1QGd
         xWu47O6BBkbp2ptRA0tCDMiPyUxkdic1FD/SMY6KJ5eiopl/qxB4A69Re+eSkrLpENFg
         0aZ5CsEdmFgU+k166rICYKRK55hKRLoU6XwpaTVvAnK8+eF20ZCTFOGzXOEr/jPK9WZz
         YwXnLjKnuC4bYN185joLIxCrI7kBaqHS0BAPO2EiNCRFqBSwKGD8oOMzBg1ZT5pgRmVz
         RU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jGdInkciuraxCObjCq4PSMBKIp6zsKH4I8SuIMPE9Zk=;
        b=Q/MZsX8yE4IxO0mkYuODTBDptJFOULFjb+pCdc0Idca+80C7tHtJBil8gluCzXSawK
         E6RSwSYkrZ8M/mbBLQ99AaF/Pqs3I3EefdHZcDHJSKAi18Fa4CkGr+XHGBAsDU1y6r7W
         dOrUaS3z5tP3eeAFcvn2QFPXxUFNXPYFoK+JJ3aWuZV82/i3wsE4/Ly44hIzOnLiXwuK
         2cVfgwJrT3Pi4XWho2WyXQTyKc4VNtco7IWp28uJvKO46H5lmsG+bXmTwnEzi8BBc4Ip
         L66d2gU2PKSBs6UHRuLz2D6CFinSazvdhaOCUHMHKBZ4tAM+cqbbBxhDiLHF9YIjDiwM
         TFWw==
X-Gm-Message-State: AOAM530VfZwwsHLulIJwQ9XdJEmzMlkK369zW4q+v/xsuB/qSZbtpz5W
        z5WyHQaWMxf2+t73+VxpXxM=
X-Google-Smtp-Source: ABdhPJzcRi0tEGKPaq+nPEfJC/eKvHR7Aug0gdH2/i73DOWJzSRgOLFjKDuvH4kfWy3SauZhs33IXA==
X-Received: by 2002:adf:9f0a:: with SMTP id l10mr6614763wrf.427.1603321324750;
        Wed, 21 Oct 2020 16:02:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id d30sm6458263wrc.19.2020.10.21.16.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 16:02:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel compilation error
Date:   Thu, 22 Oct 2020 01:57:37 +0300
Message-Id: <20201021225737.739-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfp_kmode_exception() function now is unreachable using relative
branching in THUMB2 kernel configuration, resulting in a "relocation
truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
linker error. Let's use long jump in order to fix the issue.

Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/vfp/vfphw.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 4fcff9f59947..6e2b29f0c48d 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
 	ldr	r3, [sp, #S_PSR]	@ Neither lazy restore nor FP exceptions
 	and	r3, r3, #MODE_MASK	@ are supported in kernel mode
 	teq	r3, #USR_MODE
-	bne	vfp_kmode_exception	@ Returns through lr
+	ldr	r1, =vfp_kmode_exception
+	bxne	r1			@ Returns through lr
 
 	VFPFMRX	r1, FPEXC		@ Is the VFP enabled?
 	DBGSTR1	"fpexc %08x", r1
-- 
2.27.0


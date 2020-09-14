Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F27268A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgINLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgINLsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:48:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F16C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:48:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so10323362wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AhZpyl4i8SQbKTfnwUmt0Ow0fuH1tW4/N+hsM5LmxE=;
        b=uQ1qKJad6ONK2I9zSeCcW3EcuegrfA6TyzXNGCTxig1ojMO7caJmoTtZX9hKjIIvTq
         zaDXW+gCx02cq8ouVNbnIdSuT0ggNDM4WOv3HbxnWj5O/dhOuD7xFLDeLSwPOBUFTaHG
         CIviKGRX+tMLG+918/sRR/NB7g9KcUz/A/0zr89RABUZgQZbRxewuBdqGPoMBqNqPndY
         8pllDuTyin0iDBXfW73KJB+5ycfqri0Pt4x07/+sntU2E4FbdtZkHodWtGP9v7WHm9DV
         B9sD1RJPz07Hhr4dEWF0lJICUGCWaDoitOokaNC2Mj2Jje/vlJ4p/mqrptwoS/x9J7Ad
         WzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AhZpyl4i8SQbKTfnwUmt0Ow0fuH1tW4/N+hsM5LmxE=;
        b=JcFDuzEV4keth4ivsvGihuPyO0+hPpjOk4h9mdh+cBw/AA8FrmIwLiZqcBtV0FoEPi
         xY9DlvBxkkOi4OewhDezW5RikM+fr9i1N5OzddXCd3eiHzBvOZlJ6wB3yPx1Qy+JiGQv
         z8xI+faGvGVHSdyeZdooVjjx1AIsYSbkarSJXpzhtqvZVWB9lpkr3+HCOfYhJczL/LiW
         j18GWy0NeUR04cX+lssvT1VrNs3fi0g8nxCgFNmNHONd4hlrr9DRJJVIJ1vyYeeENhAB
         sZLjn/nhym7CT8x2Qr2FuyvGSM6SaNSwtcYCTqBV5+CpiS1H3jz0KHX8fZu4vGwI0K1t
         MA3g==
X-Gm-Message-State: AOAM532a2r1F0A+xpG3Uas+oC+kTG19OO9I4U1kMolnojdZQW9QV4e5k
        e14BDhC3GcaVfgNk+zAnkKU=
X-Google-Smtp-Source: ABdhPJz+eFLzDlLT9CFvpFwHsIvzE/DQK8WtHAzFn7XOfw8a0cH14LOzIF3aFVv99HP4D4XNOv9zPw==
X-Received: by 2002:a1c:96:: with SMTP id 144mr14662074wma.84.1600084109563;
        Mon, 14 Sep 2020 04:48:29 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id 9sm18535063wmf.7.2020.09.14.04.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:48:28 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     vgupta@synopsys.com
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] arc: plat-hsdk: fix kconfig dependency warning when !RESET_CONTROLLER
Date:   Mon, 14 Sep 2020 14:46:52 +0300
Message-Id: <20200914114651.105219-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ARC_SOC_HSDK is enabled and RESET_CONTROLLER is disabled, it results
in the following Kbuild warning:

WARNING: unmet direct dependencies detected for RESET_HSDK
  Depends on [n]: RESET_CONTROLLER [=n] && HAS_IOMEM [=y] && (ARC_SOC_HSDK [=y] || COMPILE_TEST [=n])
  Selected by [y]:
  - ARC_SOC_HSDK [=y] && ISA_ARCV2 [=y]

The reason is that ARC_SOC_HSDK selects RESET_HSDK without depending on or
selecting RESET_CONTROLLER while RESET_HSDK is subordinate to
RESET_CONTROLLER.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: a528629dfd3b ("ARC: [plat-hsdk] select CONFIG_RESET_HSDK from Kconfig")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 arch/arc/plat-hsdk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/plat-hsdk/Kconfig b/arch/arc/plat-hsdk/Kconfig
index ce8101834518..6b5c54576f54 100644
--- a/arch/arc/plat-hsdk/Kconfig
+++ b/arch/arc/plat-hsdk/Kconfig
@@ -8,5 +8,6 @@ menuconfig ARC_SOC_HSDK
 	select ARC_HAS_ACCL_REGS
 	select ARC_IRQ_NO_AUTOSAVE
 	select CLK_HSDK
+	select RESET_CONTROLLER
 	select RESET_HSDK
 	select HAVE_PCI
-- 
2.25.1


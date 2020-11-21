Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756522BC05E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 16:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgKUPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 10:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgKUPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 10:50:45 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6891C061A4B;
        Sat, 21 Nov 2020 07:50:44 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so13798709wmg.3;
        Sat, 21 Nov 2020 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwoT1ZC6v4ZFk+JlctThgrwC1hEtu5vyzf2O45M+XG0=;
        b=dKjh0wYwqJVwuIf2AYQDGVM3mTWhAf3ZDZNawYTo1AuUqf5ZwqwNQ5TmZvJsFG/AzR
         B9O2EZuv3njmAAcv4hbBR4bVxZ/GgmEzeyJroK7jMvSqA9OIB95Ub3AkVfYi8UvH2huZ
         CLew8Ly86bRlulkRhTa0nd3+bRwR5PS8tNs0Vi8r2it6w3ente1pnZAIORBV5dtOxCgy
         dqCSpnFM2jyzCDjVcxjCHw6SgHVfRun4iZ3MzzM0Sh7LQOXxLshXQzrR+NUoFUlBDcqh
         p7K/v4uy2XQIq8y+ukzbYS1o7BSaxBUbXAEzSLAcn5GEknk+GwwgRefhKsD9K04Q9dqV
         FJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwoT1ZC6v4ZFk+JlctThgrwC1hEtu5vyzf2O45M+XG0=;
        b=f5E6aL7ZoFlA9MAn/RRErQA4pmsh5Vr5elDpe1mfvtXFfVh7Ql4x272MAhG/lBR+f+
         wHx2IpajcUF9agdxH+Fm/sdWfxjMfKx6WWXSc8NXwjoNOOus1EXHTnhX2YSCLpgRE0N/
         6RrKT8Rmx6skBCyWD1/H4OOCDQvJrmGgTBRRPHj8QgQNz273DaTRU/j4lsLQbdMDocaY
         2hrRlDBEIvCo85h81YsoYBgTqK1YrBCT8RRau7Pp0NWi2HzRSZVmoTS67Rk8GCWrT1ub
         Y8X/p0KN+XKBoLgG4NkyJTgaIjutXa9EdrwbFLF44xMEQ2qCUNZtY8IVRwdwG2HrwmDC
         NaiA==
X-Gm-Message-State: AOAM532ZRJia9o1dzTYzy0eOlzKemzAKsS8C1ZzTe9I9XyLHvS/hJDKR
        qjeeEpEiyqBb4t54id0PFLioh0/LkV9eftgc
X-Google-Smtp-Source: ABdhPJxuhOI/GVduFqflO/phZYTJWRHcNnLyIRIIfJaQaJS8ft12Zp73Mo9UXyUTuempyrGefFP4Eg==
X-Received: by 2002:a7b:c77a:: with SMTP id x26mr15320703wmk.63.1605973843652;
        Sat, 21 Nov 2020 07:50:43 -0800 (PST)
Received: from localhost.localdomain (161.red-83-46-194.dynamicip.rima-tde.net. [83.46.194.161])
        by smtp.gmail.com with ESMTPSA id n128sm7959598wmb.46.2020.11.21.07.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2020 07:50:43 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        devel@driverdev.osuosl.org, neil@brown.name
Subject: [PATCH v6 3/4] MAINTAINERS: add MT7621 PHY PCI maintainer
Date:   Sat, 21 Nov 2020 16:50:36 +0100
Message-Id: <20201121155037.21354-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121155037.21354-1-sergio.paracuellos@gmail.com>
References: <20201121155037.21354-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself as maintainer for mt7621 pci phy driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f01ce8f451c8..c07967b9a654 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11108,6 +11108,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
 F:	drivers/i2c/busses/i2c-mt7621.c
 
+MEDIATEK MT7621 PHY PCI DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
+F:	drivers/phy/ralink/phy-mt7621-pci.c
+
 MEDIATEK NAND CONTROLLER DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.25.1


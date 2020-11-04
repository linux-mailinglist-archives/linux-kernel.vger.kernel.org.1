Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C916D2A6EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbgKDUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgKDUaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:30:14 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A46C0613D3;
        Wed,  4 Nov 2020 12:30:14 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r8so13154062qtp.13;
        Wed, 04 Nov 2020 12:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/DwTmttJZ2GPV5jUwCfpW2S+p7KLxB2HNhnRBBaDCQ=;
        b=iFEEkIqgNS1v3p45lncZ+rJaoCCN126cxF9ug1Of6gLiPjJZ+ikrxkQ89aeZzqvYhA
         Jf24sDuKyhloTWdp/VANjCqXOw1SJcNTmLIB55GzmhnNoaCzVCggJruqW0Py0EQuFlJo
         WYlR2YMQQnW6o1JNY+nIpL5sbcfWHGcGXckJZo9rnqSK1IOCDqSw3m+FH0KXFf12OCJV
         CcT1pw/x1l9yDsUN+u0kl0Ob2oesP1hltrDb4P3kt6Rzziy8rwZdPXd1FRg89tiX5pZT
         byU2KjwU028o5lw6DfOnVMD/RqA9syEdXrJfwubdJPJFM9wxXuabBnEayad3jNStc4Hu
         CpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/DwTmttJZ2GPV5jUwCfpW2S+p7KLxB2HNhnRBBaDCQ=;
        b=WES5Il6a/8e1L3bwC0YNJlIeR27W7ORyY2+uoFQcXlpb9TiHL34prrWoEEQE9Guoq/
         P8oPV7JYZI+7B6tycw0TrgAlZyko4Zh/V4Eu7RoOSRmH+ggnls4BW+G1tzXcx1epVYny
         T3Oubmdx3IOUfYeqy5Qypv4/cL6P0RNUGrmWdlSURizNgA2wEt3fMdIJGOBVv/MCAvDL
         BCedWybRlGxckXyIsvYVa24AdqbeGXeGOnUDz1nj4IZGA5AGvcVaudUdva3n6PWJhXUB
         zcbO8PXP0WQ96HF6qp0LwR/GZdR/sfJbLcfwyo4vURFQdv7NGpupjBfGi0wi15NyU/SL
         plDQ==
X-Gm-Message-State: AOAM531YSOmY/plZI3Qqr6JTfyfz8uD0ezjqYTttPzWWJzkburCc5xsQ
        uu+Qskeom77F5m1vQJaPPYBmJoZ5ZWBlUw==
X-Google-Smtp-Source: ABdhPJyG/qyNCJvQvu43fV6IAs8jaE5pYcSln2BCX2bsCC899iGK2cYYZDbyEhWB7Ovq7qC96iPzEA==
X-Received: by 2002:ac8:6953:: with SMTP id n19mr8815937qtr.184.1604521811813;
        Wed, 04 Nov 2020 12:30:11 -0800 (PST)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id q14sm930435qtr.20.2020.11.04.12.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:30:11 -0800 (PST)
From:   Vivek Unune <npcomplete13@gmail.com>
To:     florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH v2 0/2] ARM: dts: BCM5301X: Linksys EA9500 make use of pinctrl
Date:   Wed,  4 Nov 2020 15:29:50 -0500
Message-Id: <20201104202952.783724-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  1. BCM47094 pinctrl - use correct driver and define mdio pins
  2. Linksys EA9500 make use of pinctrl and drop mdio-mii-mux

Vivek Unune (2):
  ARM: dts: BCM5301X: pinctrl - use correct driver and define mdio pins
  ARM: dts: BCM5301X: Linksys EA9500 make use of pinctrl

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>

 .../boot/dts/bcm47094-linksys-panamera.dts    | 26 +++----------------
 arch/arm/boot/dts/bcm47094.dtsi               |  9 +++++++
 arch/arm/boot/dts/bcm5301x.dtsi               |  2 +-
 3 files changed, 14 insertions(+), 23 deletions(-)

-- 
2.25.1


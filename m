Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816512CBCAF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgLBMOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388805AbgLBMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:14:42 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483CFC061A55
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:43 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id j13so879692pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twh7FdLnI3Fezd8SG0USiCPnQPrQFrNMmmfjQ/SF6eE=;
        b=Ra3qjBsU2lId9leoR6YrGFCIh8IBKQrDGUjKPbVBUi0nRiIjIPY0e3Lxju5UGz36Eb
         FUyHHdSO6cbYd2WhKMZc1+rL5UO8YvCU4RWtSJsBu4CdineLOiy5qoHaxXGTYFeeKENc
         KXJpyG0kvq0kOf9MbH0Yrefv3RKu2Rsjau00s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twh7FdLnI3Fezd8SG0USiCPnQPrQFrNMmmfjQ/SF6eE=;
        b=cvjnVH2gozse1SCY8Q6+dMcEqS5EXhGJdR+ynNVligOSnUVNXAS44amXhq9FuSWOhu
         8APNYQNQ9iKr3+o6I8Amc/jSWcDL12XqkVz2k34BUT2cJk0x9gOe3AEWEBeVVkqohSI/
         7zmeG5Xh4Zrk3Z68pdLMJ6Oi9huCEi3IlOUvVqNP+nj0IwS1Ozs6oihKaPlwEToJ4KWn
         gPvXuUOtxd4KpePjYlulXsbJoLWVyFrFTNeQ5jhRQn3JAOSxLutZ7IKNqioGtBQwdJn7
         ZjKfFCUB2wzs3D20ZYgPsPLdeG/ZE0dQMfd6YNkoxpNcBPrkWcDHyBBsvSLCDT8hb2GF
         rCtg==
X-Gm-Message-State: AOAM530lVHV8MVUIW+LTe71NQIIS9gM29kbo8Bfm5QROzzQgxuzVzfyg
        NL9vAhdufdM10eOLXLNzJAvfww==
X-Google-Smtp-Source: ABdhPJwcgJ3Euhvx5PWyQcxmWJUdLYodQJL4DDylGLMJipaSJoce4oUGxDeygF2wMblP3aAvC+oaKw==
X-Received: by 2002:a17:902:14b:b029:da:b499:25c7 with SMTP id 69-20020a170902014bb02900dab49925c7mr2297336plb.80.1606911222873;
        Wed, 02 Dec 2020 04:13:42 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:42 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 09/10] dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0 10.1" OF
Date:   Wed,  2 Dec 2020 17:42:40 +0530
Message-Id: <20201202121241.109952-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202121241.109952-1-jagan@amarulasolutions.com>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

10.1" OF is a capacitive touch 10.1" Open Frame panel solutions.

i.Core MX8M Mini needs to mount on top of C.TOUCH 2.0 carrier with
pluged 10.1" OF for creating complete i.Core MX8M Mini C.TOUCH 2.0
10.1" Open Frame solution board.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 8c8f7728788d..9e275921112d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -669,6 +669,7 @@ properties:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
               - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
+              - engicam,icore-mx8mm-ctouch2-of10  # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0 10.1" Open Frame
               - engicam,icore-mx8mm-edimm2.2      # i.MX8MM Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
-- 
2.25.1


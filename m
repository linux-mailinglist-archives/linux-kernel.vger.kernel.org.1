Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11ED2A11B5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgJ3Xns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJ3Xns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:43:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C50C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p22so4272450wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNNy2YgSsziBNothSNpvypbFmOK3qCyQ8mipkm7FJWc=;
        b=Ih02k2hTBl4tyjmXT+sgJ7QSXhnTt6K5GvES1CXFwlTM3hODVd99CJKGCwSbiEHFmr
         etVglYvXv1oWCW16GliLzJHc5i59jpUXLmrSs2omk9OYQpe4dzcLnVIabwfhGtp1Ii6q
         W9geYhC4z++Wk4Ku75fe7sF0lItXzxcChYK+wluTEmdMZCIwDTL7l/0amY0tKCTS80CF
         qSdA+a1vp8OrF/jh5eTbIp5PNphCe9SgdLw+XsbraVxkFbmMnDQjcLcUPbU2F/SWUV/m
         h/DkciSq0ZjbFaXnyu9X1HboRbBwJRe74hMw4rzKVR4eRzEPCJJ+bdR3l6s4uB1woE9U
         sLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNNy2YgSsziBNothSNpvypbFmOK3qCyQ8mipkm7FJWc=;
        b=kiHoJVQksC1/fup6dgUfnQvweIh8D0H3G4IjOMZAjsyIRQyd/n3wZC/arHkugzKiyy
         AsBCBvog55PU/DVGkTJ2Ih8LEYXBsWQAkZhe5URg6kFboDErBiSUph62JpOmmzcAAwju
         dRmJenqfWpXo2RWidKDciRc5t9wKJCezjxFHPTwD8xQRpKCKZA69u+pVW77K6iSpDeSq
         g865W5hztD7jsIPzIE6ly08qJkAUlpWrNMZhOuy85RXhWmaqlCJNdVlDjvcB6gbGS5nm
         iWa7CCORt4k+8ftz6jH2aDjZem7wNY5RWwpdTKmAAMi3W/TR4JZcvCMOEPBtJ8buAyC1
         Ag3A==
X-Gm-Message-State: AOAM530jdRiEvKqse3tMZGzcQLbj2eGsU7mizyn9lGdDY8nPWdhQwOvH
        1Rf5wN/bSyx18Ge6EUFVwFA=
X-Google-Smtp-Source: ABdhPJx3+dQ3CE7ugBn1zhPMe3CPhO9AYTPFbByw2qZ37BQ9JH4DLBYC8sRK1fcW0uOCY/ums3KvEQ==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr5463099wmj.135.1604101426228;
        Fri, 30 Oct 2020 16:43:46 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z10sm4702381wrp.2.2020.10.30.16.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 16:43:45 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 0/6] Elimo Impetus and Initium support - rework
Date:   Fri, 30 Oct 2020 23:43:19 +0000
Message-Id: <20201030234325.5865-1-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I applied the suggestions from the discussion that stemmed from V1,
i.e.:

- using "sochip,s3", "allwinner,sun8i-v3" in the compatible string
- add a patch to do the same for the Pine64 PineCube
- alphabetic order in the dt-binding file
- match the dt-binding file with the actual dts files

Matteo Scordino (6):
  dt-bindings: vendors: add Elimo Engineering vendor prefix
  ARM: dts: sun8i: V3/S3: Add UART1 pin definitions to the V3/S3 dtsi
  ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus SoM
  dt-bindings: arm: sunxi: add Elimo bindings
  ARM: dts: sun8i: s3: Add dts for the Elimo Initium SBC
  ARM: dts: sunxi: align pinecube compatible property to other S3 boards

 .../devicetree/bindings/arm/sunxi.yaml        | 13 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 51 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts  | 28 ++++++++++
 arch/arm/boot/dts/sun8i-s3-pinecube.dts       |  2 +-
 arch/arm/boot/dts/sun8i-v3.dtsi               |  5 ++
 7 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts

-- 
2.20.1


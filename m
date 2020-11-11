Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD35F2AFC5F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgKLBfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgKKXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:23:56 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFCBC0613D6;
        Wed, 11 Nov 2020 15:23:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r186so2553119pgr.0;
        Wed, 11 Nov 2020 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rmvEzNyFoJX1iHYxKsv0/EGBjX8DBa3yt0/jMPmZuc0=;
        b=SIfjbVbXY9g2nGpr3BqroW0o9pCuBd41UimxHetMt19exNTV0jskvTTI4D/ubKIHsB
         DUf4SCe+EqQ/6L2D52wX8PE5uJ9dSwBdlrq1GFulADQLx1Thh3z8/UgMxLuaLxr8I0d9
         8haeVcVDKdVJvIdEYtH0oxYWVhiOV8ajBx2YGhgg40jK3lUEkPeIOC3+yJ8SQst6SfER
         ALddFewf+XAW2+kSkKkVgWuLwSK1CETx+eXOTrJsH9h4RdGYW00TCaNlHaJkZ2ZVTFM0
         s2beFieRVB7U64JwJDuxp2kiSK5JmU4L8UMmJ4UsmY/2/pPc9GiFxNyfnL08fUywSk4f
         QlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rmvEzNyFoJX1iHYxKsv0/EGBjX8DBa3yt0/jMPmZuc0=;
        b=Ge/xDdwdGwUPrn7ShOjHCFmCW66MdRcFaVf1E/rJCHvTHRhfyFWpuzPu+TDyTiTFj4
         OoLD1Ai0+QrU/oGFvXUB2tDPMPI/nBLSORR3sgG2E9yHoJQzTxFTaRS5CrZigeyB47eC
         Ew+W8fMsUZzLxwPDSteRFCx5gAnEiF7qq8L9lKrH2kYc52/A/JL4mXlUsCkNFBvc/Ku8
         3UshPo8POKRUEuJHj+OBQLZbtvaG8/aRkO5ThbQ5q1fTWNdSMN/3GInsN0AXXokpoOUn
         PUtCFAqVO+Z7m/wEbAIoNoMuPE5LnQCoDikXnUEfD8SArxXwelpywzayTKdckvsStt/T
         M8sg==
X-Gm-Message-State: AOAM530+sAP/5v4jUIbhmx/jNYy8dhMUzLEvHC05LgxPVwuKMIeInhGc
        d0hynPLYX5dS9ntpW1+fUjMbBvq/FrP3Eo7Z
X-Google-Smtp-Source: ABdhPJwLIkmY1lx2BkFH6Ky9XCzcwXy2Tiedp8iEyPSz0H7c5glq67safBqMDc1pSrdZwJsRHwPlYg==
X-Received: by 2002:a17:90a:4208:: with SMTP id o8mr6176658pjg.19.1605137026461;
        Wed, 11 Nov 2020 15:23:46 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id a128sm3901431pfb.195.2020.11.11.15.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:23:45 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
Date:   Wed, 11 Nov 2020 15:23:26 -0800
Message-Id: <20201111232330.30843-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series adds the initial version of device tree for Facebook
Galaxy100 (AST2400) BMC.

Patch #1 adds common dtsi to minimize duplicated device entries across
Facebook Network AST2400 BMC device trees.

Patch #2 simplfies Wedge40 device tree by using the common dtsi.

Patch #3 simplfies Wedge100 device tree by using the common dtsi.

Patch #4 adds the initial version of device tree for Facebook Galaxy100
BMC.

Tao Ren (4):
  ARM: dts: aspeed: Common dtsi for Facebook AST2400 Network BMCs
  ARM: dts: aspeed: wedge40: Use common dtsi
  ARM: dts: aspeed: wedge100: Use common dtsi
  ARM: dts: aspeed: Add Facebook Galaxy100 (AST2400) BMC

 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-galaxy100.dts     |  57 +++++++++
 .../boot/dts/aspeed-bmc-facebook-wedge100.dts | 120 +++---------------
 .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 112 +---------------
 .../dts/ast2400-facebook-netbmc-common.dtsi   | 117 +++++++++++++++++
 5 files changed, 191 insertions(+), 216 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
 create mode 100644 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi

-- 
2.17.1


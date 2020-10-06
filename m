Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3EE284F6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:05:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A16C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 09:05:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m16so9167676ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAdbXuSvVlSM2nTJl+6lnaw3AgFKGzcm9XVz8xwLu10=;
        b=sDMilXL4+Om1AsMsj+y9BoKnhLeWBPImLBU41kLw0UOG2spQ3ij1GxTTPUA5dcQdmn
         /3bd5SwTVzLLkuN4kkgW+gOquQqXb7IVKSW1ngnh2AeLwCuOKcXUaLBS+FpuWOTNCNQA
         1lT6vY5kx4hqwCaSpKwCQh+ki5honF7OBLFgSGBeQwmC/lMrzwMD9S9LRkmRTMG35AiP
         vVp7fm+ggv17eNk/UwgB2LvaBjM8UPdg9TGggOLmQju8SUxGMdGNB2K0Vo9MrsQc/gWz
         O0Nz8pR2MmNR+vOa6Fx5WZUfD6NwEiGi1DwcUfskV2Fkg8cY+bmK/8QhI3lpYvbYSkKM
         +WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAdbXuSvVlSM2nTJl+6lnaw3AgFKGzcm9XVz8xwLu10=;
        b=hFQFF9kHnhCFmcwotBH65gIMQ/MI7+Iw28BMp4AJ1lPziSkgrvHfTlA5StlNNplFsn
         P0R5Xs8pyjX6/1xU7jLeFq8BpHaQEYsrs1S8d1ULuQSC421jvqhj5L0ZgfmpezcrFrI4
         CkYXBgvp7y99UjcioidAg/BhEeoOTZHenuCkjdl8PDBZ3cyakW4qTJ+eV8EPupCD9S9M
         8f8yTlrUsYEc1x67Oo5OVs6WMgS6uoOVO+LWwYeTk8pVfnjoz43RoesWOiGJmzeBBv+v
         SsP6pZRonaDCp565Ysj400+VrF4HM1++yrNpTB5utokRSjRSPxV/2XS8RSgURliaOEyQ
         UsvA==
X-Gm-Message-State: AOAM531BCNg6ougIl7xebEtzxSfecooJr7oil0+/ZTiekP+21uMjcc8d
        xyWNqcbE3ZaAuPqb9dpyT07N1A==
X-Google-Smtp-Source: ABdhPJxvChusiVdW5VMFAiybl8fEzzkWPdeDLJrMeJG2k/mhdHmwqr+oDLAahEDp4kFPTIKvMJs/VQ==
X-Received: by 2002:a2e:8508:: with SMTP id j8mr1958522lji.354.1602000326185;
        Tue, 06 Oct 2020 09:05:26 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id c16sm640925lfc.304.2020.10.06.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:05:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] power: avs: Move drivers to the soc directories and drop avs
Date:   Tue,  6 Oct 2020 18:05:12 +0200
Message-Id: <20201006160516.319830-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The avs drivers in drivers/power/avs/* are all SoC specific drivers that
doesn't share any code. Instead they are located in a directory, mostly to keep
similar functionality together. From a maintenance point of view, it makes
better sense to collect SoC specific drivers like these, into the SoC specific
directories.

Therefore, this series moves the drivers, one by one - and in the end, it
deletes the empty avs directory.

It seems best to me, if this can be funneled via Rafael's linux-pm tree. Then
when going forward, each driver should be managed through the SoC maintainer's
trees.

Kind regards
Ulf Hansson

Ulf Hansson (4):
  power: avs: qcom-cpr: Move the driver to the qcom specific drivers
  power: avs: rockchip-io: Move the driver to the rockchip specific
    drivers
  power: avs: smartreflex Move driver to soc specific drivers
  power: avs: Drop the avs directory and the corresponding Kconfig

 MAINTAINERS                                   |  6 +--
 arch/arm/plat-omap/Kconfig                    |  2 +-
 drivers/power/Kconfig                         |  1 -
 drivers/power/Makefile                        |  1 -
 drivers/power/avs/Kconfig                     | 37 -------------------
 drivers/power/avs/Makefile                    |  4 --
 drivers/soc/qcom/Kconfig                      | 16 ++++++++
 drivers/soc/qcom/Makefile                     |  1 +
 .../{power/avs/qcom-cpr.c => soc/qcom/cpr.c}  |  0
 drivers/soc/rockchip/Kconfig                  |  8 ++++
 drivers/soc/rockchip/Makefile                 |  1 +
 .../rockchip/io-domain.c}                     |  0
 drivers/soc/ti/Makefile                       |  1 +
 drivers/{power/avs => soc/ti}/smartreflex.c   |  0
 14 files changed, 31 insertions(+), 47 deletions(-)
 delete mode 100644 drivers/power/avs/Kconfig
 delete mode 100644 drivers/power/avs/Makefile
 rename drivers/{power/avs/qcom-cpr.c => soc/qcom/cpr.c} (100%)
 rename drivers/{power/avs/rockchip-io-domain.c => soc/rockchip/io-domain.c} (100%)
 rename drivers/{power/avs => soc/ti}/smartreflex.c (100%)

-- 
2.25.1


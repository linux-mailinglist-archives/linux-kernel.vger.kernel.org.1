Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72AB2F54E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 23:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbhAMWYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbhAMWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:21:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFDFC061575;
        Wed, 13 Jan 2021 14:20:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d13so3738742wrc.13;
        Wed, 13 Jan 2021 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htUNH449lQEaPPKQp05wHHqDqIW6Q/fjdyTJ72cTNUw=;
        b=ZEVJd2QwjOYf0/m+TM3MblNozCNY9EGJhDUEpWok48YHh8zhzbRLpVI6q/66EXKkOz
         TTcPSqXwVQ2Yx0wM61+pOdLhbNJ3kz/DwOR5WJgvt6Sa7N4NW/y1Z1Xg82mekj7S84ia
         l2oXbUAlUB2lnN2ZV7Bn6ptyNXEWB0vWbfLoRpO48muZ51CEGRbynlwGTeWovS9G6I6r
         kuZ3WdrVv6kb1p76wKddg95jAjn6OUMep7XT77wqlipyofaZKGwnGhkGPUYUaqv/Aihw
         lcfr9k4NBM55xZmpCWslZhGbmG2ztlDq8y3U8ibUBtVUmO/2PV4NNXh9agdTj8Mg6Lis
         Ksqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htUNH449lQEaPPKQp05wHHqDqIW6Q/fjdyTJ72cTNUw=;
        b=GiQeHdGD3hxrpFdgD+NCwRpjh0H0mljnoM+/+rJHsLaktokAEtGkbJExx5tIK3POLB
         Nqr2rDALVzrNSwTcrzekNKKxLB4prO/Sv7Pff2cS1UYvZOV6RZPc2nHAaUrzJye42HtS
         ECmvOss8/D+m1BJymx3bxwF84S5OUf0vRkv/iYP8YyUuLeoH8BU27OZtIsEvtQIvBUw5
         tH2yYqpPpmqlPFRPVKktW9/6aSyF//uzH2vszvOFSqs7g+xb/A/mqCbmD2jpM3UIZ0yP
         +gpMP8I9Kfmj1b0XfJcs6ohe/siPQVh930nEASBxoiuFaTInLIDhkrOUwL1xYceplyke
         H6eg==
X-Gm-Message-State: AOAM531hzK/k9RTtYJP4W4+k2Ko5Cbd4lwOTTdzLPLLO3I2UqRc6fhCt
        /JTGgMvElF8NhnNM+95mSeb2tgbymMg=
X-Google-Smtp-Source: ABdhPJwIEeN0y9iSEVC1cPKJkSNKUAswPh/8btjeeSeOqmyZoHGdXxslQQGAVelAfOANpYTUYZtLxg==
X-Received: by 2002:adf:814f:: with SMTP id 73mr674491wrm.368.1610576419436;
        Wed, 13 Jan 2021 14:20:19 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id t1sm5594929wro.27.2021.01.13.14.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:20:18 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 0/6] Fix issues on pf8x00 driver
Date:   Wed, 13 Jan 2021 23:20:10 +0100
Message-Id: <20210113222016.1915993-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch set aims is to fix some issues contains in the pf8x00 driver.
Some issues are documentation ones, some others are in code.

These issues where found while developing another version of the same
driver. I prefer to share with you the patch for it.

I do these patches on the master branch of the linux-next repository.

1: there is a missing documentation when we build the driver as a
module.

2: nxp,phase-shift documentation was not optimal.

3: nxp,ilim-ma is useless since another property does (nearly) the same.

4: Same than 4, in driver code.

5: It's better to use a linear_range to describe the voltage of bucks.

6: Fix several mistakes in the handle of nxp,phase-shift property.

Changes introduced in v2:
Some patches were mixed (and did not compile separately);
Add path 7 for the handle of nxp,phase-shift property.

Changes introduced in v3:
Remove useless patch 0;
Do requested fixes in patches.

Changes introduced in v4:
Mark nxp,ilim-ma as deprecated since it was already present in a kernel
version.

Thanks,

Adrien Grassein (6):
  regulator: pf8x00: add a doc for the module
  regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
  regulator: dt-bindings: pf8x00: mark nxp,ilim-ma property as
    deprecated
  regulator: pf8x00: mark nxp,ilim-ma property as deprecated
  regulator: pf8x00: use linear range for buck 1-6
  regulator: pf8x00: fix nxp,phase-shift

 .../regulator/nxp,pf8x00-regulator.yaml       |  16 +-
 drivers/regulator/Kconfig                     |   4 +
 drivers/regulator/pf8x00-regulator.c          | 203 +++++++++++-------
 3 files changed, 135 insertions(+), 88 deletions(-)

-- 
2.25.1


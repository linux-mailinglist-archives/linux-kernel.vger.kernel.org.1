Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6F2DB562
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgLOUt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgLOUtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:49:42 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3BAC0617B0;
        Tue, 15 Dec 2020 12:49:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d26so7958485wrb.12;
        Tue, 15 Dec 2020 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoBFNMUgbo16Fl4aa79+QcL7cdoW7rpNaANElfs+MEc=;
        b=f6pjm9wdqRA6MYJ5xn+FidjH1oOBigZE0pK+3eQ65tOLzMsAe/TTDbbYK7Q0DmS3Gu
         NuNXIWJgZCmYTmh7brVzqK2LIVBbvFsGd2jsQSJqEWdcSGBsOnAcBdzyuFwdjAxWofFz
         INBKh0HxYM5AYQUglNi9V7J4/zk2+uXQo8MaHf4Hn+4Y4ueFf6GYAjmnWJw04gXdEpcf
         IJLYpNX1epq2WalCB00KLcKEU2bfAd5TP/uvi1fmLxC+2DxmyX35J3jn6CGSkxpy9NAo
         9B5KHOLDRei5Wku2Zebc1NWi6jmNR2RReZR0fsTLjdl0j0Tixs+d7jnfT4u8qqBPYxRz
         BdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoBFNMUgbo16Fl4aa79+QcL7cdoW7rpNaANElfs+MEc=;
        b=dh5zonZtHVfsTg6ENfogDGl1xmw0QvYv95JEB0nij6XlMUx1hIASDb+2do3NJGnAJ3
         uN5X0Yvd5XXQlMUuMKGMWmtjEmFDFDZPnAVj+mTE83WyelST/F/r/evTLxe1R/EeAO2m
         VFtLfs0UQDH/cBnicPZTklGcAcF+BzgrUmJ+pV+2zcem0Xxw7S1Rs2RZfoMn7ETM9NhM
         juPuJPWpII0Yzdly7JEj8afpvSTAQ5TuuWsItBN3LSVCzp/fh6tRr4oBOlDH6zeMUzrS
         RVKWC6TOTQQf1Ka7YOhL1PFFSveZw3TSA3kt5xyVq4KkB1OmDmR9Mgcv50TvqT8RhMRj
         BiqA==
X-Gm-Message-State: AOAM533Gpv354GzVOrCXLDd92UU2y+Z670Qt7tMR/oKiM+onHlL2jKKZ
        pRr1WZx+I0S4LQ4/9PKslYE=
X-Google-Smtp-Source: ABdhPJxqAo08DBqIJbXmko5O4vE/ahVCpIQHrwdNl2srjLaHy/eZIJN5ANkzmf4jS4Cbt8P+ElOVpw==
X-Received: by 2002:adf:c449:: with SMTP id a9mr35571049wrg.281.1608065340576;
        Tue, 15 Dec 2020 12:49:00 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id i16sm37199246wrx.89.2020.12.15.12.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:49:00 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
To:     broonie@kernel.org, jagan@amarulasolutions.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 0/6] Fix issues on pf8x00 driver
Date:   Tue, 15 Dec 2020 21:48:52 +0100
Message-Id: <20201215204858.8186-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch set aims is to fix some issues contains in the pf8x00 driver.
Some issues are documentation ones, some others are in code.

These issues where found while developing another version of the same
driver. I prefer to share with you the patch for it.

I do these patches on the master branch of the linux-next repository.

1: regulator_name property is useless in documentation.

2: there is a missing documentation when we build the driver as a
module.

3: nxp,phase-shift documentation was not optimal.

4: nxp,ilim-ma is useless since another property does (nearly) the same.

5: Same than 4, in driver code.

6: It's better to use a linear_range to describe the voltage of bucks.

Thanks,


Adrien Grassein (6):
  regulator: dt-bindings: remove useless properties
  regulator: pf8x00: add a doc for the module
  regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
  regulator: dt-bindings: pf8x00: remove nxp,ilim-ma property
  regulator: pf8x00: remove nxp,ilim-ma property
  regulator: pf8x00: use linear range for buck 1-6

 .../regulator/nxp,pf8x00-regulator.yaml       |  46 +------
 drivers/regulator/Kconfig                     |   4 +
 drivers/regulator/pf8x00-regulator.c          | 121 ++++++++----------
 3 files changed, 61 insertions(+), 110 deletions(-)

-- 
2.20.1


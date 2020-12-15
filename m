Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA72DB7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgLPABP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLOX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:57:30 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A39C0613D6;
        Tue, 15 Dec 2020 15:56:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c5so17846758wrp.6;
        Tue, 15 Dec 2020 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0tDTGdmjTEhOT1mF/BO2vAWknmeFq4UNFVVwBKOvcA=;
        b=VN7g1w9zub1pO87ufeeJ9tJQ5me6kjP9rgzxapaTDQz9bY1lxABsjSyeckVr4Y1IOJ
         C/etWncp1xnp9rc4jMt1ZpAsD5ScRAp67rhlRT4nNl2v8sRCUGrn0w/QTwlRw96bYUCN
         tbyf5XFA1fZlLCAqR570sC0pQHD4KwA5DTiaE4yRFMioOVZIjnkSJ64c0IivpuVGnLDk
         5Lj4isaIRZG1VOQMZ2hkoKoxiKHYojV+VlWY7Yu7rv63JDltJA3b017qYQMCe7iNYN4H
         9VokxDKtm33P40fGtsrxRxPkm8RugthdNQuvTp8maZIquUEKLnWEoJd4bE7PLFttlUmy
         zPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0tDTGdmjTEhOT1mF/BO2vAWknmeFq4UNFVVwBKOvcA=;
        b=PS+Jky0vN+Q++7KeZb+/J51PuRloNTBYwGfzJRXu8WauXWV10QRcTsbLfrtmQ1ZBnc
         Mo+78dAwceTQzBjYRBV3697jrZTDQKTFZIn9TfWBZunHnbb3kSCK5jH1phDWNXR9ffUS
         /ha4+fTLmXKv2ewLiji92ybSov4X4Ow46fG81wCEZqcOPFLrRmb7mFW0ILrmw1Iq67EW
         LXAcvsjRWlSVsGWN7tV8hPzp4A5Zz8VcgT1t8V7sN+wB68w5foQV6LRwO9VHWsM1VjdW
         BtmNj3CZsJTsUslkDH7QKNqJbuH0vg5+av5kFrxiExxzfqNM4IxCcPwCZo0AT65pDi70
         t9VA==
X-Gm-Message-State: AOAM533o70hCMix9uZ8J9r68Ud01EgcBzYXHRLL6GpxnSHU5bIBFZUOx
        cmAtWiuR/2UnotYbPvmpIBo=
X-Google-Smtp-Source: ABdhPJz0iH8Eah+28RVXW9HuSMQd5jQ1egsysY2fogCkcKCNn4+lCcguGQIwBDWuXJ/HKbVE2lDcKw==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr24691141wro.388.1608076608812;
        Tue, 15 Dec 2020 15:56:48 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c10sm204160wrb.92.2020.12.15.15.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:56:47 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 0/7] Fix issues on pf8x00 driver
Date:   Wed, 16 Dec 2020 00:56:32 +0100
Message-Id: <20201215235639.31516-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
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

1: regulator_name property is useless in documentation.

2: there is a missing documentation when we build the driver as a
module.

3: nxp,phase-shift documentation was not optimal.

4: nxp,ilim-ma is useless since another property does (nearly) the same.

5: Same than 4, in driver code.

6: It's better to use a linear_range to describe the voltage of bucks.

7: Fix several mistakes in the handle of nxp,phase-shift property.

Changes introduced in v2:
Some patches were mixed (and did not compile separatly);
Add path 7 for the handle of nxp,phase-shift property.


Adrien Grassein (7):
  regulator: dt-bindings: remove useless properties
  regulator: pf8x00: add a doc for the module
  regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
  regulator: dt-bindings: pf8x00: remove nxp,ilim-ma property
  regulator: pf8x00: remove nxp,ilim-ma property
  regulator: pf8x00: use linear range for buck 1-6
  regulator: pf8x00: fix nxp,phase-shift

 .../regulator/nxp,pf8x00-regulator.yaml       |  46 +----
 drivers/regulator/Kconfig                     |   4 +
 drivers/regulator/pf8x00-regulator.c          | 174 ++++++++----------
 3 files changed, 81 insertions(+), 143 deletions(-)

-- 
2.20.1


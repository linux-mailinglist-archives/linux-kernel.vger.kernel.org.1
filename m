Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56592EFB67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbhAHWvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAHWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:51:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C08C061574;
        Fri,  8 Jan 2021 14:50:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t30so10446629wrb.0;
        Fri, 08 Jan 2021 14:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHMGewOKbQWHQFGRFUDVMlrfBQIw1GErq0N8ygK7hTc=;
        b=mRMIFrbcuLGC7NdTdfKN26wVTSg1919Asj+k77GR+JpCwBoD2ZJzgkbC/5hm2A0ZvE
         k0rD6jqznc6EsSCaAHhucYkIUTRIbjdjKxHiip9KoXI5oaz1qbIiqDjQRwVUDz9UhVZR
         e88fiuV/agsha5LRduRTfmm5RogH9NslCQIA92yzeNEipCFMxDfTFdytp9wdv5r1nzEa
         7zMidyyaoF+8QaYV6Gj3iMMToiQg6NdNFW1wRvniY2Osm3IgJKYVfysEtCx5SjcPO05k
         +Z7nuJiMM0gRVrtWbg4x2Jw5Jyy5tOOnF++VeekUEvRujkheL3YOLCOWXn8QegZADPUU
         +/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHMGewOKbQWHQFGRFUDVMlrfBQIw1GErq0N8ygK7hTc=;
        b=bDiZsbluGnjWTGKAnaB5Csn+O/+37VJ9SRlYUWQXd1D4gwjoixDlsty1AU8TrOwD6M
         ILHBPDHs4TofdiSzsFUWqY34IRR3qm36Cff953tS4v4VVsrZFkJwKq1G2a5jlPUJirjg
         NnKhPCsePr0TgNMaRXfbkWdNDT5hr5TP4i/P17VIsFPljk+L4nuR/yxyxzRTgEi0/5Fi
         7VbEAGtgoVB2WebL8GdqHLNQtKlfR8FQbYWQbCGAz9kl+z0mRQX9J1teB7qxJ+419Nbo
         tKlordzP53W/LLAHdPIlpQJ5U7A7jT8DGCmS2E19bIne7/SiDxqNvtaDeUKcF0eWCZHP
         X2RQ==
X-Gm-Message-State: AOAM530URKkQOaPoGam4VP0UMxD/3pX+cIDZ0ORm3//HyPvRQ/TbJkSC
        7DBGYng6HyaQiyHTyR0ty74=
X-Google-Smtp-Source: ABdhPJzQuHTeXjaaQXYaSDgw0y+xPieV0Q/1jOYZb2k2rTdizEdUsC53mkkXNLET6zhwKL8igJ4UtQ==
X-Received: by 2002:a5d:5917:: with SMTP id v23mr5839464wrd.308.1610146251279;
        Fri, 08 Jan 2021 14:50:51 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270094076597458eade1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9407:6597:458e:ade1])
        by smtp.gmail.com with ESMTPSA id o23sm15900644wro.57.2021.01.08.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:50:50 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 0/6] Fix issues on pf8x00 driver
Date:   Fri,  8 Jan 2021 23:50:00 +0100
Message-Id: <20210108225006.153700-1-adrien.grassein@gmail.com>
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

Thanks,

Adrien Grassein (6):
  regulator: pf8x00: add a doc for the module
  regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
  regulator: dt-bindings: pf8x00: remove nxp,ilim-ma property
  regulator: pf8x00: remove nxp,ilim-ma property
  regulator: pf8x00: use linear range for buck 1-6
  regulator: pf8x00: fix nxp,phase-shift

 .../regulator/nxp,pf8x00-regulator.yaml       |  27 +--
 drivers/regulator/Kconfig                     |   4 +
 drivers/regulator/pf8x00-regulator.c          | 174 ++++++++----------
 3 files changed, 79 insertions(+), 126 deletions(-)

-- 
2.25.1


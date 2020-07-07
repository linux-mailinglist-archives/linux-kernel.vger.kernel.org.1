Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A23216E32
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgGGOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGGOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:01:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E648EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:00:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so43390039wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YDWmEcudqEHLtwf/RKE1CHN8JF3UPekBXjlO05WGYPU=;
        b=YCILm8dfx6J0RRLoEJzwZEtZPGpnq2+39qZdn0I4jEdfuWxD4KC8PILlXTVNr0jsY2
         Aoo1g8vDXHsI+EFCYTgsgs5FNAdsxnNSjlnHBhKkDHQJTUGBlkcKs5xUAj0L2hNQu5Pu
         Yp9cTB9Dp4BsQ7L60KLZqKibBpe3L1J/b1ip8JUcAHEMg9iWSAOwoMAs0vGCHuP95FC0
         K+B0HD35Lq2rceD5QZZV5ZW6l0NrM8PZdex/5vdWUA2GtuYoD0os3o55mKGv+2pssYWl
         zCFoVLPaq/T1CTo/TDdfxVBl41MJ1brkS29XDIWlDGUygjDDI8Wc/9qlDXuPzNWhf3dQ
         LuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YDWmEcudqEHLtwf/RKE1CHN8JF3UPekBXjlO05WGYPU=;
        b=K3Xm6FhnogH3LhaVjuPhDhM+6OYWMpK9gfdIk/OfvYYSyNCRdfFN2xZcX7Fr1LmlRs
         xT85278gAj0U7GB76pGliVEPPC0Yrm4eOckuuLVWT55TFx/d1sFrrzBaFGr85vbAKMKv
         9GVnCgt1mO9p91sU81zZ8/7kkDDYzIBHSW/h7TXzTI0tplFAEfzjlSTdXt6K2jB+weYp
         5RL4eX7wsEI34N9c/cYUgFcndECb+D2YeUGlHOf2sWvdkyI77/XlKqkvOGB1Kp/7y/yP
         2qeKYS/DMj6A1otST8yiSpnP784t8mM9f2il+57ZvGjWSQPK3U95evjKOzBo/oJIN0Ky
         TBWA==
X-Gm-Message-State: AOAM533DqzduzQrZE6FMK1XsMzREVw08yHMjec0KdOHZnMELqFrLyY5d
        SMuZYyorefP30nSIo6y8onITtQ==
X-Google-Smtp-Source: ABdhPJwiFN6Pi0XW8PKRFR8WoDwYkfTftlzPnvTlv7DFLE5xp4Rf3wPnaGdd1+C2BnYswrv9LPFNpQ==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr4343891wmg.123.1594130458680;
        Tue, 07 Jul 2020 07:00:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z25sm1102823wmk.28.2020.07.07.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:00:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/10] Fix a bunch SCSI related W=1 warnings
Date:   Tue,  7 Jul 2020 15:00:45 +0100
Message-Id: <20200707140055.2956235-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

There are a whole lot more of these.  More fixes to follow.

Lee Jones (10):
  scsi: megaraid: megaraid_mm: Strip excess function param description
  scsi: megaraid: megaraid_mbox: Fix some kerneldoc bitrot
  scsi: fdomain: Mark 'fdomain_pm_ops' as __maybe_unused
  scsi: megaraid: megaraid_sas_fusion: Fix-up a whole myriad of
    kerneldoc misdemeanours
  scsi: megaraid: megaraid_sas_base: Provide prototypes for non-static
    functions
  scsi: aha152x: Remove unused variable 'ret'
  scsi: pcmcia: nsp_cs: Use new __printf() format notation
  scsi: pcmcia: nsp_cs: Remove unused variable 'dummy'
  scsi: libfc: fc_disc: Fix-up some incorrectly referenced function
    parameters
  scsi: megaraid: megaraid_sas: Convert forward-declarations to
    prototypes

 drivers/scsi/aha152x.c                      |   3 +-
 drivers/scsi/fdomain.h                      |   2 +-
 drivers/scsi/libfc/fc_disc.c                |   6 +-
 drivers/scsi/megaraid/megaraid_mbox.c       |   4 +-
 drivers/scsi/megaraid/megaraid_mm.c         |   1 -
 drivers/scsi/megaraid/megaraid_sas.h        |  25 ++++-
 drivers/scsi/megaraid/megaraid_sas_base.c   |   4 -
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 102 ++++++++------------
 drivers/scsi/megaraid/megaraid_sas_fusion.h |   6 ++
 drivers/scsi/pcmcia/nsp_cs.c                |   5 +-
 10 files changed, 81 insertions(+), 77 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D774273F78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIVKUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIVKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:20:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C92C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d9so12017944pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7fQuWBXljb/Nb+nIz5ln0i6rqDkV5C/TaLBysLpJeXc=;
        b=dGbfJjYHGUsX4whdUEtsnGvSZclf8yoiDzGDTnKlaFyBea/9xUU4s1H9xX7nOpYJ1I
         S4rY4+6IEYE9PMLqTT8e3QiADm5LFCkzVhDYfNvt6reB8bjwKH/6LqMuPv2SMNJB3jaO
         MGmMiQIXp7OhAmAuvnds2yAQTGcucHiXhIlv+W1Oebel5ibvrnSbCF0Gr/fnEzhKBdDH
         TotftJ3/oAjjKnbWA0NsGC7D8gc8s+Vyb5PUQL0AcHpTDpJf6U/Y7AVSYTx4nt5SDQuF
         abDQjWlx7h2hS3X1N3h7Kc/LBnGIL5kakrHMiwdgz8XKohpUHtgfyBUgMNMKhWm2uNSo
         SmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7fQuWBXljb/Nb+nIz5ln0i6rqDkV5C/TaLBysLpJeXc=;
        b=jjEopF0u5+LEInVEo+v7KZWX/v96ZqZt9rXIKi7UDNXhEI6n7Kx1NycsZeCluJmLD/
         tjKoMaJeSU0M7z4juQaZijyBdc+tALu0spq4Df8y0wiJ01qjuXULPVihZZ2l5GLi8wnN
         SQs7WStxXgwLmzPWhP2ftqceWd0ju8GpYe/2N2Q59me6SuAi5zLQgGqOLOjCQHf9XV5K
         Gvfjx+870zjZ6GSp8Mp09g+rVvvCIqyn5i7CtQVNnP5YBDZAYYK0sEx8Xs4y4MciIJ43
         mVji9kCIIfRpi5F5a3jY0d/GWhPx6m9h8DF0YT2OP8kY/IwLUL3OGVNuXa13RZFOgVoA
         irGw==
X-Gm-Message-State: AOAM532g14XGnWRMqTKXWmrngrPREnDr0w17UN1onIj+qmqGAIEkZQHO
        X12vB2NTbcTZhbPXBk+G8bo=
X-Google-Smtp-Source: ABdhPJwYE2X4pOLB8U6Db8OOQsfH9D2Xluj+RFfwZ+28ZZL03wPUAuhWHBB8HhE/mQOOeQbP5GQQCw==
X-Received: by 2002:a05:6a00:15c1:b029:13e:d13d:a07a with SMTP id o1-20020a056a0015c1b029013ed13da07amr3390355pfu.17.1600770037261;
        Tue, 22 Sep 2020 03:20:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.20.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:20:36 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 0/10] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Tue, 22 Sep 2020 18:20:08 +0800
Message-Id: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series merge different sub-device I2C read/write into one Regmap and
fix coding style for well-organized.

Gene Chen (10)
  mfd: mt6360: Rearrange include file
  mfd: mt6360: Remove redundant brackets around raw numbers
  mfd: mt6360: Indicate sub-dev compatible name by using
  mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360
  mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
  mfd: mt6360: Rename mt6360_pmu by mt6360
  mfd: mt6360: Remove handle_post_irq callback function
  mfd: mt6360: Fix flow which is used to check ic exist
  mfd: mt6360: Merge header file into driver and remove unuse register define
  mfd: mt6360: Merge different sub-devices I2C read/write

 b/drivers/mfd/Kconfig       |    1 
 b/drivers/mfd/mt6360-core.c |  564 +++++++++++++++++++++++++++++---------------
 include/linux/mfd/mt6360.h  |  240 ------------------
 3 files changed, 380 insertions(+), 425 deletions(-)

changelogs between v2 & v3
- Replace mt6360_data to mt6360_ddata
- Split I2C read/write to regmap driver

changelogs between v3 & v4
- Merge back mt6360 regmap driver to MFD driver

changelogs between v4 & v5
- use devm_regmap_init
- define crc calculation magic number


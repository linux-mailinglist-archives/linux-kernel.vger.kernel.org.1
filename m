Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FF268787
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgINIu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgINIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:50:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF3C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:50:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so17783247wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Z76iN5dKrEwSbBG4O9fZZwE0qBKlqiQkkuHppjnLYk=;
        b=I4Wog418XUa15zpIkSdZkM0NfYYZFUjtsBkNZ/nbw/Vs16KcGu6uLbhnVEfgX/mnzm
         ngoZJMAxMmv4IxCIuOMUpm5SE+/85fyREV/XPkPMYm3dgvKcgMlbLFzS1cmalD84aXon
         0TXQg1ex1N/stApONUWBM15sM/2NPvq71eKY6xdsdLIOTY788Au2Gs/V3qPU9YRM8d84
         OvxVM/yV1/P1pPkB0PxNuskRmkB3+Bny/JmF7paTyd8qfKe4q9Ok5Ga+DOb2XH4aYiLX
         /g2tNeUFNF7b42K/SJLaE2ns2DWLx5d1aTkMYM/GF5jy2FMHQL/c+23W2mJlcBqgRkYZ
         j4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2Z76iN5dKrEwSbBG4O9fZZwE0qBKlqiQkkuHppjnLYk=;
        b=jbKC9L8eaf8X5OFkufXLLcln3pYNYQ7bCMZrIl0OBin4CD27xBHOHdzNMxB3/7B1uy
         2QqAzvwck+LXk7xkwP20bIJ0F+vyxJlTi5ofE/YhJfpOMDrnFCnRK25iuiYodZ3iXU/H
         TpcOZoVP7WuoTIcmJNyP2IEiA+oKus1DepMJQnTShWXTSoO8o4QMYxlyIc06ulsulSDg
         3MzZC6JswbHGS+Blh0yIFBG5UvTlGjAPS7HRAGANShgVOp1p+guzS0CUEH4cSrdlydfA
         +Vh0sNjjvKrW/oAUDmg4ZitCD/2OOMsrV1263XXTKtTJguAnmHINyZ3uCwiYsJnvMsgK
         b9xA==
X-Gm-Message-State: AOAM532CdDCrwBI3tXHQVcekaicmSG7bJ4N5+HnnIri+o2Jej/AGuj6k
        izSs2ahUJdadwSL0iqEjCVLaATA6UWqYhQ==
X-Google-Smtp-Source: ABdhPJziOaoLyqZezVgUbtyPAxvBCTpzyAkveYpRhKWSfKSVWKFznTfHP8u9zRb8BEszGSJh/ZyEYQ==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr14104094wrq.381.1600073403505;
        Mon, 14 Sep 2020 01:50:03 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j14sm20378080wrr.66.2020.09.14.01.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 01:50:02 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 0/3] can: xilinx_can: Some minor changes
Date:   Mon, 14 Sep 2020 10:49:55 +0200
Message-Id: <cover.1600073396.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

recently some small patches come to our internal tree. We started to use
coverity which found 2 issues (last two patches) which is simply to fix.

Thanks,
Michal


Srinivas Neeli (3):
  can: xilinx_can: Limit CANFD brp to 2
  can: xilinx_can: Check return value of set_reset_mode
  can: xilinx_can: Fix incorrect variable and initialize with a default
    value

 drivers/net/can/xilinx_can.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.28.0


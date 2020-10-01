Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64227F824
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 05:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgJADTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 23:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJADTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 23:19:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D60BC061755;
        Wed, 30 Sep 2020 20:19:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gm14so1180581pjb.2;
        Wed, 30 Sep 2020 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TzTxeT60ryeWMJ2cTkeqKHhehh6PdOfcbkVZkAE4QmE=;
        b=NBZoq41lN0PqyZAkXRbNzrxPxf+bjoCCNTpCN/whEdWGDl9IyJMMR+eQs1LN+j5FBR
         1nTMo7KW9IvubmKVNHmwQUGrThN2xXiwf79BJRVGwMrdfa9MJEB6BYlWVw3jA3Iqni8s
         i0Mal2NS/BC0RJCBJWP89T9fbz7EOx5B8chWQEqzFRmd7LUfD0gw0vJgFt+INM73qKu8
         xzBB0cubKDMXrQY33KZnoxQEnVmi87e6FW/Aer+zHdz8LNUEHfNZTtu2F9eSvlIPOIwX
         zWIPlsT8ah8QtnlwiLUDCQpy8KfAF6gpChk6g2L9qzkyendcI2ytLChNQYhVEPAFo7V3
         /ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TzTxeT60ryeWMJ2cTkeqKHhehh6PdOfcbkVZkAE4QmE=;
        b=KC2v9tysHy8qig3yVq9phaZrdlpqeqfaqYhGwSbL8FlmXuixp0BZNAT49NgiAVP4EE
         Mrd3UUDIjdc+TXc2cEoszaHhN5V9yd7/WwJ4Xc7K6FPCmusD52BD62uOEv3uN8nE+PHw
         zYNOQ/uAkhNPuI+ZPVOrepDnHU1+cSnxHp2MSdARt4eC8wIHUmqspoZ47kC/qu7HL74v
         LMfndIHTWtMp8vf3l0kXYa8vLgvAlV6c82FL0PPOcxP5D6wKTkUcXsA7ve2hWtE32ngs
         Bvr5y5OfXdA7WcVbwTIFDV23s1YU/o/mEL+WGMFxbGwMRMRPph+gsScuolH04DJLHqUr
         eR5Q==
X-Gm-Message-State: AOAM530idDi/Q8+3gQ9UFkI2zmoUDNMVa0zpqQcVDlhwPhpn/+nCHwZX
        ZH0c/sUL+UrcBGomFsvJcipjCzhfdBhGiw==
X-Google-Smtp-Source: ABdhPJwrEd87Kq23ZL50kkKhUlnt+l4V+60iiBswC++xvNZ16bchLoxzTgBUPdP7HP3Iaov+WTwpEw==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr4746535pjq.91.1601522370310;
        Wed, 30 Sep 2020 20:19:30 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17sm3369242pgd.86.2020.09.30.20.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:19:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 0/2] phy: phy-brcm-sata: Allow configuration SATA AFE TX amplitude
Date:   Wed, 30 Sep 2020 20:19:14 -0700
Message-Id: <20201001031916.411999-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

This patch series allows the configuration of the Broadcom SATA PHY TX
amplitude which may be required in order to meet specific tests.

Thanks!

Florian Fainelli (2):
  dt-bindings: phy: Allow defining the SATA AFE TX amplitude
  phy: phy-brcm-sata: Allow configuration SATA AFE TX amplitude

 .../devicetree/bindings/phy/brcm-sata-phy.txt |  3 ++
 drivers/phy/broadcom/phy-brcm-sata.c          | 32 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.25.1


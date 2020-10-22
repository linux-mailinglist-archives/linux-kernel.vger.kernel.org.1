Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7829662D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371956AbgJVUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371946AbgJVUvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:51:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED1BC0613CE;
        Thu, 22 Oct 2020 13:51:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so1743910pgg.1;
        Thu, 22 Oct 2020 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjR+kct0r35yvE0Jg2mhIMMimMY2rHYgdXkXg5+lz8c=;
        b=oGs8rwDXMv95ZQHlitL4Jkj9QLcYEqRr/NYPC4EqyhxFOmBuiurtF5/Pp694JepAkF
         I2iGE21cHeDVd/tpZIw3+otqS0sZt1wWn3mM6gAhsrWuqYx5V9jLKfSu/RlpojZ+J8Ds
         p9yEm4u2P3vbUhOrLnM1ERQIrBFcytSR6/4uwL6L7Hr2fqAt8TrHlsUA8ZMc+TsGrVua
         K5ItnoDJnzisNpXHlks/0uIi47PSABlQzSga//vRxs9PhMtJEgE2awXOQpSz2MOSlv1A
         oDLaoRs+46h0NUUfAclccTwQ9Hyn2ip8w2I42t/C+M256X92w0w9/1uOaO3fFsmeWENW
         3ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjR+kct0r35yvE0Jg2mhIMMimMY2rHYgdXkXg5+lz8c=;
        b=VgC1Ryo9TsVD4J5KwKuxYjYbqSA1PUqP2lqINgVqEY5DCawf1vm62Gz1R0DTY+u8aa
         ukwxcp1DPq3A1Mcy2uMzj7hzBDXp7qujrh+ImO2n/9ImNZ56iJo3Rhm+uYbMMXYqDkB0
         1nf+pAZvgQe4WhwuDHi7iQ7e8WC81B83pDMn43Z6mrF+Zrn8ANCaJoZn51qZuH7lfwPe
         Ou5+exdjjUl6dLsO/ptZlP3Ns5TpfoR6p/8nb+ktrJ1z6yKh6ugDdon2x66ZBn9mbNB2
         XHclmonvh1SeUeULgMpiKA2qkeBC3DcZ7QaBtowYFmgCoDGGVNrHJUeZ+3TdQ+BziFwH
         o8dQ==
X-Gm-Message-State: AOAM532vKzzZvUSFm2BgsDoZ0lR1n3K+lLccNsd1l5YgT8tZqW0+qwJ4
        wRAFu/5S67LCEL1U8t0C7f4t1L6Vm8s=
X-Google-Smtp-Source: ABdhPJzemEptponQUydQQtXlCuHIh4VOVtEcpMQn0D4YMPNcE+w9bBEmK9Y+NO7dnkf7A3yQqHzPgQ==
X-Received: by 2002:aa7:8b0b:0:b029:152:900d:2288 with SMTP id f11-20020aa78b0b0000b0290152900d2288mr4031530pfd.53.1603399862537;
        Thu, 22 Oct 2020 13:51:02 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id kc21sm2890803pjb.36.2020.10.22.13.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:51:01 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 0/2] phy: phy-brcm-sata: Allow configuration SATA AFE TX amplitude
Date:   Thu, 22 Oct 2020 13:50:54 -0700
Message-Id: <20201022205056.233879-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod, Kishon,

This patch series allows the configuration of the Broadcom SATA PHY TX
amplitude which may be required in order to meet specific tests.

Thanks!

Changes in v2:

- rebased against phy/next
- added Rob's Acked-by to the dt-binding patch

Florian Fainelli (2):
  dt-bindings: phy: Allow defining the SATA AFE TX amplitude
  phy: phy-brcm-sata: Allow configuration SATA AFE TX amplitude

 .../devicetree/bindings/phy/brcm-sata-phy.txt |  3 ++
 drivers/phy/broadcom/phy-brcm-sata.c          | 32 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.25.1


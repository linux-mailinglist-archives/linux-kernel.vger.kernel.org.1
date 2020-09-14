Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08126878F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgINIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgINIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:50:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A9C061352
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:50:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so9806939wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RihlPiUoKJ5dO8u5VgwLil1hFKYQdPZrQdkm6dxH7U=;
        b=OGWWk4oUqeZhemDzsBit+3ybTzgLDKa8+inPhCSBdmqT0VzUjdt473bbAx3PXD/Me1
         eom9s9PKN5pOuPDzFY8AmNEoCYJLd74DOxySWtNOyilvYNdjkPP9vo2ruWNm2vZzzLwc
         clrzILcPcXnV9H59MtGhVLK9Q3XhKSWhFpes4vKRRbtz1Ujtg943pwlv3IOxo4PawCsA
         wFlI3O3k5pELJnuaLXjy1AocjNWv277s1Z7ijKfV7B8NMJefnKlW5XwzMPckNmVoAcDa
         MHjzDGi6vpv4Pd0z8TG8BIYNFAwiOvw3crmxTlPMJ8DAudVkWC6dooPf1kpLi9WwgHfs
         KZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6RihlPiUoKJ5dO8u5VgwLil1hFKYQdPZrQdkm6dxH7U=;
        b=KLifQo18nGoAdrk+aOQpio0rFLUDdQh5YYDnPUmmV++FmmQ3q268Eb9+g0CRM8MGT0
         P6v9RnLZMlV4XNjr06zjUBzlrwcYoT8CeQBp6BNkC06fqgXznL/jQatPGnY9wgbbPt7s
         s5rYaUVkm2+RIQAkyAgNczzF2kOYG00E9VllYPRy5GJBEBxH25Npa8yvIIoB2BNR7xIB
         rhAGzR8hyXwNwCnpfDD3xQugyiOiqGfHE3IPfluyPIacR4lMIlUUsDGJIJ/KROwUteb+
         4Cgl5ifb2YDiST0WOKfjOypUK4voxGkliwVsVLpbVIUzy/Yf2heQ5Gx0O1S3rKDOSMH5
         8zqA==
X-Gm-Message-State: AOAM531U0DLi9TmzibiAPoPvGjdjc8TTlbln0ebTG6XYivcYE0G0x0MH
        /ScdVftlkunu8+7jMSacVM7v6pEMqwWs+Q==
X-Google-Smtp-Source: ABdhPJwdaqg5f5Kke+vMgGPevV790jo7Y8/D5K3C8rI0hjcUYSusmPhaIAH2G6dWHFzgQjwy7rM1wA==
X-Received: by 2002:a1c:750d:: with SMTP id o13mr11267961wmc.54.1600073405221;
        Mon, 14 Sep 2020 01:50:05 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q12sm18980386wrs.48.2020.09.14.01.50.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 01:50:04 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 1/3] can: xilinx_can: Limit CANFD brp to 2
Date:   Mon, 14 Sep 2020 10:49:56 +0200
Message-Id: <bca871d7f3ca9c653d50e63c5b60028f2bdf3fb0.1600073396.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600073396.git.michal.simek@xilinx.com>
References: <cover.1600073396.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@xilinx.com>

Bit enlarging is observed for CANFD2.0 when brp is 1,
So change brp_min value to 2.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/can/xilinx_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index c1dbab8c896d..f4b544b69646 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -259,7 +259,7 @@ static const struct can_bittiming_const xcan_bittiming_const_canfd2 = {
 	.tseg2_min = 1,
 	.tseg2_max = 128,
 	.sjw_max = 128,
-	.brp_min = 1,
+	.brp_min = 2,
 	.brp_max = 256,
 	.brp_inc = 1,
 };
@@ -272,7 +272,7 @@ static struct can_bittiming_const xcan_data_bittiming_const_canfd2 = {
 	.tseg2_min = 1,
 	.tseg2_max = 16,
 	.sjw_max = 16,
-	.brp_min = 1,
+	.brp_min = 2,
 	.brp_max = 256,
 	.brp_inc = 1,
 };
-- 
2.28.0


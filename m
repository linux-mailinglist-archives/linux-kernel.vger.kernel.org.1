Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497F268785
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgINIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgINIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:50:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A62DC061351
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:50:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so17738269wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tnhr79mi4DKCMRU16Knp1ByZEtd2oOyfWvrEsPnasz0=;
        b=ggbwbppVHTxdFbCi0nMw/1Da6Zuoa6rODfIkC4FE1354F9DP6tyBWSrzqrTfGrfQX3
         Gj3UYObzDxfj8+PrK/feQQLBRLx2I/GYO7OxagaLX5SDn+e1/8CtiTGKL59uCWEoQQmq
         DYzsdbhUUPe/7aPlqDxd4heNSLaTOKiErKd2BoSsiDPjtlFfnJA50MOiIkWliA8UVtHp
         8/P9G4uvJdQ0msLNBk0ougfo/eJmMaE6b9P33WjgAgNkaw6Y2QIf5lLK290s265Zi9v9
         FRhQriOKoyy+3IdK3pL5mqov96frfb4LELX34Inb/XDcOLQ47joFRAwjqMBknsUNPOaz
         vW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Tnhr79mi4DKCMRU16Knp1ByZEtd2oOyfWvrEsPnasz0=;
        b=qM3EuQt4n+IEPQRiQiS9l7TDP0ACqF6ZOGIS4AEInGxRnfL1ZtINGQ7yxKXxlXav8D
         2Ob/PmsBT353XzRUusnjp+ZFTO20cKbq59bh6H3+EQpkayFh+aBztoGxgMUr5ezevIjo
         2gArO7b+lL8JPGJdAnVieC0jxvRwjG7qMP1fXXlmQylihEbA4MEdstUEw8CfKFNF+gu1
         M7BLuDvV4TyLnVbnpjwOnA2DiGWWXEx5fiBBlSzb9bUeq+JpCKTcUFYObTt/Fp7nUxx1
         fWZPfbcEl/1seTd3aOYnsH8ypBENSSQpluROIO0+j7kwehCLFruX9c7kYvM1lGnxyrJT
         Ee0w==
X-Gm-Message-State: AOAM530eEZ+phHuOlrD1beYo0hhz+sLUqkm5bEeLj18CsfvItINxq2rA
        grRHRxlI4mJfb8s+TYRrAbrh9dQnxHxGiQ==
X-Google-Smtp-Source: ABdhPJwNn8yyjbVS7CEijF6HJmDzLprYpyLbe3fkcIfXlK11CXthgCbgprAuNq7BPa8a1yvOLYbL6A==
X-Received: by 2002:adf:bb8c:: with SMTP id q12mr14828713wrg.393.1600073406766;
        Mon, 14 Sep 2020 01:50:06 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w21sm19324776wmk.34.2020.09.14.01.50.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 01:50:06 -0700 (PDT)
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
Subject: [PATCH 2/3] can: xilinx_can: Check return value of set_reset_mode
Date:   Mon, 14 Sep 2020 10:49:57 +0200
Message-Id: <bac2c2b857986472a11db341b3f6f7a8905ad0dd.1600073396.git.michal.simek@xilinx.com>
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

Check return value of set_reset_mode() for error.

Addresses-Coverity: "check_return"
Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/can/xilinx_can.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index f4b544b69646..3393e2a73e15 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1369,9 +1369,13 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 static void xcan_chip_stop(struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
+	int ret;
 
 	/* Disable interrupts and leave the can in configuration mode */
-	set_reset_mode(ndev);
+	ret = set_reset_mode(ndev);
+	if (ret < 0)
+		netdev_dbg(ndev, "set_reset_mode() Failed\n");
+
 	priv->can.state = CAN_STATE_STOPPED;
 }
 
-- 
2.28.0


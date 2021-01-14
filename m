Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF852F689B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbhANR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbhANR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:58:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3E5C061798
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:57:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l06sF-0004RA-HF; Thu, 14 Jan 2021 18:57:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l06sC-0002l7-E5; Thu, 14 Jan 2021 18:57:28 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tty: vcc: Drop unnecessary if block
Date:   Thu, 14 Jan 2021 18:57:17 +0100
Message-Id: <20210114175718.137483-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vcc_probe() succeeded dev_set_drvdata() is called with a non-NULL
value, and if vcc_probe() failed vcc_remove() isn't called.

So there is no way dev_get_drvdata() can return NULL in vcc_remove() and
the check can just go away.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/vcc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 9ffd42e333b8..d9b0dc6deae9 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -681,9 +681,6 @@ static int vcc_remove(struct vio_dev *vdev)
 {
 	struct vcc_port *port = dev_get_drvdata(&vdev->dev);
 
-	if (!port)
-		return -ENODEV;
-
 	del_timer_sync(&port->rx_timer);
 	del_timer_sync(&port->tx_timer);
 
-- 
2.29.2


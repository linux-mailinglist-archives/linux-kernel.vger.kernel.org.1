Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079322FE7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbhAUKgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbhAUKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B89ED238EE;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=E3rqOhlNjsoj1qD6go+1xdGHgfZsx2+E9ZgBMrIJGPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCHPjIgRidSetEiDc/rT5Ghl1rwpxwhraSA2gf7FL8ZILU3DCyF+dffdL10fZg+Lj
         n1AV7tutGE05vSTha7KYM3Nivlu/ZC/3oWAl3IhcSrRiDssMlnBtPTXXhbGH/95KL0
         Wu2Brx46b3KGRom5yCT7zhEZ9SAiYiNpN75qfMKPmy+A/eq12BPrkbvhd1Hdi+9hkV
         CzqSnkYeL7N5849hKFLbNzU2CVV78CiDnN9+mqkQRKB3lRWSlKGH5JblMYSZdM+mlJ
         u+qCtJqxHlz3YWwm4dehjrDmOVZB6xrwv3ipl+F/oPFDrDZMP0D9Uxg87C/YA9k2KB
         nz2zD5fiwkkoQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDd-0004Ya-5B; Thu, 21 Jan 2021 11:29:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 07/10] USB: serial: xr: simplify line-speed logic
Date:   Thu, 21 Jan 2021 11:29:19 +0100
Message-Id: <20210121102922.17439-9-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the changed-line-speed conditional expression.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 2000277bacc1..fc727f4283f2 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -451,8 +451,7 @@ static void xr_set_termios(struct tty_struct *tty,
 	u8 bits = 0;
 	int ret;
 
-	if ((old_termios && tty->termios.c_ospeed != old_termios->c_ospeed) ||
-	    !old_termios)
+	if (!old_termios || (tty->termios.c_ospeed != old_termios->c_ospeed))
 		xr_set_baudrate(tty, port);
 
 	switch (C_CSIZE(tty)) {
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153402F6899
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbhANR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbhANR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:58:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97976C061796
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:57:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l06sF-0004R8-H9; Thu, 14 Jan 2021 18:57:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l06sC-0002l1-1t; Thu, 14 Jan 2021 18:57:28 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tty: some cleanups in remove functions
Date:   Thu, 14 Jan 2021 18:57:15 +0100
Message-Id: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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

Hello,

while working on changing the prototype of struct vio_driver::remove to
return void I noticed a few exit paths in such callbacks that return an
error code.

This is a bad thing because the return value is ignored (which is the
motivation to make it void) and the corresponding device then ends in
some limbo state.

Luckily for the three offenders here these cases cannot happen and are
simplified accordingly. This then makes the patch that changes the
remove callback's prototype simpler because it only changes prototypes
and drops "return 0"s.

Best regards and thanks for considering,
Uwe Kleine-König

Uwe Kleine-König (3):
  tty: hvcs: Drop unnecessary if block
  tty: vcc: Drop unnecessary if block
  tty: vcc: Drop impossible to hit WARN_ON

 drivers/tty/hvc/hvcs.c |  3 ---
 drivers/tty/vcc.c      | 10 ++--------
 2 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.29.2


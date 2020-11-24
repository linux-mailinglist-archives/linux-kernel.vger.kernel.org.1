Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D102C293E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbgKXOSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbgKXOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:18:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EA7C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:18:40 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khZ9S-0007zv-TB; Tue, 24 Nov 2020 15:18:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khZ9S-0001pg-9S; Tue, 24 Nov 2020 15:18:38 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 0/2] siox: two cleanups
Date:   Tue, 24 Nov 2020 15:18:32 +0100
Message-Id: <20201124141834.3096325-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

compared to v1 sent starting with
Message-Id:20201119132311.2604232-1-u.kleine-koenig@pengutronix.de:

 - Prepare siox_shutdown() to be called even for unbound devices in
   patch 1.
 - remove stray "if (sdriver->probe)" in patch 1 (how embarrassing).
 - Fix grammar in patch 2's commit log.

Uwe Kleine-König (2):
  siox: Use bus_type functions for probe, remote and shutdown
  siox: Make remove callback return void

 drivers/siox/siox-core.c | 50 ++++++++++++++++++++--------------------
 include/linux/siox.h     |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)


base-commit: 418baf2c28f3473039f2f7377760bd8f6897ae18
-- 
2.29.2


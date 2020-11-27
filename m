Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9F2C6D25
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgK0WNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbgK0VeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 16:34:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78AEC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:34:07 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kilNW-0004dl-AF; Fri, 27 Nov 2020 22:34:06 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kilNV-0002kF-V1; Fri, 27 Nov 2020 22:34:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] =?UTF-8?q?mailmap:=20add=20two=20more=20addresses=20of=20?= =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
Date:   Fri, 27 Nov 2020 22:33:58 +0100
Message-Id: <20201127213358.3440830-1-u.kleine-koenig@pengutronix.de>
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

This fixes attribution for the commits (among others)

 - d4097456cd1d ("video/framebuffer: move the probe func into .devinit.text in Blackfin LCD driver")
 - 0312e024d6cd ("mfd: mc13xxx: Add support for mc34708")

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello Andrew,

there is no explicit maintainer for .mailmap, but most of the last few
patches went in through you, so I'm addressing you. If that's wrong,
please advise who to bother instead.

Thanks
Uwe

 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index d9fb83d67055..225546cc8028 100644
--- a/.mailmap
+++ b/.mailmap
@@ -322,6 +322,8 @@ TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
 Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
 Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
+Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Uwe Kleine-König <ukleinek@strlen.de>
 Uwe Kleine-König <ukl@pengutronix.de>
 Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

base-commit: 9223e74f9960778bd3edd39e15edd5532708b7fb
-- 
2.29.2


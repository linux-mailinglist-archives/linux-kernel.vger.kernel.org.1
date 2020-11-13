Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D00F2B1790
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMIxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:53:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:53:33 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdUpo-0007H8-EK; Fri, 13 Nov 2020 09:53:32 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdUpn-0000GL-Po; Fri, 13 Nov 2020 09:53:31 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 0/2] Rename ioremap functions that include request_mem
Date:   Fri, 13 Nov 2020 09:53:25 +0100
Message-Id: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
References: <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
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

here comes a patch set that implements the suggestion in the previous
mail so we have something to discuss about.

Best regards
Uwe

Uwe Kleine-König (2):
  base: Rename devm_ioremap_resource to make the implicit request_mem
    explicit
  platform: Rename devm_platform_ioremap_resource to make the implicit
    request_mem explicit

 .../driver-api/driver-model/devres.rst        |  6 +--
 drivers/base/platform.c                       | 26 +++++------
 include/linux/device.h                        | 32 ++++++++++++--
 include/linux/platform_device.h               | 43 +++++++++++++++++--
 lib/devres.c                                  | 18 ++++----
 5 files changed, 93 insertions(+), 32 deletions(-)


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.28.0


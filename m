Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC302B17F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgKMJMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:12:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA2C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 01:12:08 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdV7m-00016t-TA; Fri, 13 Nov 2020 10:12:06 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdV7m-0001QK-F3; Fri, 13 Nov 2020 10:12:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 3/2] checkpatch: document the function renaming and deprecation around devm_ioremap_resource
Date:   Fri, 13 Nov 2020 10:11:57 +0100
Message-Id: <20201113091157.125766-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
References: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this can also be squashed into the respective patches instead.

Best regards
Uwe

 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..5abb87256d4c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -615,6 +615,11 @@ our %deprecated_apis = (
 	"rcu_barrier_sched"			=> "rcu_barrier",
 	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
 	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
+	"devm_platform_get_and_ioremap_resource" => "devm_platform_get_request_and_ioremap_resource",
+	"devm_platform_ioremap_resource"	=> "devm_platform_request_ioremap_resource",
+	"devm_platform_ioremap_resource_wc"	=> "devm_platform_request_ioremap_resource_wc",
+	"devm_ioremap_resource"			=> "devm_request_ioremap_resource",
+	"devm_ioremap_resource_wc"		=> "devm_request_ioremap_resource_wc",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.28.0


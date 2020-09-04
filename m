Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E9325D4B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgIDJZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:25:50 -0400
X-Greylist: delayed 351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Sep 2020 02:25:49 PDT
Received: from smtp2-3.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF84C061244;
        Fri,  4 Sep 2020 02:25:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 8CBFB23F5D3;
        Fri,  4 Sep 2020 11:19:52 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.009
X-Spam-Level: 
X-Spam-Status: No, score=-3.009 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.109, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1IfM2F4ymQRy; Fri,  4 Sep 2020 11:19:51 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 54AF623F913;
        Fri,  4 Sep 2020 11:19:51 +0200 (CEST)
From:   poeschel@lemonage.de
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] Documentation: iio: fix a typo
Date:   Fri,  4 Sep 2020 11:19:11 +0200
Message-Id: <20200904091911.269715-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Rename function name to the actual name referenced in
struct iio_sw_trigger_ops.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 Documentation/iio/iio_configfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
index 6e38cbbd2981..3a5d76f9e2b9 100644
--- a/Documentation/iio/iio_configfs.rst
+++ b/Documentation/iio/iio_configfs.rst
@@ -53,7 +53,7 @@ kernel module following the interface in include/linux/iio/sw_trigger.h::
 	 */
   }
 
-  static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
+  static int iio_trig_sample_remove(struct iio_sw_trigger *swt)
   {
 	/*
 	 * This undoes the actions in iio_trig_sample_probe
-- 
2.28.0


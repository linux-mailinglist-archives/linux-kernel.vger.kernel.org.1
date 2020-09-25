Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF532794A0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgIYXS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgIYXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:18:26 -0400
Received: from agrajag.zerfleddert.de (agrajag.zerfleddert.de [IPv6:2a01:4f8:bc:1de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F003C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:18:26 -0700 (PDT)
Received: by agrajag.zerfleddert.de (Postfix, from userid 1000)
        id 30D245B2053C; Sat, 26 Sep 2020 01:18:23 +0200 (CEST)
Date:   Sat, 26 Sep 2020 01:18:23 +0200
From:   Tobias Jordan <kernel@cdqe.de>
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Subject: [PATCH] leds: omnia: fix leak of device node iterator
Message-ID: <20200925231823.GA15759@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error path of the for_each_available_child_of_node loop in
omnia_leds_probe, add missing call to of_node_put to fix leaking the
iterator.

Fixes: 089381b27abe ("leds: initial support for Turris Omnia LEDs")
Signed-off-by: Tobias Jordan <kernel@cdqe.de>
---
 drivers/leds/leds-turris-omnia.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-turris-omnia.c b/drivers/leds/leds-turris-omnia.c
index bb23d8e16614..6c3d3d90f277 100644
--- a/drivers/leds/leds-turris-omnia.c
+++ b/drivers/leds/leds-turris-omnia.c
@@ -236,8 +236,10 @@ static int omnia_leds_probe(struct i2c_client *client,
 	led = &leds->leds[0];
 	for_each_available_child_of_node(np, child) {
 		ret = omnia_led_register(client, led, child);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(child);
 			return ret;
+		}
 
 		led += ret;
 	}
-- 
2.20.1


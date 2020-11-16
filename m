Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050C52B44A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgKPNWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgKPNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:22:46 -0500
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAFAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:22:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id DB71623EFF1;
        Mon, 16 Nov 2020 14:22:43 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.982
X-Spam-Level: 
X-Spam-Status: No, score=-2.982 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.082, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zn8rBJ5nAW0P; Mon, 16 Nov 2020 14:22:42 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id A0A4623F115;
        Mon, 16 Nov 2020 14:22:42 +0100 (CET)
From:   poeschel@lemonage.de
To:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] auxdisplay: panel: Fix missing print function pointer
Date:   Mon, 16 Nov 2020 14:21:55 +0100
Message-Id: <20201116132155.555489-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116100504.tccqktcgxwn4pyqd@lem-wkst-02.lemonage>
References: <20201116100504.tccqktcgxwn4pyqd@lem-wkst-02.lemonage>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

charlcd drivers need to provide some print function to charlcd. For
hd44780 based panel driver this function was missing. We provide the
generic hd44780_common_print function which should be suitable.

Fixes: b26deabb1d915fe87d395081bbd3058b938dee89 ("auxdisplay: hd44780_common_print")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/panel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index e07fadac281d..36848e464d1f 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -810,6 +810,7 @@ static void lcd_write_data_tilcd(struct hd44780_common *hdc, int data)
 
 static const struct charlcd_ops charlcd_serial_ops = {
 	.backlight	= lcd_backlight,
+	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
@@ -826,6 +827,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 
 static const struct charlcd_ops charlcd_parallel_ops = {
 	.backlight	= lcd_backlight,
+	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
@@ -842,6 +844,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
 	.backlight	= lcd_backlight,
+	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
-- 
2.29.2


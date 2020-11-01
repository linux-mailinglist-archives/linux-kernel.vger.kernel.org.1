Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7692A20CC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 19:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKASjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 13:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgKASjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:39:20 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16047C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 10:39:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id E4326B04;
        Sun,  1 Nov 2020 19:39:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mLVmrU8rCt9z; Sun,  1 Nov 2020 19:39:14 +0100 (CET)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 2F636AAC;
        Sun,  1 Nov 2020 19:39:14 +0100 (CET)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kZIG1-008KHD-35; Sun, 01 Nov 2020 19:39:13 +0100
Date:   Sun, 1 Nov 2020 19:39:13 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup_dummy: log about characters received by the dummy
 driver
Message-ID: <20201101183913.yg35cbqpn2ba6cew@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dummy speakup driver is used to check that speakup is working
properly, without the need for actually owning the hardware. Some
drivers require receiving characters, so we need a way to check that
this is working properly.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-5.9/drivers/accessibility/speakup/speakup_dummy.c
===================================================================
--- linux-5.9.orig/drivers/accessibility/speakup/speakup_dummy.c
+++ linux-5.9/drivers/accessibility/speakup/speakup_dummy.c
@@ -80,6 +80,11 @@ static struct attribute *synth_attrs[] =
 	NULL,	/* need to NULL terminate the list of attributes */
 };
 
+static void read_buff_add(u_char c)
+{
+	pr_info("speakup_dummy: got character %02x\n", c);
+}
+
 static struct spk_synth synth_dummy = {
 	.name = "dummy",
 	.version = DRV_VERSION,
@@ -103,7 +108,7 @@ static struct spk_synth synth_dummy = {
 	.flush = spk_synth_flush,
 	.is_alive = spk_synth_is_alive_restart,
 	.synth_adjust = NULL,
-	.read_buff_add = NULL,
+	.read_buff_add = read_buff_add,
 	.get_index = NULL,
 	.indexing = {
 		.command = NULL,

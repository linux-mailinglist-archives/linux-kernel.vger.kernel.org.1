Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D023FDE6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 13:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgHILWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHILWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:22:40 -0400
X-Greylist: delayed 1459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Aug 2020 04:22:39 PDT
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03CC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 04:22:38 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.89)
        (envelope-from <laforge@osmocom.org>)
        id 1k4j1n-000872-JS; Sun, 09 Aug 2020 12:58:11 +0200
Received: from laforge by localhost.localdomain with local (Exim 4.94)
        (envelope-from <laforge@osmocom.org>)
        id 1k4j05-009dAl-C9; Sun, 09 Aug 2020 12:56:25 +0200
From:   laforge@gnumonks.org
To:     linux-kernel@vger.kernel.org
Cc:     linux@dominikbrodowski.net, Harald Welte <laforge@gnumonks.org>
Subject: [PATCH] MAINTAINERS: Change OmniKey CM40xx drivers to Orphan state
Date:   Sun,  9 Aug 2020 12:56:15 +0200
Message-Id: <20200809105615.2295490-1-laforge@gnumonks.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Welte <laforge@gnumonks.org>

I haven't been doing any work on those drivers in ages, neither
do I even use any related devices.

Signed-off-by: Harald Welte <laforge@gnumonks.org>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f77df02e4121..05f5eb227700 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12694,15 +12694,13 @@ F:	Documentation/filesystems/omfs.rst
 F:	fs/omfs/
 
 OMNIKEY CARDMAN 4000 DRIVER
-M:	Harald Welte <laforge@gnumonks.org>
-S:	Maintained
+S:	Orphan
 F:	drivers/char/pcmcia/cm4000_cs.c
 F:	include/linux/cm4000_cs.h
 F:	include/uapi/linux/cm4000_cs.h
 
 OMNIKEY CARDMAN 4040 DRIVER
-M:	Harald Welte <laforge@gnumonks.org>
-S:	Maintained
+S:	Orphan
 F:	drivers/char/pcmcia/cm4040_cs.*
 
 OMNIVISION OV13858 SENSOR DRIVER
-- 
2.28.0


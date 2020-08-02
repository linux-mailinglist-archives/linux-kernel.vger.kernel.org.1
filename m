Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437AF23561E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 11:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHBJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 05:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbgHBJV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 05:21:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC22120738;
        Sun,  2 Aug 2020 09:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596360116;
        bh=be34PBBJyc6qL1vpriQhJlTvltd+3yYKM1ILsPRj030=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0WTxxVPKAYt+Yav8MlI4ckK6QyRkvG/FML0m7Z88nkruJRahxaqhWGEb+AXkRjoS
         MKZz/G6tF3IFGX1oKZih/xlSeVEn6+zjW/MCk8QRzOTMnmRI/StkmDi72j3yR4zy/D
         U3SnL26JoLWZ5CYxlPe+4kcHDgr0xab0XdCJfaD8=
Date:   Sun, 2 Aug 2020 11:21:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, christian.gromm@microchip.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: fix up movement of USB driver
Message-ID: <20200802092139.GA140088@kroah.com>
References: <7c18e466-0941-ee7e-9a0f-5a993c993152@gmail.com>
 <20200802091831.GA139182@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802091831.GA139182@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When moving the most usb driver out of staging, we forgot to remove the
subdirectory out of the staging Makefile as well.

Fixes: 97a6f772f36b ("drivers: most: add USB adapter driver")
Cc: Christian Gromm <christian.gromm@microchip.com>
Reported-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/most/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/most/Makefile b/drivers/staging/most/Makefile
index a803a98654a8..7c10b84ebac0 100644
--- a/drivers/staging/most/Makefile
+++ b/drivers/staging/most/Makefile
@@ -6,4 +6,3 @@ obj-$(CONFIG_MOST_SOUND)	+= sound/
 obj-$(CONFIG_MOST_VIDEO)	+= video/
 obj-$(CONFIG_MOST_DIM2)	+= dim2/
 obj-$(CONFIG_MOST_I2C)	+= i2c/
-obj-$(CONFIG_MOST_USB)	+= usb/
-- 
2.28.0


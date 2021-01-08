Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2652EF12F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbhAHLX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:23:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAHLX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:23:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F04E7235FC;
        Fri,  8 Jan 2021 11:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610104966;
        bh=bPA+yYa3LXJIdekAVokwxs+irPR0JvP4kZBMHOP/80g=;
        h=From:To:Cc:Subject:Date:From;
        b=JvY/tPBmN0icY0w/w2M5W2y87kuHQ4r5oJ6crg0G/mZvZNGP7zwe1ZQZCtanyK2Gb
         6QO9xQ+G4wFwzjXh0kIamI1/7GqMtNG07l/3vBmcOtk7Xcli+Pp+wWrH+Cv/3yKfS2
         AjixZO8Nj6SMwuMXvLJlwFqHNPGiVxgXKbGerzMDjLEZ/qLF2lc48bOC3qg/pbw37O
         CVSEJ4uAU6/u9SzuCG7Jce0S6Zw5cMSy6jEfBIjYwm6zUBZGjSYXM5QZ1Bfxh5Wnns
         M2w/J9yqJGiHeD6SmlSgEvk+2ho9SLj0zK2snWvmwPfp8T1cN/wC8ylnlwxkxZeEq4
         5xO/hqeYBDsiw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kxpqy-0006qw-VN; Fri, 08 Jan 2021 12:22:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] gnss: drop stray semicolons
Date:   Fri,  8 Jan 2021 12:22:33 +0100
Message-Id: <20210108112233.26294-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop semicolons after function definitions that have managed to sneak in
and get reproduced.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/mtk.c    | 2 +-
 drivers/gnss/serial.c | 2 +-
 drivers/gnss/sirf.c   | 2 +-
 drivers/gnss/ubx.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
index d1fc55560daf..c62b1211f4fe 100644
--- a/drivers/gnss/mtk.c
+++ b/drivers/gnss/mtk.c
@@ -126,7 +126,7 @@ static void mtk_remove(struct serdev_device *serdev)
 	if (data->vbackup)
 		regulator_disable(data->vbackup);
 	gnss_serial_free(gserial);
-};
+}
 
 #ifdef CONFIG_OF
 static const struct of_device_id mtk_of_match[] = {
diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index def64b36d994..5d8e9bfb24d0 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -165,7 +165,7 @@ void gnss_serial_free(struct gnss_serial *gserial)
 {
 	gnss_put_device(gserial->gdev);
 	kfree(gserial);
-};
+}
 EXPORT_SYMBOL_GPL(gnss_serial_free);
 
 int gnss_serial_register(struct gnss_serial *gserial)
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 2ecb1d3e8eeb..bcb53ccfee4d 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -551,7 +551,7 @@ static void sirf_remove(struct serdev_device *serdev)
 		regulator_disable(data->vcc);
 
 	gnss_put_device(data->gdev);
-};
+}
 
 #ifdef CONFIG_OF
 static const struct of_device_id sirf_of_match[] = {
diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 7b05bc40532e..c951be202ca2 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -126,7 +126,7 @@ static void ubx_remove(struct serdev_device *serdev)
 	if (data->v_bckp)
 		regulator_disable(data->v_bckp);
 	gnss_serial_free(gserial);
-};
+}
 
 #ifdef CONFIG_OF
 static const struct of_device_id ubx_of_match[] = {
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7B1A4516
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDJKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 06:19:17 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34484 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgDJKTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:19:17 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03AAJ8WW014694;
        Fri, 10 Apr 2020 12:19:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 25/23] floppy: make sure to reset all FDCs upon resume()
Date:   Fri, 10 Apr 2020 12:19:02 +0200
Message-Id: <20200410101904.14652-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-23-w@1wt.eu>
References: <20200331094054.24441-23-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In floppy_resume() we don't properly reinitialize all FDCs, instead
we reinitialize the current FDC once per available FDC because value
-1 is passed to user_reset_fdc(). Let's simply save the current drive
and properly reinitialize each FDC.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8da7921659f1..b102f55dfa5d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4545,11 +4545,13 @@ static void floppy_device_release(struct device *dev)
 static int floppy_resume(struct device *dev)
 {
 	int fdc;
+	int saved_drive;
 
+	saved_drive = current_drive;
 	for (fdc = 0; fdc < N_FDC; fdc++)
 		if (fdc_state[fdc].address != -1)
-			user_reset_fdc(-1, FD_RESET_ALWAYS, false);
-
+			user_reset_fdc(REVDRIVE(fdc, 0), FD_RESET_ALWAYS, false);
+	set_fdc(saved_drive);
 	return 0;
 }
 
-- 
2.20.1


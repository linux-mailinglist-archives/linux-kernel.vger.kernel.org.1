Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2CF19E1BB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 02:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDDAAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 20:00:08 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40293 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgDDAAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 20:00:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vH454MQJzWS;
        Sat,  4 Apr 2020 02:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585958405; bh=rF9Azg0yoCvSWs6Gga3gO15qve4vsBHrMOl9X8Urzq0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=rv1jB5t1iZLbK+mzmx5a3MMuCB8fobnQXVTL2JGZLKmN2Ah0/TASh+FoN/3usSH/G
         Q89dmpdn4+Jbp2bM8YyEFi6etGB1qfdY3Y65Q8+yIt9zA6exmNDPShnJmCi5JaRI6z
         2MvXsUJeRDM7AhX3cLWkyRE86lZSfXyn4pqlkf5UAmgp7AX2rqgHoCi58twvgMLO6x
         3I9nPc+4s63dalS9H4xnUC3WJ4S7ygptkPDZnc0ojMJrnlKrQwfRu9/+4+9empDgMh
         QTJQMRELun9g6Cd3UEndjlrjjkfRt+49yGNb9gMk2IXWhlJ1wOy55wXEcZUXZ/zcCy
         2yxgTfHDStXvA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 04 Apr 2020 02:00:05 +0200
Message-Id: <bf69d78d3614d25821db6f1ccb8b6911ed43d2b1.1585958250.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
References: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/5] usb: chipidea: usb2: fix formatting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces before closing braces.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 62cf8a99cf78..bf300a234e64 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -33,8 +33,8 @@ static const struct ci_hdrc_platform_data ci_zynq_pdata = {
 };
 
 static const struct of_device_id ci_hdrc_usb2_of_match[] = {
-	{ .compatible = "chipidea,usb2"},
-	{ .compatible = "xlnx,zynq-usb-2.20a", .data = &ci_zynq_pdata},
+	{ .compatible = "chipidea,usb2" },
+	{ .compatible = "xlnx,zynq-usb-2.20a", .data = &ci_zynq_pdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_usb2_of_match);
-- 
2.20.1


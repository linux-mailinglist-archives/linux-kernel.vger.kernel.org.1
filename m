Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD602CF29B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbgLDRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:05:28 -0500
Received: from latitanza.investici.org ([82.94.249.234]:47355 "EHLO
        latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgLDRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:05:26 -0500
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfFl70CTz8sj5;
        Fri,  4 Dec 2020 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101483;
        bh=3TDaxIk3qaz2HcMErSZKF6ZFVsiVELk5Alr3JxrBrw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C04cefqXlKXobHFRfE8VmBbY+UyYIv881PE7UmyrCMfLJ7vMWyEsYeba75zKznWzJ
         GzwRX5nXxd1A++oVQMxoakccosirYT3cv5AVEqlbf706Rq9yfYo8PfXCrFLBsAwkRf
         ZgbVFEBRRwObAtqUZLZ1rhR03BJ3tmD+k4N8NggQ=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfFl2NvVz8sj2;
        Fri,  4 Dec 2020 17:04:43 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 11/12] musb: Replace strstarts() by str_has_prefix().
Date:   Fri,  4 Dec 2020 18:03:17 +0100
Message-Id: <20201204170319.20383-12-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The two functions indicates if a string begins with a given prefix.
The only difference is that strstarts() returns a bool while str_has_prefix()
returns the length of the prefix if the string begins with it or 0 otherwise.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 drivers/usb/musb/musb_cppi41.c  |  4 ++--
 drivers/usb/musb/musb_debugfs.c | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 7fbb8a307145..a6d22c0957c5 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -686,9 +686,9 @@ static int cppi41_dma_controller_start(struct cppi41_dma_controller *controller)
 		ret = of_property_read_string_index(np, "dma-names", i, &str);
 		if (ret)
 			goto err;
-		if (strstarts(str, "tx"))
+		if (str_has_prefix(str, "tx"))
 			is_tx = 1;
-		else if (strstarts(str, "rx"))
+		else if (str_has_prefix(str, "rx"))
 			is_tx = 0;
 		else {
 			dev_err(dev, "Wrong dmatype %s\n", str);
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 30a89aa8a3e7..47fc32bc6507 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -181,36 +181,36 @@ static ssize_t musb_test_mode_write(struct file *file,
 		goto ret;
 	}
 
-	if (strstarts(buf, "force host full-speed"))
+	if (str_has_prefix(buf, "force host full-speed"))
 		test = MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS;
 
-	else if (strstarts(buf, "force host high-speed"))
+	else if (str_has_prefix(buf, "force host high-speed"))
 		test = MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS;
 
-	else if (strstarts(buf, "force host"))
+	else if (str_has_prefix(buf, "force host"))
 		test = MUSB_TEST_FORCE_HOST;
 
-	else if (strstarts(buf, "fifo access"))
+	else if (str_has_prefix(buf, "fifo access"))
 		test = MUSB_TEST_FIFO_ACCESS;
 
-	else if (strstarts(buf, "force full-speed"))
+	else if (str_has_prefix(buf, "force full-speed"))
 		test = MUSB_TEST_FORCE_FS;
 
-	else if (strstarts(buf, "force high-speed"))
+	else if (str_has_prefix(buf, "force high-speed"))
 		test = MUSB_TEST_FORCE_HS;
 
-	else if (strstarts(buf, "test packet")) {
+	else if (str_has_prefix(buf, "test packet")) {
 		test = MUSB_TEST_PACKET;
 		musb_load_testpacket(musb);
 	}
 
-	else if (strstarts(buf, "test K"))
+	else if (str_has_prefix(buf, "test K"))
 		test = MUSB_TEST_K;
 
-	else if (strstarts(buf, "test J"))
+	else if (str_has_prefix(buf, "test J"))
 		test = MUSB_TEST_J;
 
-	else if (strstarts(buf, "test SE0 NAK"))
+	else if (str_has_prefix(buf, "test SE0 NAK"))
 		test = MUSB_TEST_SE0_NAK;
 
 	musb_writeb(musb->mregs, MUSB_TESTMODE, test);
-- 
2.20.1


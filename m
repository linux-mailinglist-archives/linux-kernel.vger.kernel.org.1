Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85C02423B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 03:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHLBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 21:31:47 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:53628 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgHLBbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:31:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BRBxj74SVz8r;
        Wed, 12 Aug 2020 03:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597195898; bh=BhbnThh734Nzl8xThcSqWlmj3ApkVzpWgsxrjxY7oqk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=HmrNmlXO2SIRXrFtlbmm4i+3Z/rwAiaArpUFwwuAyJvNfCeHDf3+ccYyIu+no9H/e
         dKHC+eRvr6IJJ8TTDLjdP1S80feC0sYMFd0+BldSofGby1+HaSe12uPzrTu+NMOAnN
         7Dv/wFEjM1UxODytTdnC6stmhTu5SAgwMkQoXDHcpVwLoHXNXZ+zNfcKJkWFOGmQxz
         HrpzT77hu0QBv3NsAdrRiiLTqkhONb8ePNRr02vjG4hEDIOm6ra7+dL9/OcxrG/fpA
         qbf1dl425fO5yp1MJHOuRvDprdmotITE04S3VYvgNN9G/uGPXRkskOt+2qVXLsY/fT
         43lZga0++l6aQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 12 Aug 2020 03:31:37 +0200
Message-Id: <3ff002c7aa3bd774491af4291a9df23541fcf892.1597195321.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 6/7] regulator: cleanup regulator_ena_gpio_free()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since only regulator_ena_gpio_request() allocates rdev->ena_pin, and it
guarantees that same gpiod gets same pin structure, it is enough to
compare just the pointers. Also we know there can be only one matching
entry on the list. Rework the code take advantage of the facts.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 448a267641df..bfd4114d6654 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2260,19 +2260,19 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 
 	/* Free the GPIO only in case of no use */
 	list_for_each_entry_safe(pin, n, &regulator_ena_gpio_list, list) {
-		if (pin->gpiod == rdev->ena_pin->gpiod) {
-			if (pin->request_count <= 1) {
-				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
-				list_del(&pin->list);
-				kfree(pin);
-				rdev->ena_pin = NULL;
-				return;
-			} else {
-				pin->request_count--;
-			}
-		}
+		if (pin != rdev->ena_pin)
+			continue;
+
+		if (--pin->request_count)
+			break;
+
+		gpiod_put(pin->gpiod);
+		list_del(&pin->list);
+		kfree(pin);
+		break;
 	}
+
+	rdev->ena_pin = NULL;
 }
 
 /**
-- 
2.20.1


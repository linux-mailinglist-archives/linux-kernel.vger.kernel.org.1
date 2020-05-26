Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D519E1DC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 02:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDDAMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 20:12:00 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:30304 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgDDAL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 20:11:59 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vHKn5MRwzBh;
        Sat,  4 Apr 2020 02:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585959117; bh=0Pswf+vz2pxT8SBuz/XAQm33cUJ1w9kVwcd2epzBoxE=;
        h=Date:From:Subject:To:Cc:From;
        b=fBO4pc4WoebiKwXXD6pf97eoNMjlBNYtJcsW7+ROf4HeJEXoHhmq5DR0aThh4WfU+
         9HhsAbvp/I9mjsMieC6EvFeoKITIyQm2iYRpPP6fw9KtQkmrQY62lPhEoyOZUvNyEf
         GEIE0XGOnMaQBms7fJ2cKo+iUSjLXucKjjjmS1a0JPU5lXrkpGZoPfQYr4+ikBYDos
         UvFDqE0/FY7R5HO8tb0yk+PE5lIvXYES4t7p/oJmDOMJ46I65cwf+xP5Dob6ceoFwe
         V07E867rVPctfWZ02X31n9+nMY/JUqz/8PnZexuSRUANpxNSIoa6Waany4Iw7FhfXZ
         R9sZgoLzC5+tg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 04 Apr 2020 02:11:57 +0200
Message-Id: <731a4b299c6ae0ee9d8995157600a3477f21a36c.1585959068.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regulator: use consumer->supply_name in
 debugfs/regulator_summary
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com> (supporter:VOLTAGE AND CURRENT
        REGULATOR FRAMEWORK),
        Mark Brown <broonie@kernel.org> (supporter:VOLTAGE AND CURRENT
        REGULATOR FRAMEWORK),
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it easier to identify regulator consumers when consumer device
uses more than one supply.

Before:

  regulator                      ena use open bypass voltage current min     max
 -----------------------------------------------------------------------------------
  regulator-dummy                  1   0    2      0     0mV     0mA 0mV     0mV
     1-0010                                                          0mV     0mV
     1-0010                                                          0mV     0mV

After:

  regulator                      ena use open bypass voltage current min     max
 -----------------------------------------------------------------------------------
  regulator-dummy                  1   0    2      0     0mV     0mA 0mV     0mV
     1-0010-vccio                                                    0mV     0mV
     1-0010-vcc33                                                    0mV     0mV

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c340505150b6..ad143004c32b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5496,6 +5496,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 		seq_printf(s, "%*s%-*s ",
 			   (level + 1) * 3 + 1, "",
 			   30 - (level + 1) * 3,
+			   consumer->supply_name ? consumer->supply_name :
 			   consumer->dev ? dev_name(consumer->dev) : "deviceless");
 
 		switch (rdev->desc->type) {
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD5300BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbhAVSoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729790AbhAVSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611340376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3cpCSqh66HV5kyjhmqDruiKWm7pAVeqbEohNdoD344o=;
        b=ikTevgtQWGWQb97JwcRi35H75fMS+4IxOmrfcvDIqAyZnDFgfn2xRgq9Lt5GawHlSpQPdX
        6LGjhwRnijMgOHQ6/Z0wRW+mSimBEhGb0L7fCIFc3uEx1ylxLGlsh+eUBw6uYZpiPWtuOZ
        PV7C71sgJ4HdDTCVLpmjwTFozLMXtb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-ncLZ1jqPNYiRSQ7CObBVIw-1; Fri, 22 Jan 2021 13:32:53 -0500
X-MC-Unique: ncLZ1jqPNYiRSQ7CObBVIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B945C1005513;
        Fri, 22 Jan 2021 18:32:52 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-174.ams2.redhat.com [10.36.112.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 985E319C44;
        Fri, 22 Jan 2021 18:32:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] regulator: core: Avoid debugfs: Directory ... already present! error
Date:   Fri, 22 Jan 2021 19:32:50 +0100
Message-Id: <20210122183250.370571-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes regulator_get() gets called twice for the same supply on the
same device. This may happen e.g. when a framework / library is used
which uses the regulator; and the driver itself also needs to enable
the regulator in some cases where the framework will not enable it.

Commit ff268b56ce8c ("regulator: core: Don't spew backtraces on
duplicate sysfs") already takes care of the backtrace which would
trigger when creating a duplicate consumer symlink under
/sys/class/regulator/regulator.%d in this scenario.

Commit c33d442328f5 ("debugfs: make error message a bit more verbose")
causes a new error to get logged in this scenario:

[   26.938425] debugfs: Directory 'wm5102-codec-MICVDD' with parent 'spi-WM510204:00-MICVDD' already present!

There is no _nowarn variant of debugfs_create_dir(), but we can detect
and avoid this problem by checking the return value of the earlier
sysfs_create_link_nowarn() call.

Add a check for the earlier sysfs_create_link_nowarn() failing with
-EEXIST and skip the debugfs_create_dir() call in that case, avoiding
this error getting logged.

Fixes: c33d442328f5 ("debugfs: make error message a bit more verbose")
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ca03d8e70bd1..75ec6f334506 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1617,7 +1617,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  const char *supply_name)
 {
 	struct regulator *regulator;
-	int err;
+	int err = 0;
 
 	if (dev) {
 		char buf[REG_STR_SIZE];
@@ -1663,8 +1663,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 		}
 	}
 
-	regulator->debugfs = debugfs_create_dir(supply_name,
-						rdev->debugfs);
+	if (err != -EEXIST)
+		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);
 	if (!regulator->debugfs) {
 		rdev_dbg(rdev, "Failed to create debugfs directory\n");
 	} else {
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1299B2E32C5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgL0VOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgL0VOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vm7Y8WgzRnmtdtSY9WnjMOrzj5tbdz7TQz37CAGCkhc=;
        b=YQo1yVkB8y4JR4Xk2kSXu+GF2UI+SZyn6Dt4gBDVawC2moloSz4n3N8sFhANjXbO5+m8jw
        eIAdW4ggajWz0VbfbD2HCTWIyr1sOEnsscPAJprVh3RRdMKYMVO41TsMQ50qcxsxFtX80A
        /p/1cUTYMVDYNqIQLxcSMd37xVmdM0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-gETInfbCN6GPEb1do1u5WQ-1; Sun, 27 Dec 2020 16:12:43 -0500
X-MC-Unique: gETInfbCN6GPEb1do1u5WQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B190107ACE4;
        Sun, 27 Dec 2020 21:12:41 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7A41ACB9;
        Sun, 27 Dec 2020 21:12:39 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 02/14] mfd: arizona: Add MODULE_SOFTDEP("pre: arizona_ldo1")
Date:   Sun, 27 Dec 2020 22:12:20 +0100
Message-Id: <20201227211232.117801-3-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The (shared) probing code of the arizona-i2c and arizona-spi modules
takes the following steps during init:

1. Call mfd_add_devices() for a set of early child-devices, this
includes the arizona_ldo1 device which provides one of the
core-regulators.

2. Bulk enable the core-regulators.

3. Read the device id.

4. Call mfd_add_devices() for the other child-devices.

This sequence depends on 1. leading to not only the child-device
being created, but also the driver for the child-device binding
to it and registering its regulator.

This requires the arizona_ldo1 driver to be loaded before the
shared probing code runs. Add a doftdep for this to both modules to
ensure that this requirement is met.

Note this mirrors the existing MODULE_SOFTDEP("pre: wm8994_regulator")
in the wm8994 code, which has a similar init sequence.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/arizona-i2c.c | 1 +
 drivers/mfd/arizona-spi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 4b58e3ad6eb6..2a4a3a164d0a 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -115,6 +115,7 @@ static struct i2c_driver arizona_i2c_driver = {
 
 module_i2c_driver(arizona_i2c_driver);
 
+MODULE_SOFTDEP("pre: arizona_ldo1");
 MODULE_DESCRIPTION("Arizona I2C bus interface");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 2633e147b76c..704f214d2614 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -110,6 +110,7 @@ static struct spi_driver arizona_spi_driver = {
 
 module_spi_driver(arizona_spi_driver);
 
+MODULE_SOFTDEP("pre: arizona_ldo1");
 MODULE_DESCRIPTION("Arizona SPI bus interface");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62CB2FDC91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbhATWXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:23:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731344AbhATVwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611179409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwWb/jzvcF0HeOiU902re41Et7/qhlMHI34fzUY/I1I=;
        b=Brg3nKvJjCzp9VKIsxNJ6JMirvDCvHayOqJa6sEkKBbH13Ijy8e994svvQneQOVRdrjrHd
        5BPjgX+BUxNNnjvYlQatFKQP6JiEhvwrKyQSPn2230f5vDZPSlxYKBtQyIUYK+4sB4GHWd
        UWBLkRXqeTNyEgTsgSbzPmR5ajCm8mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-DW4KbaaFP52ECPAscXvJHw-1; Wed, 20 Jan 2021 16:50:06 -0500
X-MC-Unique: DW4KbaaFP52ECPAscXvJHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F18051BE;
        Wed, 20 Jan 2021 21:50:04 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-1.ams2.redhat.com [10.36.114.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9C6627DD;
        Wed, 20 Jan 2021 21:50:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 1/5] mfd: arizona: Add MODULE_SOFTDEP("pre: arizona_ldo1")
Date:   Wed, 20 Jan 2021 22:49:53 +0100
Message-Id: <20210120214957.140232-2-hdegoede@redhat.com>
In-Reply-To: <20210120214957.140232-1-hdegoede@redhat.com>
References: <20210120214957.140232-1-hdegoede@redhat.com>
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
shared probing code runs. Add a softdep for this to both modules to
ensure that this requirement is met.

Note this mirrors the existing MODULE_SOFTDEP("pre: wm8994_regulator")
in the wm8994 code, which has a similar init sequence.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
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


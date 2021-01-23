Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7863301511
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 13:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbhAWMQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 07:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbhAWMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 07:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611404010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSSv/cvHQku1Gh6c6/+OkvTHC43scQr7nzlxM4hYCrU=;
        b=cwmA8MNuLsqXbvSkIFMXzP8sdzVG6vtbZwtk/8nKI+pd+dpb47raGFZ9E7ONq/tcRl5jG4
        vRwH2C7MpiRJ5+3p6JK6mlje5/mXa/Z8Cqr+LV1cpvkKtg/s7r9r7ygXnhx9bCZmvBm36N
        GaNImj6NQrEAUrqXy+5NhCoxXQPB/wE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-gxjqmD-IPy-0_ByU3AT-tg-1; Sat, 23 Jan 2021 07:13:28 -0500
X-MC-Unique: gxjqmD-IPy-0_ByU3AT-tg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1255A806661;
        Sat, 23 Jan 2021 12:13:27 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-82.ams2.redhat.com [10.36.112.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB981189B8;
        Sat, 23 Jan 2021 12:13:24 +0000 (UTC)
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
Subject: [PATCH v4 04/13] extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
Date:   Sat, 23 Jan 2021 13:13:04 +0100
Message-Id: <20210123121313.79530-5-hdegoede@redhat.com>
In-Reply-To: <20210123121313.79530-1-hdegoede@redhat.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial value of the GPIO should match the info->micd_modes[0].gpio
value. arizona_extcon_probe() already stores the necessary flag in a
mode variable, but instead of passing mode as flags to the gpiod_get()
it was using a hardcoded GPIOD_OUT_LOW.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 76aacbac5869..72d23b15108c 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1510,7 +1510,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 		 */
 		info->micd_pol_gpio = gpiod_get_optional(arizona->dev,
 							 "wlf,micd-pol",
-							 GPIOD_OUT_LOW);
+							 mode);
 		if (IS_ERR(info->micd_pol_gpio)) {
 			ret = PTR_ERR(info->micd_pol_gpio);
 			dev_err(arizona->dev,
-- 
2.29.2


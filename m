Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3A300931
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbhAVRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:03:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728688AbhAVQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611333685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNZkCxoZOmDNOt09otT8v1IrfnyE2TFx0xNRU7HNxpM=;
        b=PV9G9gveBic7uSp/rYQTUc/KVmPIi48SyxoDZ2JJJmhWX61gdDPIOuoKxiVIwlTUkzyLln
        5Mpi8sEunzMvVm7TZ890pKWtewVt5EU/2PUqDvkqNPbP6+ytadiwkpqIw5SesbWtNsSba4
        zGbQ4S0z4++YdCWdben21M3qMZ5WUhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-nJ631W6xP5u4PhY_m1yU2w-1; Fri, 22 Jan 2021 11:41:23 -0500
X-MC-Unique: nJ631W6xP5u4PhY_m1yU2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA20CBBEE0;
        Fri, 22 Jan 2021 16:41:21 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-174.ams2.redhat.com [10.36.112.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9F576EF46;
        Fri, 22 Jan 2021 16:41:19 +0000 (UTC)
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
Subject: [PATCH v3 04/13] extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
Date:   Fri, 22 Jan 2021 17:40:58 +0100
Message-Id: <20210122164107.361939-5-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-1-hdegoede@redhat.com>
References: <20210122164107.361939-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
2.28.0


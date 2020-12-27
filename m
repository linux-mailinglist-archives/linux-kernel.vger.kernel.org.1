Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA18F2E32CB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgL0VO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgL0VO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EC/aTHO5BGjbIzin/rZAInkFVqHOEkmhdU6CAhi0o9g=;
        b=YgfjKo5ig5Keiljv17YyhjTZeL728V+AknLcanBRDxaJwq5pzMe3msYwapa7+t1/ajUhbR
        Du1GS4yhWN81P1h9E91UUBTLaIShPdlaZlw15VVbgVtGflhCH0pu91uYBpdA5Bkl3i92UK
        rpw6Vd3Z0UYk4v7UQHIluCKa+1YSB/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-aWhcP1NMOWOfsETGabpNxg-1; Sun, 27 Dec 2020 16:12:58 -0500
X-MC-Unique: aWhcP1NMOWOfsETGabpNxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B547CE75D;
        Sun, 27 Dec 2020 21:12:56 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6701B1ACB9;
        Sun, 27 Dec 2020 21:12:54 +0000 (UTC)
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
Subject: [PATCH 08/14] extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
Date:   Sun, 27 Dec 2020 22:12:26 +0100
Message-Id: <20201227211232.117801-9-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial value of the GPIO should match the info->micd_modes[0].gpio
value. arizona_extcon_probe() already stores the necessary flag in a
mode variable, but instead of passing mode as flags to the gpiod_get()
it was using a hardcoded GPIOD_OUT_LOW.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 95acfe7620fd..145ca5cd40d5 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620152E32CA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgL0VOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgL0VOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1wGRecH9d5WNkaAx38evsg5m9pAaNEKEzOslv2iB/Y=;
        b=FHFsZf7gOWhbL4pPYEof1FpEicXR8nRDdGA3U9fo9TKug9bITm5EqUlMU2tCPvveAeL+N0
        25AUlsnJGoVakMAyXBnA2RI/MR9g53Yr+KVqFCnIAQbM4gUhCvKWV+zXzIks3H1QCKTDJ5
        SqiLw4SRD4qqfAuRAO7KQn9mnkDDfo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-9TsPTeM0O4e1cafHRcgwqg-1; Sun, 27 Dec 2020 16:12:56 -0500
X-MC-Unique: 9TsPTeM0O4e1cafHRcgwqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F82D800D53;
        Sun, 27 Dec 2020 21:12:54 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E763C1ACB9;
        Sun, 27 Dec 2020 21:12:51 +0000 (UTC)
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
Subject: [PATCH 07/14] extcon: arizona: Fix modalias
Date:   Sun, 27 Dec 2020 22:12:25 +0100
Message-Id: <20201227211232.117801-8-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the modalias so that the driver will be loaded automatically. The
module's name is "extcon-arizona", following other extcon module-names.

But the driver's and platform-device's name is "arizona-extcon" and the
modalias must match that.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 76aacbac5869..95acfe7620fd 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1816,4 +1816,4 @@ module_platform_driver(arizona_extcon_driver);
 MODULE_DESCRIPTION("Arizona Extcon driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:extcon-arizona");
+MODULE_ALIAS("platform:arizona-extcon");
-- 
2.28.0


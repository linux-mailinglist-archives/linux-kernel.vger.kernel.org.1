Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF511274295
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIVNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbgIVNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/SdhQW5fw5W5HYVa1+EIBnAaUL1HASIyjoIkGL6WiE=;
        b=iX7IDb2udi1E2gnYQn9Jqco30Td0W3aJRpprmJqvUCWK3o84QG6A/ujS78oV6oAB74vCKh
        5G1Cvi5M3exduGbvbsrwxfHhMA9TgIELvpemtceB7LpDEHY8rY03k/B+dot+BCrB9MZi0r
        h2YrKbi9F3DcFoZabicfrz5yir2Xpsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-k3LUx8y9NhGtVIq-CDxbYA-1; Tue, 22 Sep 2020 09:04:54 -0400
X-MC-Unique: k3LUx8y9NhGtVIq-CDxbYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 283098015FA;
        Tue, 22 Sep 2020 13:04:52 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1644373684;
        Tue, 22 Sep 2020 13:04:49 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 04/13] firmware: arm_sdei: Avoid nested statements in sdei_init()
Date:   Tue, 22 Sep 2020 23:04:14 +1000
Message-Id: <20200922130423.10173-5-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdei_init(), the nested statements can be avoided by bailing
on error from platform_driver_register() or absent ACPI SDEI table.
With it, the code looks a bit more readable.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 0f49fff20cc7..1fa4e577b78e 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1081,17 +1081,18 @@ static bool __init sdei_present_acpi(void)
 
 static int __init sdei_init(void)
 {
-	int ret = platform_driver_register(&sdei_driver);
-
-	if (!ret && sdei_present_acpi()) {
-		struct platform_device *pdev;
-
-		pdev = platform_device_register_simple(sdei_driver.driver.name,
-						       0, NULL, 0);
-		if (IS_ERR(pdev))
-			pr_info("Failed to register ACPI:SDEI platform device %ld\n",
-				PTR_ERR(pdev));
-	}
+	struct platform_device *pdev;
+	int ret;
+
+	ret = platform_driver_register(&sdei_driver);
+	if (ret || !sdei_present_acpi())
+		return ret;
+
+	pdev = platform_device_register_simple(sdei_driver.driver.name,
+					       0, NULL, 0);
+	if (IS_ERR(pdev))
+		pr_info("Failed to register ACPI:SDEI platform device %ld\n",
+			PTR_ERR(pdev));
 
 	return ret;
 }
-- 
2.23.0


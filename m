Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6012A274297
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIVNFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgIVNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjXPgR3xhMvVhsV/g017VW+0bLWetpDVTRtxlxD1aas=;
        b=emWqrbPIvbJH5J3KqxOPOxIjsCvDpJ3TXa+G0GZG8+FvINwIEa+juMX5m+Q6/7KtXLV2mb
        G+PVWnK0Z2vZS/fRyNSnbusccyC8Gx0nQK4XUwnwZ/UsoW61brXsn5ndV7eJYxWhA2E4VH
        ekn4sqYFw4cJ4GCsyYPihwGrQEN1THo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-K1V4j65vMaa1N9iRHJjLsg-1; Tue, 22 Sep 2020 09:04:56 -0400
X-MC-Unique: K1V4j65vMaa1N9iRHJjLsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB98F801AE3;
        Tue, 22 Sep 2020 13:04:54 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8609573670;
        Tue, 22 Sep 2020 13:04:52 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 05/13] firmware: arm_sdei: Unregister driver on error in sdei_init()
Date:   Tue, 22 Sep 2020 23:04:15 +1000
Message-Id: <20200922130423.10173-6-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDEI platform device is created from device-tree node or ACPI
(SDEI) table. For the later case, the platform device is created
explicitly by this module. It'd better to unregister the driver on
failure to create the device to keep the symmetry. The driver, owned
by this module, isn't needed if the device isn't existing.

Besides, the errno (@ret) should be updated accordingly in this
case.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1fa4e577b78e..e7e9059c395b 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1090,9 +1090,12 @@ static int __init sdei_init(void)
 
 	pdev = platform_device_register_simple(sdei_driver.driver.name,
 					       0, NULL, 0);
-	if (IS_ERR(pdev))
-		pr_info("Failed to register ACPI:SDEI platform device %ld\n",
-			PTR_ERR(pdev));
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		platform_driver_unregister(&sdei_driver);
+		pr_info("Failed to register ACPI:SDEI platform device %d\n",
+			ret);
+	}
 
 	return ret;
 }
-- 
2.23.0


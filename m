Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192C72742A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIVNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726671AbgIVNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yl2ucacoHXcwzsM83eJQRYuAtPLhphuchaQ+QgA8Umg=;
        b=MIXRNlQqCDpjL3HTLEorceOlBXrUBqKdsxD2w13NDs8jlm8aXdnM96WPV7Fa412vXj/ytY
        v+oOUdD+xY5xQ2SzwKWnZQmkOjrf8S2bEgiZDyIFkWe7snJFcgssQKhXdmgtHRQeeHoNSX
        FqilKttVBMoN1pnDyEMQLzsKMARwrSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-XvZQPy5iO6-isijmrOEuPA-1; Tue, 22 Sep 2020 09:05:01 -0400
X-MC-Unique: XvZQPy5iO6-isijmrOEuPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC91B1891E85;
        Tue, 22 Sep 2020 13:04:59 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B58773684;
        Tue, 22 Sep 2020 13:04:57 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 07/13] firmware: arm_sdei: Remove redundant error message in sdei_probe()
Date:   Tue, 22 Sep 2020 23:04:17 +1000
Message-Id: <20200922130423.10173-8-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the redundant error message in sdei_probe() because
the case can be identified from the errno in next error message.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 5daa4e20595c..4caeef3e1e0b 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -982,8 +982,6 @@ static int sdei_probe(struct platform_device *pdev)
 		return 0;
 
 	err = sdei_api_get_version(&ver);
-	if (err == -EOPNOTSUPP)
-		pr_err("advertised but not implemented in platform firmware\n");
 	if (err) {
 		pr_err("Failed to get SDEI version: %d\n", err);
 		sdei_mark_interface_broken();
-- 
2.23.0


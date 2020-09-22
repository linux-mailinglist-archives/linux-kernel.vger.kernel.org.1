Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D78274298
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgIVNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbgIVNFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sF00K7uLa4pgR5zvCSv7eqGwCMQfVLndkYmDDleWKdg=;
        b=M15RuNzrbSuByUprVMINOCXM85BTMLKD1XynjPbLJS4NDX/dTf8ccJnDOGUtuNAJV5t4tD
        LUe0fbYR1v6CJIvqDOOWkGyzAdN1n6KUXMnkYiq3zwWBj4ynOYQhDJT+8lRTDiCpkC3XGc
        FxRhAgSKVCG+V78Ccmhx8tQw8JBUo2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-nLspKMAzPmOpPeuNqgWKbg-1; Tue, 22 Sep 2020 09:04:58 -0400
X-MC-Unique: nLspKMAzPmOpPeuNqgWKbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3FF104D3E0;
        Tue, 22 Sep 2020 13:04:57 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D75473670;
        Tue, 22 Sep 2020 13:04:54 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 06/13] firmware: arm_sdei: Remove duplicate check in sdei_get_conduit()
Date:   Tue, 22 Sep 2020 23:04:16 +1000
Message-Id: <20200922130423.10173-7-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two checks are duplicate because @acpi_disabled doesn't
depend on CONFIG_ACPI. So the duplicate check (IS_ENABLED(CONFIG_ACPI))
can be dropped. More details is provided to keep the commit log complete:

   * @acpi_disabled is defined in arch/arm64/kernel/acpi.c when
     CONFIG_ACPI is enabled.
   * @acpi_disabled in defined in include/acpi.h when CONFIG_ACPI
     is disabled.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index e7e9059c395b..5daa4e20595c 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -958,7 +958,7 @@ static int sdei_get_conduit(struct platform_device *pdev)
 		}
 
 		pr_warn("invalid \"method\" property: %s\n", method);
-	} else if (IS_ENABLED(CONFIG_ACPI) && !acpi_disabled) {
+	} else if (!acpi_disabled) {
 		if (acpi_psci_use_hvc()) {
 			sdei_firmware_call = &sdei_smccc_hvc;
 			return SMCCC_CONDUIT_HVC;
-- 
2.23.0


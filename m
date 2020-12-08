Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96442D22E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 06:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgLHFJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 00:09:08 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52756 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgLHFJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 00:09:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B858HUc048119;
        Mon, 7 Dec 2020 23:08:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607404097;
        bh=C6FwkyDgXtSraSg5zTTJYSsWZpjWh6LH1ulfNuODAHE=;
        h=From:To:CC:Subject:Date;
        b=tYmQmQMlhxSd3fPvPJLAZQCGTgVfmX8bBTc0HDGf4ChyGRu3Fj7vCcIcvg8zVz26C
         oNJJQJLooPrlUZOtvr7sXSOV2zXdzua2FQjinLy12qE1ssShHp1z3ggx8dz654tulB
         nMq+DftR/uZoqKNIiBj5QCOXNsqzp3KKAJz0Hxxk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B858HDY129601
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Dec 2020 23:08:17 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Dec
 2020 23:08:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Dec 2020 23:08:17 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B858DFq088962;
        Mon, 7 Dec 2020 23:08:14 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [RESEND PATCH] MAINTAINERS: Add myself as a reviewer for CADENCE USB3 DRD IP DRIVER
Date:   Tue, 8 Dec 2020 10:38:06 +0530
Message-ID: <20201208050806.15382-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to help in reviewing CADENCE USB3 DRD IP DRIVER patches

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Resending the patch to add more viewers.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6aac0f845f34..ff9bd7d18d94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3861,6 +3861,7 @@ CADENCE USB3 DRD IP DRIVER
 M:	Peter Chen <peter.chen@nxp.com>
 M:	Pawel Laszczak <pawell@cadence.com>
 M:	Roger Quadros <rogerq@ti.com>
+R:	Aswath Govindraju <a-govindraju@ti.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
-- 
2.17.1


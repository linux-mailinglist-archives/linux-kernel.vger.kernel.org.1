Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3554E2CF2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgLDRPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:15:39 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42870 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgLDRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:15:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B4HE2Y2018225
        for <linux-kernel@vger.kernel.org>; Fri, 4 Dec 2020 11:14:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607102042;
        bh=HNrijLJnGK3T9CnkGIR6IB4XYT+8wc5LNUFsnL/FAUI=;
        h=From:To:CC:Subject:Date;
        b=r+/p3+ZSqXeLQnh2BnnFv/2BbWsGfHHd1rk0Jn8GcExaZsnd3lFI5IptTYniC6W90
         QXzLShxZnxGsRcc70s+nYVsicdioExPYziba8E/oJcYpR5eyDrs2dCwTNwyR5l/bBX
         fB5BkZsNtDnsqovjpPJGIsW0udKsK2Wvdt5belI8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B4HE277018035
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 4 Dec 2020 11:14:02 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Dec
 2020 11:14:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Dec 2020 11:14:01 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B4HDxB7034323;
        Fri, 4 Dec 2020 11:14:00 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer for CADENCE USB3 DRD IP DRIVER
Date:   Fri, 4 Dec 2020 22:43:57 +0530
Message-ID: <20201204171357.15402-1-a-govindraju@ti.com>
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


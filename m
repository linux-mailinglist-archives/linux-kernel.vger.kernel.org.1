Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500752D4871
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgLIR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:58:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56352 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLIR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:58:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B9HvK6F043926;
        Wed, 9 Dec 2020 11:57:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607536640;
        bh=n2EdWdd2h0GvAOC4E08Jb6Cv4a45zDdLDR18BXOJQv4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gmbqirQKH4aCt0ZakLGl5Nqhn5vhNouSmwOiRoBMB+ccR7uyg8vPfq+DR5406MqsN
         S/vJB767kQD113Fjq5l0f4sOZHDU7lvrEhQ3fWSL29kFXQHeHv4S69VfV/Mcd3D1Eo
         tFFYQRwA6VIvY7liEzJzOZTgY0mWGxGzNe5Y4MEQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B9HvKaJ047440
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Dec 2020 11:57:20 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Dec
 2020 11:57:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Dec 2020 11:57:19 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B9HvATG094634;
        Wed, 9 Dec 2020 11:57:16 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH RFC 1/2] Documentation: devicetree: Add property for ignoring the dummy bits sent before read transfer
Date:   Wed, 9 Dec 2020 23:27:07 +0530
Message-ID: <20201209175708.16252-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209175708.16252-1-a-govindraju@ti.com>
References: <20201209175708.16252-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dummy zero bits are sent before data during a read transfer. This causes
the data read to be shifted to the right. To fix this send zero bits after
the address during a read transfer.

Add property to send zero bits after the address during a read transfer.

Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
index a8ebb4621f79..09fb1cec54f0 100644
--- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
+++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
@@ -10,7 +10,9 @@ Optional properties:
 - read-only : parameter-less property which disables writes to the EEPROM
 - select-gpios : if present, specifies the GPIO that will be asserted prior to
   each access to the EEPROM (e.g. for SPI bus multiplexing)
-
+- read-op-dummy-cycles: If present specifies the number of dummy zero-bits to
+  be sent after the address during a read transfer to ignore any bits sent
+  preceding the data.
 Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
 apply.  In particular, "reg" and "spi-max-frequency" properties must be given.
 
-- 
2.17.1


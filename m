Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4AA27503A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgIWFQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgIWFQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:16:52 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD608C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 22:16:49 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 61A4D806B5;
        Wed, 23 Sep 2020 17:16:45 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1600838205;
        bh=SaTbXFYCY7HlXex9brrvPqrOq0OvcN+7TtVMuJNeQo4=;
        h=From:To:Cc:Subject:Date;
        b=qdnXUJIG153onjjhEOb1waJA/H0+sSEHlyOF1eDYCWU3CDEPr/Y3ahr4a8X6R08r3
         nWsjcMJomDeBKxRY67gxxbjjYxJ5EeBNJ1vzkioZjGHfbNU/HXdlJd+1O+p7wTmC7T
         /w46f+wWdAEGGJ43ZIK/PNK+K7SF8pXvU9MD7LOTauIbK5arGTE6oAKeujYb1767Id
         c7+aEbtxBBkME5yXu8JO4cNnWizqMQEQ6pF/XuGl7TcrpU2q4tgZOqojzZuC5xoMsI
         T+nXGQaWU0j1a0V44q3EwBwnrObsxJrTwLNf+70PZsXVt+80pitXo6zkHoTDVmY2tZ
         DjMB/kx7GaOXQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f6ada3a0000>; Wed, 23 Sep 2020 17:16:45 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id D393C13EEB7;
        Wed, 23 Sep 2020 17:16:41 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2A811280055; Wed, 23 Sep 2020 17:16:42 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, trivial@kernel.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] dt-bindings: Add LM81 and DS1780 as trivial devices
Date:   Wed, 23 Sep 2020 17:16:37 +1200
Message-Id: <20200923051637.30464-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM81 and DS1780 are close relatives of the ADM9240 and already
supported by the same driver. Document them as trivial devices.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I wasn't sure if I should put the LM81 under "national" or "ti". In the
end I went with "national" because of all the other existing lm8x variant=
s.

 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
index 4ace8039840a..6cfeee1b4527 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -54,6 +54,8 @@ properties:
           - dallas,ds1682
             # Tiny Digital Thermometer and Thermostat
           - dallas,ds1775
+            # CPU Peripheral Monitor
+          - dallas,ds1780
             # CPU Supervisor with Nonvolatile Memory and Programmable I/=
O
           - dallas,ds4510
             # Digital Thermometer and Thermostat
@@ -296,6 +298,8 @@ properties:
           - national,lm75
             # Serial Interface ACPI-Compatible Microprocessor System Har=
dware Monitor
           - national,lm80
+            # Serial Interface ACPI-Compatible Microprocessor System Har=
dware Monitor
+          - national,lm81
             # Temperature sensor with integrated fan control
           - national,lm85
             # I2C =C2=B10.33=C2=B0C Accurate, 12-Bit + Sign Temperature =
Sensor and Thermal Window Comparator
--=20
2.28.0


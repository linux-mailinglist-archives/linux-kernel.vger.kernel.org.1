Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4782F2F4986
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbhAMLCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbhAMLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A58CA233E2;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=X7nJI38NR4TtargsVEBZ/Y+J+5Kx9yFaVy/hocRvqJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gO9blKt8nIjk+NNG/KVvA5FpH6K+++4ZibvfojcDrpO+VG6+zMJA7OlrnDdBSpWo8
         xNefvIbmRO0pimbz4LyqUkTwR2CYNxmBVsAdUiq6GDnGQcRxhaOpc7XqykN7WaQMrU
         f0dtD965nZHzWU2eWGG31EKsVPV8PXiRryg5GSpfXMFciz6q4XHV67xqisA3QHOF/+
         JzM11+M6eeM5etOb33hXCIzsZjkWwd8NCcaBDi0Glje5CxllWLngYaCyp85/DB7Yr1
         mG8Z4wZ6KhjWJTgS9bwC7Xu1g+4bL0v+zngC/5GFsliP64PB+U+xoWt1d6UdQVPJAZ
         uf2CbOd+Smt9g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGD-D9; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/24] MAINTAINERS: update atmel,sama5d2-adc.yaml reference
Date:   Wed, 13 Jan 2021 11:59:11 +0100
Message-Id: <8622ae7ce2966826b45938fdbc4fa516a3c9f6fe.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 58ff1b519753 ("dt-bindings:iio:adc:atmel,sama5d2-adc: txt to yaml conversion")
renamed: Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
to: Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a35f1bb9ae44..12609dbe15a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11789,7 +11789,7 @@ MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+F:	Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
 F:	drivers/iio/adc/at91-sama5d2_adc.c
 F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
 
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5A2F493B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbhAMLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbhAMLAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75EC2224B0;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=y+ENxO6fogU99ORCO8xr4UpDZT49yjmxWCfiIejsSWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIIr2laNWy4rQidI2P9Wn6xsT6XmK1DpDnb8FKyY+xMBbgnpFuY9c4jrbrLm+GwR2
         GfIc197OxegviK5gKq9HG9ZUW2v/9tlOwiGqmGkum6KA0BV4cmwLIuocxtgpvc+gMJ
         gyN6cReyFHKIXKCK9RR/LKaGvaGBZqL+pTiwTb8jskXdgsncxIFPy955OuahneDGLB
         tKa1MuBClTN6C79Tz8Sna7h+AyYwIEiG/U96owfsm5krW0A6eAsu3XSxtr0AWdBrZB
         LabyGQvzU7aIRFUCRBxBKg6fR02L9bjufI0A29owCrEUSRDTwOE6Pz5udNuSgk9I6/
         GSTuUWuTqK4oQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpFq-31; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/24] MAINTAINERS: update adi,ad5758.yaml reference
Date:   Wed, 13 Jan 2021 11:59:02 +0100
Message-Id: <f492bd7d4c1717f04b59ee364459bf0d999fc4c7.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 1e6536ee349b ("dt-bindings:iio:dac:adi,ad5758 yaml conversion")
renamed: Documentation/devicetree/bindings/iio/dac/ad5758.txt
to: Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 289465785e88..68f43b83235b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1132,7 +1132,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	Documentation/devicetree/bindings/iio/*/adi,*
-F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
 F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc249*
 F:	drivers/iio/amplifiers/hmc425a.c
-- 
2.29.2


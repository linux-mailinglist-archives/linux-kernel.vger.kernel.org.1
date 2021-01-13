Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95D62F4949
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbhAMLBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38835 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbhAMLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E966233A1;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=Y4qatxt3HZ54IM23vdEC4AIY04tzsOM8RzYEpJ3qLWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJgvEqSnEcQp5+xJw9mxxoCM0YhYXKYh1R5DbQw4n27smXvWb80slWJnvlE4aqHhs
         7J4vCn5PBYHiNxilB7How70CvwEZgLTKIRs0LL5IIuSy5T25/UBjrKwx7rKjuH0EtM
         4HudAfwko+VQ51BeFJlw0ipB6n2PzBsVnpZmA9zYEi650hNyEm36OE6JhcGwgjWZqV
         mJPb19smVjE9ANjaYTgVtcezcEcTbim0j/v7p7PwRqPmqPS3N0JcwWsyubvA47B3H4
         WPFg5ZYjtwNDUM8WXE/9O6AYkJTXcHZJy0h/sIbpyzwSJtzk9mi/GiW1QApLlQYSnO
         3NEikG1NVI5rw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGI-F2; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/24] MAINTAINERS: update renesas,rcar-gyroadc.yaml reference
Date:   Wed, 13 Jan 2021 11:59:13 +0100
Message-Id: <6b06d136d9fae99af67410a86893e83ee9491d96.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 8c41245872e2 ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
to: Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4fee1b3d768..e5d2f3ef659c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15215,7 +15215,7 @@ RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
+F:	Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
 F:	drivers/iio/adc/rcar-gyroadc.c
 
 RENESAS R-CAR I2C DRIVERS
-- 
2.29.2


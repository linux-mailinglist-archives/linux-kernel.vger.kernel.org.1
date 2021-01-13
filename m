Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409FD2F4953
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbhAMLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbhAMLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 998C42339F;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=2/1q8BZx5WBeuiCKmec8rkDOjUolBoL3/eOshkJJtbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogq4aDxjSn0hFMEbAIwFtwN8eBeJkO/PqOmdHbVHmQM5wcLfkycA1Zq2QDjPaHv6T
         WTn8oCHs9a3xEOXg+7kPkNN11W9QPOgOwRJTA/NlNlr/63maT4tzHuaGiScVBciFWf
         VmqytWWrB+ULrtIIe/bbqYbskDfwRCt4i9d1HO+NU5Hh5pb26usSQ43sf5005wUpa4
         JF97EXOVAIuKKaAxRC8u3VDhMrojjavPa2G3i61hNynihZEUEpfi0XkZk0vFiIawk/
         VAf/Yqj2iEJc84srWX62XG9fM1cKlFCbU87f/2LdjboIC7Zq3aDGIfOfzBgS39uz3g
         TlH9YrvjH2sOQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGS-Hy; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] MAINTAINERS: update st,vl53l0x.yaml reference
Date:   Wed, 13 Jan 2021 11:59:15 +0100
Message-Id: <55bc685f4767ee28ec2c38d40f14ddaf86974dbf.1610535350.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset b4be8bd1c6a2 ("dt-bindings:iio:proximity:st,vl53l0x yaml conversion")
renamed: Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
to: Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bba2d2d8576a..17640957fc93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16898,7 +16898,7 @@ ST VL53L0X ToF RANGER(I2C) IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
+F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
 STABLE BRANCH
-- 
2.29.2


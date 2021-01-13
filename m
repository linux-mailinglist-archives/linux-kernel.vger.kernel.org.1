Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291C72F493C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhAMLAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbhAMLAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7923F23136;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=OzCLscW+xbktqDDGJ4jmCFt52UXDf5xySBxk2PLsgLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIaUzDxRm9Z6JJjhN1TptwwvzDnGsk293Z1eL3o0AnsrwOPIfM6/URhBFJjpJmL50
         M/WRac6oo3Gcff3VryIS3PEdTBTAN/Vxed6j/RZLxqNvnXhND5pr/bY3qcVsCBRAxW
         955wbNvIHVOht2wIVbcUZC42rq37CfxOpHc1P+CVtj5Uj0hlYgRBABkLro0AULNdxh
         gc3wEP4bCeMwyKN4PXpDUrZoT8JpztQVAiNNyGYPa5i31rNRQ9ja5KM5m0gSf3sNxj
         o83ddShL09xsh/zkTuy/K5LdqrgCmSyR7bl8nJrtiEy5otemSuucl0bCjpgtoaQHD0
         h3zUGi4TUUIQg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGF-E5; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/24] MAINTAINERS: update pni,rm3100.yaml reference
Date:   Wed, 13 Jan 2021 11:59:12 +0100
Message-Id: <bac1a7e1658cf255225d4f570703f4e3d6bb1c5b.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset f383069be33e ("dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
to: Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12609dbe15a3..e4fee1b3d768 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14265,7 +14265,7 @@ PNI RM3100 IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
+F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml
 F:	drivers/iio/magnetometer/rm3100*
 
 PNP SUPPORT
-- 
2.29.2


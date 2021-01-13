Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35912F497E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbhAMLCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbhAMLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE80D233F8;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=0KUSOcYdlFDQOmEbTyJ1Jg7PLXqu+3897CFhO7LpT3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRnAZnuxpXzHOLJkYUtl6MOGaQ8LHbpMYCuC91SnWFn6xIyGRnUx+u6L4WYzw0BRJ
         NR0PXtozoxbs4ynR2qNB9QlXmVwkbcqUF28sy74KnIxzStojzdJsvsN6BnY0Mj+LhD
         3E9ANQ9J/8Ou5s8AICWNU5rStDTytv7G7uxlGc4VA2vueI42V4z+TVgAQffpb0t6Ky
         igJY4S3vsJWy00YV6s+8D9JCw0eIWZmS1FvtJqknStfUySab0Jy7CEprg1TDdxRgRq
         gPyXiP4wuObU/5CqK9H1CvyhAVgZSRF9ZAm6f3+prifRa64QpNxdo7haMiaXYpBN2d
         ABqjzBLTWF1tg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGA-CE; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/24] MAINTAINERS: update mtk-sd.yaml reference
Date:   Wed, 13 Jan 2021 11:59:10 +0100
Message-Id: <4f691aef6e2f20d4189413c62b17e780e07cc5f7.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset c626695ecd8b ("dt-bindings: mmc: Convert mtk-sd to json-schema")
renamed: Documentation/devicetree/bindings/mmc/mtk-sd.txt
to: Documentation/devicetree/bindings/mmc/mtk-sd.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6083de743261..a35f1bb9ae44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11272,7 +11272,7 @@ F:	drivers/media/platform/mtk-vpu/
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/mmc/mtk-sd.txt
+F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
 F:	drivers/mmc/host/mtk-sd.c
 
 MEDIATEK MT76 WIRELESS LAN DRIVER
-- 
2.29.2


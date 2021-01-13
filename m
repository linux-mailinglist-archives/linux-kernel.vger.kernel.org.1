Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3392F4985
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbhAMLCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:02:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbhAMLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A15F0233A2;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=Obtl3V/dKh9fcLvT5bqFekZ52N8lhZOu2qB63wUND/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNLK04Nzn9zHBjNCSXrJkoadoLv7bAAD7+A4HFHRo0IWI/W/Ihdc33+xayPX9FfCg
         BBuREFi1kMYWOrLaWRDGw9GLr24qCPVIvEPiRzBBV4RilTfLf7wT7I8iGCar/Iw3oa
         YX11xPa2oip9RpAd4CuRUjmCvgIb12P60h5jzRwIjEZVGoYgjwHL/uWF9bcn8Mebo7
         XV0KDDtlGlhv62en6UnD8CAwsKMQdOIKk5jD9dfub8cCB0te7I0XEXQ3lsk86XWOtp
         P9EbS06v8uEqApqM7583p6aLc/o+IosCAj8rDLw44cU/CJb2jowMG51hinlEdJJaYW
         JXjweXOQx/DbQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpFs-40; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/24] MAINTAINERS: update fsl,dpaa2-console.yaml reference
Date:   Wed, 13 Jan 2021 11:59:03 +0100
Message-Id: <f2ac1f87defc09096af430390376013bc33531e9.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 616fde2dd60f ("dt-bindings: misc: convert fsl,dpaa2-console from txt to YAML")
renamed: Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
to: Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f43b83235b..7578b9798bfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7201,7 +7201,7 @@ M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
+F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
 F:	Documentation/devicetree/bindings/soc/fsl/
 F:	drivers/soc/fsl/
 F:	include/linux/fsl/
-- 
2.29.2


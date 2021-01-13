Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC55D2F4945
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbhAMLAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbhAMLAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 721C522210;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=A1/jWq+ulvdeKmLLzYTSgBXqmDV0uyq0oC2EsyGiWSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwDNkHHzAmRXOneYOma5RPx7xsxcpkUuZqqF+Bl8bh+NU6RyYpEUSAkZ+BIkn/gPt
         hZgFo80KZOH2gYdEy+TGpbbzbK6FCsgrQ44El2XdRpjh7Ty0zxhqybvpWDjsCUIlLe
         y04+1m6oXkWd2WXKVNSNrc0Qrr5+9yXXHyT3akngAyG5IpFq2ixLJ603QhYLr6MTqT
         zldgB8drQaiwLxYGqqDOFhU/q6iw6MD7kMerHQPwnmRP1CgL29IeWnKi14UWr67R83
         MF6xX3J1QkVdS6lqTDzciqBIbaSTGP1Dv/DYuPxvbwURURjL0Py1Pr0U/k5M8rdq0Q
         +dHgfPDgXagqg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpG1-8Z; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/24] MAINTAINERS: update current-sense-amplifier.yaml reference
Date:   Wed, 13 Jan 2021 11:59:07 +0100
Message-Id: <8f4dfc7ab47ccc864c51ec0a18f64bc3fe0be1d5.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset fbac26b9ad21 ("dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
to: Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2579cdad3ab..832297460974 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8720,7 +8720,7 @@ IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 F:	drivers/iio/afe/iio-rescale.c
-- 
2.29.2


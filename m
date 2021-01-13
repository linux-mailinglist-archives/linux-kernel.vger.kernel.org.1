Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72CC2F4952
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbhAMLBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbhAMLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3534233CE;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=9tGeeLO4hOolI7+7NkhkSi1HaErIWgKThp7sxRk1wlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpOJxbPbH5aE0rd33M++ikf/7usgqJAJdNzgMlQiIF69vnRinGpID5WhyB7vCbnSV
         T0iKXg4nNMRYIDd+/9rdaL6dxTS9RGZ7HuK9Tejr01boWDlNsnRJ1iA0SBfQGzPuBE
         rDuQSl1hmTld3y8MC7epz8HXBQkmqPETVCGa1fG/uv33SbxvDkngfNirDoJv8wNKAZ
         VBr+Ytmj9ickrY0s13y03tA0CibZuN/NxvH740JuHnuGwX3hx4u/HzHZPNAZzJhizV
         exuRiuEbRuF8gJHD5yu8XTjlzCHBE+6tGtIOeP3S/Vuf82BMi4S1P8hyKXsIklp2ia
         mL3QRuv6OdUtQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpG4-9t; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/24] MAINTAINERS: update current-sense-shunt.yaml reference
Date:   Wed, 13 Jan 2021 11:59:08 +0100
Message-Id: <e1ecac5b4faf048a5e85393223a4da7f6d28d070.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
to: Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 832297460974..a699a221a48b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8721,7 +8721,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
-F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 F:	drivers/iio/afe/iio-rescale.c
 
-- 
2.29.2


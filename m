Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEF92F496B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbhAMLBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbhAMLBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:01:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96CDA238E7;
        Wed, 13 Jan 2021 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=DQDknHPOnBWjCkPDysFt7tqeQlGBl/GidYLvIZ+e9d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQIhycGI01SKo48NJyvI5US3PuKM/rO7pTDs4hE1KGGCZ7Uui9LEM+oTzPjsolSov
         hqaR3kfCQBWQEmTaMLfeyonbag7+qJxn3tJnJPvF2Wq/R1P1h7saMl53vYU1XWbeiQ
         AeMM4Pn93FAjkVuZEHZ2RzZ+RL+a5/lCB+i+ntBgB+m/qzGoB4fd7Pa44iPxkTjA1X
         BenpHLZU1CN/VPPEiaPR2YO0MCh2d1vqth6dPhJWDGy98Ll/ElhuypEvaMGi/wM14m
         CPr9OPjP7MLkKWsQGASf7ytsMYyXrQrN1dkqus8atDq0KONN+e0VH6+h0h+PP9YRMA
         9Ayj/Epxmi2Uw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpG7-BJ; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] MAINTAINERS: update voltage-divider.yaml reference
Date:   Wed, 13 Jan 2021 11:59:09 +0100
Message-Id: <8f0eb68c83148410a7efdf406b88c8e143c841ac.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 6f633bc91ac1 ("dt-bindings:iio:afe:voltage-divider: txt to yaml conversion")
renamed: Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
to: Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a699a221a48b..6083de743261 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8722,7 +8722,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
-F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 F:	drivers/iio/afe/iio-rescale.c
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
-- 
2.29.2


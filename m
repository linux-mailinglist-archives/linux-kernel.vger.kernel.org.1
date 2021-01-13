Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73FA2F49D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbhAMLQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:16:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbhAMLQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:16:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07A5323329;
        Wed, 13 Jan 2021 11:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610536552;
        bh=CDnWZOXyQijCFw320U07T/MrFsjYUeoNGJWzCOH1dHU=;
        h=From:To:Cc:Subject:Date:From;
        b=VLzRAbghvcovTVMkUlPiJbCaWG+OPJWDs8WD3fP0pIF1Dkgaeuk9W/cMOojauLeml
         PTIRvlNChR1Y0NJWmtBaUBbeKLuzdb1+H39sZynHo4tWHAvA8SdyyAvxhmaiAGqTIY
         JsLcjKHYTiv2eN4HLb1MlXblI0+k4BzfvTyrCS/xXKU/zZwdXHPSmm596aMwPNbxfu
         R5veoy2UJfVcy03ix87u3tGhgHlPcA/gXMSLmt8ou2SnazKWm7QVvf1zsR0a5RJNmS
         STnD2rBLZBSc7N6nJas1z4vk7HNR+KuJ5Oblcaz+U2yrE6ynq0v+evcbZGn7Iaa6lh
         mwmDQe1bHH2zw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kze7w-00DqEw-6V; Wed, 13 Jan 2021 12:15:48 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update references to stm32 audio bindings
Date:   Wed, 13 Jan 2021 12:15:43 +0100
Message-Id: <03950bbd5cf7bac10eaaff3725e283d3ec2538c5.1610536535.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 81437cc3b0d9 ("Merge series "dt-bindings: stm32: convert audio dfsdm to json-schema" from Olivier Moysan <olivier.moysan@st.com>:")
removed bindings/sound/st,stm32-adfsdm.txt, as stm32-* audio
bindings are now under: bindings/iio/adc/st,stm32-*.yaml.

Update cross-references to them accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9318147e0791..7e233d789051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17044,7 +17044,7 @@ M:	Olivier Moysan <olivier.moysan@st.com>
 M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/sound/st,stm32-*.txt
+F:	Documentation/devicetree/bindings/iio/adc/st,stm32-*.yaml
 F:	sound/soc/stm/
 
 STM32 TIMER/LPTIMER DRIVERS
-- 
2.29.2


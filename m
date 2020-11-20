Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2893F2BAFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgKTQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgKTQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:22 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9E422D0A;
        Fri, 20 Nov 2020 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889101;
        bh=LoZ8MEoTv7rDCX6hpawQGW8JCdHOH0nJLp45COZaV1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWlhuIwXxRhcctfQnjYTxO9qFyRJc3VE2ARu3z0o6qM1eS4eFsj4WMsV+2D2z5dKF
         FqLb05GDhwJW15B4bhFfiN6+sLMvmMno5Ja7sc1gbwM947Xybi/YhFYIUGSo1sxYwE
         0lWaldhFAqc5qbomVbk53FcF2A71ZExWNd6p5+DE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 11/38] ASoC: ti: davinci: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:25 +0100
Message-Id: <20201120161653.445521-11-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  sound/soc/ti/davinci-i2s.c:750:34: warning: ‘davinci_i2s_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/ti/davinci-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index dd34504c09ba..0039b689745a 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -758,7 +758,7 @@ static struct platform_driver davinci_mcbsp_driver = {
 	.remove		= davinci_i2s_remove,
 	.driver		= {
 		.name	= "davinci-mcbsp",
-		.of_match_table = of_match_ptr(davinci_i2s_match),
+		.of_match_table = davinci_i2s_match,
 	},
 };
 
-- 
2.25.1


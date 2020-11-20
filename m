Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122DA2BAFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgKTQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:17:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgKTQRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:17:38 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18542223BE;
        Fri, 20 Nov 2020 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889057;
        bh=6crPrNanCPybdIoCOUE0EQqvWG11iCTFahxPBw6lnv0=;
        h=From:To:Cc:Subject:Date:From;
        b=HBJpufyXc3DBA/oH7WTc5JtitlxByPOEhplD3rghF59ynLElTFbo+CIqKKlCMb3Ce
         LXbSCcB8O5cHpg/3+E00aER2ZgdP/lN8uzlty5liGSt4rC7rIDUY15fdXoYCKQIpNE
         HwHpuXK0D4GXGdba1nE/5kmodRdIH9OO5EWscNx8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:15 +0100
Message-Id: <20201120161653.445521-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
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

  sound/soc/codecs/ak5558.c:418:34: warning: ‘ak5558_i2c_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/ak5558.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 2f076d5ee284..427d7d51bf53 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -423,7 +423,7 @@ static const struct of_device_id ak5558_i2c_dt_ids[] = {
 static struct i2c_driver ak5558_i2c_driver = {
 	.driver = {
 		.name = "ak5558",
-		.of_match_table = of_match_ptr(ak5558_i2c_dt_ids),
+		.of_match_table = ak5558_i2c_dt_ids,
 		.pm = &ak5558_pm,
 	},
 	.probe_new = ak5558_i2c_probe,
-- 
2.25.1


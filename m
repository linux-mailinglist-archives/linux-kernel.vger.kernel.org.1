Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294AE2BB009
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgKTQTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbgKTQTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:13 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A92D5223FD;
        Fri, 20 Nov 2020 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889153;
        bh=zDxcfDBYmjuuUTiiRpHLHOCTf/WPUkT0pv5HqP59xZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yPPxhSwai7i1F+5ncbhIDRNTitTO/NOTd2/opdYmdz15Wg+plVdw39EpKMZc8bYbv
         VXO5CkglPIGsjfNo7QgfH2qePjM431XOSLCAPKQICgvYF1vd5CDRJQpToFLKFWkZTY
         PFGGwvU85sLZ/JzaRhPq1w5AMdPiUJCVIAzUwD7Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 25/38] ASoC: max98926: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:39 +0100
Message-Id: <20201120161653.445521-25-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/max98926.c:574:34: warning: ‘max98926_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98926.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index c4dfa8ab1d49..0977e541326d 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -571,11 +571,13 @@ static const struct i2c_device_id max98926_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98926_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id max98926_of_match[] = {
 	{ .compatible = "maxim,max98926", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98926_of_match);
+#endif
 
 static struct i2c_driver max98926_i2c_driver = {
 	.driver = {
-- 
2.25.1


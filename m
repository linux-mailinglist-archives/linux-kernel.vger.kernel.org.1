Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A334F2BAFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgKTQSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgKTQSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:47 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E8824181;
        Fri, 20 Nov 2020 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889126;
        bh=pvhn0QCdCkvGGSKnk7s/3kCGaDX+MblFh4AacTU7+js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZiW0oksOFuOn5yQIXcKJJ/KhsMzfZMlndCWn7h4QqM+peJL3sDwMvCwtBB5lryaE
         +nh8j7LRGi2n2QT25hPn6TN5Vq/G6bBys1JrZ6QPIcfHhJDic1Rd0euDP2kCcclYPd
         3UkTjcq164nq9agKNi5bMpEbqtxxDOLsjFivSiqA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 18/38] ASoC: da9055: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:32 +0100
Message-Id: <20201120161653.445521-18-krzk@kernel.org>
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

  sound/soc/codecs/da9055.c:1522:34: warning: ‘da9055_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/da9055.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index b0d9ca6de685..aed92f615b02 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1519,11 +1519,13 @@ static const struct i2c_device_id da9055_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id da9055_of_match[] = {
 	{ .compatible = "dlg,da9055-codec", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9055_of_match);
+#endif
 
 /* I2C codec control layer */
 static struct i2c_driver da9055_i2c_driver = {
-- 
2.25.1


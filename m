Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FF12BAFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgKTQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbgKTQRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:17:52 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4424D223BE;
        Fri, 20 Nov 2020 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889071;
        bh=eUNQeZbUHRAtKX1EIalnF5m65XCO6D2xUekfrik1QEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HeX5Yzr5VnPSNdN1g5g/Bg+Jcfa/RWEDO34fkIYbI4CW8Kn/lnJSuY63bK5BVsZr+
         4rkfFp3A1uVqJPzzSXoBRfYmMdQDk6aHQuGY5jbgviUWAxT0ZN+eQ+WaJfoIsnmG1J
         YHmx90ogcu0UEhJl6J7Ko3QJcYLJYTgPhQAgqu08=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 02/38] ASoC: gtm601: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:16 +0100
Message-Id: <20201120161653.445521-2-krzk@kernel.org>
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

  sound/soc/codecs/gtm601.c:90:34: warning: ‘gtm601_codec_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/gtm601.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index ae9e1c70ca57..5dfd26e1fe9a 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -97,7 +97,7 @@ MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
 		.name = "gtm601",
-		.of_match_table = of_match_ptr(gtm601_codec_of_match),
+		.of_match_table = gtm601_codec_of_match,
 	},
 	.probe = gtm601_platform_probe,
 };
-- 
2.25.1


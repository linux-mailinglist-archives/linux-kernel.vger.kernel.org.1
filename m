Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91CE2BB015
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgKTQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgKTQTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:50 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B83223FD;
        Fri, 20 Nov 2020 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889189;
        bh=eg5/nyaqALzijU8H2GOtWYcQapgeWcHG71oF3tWQQWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oosmMJ6CyU8Xo45/D/STkGuWo95XQARTBuVHD7D7pNzuZMePPS6rIIf6DMebY/CKz
         9gpaJQd0sOszdfdQpuOrwI0EDGrS3imX/6/WHX/cXQnoX+831lbcdAdEMfTwPXDq++
         SG6uIQDR/1Q/Qq2SawkIZPvlE0Ah0urCmeDcgC5A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 33/38] ASoC: es7241: mark OF related data as maybe unused
Date:   Fri, 20 Nov 2020 17:16:47 +0100
Message-Id: <20201120161653.445521-33-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  sound/soc/codecs/es7241.c:206:33: warning: ‘es7241_chip’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/es7241.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7241.c b/sound/soc/codecs/es7241.c
index 87991bd4acef..2344a0b03518 100644
--- a/sound/soc/codecs/es7241.c
+++ b/sound/soc/codecs/es7241.c
@@ -203,7 +203,7 @@ static const struct es7241_clock_mode es7241_modes[] = {
 	},
 };
 
-static const struct es7241_chip es7241_chip = {
+static const struct es7241_chip es7241_chip __maybe_unused = {
 	.modes = es7241_modes,
 	.mode_num = ARRAY_SIZE(es7241_modes),
 };
-- 
2.25.1


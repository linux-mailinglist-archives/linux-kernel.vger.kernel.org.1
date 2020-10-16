Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26034290AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbgJPRkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732250AbgJPRkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:40:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B06AC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=R0mypQamIs9PrXy5bHGToqca7ODD6+Ny7S1/CFfb2yc=; b=I7mTumPXDmlb+ddOtYMIsVyKjn
        qKb8I8MfJ5cxJTMLFcPFQoTsVO0Fl951lKjgPvGaL2ahtCyM9MOvPw9Cjji3yH4Mh8DkmQVYulDvE
        Du2T4G1AsIneiXXcH04DxDeFqp3DBPBtadu70dDtq4FzQ4+EBV92sq/Exjzzl4EjFihAPJZfOyq/k
        xH4M8XPM3QGtwElVYAKp8d+PdEOwmbezQD/D0EM3Hoq9gMV/y0jHjEzFXXm+0T7/u25oV+K6dLZqn
        juN2MpQPKv6YLbFH1UDiKRnR8feur3yEYtgz8RbbYBBvVE2CBpKg/2bZF9dfKCYp5fsyw0FTLLC74
        9Ue92Khw==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTThn-00023v-8b; Fri, 16 Oct 2020 17:39:51 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: qcom: MSM8996 depends on COMMON_CLK
Message-ID: <548bb7f8-672d-3d95-0d78-cef1c9837a42@infradead.org>
Date:   Fri, 16 Oct 2020 10:39:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a kconfig warning in sound/soc/qcom:

WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y] && COMMON_CLK [=n]
  Selected by [y]:
  - SND_SOC_MSM8996 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y]

This is needed because 'select' does not follow dependency chains.

Fixes: a6f933f63f2f ("ASoC: qcom: apq8096: Add db820c machine driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
Found in linux-next but applies to mainline.

 sound/soc/qcom/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201016.orig/sound/soc/qcom/Kconfig
+++ linux-next-20201016/sound/soc/qcom/Kconfig
@@ -106,6 +106,7 @@ config SND_SOC_QDSP6
 config SND_SOC_MSM8996
 	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
 	depends on QCOM_APR
+	depends on COMMON_CLK
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	help


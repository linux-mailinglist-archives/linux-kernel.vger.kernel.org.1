Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1438928DDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgJNJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgJNJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776DC0F26E2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 19:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bYV1w8XItU+gaKbLFzijOk8gUliJ9BqOZSyQAwLkMec=; b=Jhvl5R+mtjSDbteR8R+ac3m2mX
        cPJ/ABj9EjN8BgmtC+q3a3i1LY1Iq9t7MZzddohPwOULYGPLVMg6qXi82AksZXG1Oe0nHNIfmyIZN
        9olVfkDT281gohBV+vY9JIKtvA4pOBh7GUzHJg9FGBfrfIKnsXqp5PekCZKst7CkZ/rbSRlCGHh9y
        4VueywQKkF9Ny3YhQVzRAQOMXhb52dtpGA2126lR4OCMuojqWiyL0hHqBugg2ejZ1OL4BBsLgO5oh
        YPCAupCConLarB2XiQpFuHrgvUoxFEtXOhyvnwqS4BkNVaVo9INtfyAuwpjsfG/mYkh/rd9kgavo3
        isep+ZEw==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSWy2-0005zg-KA; Wed, 14 Oct 2020 02:56:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: sof: imx: fix Kconfig punctuation
Date:   Tue, 13 Oct 2020 19:56:31 -0700
Message-Id: <20201014025633.4879-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014025633.4879-1-rdunlap@infradead.org>
References: <20201014025633.4879-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add periods at the end of sentences in help text.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: sound-open-firmware@alsa-project.org
Cc: alsa-devel@alsa-project.org
---
 sound/soc/sof/imx/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20201013.orig/sound/soc/sof/imx/Kconfig
+++ linux-next-20201013/sound/soc/sof/imx/Kconfig
@@ -17,7 +17,7 @@ config SND_SOC_SOF_IMX_OF
 	select SND_SOC_SOF_IMX8M if SND_SOC_SOF_IMX8M_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_IMX_COMMON
 	tristate
@@ -30,7 +30,7 @@ config SND_SOC_SOF_IMX8_SUPPORT
 	depends on IMX_SCU=y || IMX_SCU=SND_SOC_SOF_IMX_OF
 	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_IMX_OF
 	help
-	  This adds support for Sound Open Firmware for NXP i.MX8 platforms
+	  This adds support for Sound Open Firmware for NXP i.MX8 platforms.
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
@@ -40,13 +40,13 @@ config SND_SOC_SOF_IMX8
 	select SND_SOC_SOF_XTENSA
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_IMX8M_SUPPORT
 	bool "SOF support for i.MX8M"
 	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_OF
 	help
-	  This adds support for Sound Open Firmware for NXP i.MX8M platforms
+	  This adds support for Sound Open Firmware for NXP i.MX8M platforms.
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
@@ -56,6 +56,6 @@ config SND_SOC_SOF_IMX8M
 	select SND_SOC_SOF_XTENSA
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 endif ## SND_SOC_SOF_IMX_IMX_TOPLEVEL

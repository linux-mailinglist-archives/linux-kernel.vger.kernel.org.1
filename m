Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C154A2B3F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgKPJIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgKPJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:08:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A40C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:08:14 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1keaUc-0001lp-CB; Mon, 16 Nov 2020 10:08:10 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1keaUZ-0001Ly-0z; Mon, 16 Nov 2020 10:08:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Lai, Poey Seng" <poey.seng.lai@intel.com>,
        "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        kernel test robot <lkp@intel.com>
Subject: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Date:   Mon, 16 Nov 2020 10:08:04 +0100
Message-Id: <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <202011160303.qi5aRChY-lkp@intel.com>
References: <202011160303.qi5aRChY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver used this construct:

	#define KMB_PWM_LEADIN_MASK             GENMASK(30, 0)

	static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32 mask,
						   u32 val, u32 offset)
	{
		u32 buff = readl(priv->base + offset);

		buff = u32_replace_bits(buff, val, mask);
		writel(buff, priv->base + offset);
	}

	...
	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
					KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));

With CONFIG_CC_OPTIMIZE_FOR_SIZE the compiler (here: gcc 10.2.0) this
triggers:

	In file included from /home/uwe/gsrc/linux/drivers/pwm/pwm-keembay.c:16:
	In function ‘field_multiplier’,
	    inlined from ‘keembay_pwm_update_bits’ at /home/uwe/gsrc/linux/include/linux/bitfield.h:124:17:
	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to ‘__bad_mask’ declared with attribute error: bad bitfield mask
	  119 |   __bad_mask();
	      |   ^~~~~~~~~~~~
	In function ‘field_multiplier’,
	    inlined from ‘keembay_pwm_update_bits’ at /home/uwe/gsrc/linux/include/linux/bitfield.h:154:1:
	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to ‘__bad_mask’ declared with attribute error: bad bitfield mask
	  119 |   __bad_mask();
	      |   ^~~~~~~~~~~~

The compiler doesn't seem to be able to notice that with field being
0x3ffffff the expression

	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
		__bad_mask();

can be optimized away.

So use __always_inline and document the problem in a comment to fix
this.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I'm not sure this is the right fix. Maybe the bitfield stuff can be
changed somehow to make this problem go away, too?

Best regards
Uwe

 drivers/pwm/pwm-keembay.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
index 2b6dd070daa4..cdfdef66ff8e 100644
--- a/drivers/pwm/pwm-keembay.c
+++ b/drivers/pwm/pwm-keembay.c
@@ -63,7 +63,12 @@ static int keembay_clk_enable(struct device *dev, struct clk *clk)
 	return devm_add_action_or_reset(dev, keembay_clk_unprepare, clk);
 }
 
-static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32 mask,
+/*
+ * With gcc 10, CONFIG_CC_OPTIMIZE_FOR_SIZE and only "inline" instead of
+ * "__always_inline" this fails to compile because the compiler doesn't notice
+ * for all valid masks (e.g. KMB_PWM_LEADIN_MASK) that they are ok.
+ */
+static __always_inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32 mask,
 					   u32 val, u32 offset)
 {
 	u32 buff = readl(priv->base + offset);
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1728A241
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbgJJWzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731473AbgJJT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:26:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC15C05BD20
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 12:26:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so9825778pfp.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkS1+btAZ6JkQmZIGS4RdsP6NRmqrmeM+iVg068RrE0=;
        b=DZo2MrqC41rnm2tRw1jTzMMSPkFb4QnlZ8D4StX//o5xAnJ0b2anhPJ1zPzs2srZlJ
         CXP3SB81/hkdL7r6ADuRaTjP+fEwH8Gn09YODu/9vFAKyxWYNsfZI9ddROUKfJ1rBX57
         I8c5UPprTq9oYGSp+N0q3C7V6EBF+LVK59wDowVy22U6NKmzr5oQrpjbMBIyznkn6L/c
         5fv9IudKfwPgPf43cLmgVio2GcasHNRbhWx6I4D2ZzQPq41S5nHBCdWzVy6mXflpBSGz
         NQ44/wX6y1vJNjYnsrBOt2gR/a+9t43eqJCLwUSrHrqpWyb+2KA6x1WLC8YTTsbsasp4
         fF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkS1+btAZ6JkQmZIGS4RdsP6NRmqrmeM+iVg068RrE0=;
        b=VskM7iX/gi0d1yYoRNjnYFMHfUj5y1Pm0RH8XdCMNatm7DASgD+N8TfVBdHA684F6w
         nAu2/+SCcmnKKUTk9YDZPezjp4bWfQWyw5tpSEIflzZnjteuu6yex/ix9SIDNzkBI8ar
         6/H//6ioMmDIQqsJy2lnEfIKgJv41cDtFKdhLYz8Hlxlz1NDQ16ZIafQvYUl8G63p69q
         YmfKlPLFYw6MmVA8lYGrvB3tTJt4aONwbAocNRJc6OR0ozf1qBhUbWuM3Dh2nNvZJx01
         lmHC9wJASCo+ehG4fZNtu2Ywk5WlOxGiA4x9Yq3VqJ6TKsBov1P4qLUGfgeZuEwjQS0Y
         LZag==
X-Gm-Message-State: AOAM533E2sj/hJxv7zTbJHF1+Jhviy+ppphIR53tcLNaW8hlLNpiqaCC
        3omXGF5yMKfAw8vBqrQ9b8k=
X-Google-Smtp-Source: ABdhPJyiJjzMJ63WO1PKiCPMKHVsyiCM2KxAjRevVt69m9mvuEXBw/jEuBXs4VBpDuvlXXgY78TSZg==
X-Received: by 2002:a17:90a:aa8c:: with SMTP id l12mr11474990pjq.114.1602357999688;
        Sat, 10 Oct 2020 12:26:39 -0700 (PDT)
Received: from raspberrypi.lan (c-73-71-109-8.hsd1.ca.comcast.net. [73.71.109.8])
        by smtp.gmail.com with ESMTPSA id h31sm14410766pgh.71.2020.10.10.12.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 12:26:39 -0700 (PDT)
From:   Allen Martin <armartin@gmail.com>
To:     hias@horus.com, phil@raspberrypi.com
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Allen Martin <armartin@gmail.com>
Subject: [PATCH] ASoC: bcm2835: Add enable/disable clock functions
Date:   Sat, 10 Oct 2020 12:26:17 -0700
Message-Id: <20201010192617.12569-1-armartin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions to control enable/disable of BCLK output of bcm2835 I2S
controller so that BCLK output only starts when dma starts.  This
resolves issues of audio pop with DACs such as max98357 on rpi.  The
LRCLK output of bcm2835 only starts when the frame size has been
configured and there is data in the FIFO.  The max98357 dac makes a
loud popping sound when BCLK is toggling but LRCLK is not.

Signed-off-by: Allen Martin <armartin@gmail.com>
---
 sound/soc/bcm/bcm2835-i2s.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index e6a12e271b07..5c8649864c0d 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -122,9 +122,27 @@ struct bcm2835_i2s_dev {
 	struct regmap				*i2s_regmap;
 	struct clk				*clk;
 	bool					clk_prepared;
+	bool					clk_enabled;
 	int					clk_rate;
 };
 
+static void bcm2835_i2s_enable_clock(struct bcm2835_i2s_dev *dev)
+{
+	if (dev->clk_enabled)
+		return;
+
+	regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_MODE_A_REG, BCM2835_I2S_CLKDIS, 0);
+	dev->clk_enabled = true;
+}
+
+static void bcm2835_i2s_disable_clock(struct bcm2835_i2s_dev *dev)
+{
+	if (dev->clk_enabled)
+		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_MODE_A_REG, BCM2835_I2S_CLKDIS, BCM2835_I2S_CLKDIS);
+
+	dev->clk_enabled = false;
+}
+
 static void bcm2835_i2s_start_clock(struct bcm2835_i2s_dev *dev)
 {
 	unsigned int master = dev->fmt & SND_SOC_DAIFMT_MASTER_MASK;
@@ -145,6 +163,7 @@ static void bcm2835_i2s_start_clock(struct bcm2835_i2s_dev *dev)
 
 static void bcm2835_i2s_stop_clock(struct bcm2835_i2s_dev *dev)
 {
+	bcm2835_i2s_disable_clock(dev);
 	if (dev->clk_prepared)
 		clk_disable_unprepare(dev->clk);
 	dev->clk_prepared = false;
@@ -158,6 +177,7 @@ static void bcm2835_i2s_clear_fifos(struct bcm2835_i2s_dev *dev,
 	uint32_t csreg;
 	uint32_t i2s_active_state;
 	bool clk_was_prepared;
+	bool clk_was_enabled;
 	uint32_t off;
 	uint32_t clr;
 
@@ -176,6 +196,11 @@ static void bcm2835_i2s_clear_fifos(struct bcm2835_i2s_dev *dev,
 	if (!clk_was_prepared)
 		bcm2835_i2s_start_clock(dev);
 
+	/* Enable clock if not enabled */
+	clk_was_enabled = dev->clk_enabled;
+	if (!clk_was_enabled)
+		bcm2835_i2s_enable_clock(dev);
+
 	/* Stop I2S module */
 	regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG, off, 0);
 
@@ -207,6 +232,10 @@ static void bcm2835_i2s_clear_fifos(struct bcm2835_i2s_dev *dev,
 	if (!timeout)
 		dev_err(dev->dev, "I2S SYNC error!\n");
 
+	/* Disable clock if it was not enabled before */
+	if (!clk_was_enabled)
+		bcm2835_i2s_disable_clock(dev);
+
 	/* Stop clock if it was not running before */
 	if (!clk_was_prepared)
 		bcm2835_i2s_stop_clock(dev);
@@ -414,6 +443,8 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	/* Clock should only be set up here if CPU is clock master */
 	if (bit_clock_master &&
 	    (!dev->clk_prepared || dev->clk_rate != bclk_rate)) {
+		if (dev->clk_enabled)
+			bcm2835_i2s_disable_clock(dev);
 		if (dev->clk_prepared)
 			bcm2835_i2s_stop_clock(dev);
 
@@ -534,6 +565,8 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 		mode |= BCM2835_I2S_FTXP | BCM2835_I2S_FRXP;
 	}
 
+	if (!dev->clk_enabled)
+		mode |= BCM2835_I2S_CLKDIS;
 	mode |= BCM2835_I2S_FLEN(frame_length - 1);
 	mode |= BCM2835_I2S_FSLEN(framesync_length);
 
@@ -668,6 +701,7 @@ static int bcm2835_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		bcm2835_i2s_start_clock(dev);
+		bcm2835_i2s_enable_clock(dev);
 
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			mask = BCM2835_I2S_RXON;
@@ -839,6 +873,7 @@ static int bcm2835_i2s_probe(struct platform_device *pdev)
 
 	/* get the clock */
 	dev->clk_prepared = false;
+	dev->clk_enabled = false;
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		dev_err(&pdev->dev, "could not get clk: %ld\n",
-- 
2.20.1


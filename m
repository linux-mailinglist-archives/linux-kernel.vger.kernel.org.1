Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6366B1A6ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbgDMQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 12:59:33 -0400
Received: from vkten.in ([104.244.73.96]:57610 "EHLO vkten.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732122AbgDMQ7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:59:31 -0400
Received: (qmail 15697 invoked from network); 13 Apr 2020 16:59:26 -0000
Received: from unknown (HELO localhost) (vkor@vkten.in@117.209.137.67)
  de/crypted with TLSv1.3: TLS_AES_256_GCM_SHA384 [256/256] DN=none
  by vkten with ESMTPSA; 13 Apr 2020 16:59:26 -0000
From:   R Veera Kumar <vkor@vkten.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     R Veera Kumar <vkor@vkten.in>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: bcm2835-audio: Make function arguments alignment match open parenthesis
Date:   Mon, 13 Apr 2020 22:29:05 +0530
Message-Id: <20200413165905.6081-1-vkor@vkten.in>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make function arguments alignment match open parenthesis.
Found using checkpatch.pl.

Signed-off-by: R Veera Kumar <vkor@vkten.in>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 33485184a98a..f783b632141b 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -233,7 +233,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 }
 
 static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
-	struct snd_pcm_indirect *rec, size_t bytes)
+				     struct snd_pcm_indirect *rec, size_t bytes)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
@@ -346,7 +346,7 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, const char *name,
 			&snd_bcm2835_playback_ops);
 
 	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
-		chip->card->dev, 128 * 1024, 128 * 1024);
+				       chip->card->dev, 128 * 1024, 128 * 1024);
 
 	if (spdif)
 		chip->pcm_spdif = pcm;
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F223B11D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgHCXmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbgHCXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:42:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3614FC06179E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:42:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s189so33136443iod.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZtgyz4w9bioKhpkBgBZgXBORnt82DhjEIEidPD/D0c=;
        b=XNDeIGNp2H4ZbKTQ3i4Ti8f6et3wSK/SnNykPc+bdzRVUKA+SGd464nUM4ENll3c27
         69/3TYIyyHmi4cZrJmyK+vmJJDIDz9yEBHdLjdtr0iz+pzS+9KUyewCQg4N8wf8UiBrh
         hZe6pLZ2DRm1jdBqN+wEnMvKvk2Y753T/sH5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZtgyz4w9bioKhpkBgBZgXBORnt82DhjEIEidPD/D0c=;
        b=tGaGkULc0koJa+9L5IP/BfTwY/iFLTt5MSACx/lkRkNn0qjbG4kqqQqOEr7r3hTPC0
         YFwl5Of7YKYTiBXohLy7hOzIGkbta2XqrjZbIhhvfyJRf5l0hWZkLy1EjrQeMkfB1srd
         hagAidcWnN1kqo71wJQKG8eE/JwGf6rLRqbyImleGnKoIsawCgxdEBx2+z8CeF36vynT
         VlCglLbLFSsUoQIN489IHtCVquRHVCdsWDT071frHh2Uy2hLpwXg+aA/IxNESqSzh5jE
         vnt9ExOOEk9h1rokHjRr3DdRZ5umn7CI482H8GD5mAHolRvjYqVP/XnhZHhaL9e+1FE1
         movg==
X-Gm-Message-State: AOAM53147wPr6AjRNoXR06i0Ird6KsqM71eF0iX83ebrCw+/0/HQKtM3
        9Fc7L56f81+GpEIC4VSgdIoRyw==
X-Google-Smtp-Source: ABdhPJzcRmjkFF3frNBKgigwLZQlEiezRtbcaLOq4pOuDMxQ0MDjYIWPRUPDi1VetefN+u9EeKkoLA==
X-Received: by 2002:a02:9185:: with SMTP id p5mr2491651jag.25.1596498126584;
        Mon, 03 Aug 2020 16:42:06 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:06 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 07/15] iio: sx9310: Use long instead of int for channel bitmaps
Date:   Mon,  3 Aug 2020 17:41:46 -0600
Message-Id: <20200803131544.v4.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses for_each_set_bit() macro to loop over channel bitmaps.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
Changes in v3:
 - Added static assert for number of channels.

Changes in v2:
 - Changed prox_stat to chan_prox_stat bitmap.

 drivers/iio/proximity/sx9310.c | 39 ++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 20a26b73b5ae90..45569a0657060c 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -118,6 +118,7 @@
 
 /* 4 hardware channels, as defined in STAT0: COMB, CS2, CS1 and CS0. */
 #define SX9310_NUM_CHANNELS				4
+static_assert(SX9310_NUM_CHANNELS < BITS_PER_LONG);
 
 struct sx9310_data {
 	/* Serialize access to registers and channel configuration */
@@ -129,7 +130,7 @@ struct sx9310_data {
 	 * Last reading of the proximity status for each channel.
 	 * We only send an event to user space when this changes.
 	 */
-	bool prox_stat[SX9310_NUM_CHANNELS];
+	unsigned long chan_prox_stat;
 	bool trigger_enabled;
 	/* Ensure correct alignment of timestamp when present. */
 	struct {
@@ -139,7 +140,8 @@ struct sx9310_data {
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
-	unsigned int chan_read, chan_event;
+	unsigned long chan_read;
+	unsigned long chan_event;
 	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
@@ -282,15 +284,16 @@ static const struct regmap_config sx9310_regmap_config = {
 };
 
 static int sx9310_update_chan_en(struct sx9310_data *data,
-				 unsigned int chan_read,
-				 unsigned int chan_event)
+				 unsigned long chan_read,
+				 unsigned long chan_event)
 {
 	int ret;
+	unsigned long channels = chan_read | chan_event;
 
-	if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
+	if ((data->chan_read | data->chan_event) != channels) {
 		ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
 					 SX9310_REG_PROX_CTRL0_SENSOREN_MASK,
-					 chan_read | chan_event);
+					 channels);
 		if (ret)
 			return ret;
 	}
@@ -531,6 +534,7 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 	unsigned int val, chan;
 	struct sx9310_data *data = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns(indio_dev);
+	unsigned long prox_changed;
 
 	/* Read proximity state on all channels */
 	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
@@ -539,24 +543,23 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 		return;
 	}
 
-	for (chan = 0; chan < SX9310_NUM_CHANNELS; chan++) {
+	/*
+	 * Only iterate over channels with changes on proximity status that have
+	 * events enabled.
+	 */
+	prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
+
+	for_each_set_bit(chan, &prox_changed, SX9310_NUM_CHANNELS) {
 		int dir;
 		u64 ev;
-		bool new_prox = val & BIT(chan);
-
-		if (!(data->chan_event & BIT(chan)))
-			continue;
-		if (new_prox == data->prox_stat[chan])
-			/* No change on this channel. */
-			continue;
 
-		dir = new_prox ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
+		dir = val & BIT(chan) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
 		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
 					  IIO_EV_TYPE_THRESH, dir);
 
 		iio_push_event(indio_dev, ev, timestamp);
-		data->prox_stat[chan] = new_prox;
 	}
+	data->chan_prox_stat = val;
 }
 
 static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
@@ -713,13 +716,13 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
 static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct sx9310_data *data = iio_priv(indio_dev);
-	unsigned int channels = 0;
+	unsigned long channels = 0;
 	int bit, ret;
 
 	mutex_lock(&data->mutex);
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength)
-		channels |= BIT(indio_dev->channels[bit].channel);
+		__set_bit(indio_dev->channels[bit].channel, &channels);
 
 	ret = sx9310_update_chan_en(data, channels, data->chan_event);
 	mutex_unlock(&data->mutex);
-- 
2.28.0.163.g6104cc2f0b6-goog


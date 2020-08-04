Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A0F23B124
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgHCXmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgHCXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:42:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261A5C0617A4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:42:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t15so31441308iob.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0H6GDwQS47ERB7u8LWsyFagTSOyltzG4Qky9evJTi+U=;
        b=YvGJRMe9hgg6bHXgr5Q+9G567B3apiE6/0BQm9bfXRIN291mlsDmpVcAG4tfkXQpr+
         XmrWZEaFR1O+2Uic+hFh57CxAnmbss1Tu01L/8Pe77sVCKgQ5TQCldCQ9NULeOJ6QANk
         Yf7Gg01I06VJ7qULm0T12j3t+RtPDnJ+m63ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0H6GDwQS47ERB7u8LWsyFagTSOyltzG4Qky9evJTi+U=;
        b=DYuhAIGRLfx2G8DuWgdZJMgo4JpnxFXU2KQQ1VIeuI+vB/vDOz5FYYPlxTa/T+KpNU
         R5P9I+hSObCzusZ+BCZfe7qK59lYMT9SE7pXyRFZhQCgQU8S/l9crJJ8B4QdGmVoDDho
         JE1pL/GGoDkERaaLo+QVpfwO8fDmaXoVOglMvz0PcDRx5mpLv+FwYbcRxE82mQr0HxoC
         uymc7w74RPF9y4qO3kFC8+AyQku0xt3KzvK1k0uHe+eIEAGO+LopHWE8dmrGylhf2TWc
         i5N2UtP5WTfZasBBUU48FjvMlyw+kEk/5VvyGXhYC6Nt7VwbzZBaIbnrW9eNhXEsLSXB
         86YA==
X-Gm-Message-State: AOAM532dP45m4TKNJnnP/JvGMxCULxBdhquV/qN2AXv5PrYPFnTfcKzf
        hZ3O4+UyuCeseKWkmMq7bUEnVw==
X-Google-Smtp-Source: ABdhPJyxUWQI6dJ4UGhK9UO9uoBheNt4jPRrhepNVLOo4S0/tVrUF1P/owG5srwtpyhy57Mg2XtX+w==
X-Received: by 2002:a02:ce4b:: with SMTP id y11mr2510609jar.144.1596498125538;
        Mon, 03 Aug 2020 16:42:05 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:05 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v4 06/15] iio: sx9310: Fixes various memory handling
Date:   Mon,  3 Aug 2020 17:41:45 -0600
Message-Id: <20200803131544.v4.6.I8accffd77d616cb55b29bc3021cb0f5e1da3b68a@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes use __aligned(8) to ensure that the timestamp is correctly aligned
when we call io_push_to_buffers_with_timestamp().
Also makes use of sizeof() for regmap_bulk_read instead of static value.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v4:
 - Use pointer to buffer struct on iio_push_to_buffers_with_timestamp().

Changes in v3:
 - Changed buffer to struct type to align timestamp memory properly.

Changes in v2:
 - Fixed commit message from "iio: sx9310: Align memory"

 drivers/iio/proximity/sx9310.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index c89a4e27201796..20a26b73b5ae90 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -131,8 +131,11 @@ struct sx9310_data {
 	 */
 	bool prox_stat[SX9310_NUM_CHANNELS];
 	bool trigger_enabled;
-	__be16 buffer[SX9310_NUM_CHANNELS +
-		      4]; /* 64-bit data + 64-bit timestamp */
+	/* Ensure correct alignment of timestamp when present. */
+	struct {
+		__be16 channels[SX9310_NUM_CHANNELS];
+		s64 ts __aligned(8);
+	} buffer;
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
@@ -343,7 +346,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
 	if (ret < 0)
 		return ret;
 
-	return regmap_bulk_read(data->regmap, chan->address, val, 2);
+	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
 }
 
 /*
@@ -693,7 +696,7 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
 		if (ret < 0)
 			goto out;
 
-		data->buffer[i++] = val;
+		data->buffer.channels[i++] = val;
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-- 
2.28.0.163.g6104cc2f0b6-goog


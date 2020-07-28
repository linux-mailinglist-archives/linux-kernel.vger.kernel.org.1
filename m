Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A45230D68
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgG1POU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbgG1PNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:18 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38797C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g19so9021727ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXu1LI4EreJiPCGpDoc5eFU1VLFE8sDpcfNeo5EdH5U=;
        b=CW0fy1nzyEScVEgQupl6l+tgIFLDYcNerhH8YNh0B+COR1awhJw+rrOEbSChQ0DpQt
         1hZVOZqOjV+v0xPI4msvxw+MX2ArFCL+INIAfGxudPO2aybWdIFdKHWMBnbcqolrofOt
         fIx9moaF3r0nGihk2ldFJ3ATQMOfkm24LsQss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXu1LI4EreJiPCGpDoc5eFU1VLFE8sDpcfNeo5EdH5U=;
        b=CR4OhdSIYAX3StoZYJRNJMCCdcAUwKw+r4Sv8M0yC+KIhoGWr35G+MKmNaxamn9HnW
         lmTZc0dWcriCpux9ll7TyU5tEvN+QNwWhIu0iB0YpmcFGqT9Fmm2C+4mzPmchDsl0UUN
         o3U2lodOZcNZt2wpiDmlqH/QiTArjqvUfAch4+ks6ODjn2BamfXBcj9cNeibLxS59EwC
         i/LfF8BAqHENpjOja202NHIl5qeZbZy0Hg+tYuaYgeJThkKCCx54Bo6W1rrIts3XUliX
         w9MS9nNM2WUD8DMNEynp2X+hXipcYsU2m37NLYDycyKgQnVXo9zuvrR+7sxkpFKtQRki
         UZ3g==
X-Gm-Message-State: AOAM5313Q573ro/r3OzAxMzQTipSjvkk9v0kMgRl+aBj2E7UtSxLXO5W
        KmvYOYLWL+YBehYxFjflU1Dnyw==
X-Google-Smtp-Source: ABdhPJxM7VC9nu3erFc2LP9bXhgfPe5tRGvIPgx/QAwT2vEhHFHgM7cY+paS40z4V1Vt7rEyI8sPvA==
X-Received: by 2002:a6b:bc82:: with SMTP id m124mr7069591iof.172.1595949195633;
        Tue, 28 Jul 2020 08:13:15 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:15 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 03/15] iio: sx9310: Fix irq handling
Date:   Tue, 28 Jul 2020 09:12:46 -0600
Message-Id: <20200728091057.3.I2a1314232ace4323af96f9981c1e1a4f31f78049@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes enable/disable irq handling at various points. The driver needs to
only enable/disable irqs if there is an actual irq handler installed.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/iio/proximity/sx9310.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 07895d4b935d12..76b8bedebeef50 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -376,13 +376,15 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 	if (ret < 0)
 		goto out;
 
-	ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
-		goto out_put_channel;
+	if (data->client->irq) {
+		ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
+		if (ret)
+			goto out_put_channel;
+	}
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq > 0) {
+	if (data->client->irq) {
 		ret = wait_for_completion_interruptible(&data->completion);
 		reinit_completion(&data->completion);
 	} else {
@@ -401,9 +403,11 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 	*val = sign_extend32(be16_to_cpu(rawval),
 			     (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
 
-	ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
-		goto out_put_channel;
+	if (data->client->irq) {
+		ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
+		if (ret)
+			goto out_put_channel;
+	}
 
 	ret = sx9310_put_read_channel(data, chan->channel);
 	if (ret < 0)
@@ -414,7 +418,8 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 	return IIO_VAL_INT;
 
 out_disable_irq:
-	sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
+	if (data->client->irq)
+		sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
 out_put_channel:
 	sx9310_put_read_channel(data, chan->channel);
 out:
@@ -1012,7 +1017,8 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 out:
 	mutex_unlock(&data->mutex);
 
-	enable_irq(data->client->irq);
+	if (!ret)
+		enable_irq(data->client->irq);
 
 	return ret;
 }
-- 
2.28.0.rc0.142.g3c755180ce-goog


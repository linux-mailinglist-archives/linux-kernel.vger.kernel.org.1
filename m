Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4326027201B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgIUKUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgIUKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750A4C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so12142890wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5xy1HmEK3Cb2cGuOZNBEue37qSrHj+Vnq/OwfaPORg=;
        b=I5VTjG3a3ViBXraLZbIZjAF4w3IjxazcKPBR8RM9zZISWgHD9OAAW/k6SSohJYhPNG
         A5YpvNK36e4G+9BFnfqnxMw1ClkJlY0mfrV41zlhv06gFtYecYAE+trrq+eIDf77q/X6
         yJ9A8CxIZkIE7MofTCSiuH14CNxFd1GOFLd0QPPHX1l5Pz9e9RJSOfW1EZPYdHwFYh3n
         /85ZsSW7M2mpjF8Yzi14whkUIf8DbmA6nOCwjNK9GhrXL+3c8xwcyiWIXyZxS1B26ilp
         /1uB7h0HAi7DX/gQsZce7RHc+1uONcDNT/4FfiDSZ1HxaKtJR1mEhMWmguiXrcYTJARi
         o/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z5xy1HmEK3Cb2cGuOZNBEue37qSrHj+Vnq/OwfaPORg=;
        b=gAV2AgHv2L2CSK7xo8p/m+skyjZ1CkvAAHKa5jWDpSBw0Cm+q9o+w61luDaQcVIaEb
         TikiPr8oBGlmozbt4y6MFaYr/OqAKrRApb7eQ/cZDXtErLWFDjLCH+YfDD3X/JsPdjub
         HPYRhpSOIpj56Z8PJLFbtFfeOOvufl3HbECD7YZqt1Fvqmmi9l9z+SZOiuCZETDgSngQ
         5m/7CoOf7GYPtnLcMJdWf36o5PSuEB5IitWOVCwoZ6QrVVE7H03N+0EyAqzJxWdAbrnX
         +6Gxg8NB0wbNR+4LJA6v9redd8ogalEnGwXhOagIO+wBPPcMPu3lMB7R9n7B60Ns/0/K
         fd0w==
X-Gm-Message-State: AOAM530dCCHeRLxRDe1jVP6FddGb0Ud2DRufoiozYkaroo6UBqRtgYN8
        F261PIJ+jOOpFdtHAanEw8DBCw==
X-Google-Smtp-Source: ABdhPJxN1Spb10RxJRxY4y67Y7+C7S5d68x0Ru3WpjlUuQNHdi07Ix7g79gisaT5NE8Ke2Dq5/yb2Q==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr43195277wrp.206.1600683635053;
        Mon, 21 Sep 2020 03:20:35 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:34 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 03/49] staging: media: zoran: datasheet is no longer available from zoran.com
Date:   Mon, 21 Sep 2020 10:19:38 +0000
Message-Id: <1600683624-5863-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply remove this broken reference

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
index 04162be80420..79da964c678b 100644
--- a/drivers/staging/media/zoran/zoran_device.c
+++ b/drivers/staging/media/zoran/zoran_device.c
@@ -265,9 +265,6 @@ jpeg_codec_reset (struct zoran *zr)
  *   Set the registers for the size we have specified. Don't bother
  *   trying to understand this without the ZR36057 manual in front of
  *   you [AC].
- *
- *   PS: The manual is free for download in .pdf format from
- *   www.zoran.com - nicely done those folks.
  */
 
 static void
-- 
2.26.2


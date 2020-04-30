Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9551C097F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 23:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgD3Vfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727102AbgD3VfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:35:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24843C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:35:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z90so6376231qtd.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4NZHd20DqH/vMopbnAr3CvIxlhLY+CMbHfzvIpU5fo=;
        b=FAkKib5UEUdJ8vrJ3fEKyY/s8lgMD7f5u4GS4xdPjhvVpDtOAC8ykkeJnOk9FbzU3b
         kmwrBahaK3+c+ARuIT6QoV3cVvis5z4O4onUhhXh2d8K3Q+GngbIOhXHY3/WTLU6J+6V
         fM6JoA3LMLm7BWJkOiU5uB0Hwsfc4WwZiBxQ8K4nPkWZHUc4Fr1ugvPHifEUl8bbBBSY
         cmZtYlfn+btahEQeH4+Ht8tRliKWoZf3Cg8juMNLcyqZWrfCk2hzMvuTxlrns1XwGGzy
         vOJGflAAQL7XqHv6DcYQxjS2I6ArwHEy7PEy9gDKdC48OReAKAvOmiDA7xP54KrJRo48
         LJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4NZHd20DqH/vMopbnAr3CvIxlhLY+CMbHfzvIpU5fo=;
        b=YodD1+3hA04Ikp5L0AvgWCy8LUeYOHNqSn1XScKBSvNFgNCXIkUoSc8rgjYUmkB6OT
         VCdSFnzvmvCMBw+2J75jzCiVCDyBB8WM0BgNyIAUvSuB+9OmpKh/sgfjDiQCnV4W536s
         PwKNDbm4D/K2U9bcfEwvqR0d5nTo+Vlklk2D3xY5FhLaChqWTLFG7u6KpTghlUr9H3dS
         eV+vEEwaGe+9FCnaq3orerc2lceIwWM7upSk5DpeYKjd/ETjslscazvmpLgSN56Bjsav
         f3VtdE3e7IRRenHWEwukMTPzaTd4naZQD/y2Npgo3VOQFuCPoy22tic+Q40dbO3FBe/L
         Sd6w==
X-Gm-Message-State: AGi0PubuYLDk9mDng52hWg/JwM4foV+c2yGekMj4mHP7k0bIoMHS5tPt
        jUjvQR39QFfJ51qwSjFVTpNHeQ==
X-Google-Smtp-Source: APiQypI9hbKnj1Bz3fAGJul0OELxHEBWAad+NzSj8OX1wtfY7PAuFyORwlaik3yuLFedpJoPks83Hw==
X-Received: by 2002:ac8:312e:: with SMTP id g43mr625184qtb.256.1588282520338;
        Thu, 30 Apr 2020 14:35:20 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s190sm1112543qkh.23.2020.04.30.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:35:19 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: ipa: fix an error message in gsi_channel_init_one()
Date:   Thu, 30 Apr 2020 16:35:11 -0500
Message-Id: <20200430213512.3434-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430213512.3434-1-elder@linaro.org>
References: <20200430213512.3434-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An error message about limiting the number of TREs used prints the
wrong value.  Fix this bug.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 845478a19a4f..b4206fda0b22 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1798,9 +1798,9 @@ static int gsi_channel_init_one(struct gsi *gsi,
 
 	/* Worst case we need an event for every outstanding TRE */
 	if (data->channel.tre_count > data->channel.event_count) {
-		dev_warn(gsi->dev, "channel %u limited to %u TREs\n",
-			data->channel_id, data->channel.tre_count);
 		tre_count = data->channel.event_count;
+		dev_warn(gsi->dev, "channel %u limited to %u TREs\n",
+			 data->channel_id, tre_count);
 	} else {
 		tre_count = data->channel.tre_count;
 	}
-- 
2.20.1


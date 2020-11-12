Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E532B04C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgKLMMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgKLMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:12:02 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C0C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:12:02 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so5758681ioo.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0z9Su447OPUlHIEYfLPhmXqBnr1rEvvT1M7lmEXZzGk=;
        b=mAvmCj4iAAwVkMzvQQdU9BOE9ZQe/Ou5+PwdAZRZzGhdykJywK2+nLEN/RrB0+KNdq
         eNMsS9RrvhZi9FAX2kMbYvJPZJVMREgdngIjDApBwI1A1xFF2/y1qbogL62W7w40e4RU
         UCXBsSrzSwSeRIn1oYu4yFBS3pNWpho3EpPgpfsOG7wOxCJq5q04n4neG0EXk92HzZbC
         79CUKDQDinFKkGOMzP6JKT9usk9B2O0LpJFPNm1bWC/2fveGxe8TE5OsYG1kZN5XTPk/
         l1nztzq3ogy8IMfNnJAxqcFOiG8ZBbATOrBYqqm2pxrcu5JuWud8Wg6IaOsMr1aXknA7
         8nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0z9Su447OPUlHIEYfLPhmXqBnr1rEvvT1M7lmEXZzGk=;
        b=bSEn5vP3yMnimR3FgMAaiBHkq2ogOf9uzraXV9x/GJFQ8xzbqs2nZuGJqlF8xKJ5aL
         MwpKh7/hd5aaOCTv4YrbUxX3/rLE0t1FBW1iMj4jbeM34IL6+6HBFIH0IgpnKLClFGwk
         PLdDmNBUNhBtQhDZ3WeP+jIoZniO46LPI2ADQs74imBv3PhNujdgUmukQoZoJmEYUcVX
         mYpB0JOhZsw/IuGJlz752DofYZj/69nRiu7EzIrI5frdZqdfES/ijBHsdFBPkaPjT3yw
         udzL6O2gB+fZtHU1ztAmHyCBeMHlBX9rtFjNSxm0TiYqdhcdNt/cQ+O3CL0NNiJxMjBY
         f9qg==
X-Gm-Message-State: AOAM530oxt/QdEWIgW/AgmIeiCoDQcpsEXD3CCtLhE3R6aYtMv4AqbjJ
        2gYv0C6ugkL4PfRNVl3arxHf/g==
X-Google-Smtp-Source: ABdhPJzaynBvIGl23OX0H+PGygvTSLGmzTxbF5bG2BdPMepJLbLo2Bt80bXWlgqpRKZcgsREOGqEXw==
X-Received: by 2002:a6b:630b:: with SMTP id p11mr21931296iog.97.1605183121958;
        Thu, 12 Nov 2020 04:12:01 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id i14sm2609563iow.13.2020.11.12.04.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:12:01 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: ipa: fix source packet contexts limit
Date:   Thu, 12 Nov 2020 06:11:56 -0600
Message-Id: <20201112121157.19784-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201112121157.19784-1-elder@linaro.org>
References: <20201112121157.19784-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have discovered that the maximum number of source packet contexts
configured for SDM845 is incorrect.  Fix this error.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sdm845.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index a9a992404b39f..bd92b619e7fec 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -150,11 +150,11 @@ static const struct ipa_resource_src ipa_resource_src[] = {
 		.type = IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS,
 		.limits[0] = {
 			.min = 1,
-			.max = 63,
+			.max = 255,
 		},
 		.limits[1] = {
 			.min = 1,
-			.max = 63,
+			.max = 255,
 		},
 	},
 	{
-- 
2.20.1


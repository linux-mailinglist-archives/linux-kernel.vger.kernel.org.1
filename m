Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB3274916
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgIVT1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgIVT1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:27:16 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so19324832lff.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZAYCNZd2exSauEKT0RXF+wYwkkwt1jBDEAUNXpjVmY=;
        b=qKvbpqHMzxC+6dctj6zg6RQtqnuu986ed6Y9mJqE3n1Cwd1N1dPPeXuthOWgXC+S79
         hoyTAoSbhhIjD0vZbu0c6vw7ucem4cti6n5qDltOluPf41fseNChBJaaOQhW2M5RB4So
         u9m3clEPHCOF2F3WG5DzHD4ySaWvfQ74w7vO0XnfQHTGuIAwNK5KTvRjM48aROKngXr9
         lvafhJsWC0lQTvE9ndTMZGONBMKbz6ppvtzKSUuwvjl6Wqbp1xLqSD/xpkUjmGZ/W7KF
         yw1VeIKWRzVEipr6IqRJ3TExn6EY2tltLZ3vCzyqrxrN5Jr8LpSQRkCl6bLUi7RO2jHl
         EY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZAYCNZd2exSauEKT0RXF+wYwkkwt1jBDEAUNXpjVmY=;
        b=I/vnhW1TXc98/Ji2cj/Apu13R5l9L7DqXZMHDsFjjFqiWlm0VQHQwQdzfEbEVZ7p3r
         Qp33PvX1Yd4NjKWyXavKrBIQYYd8Vx5NTHX5MNeuUUzqEds5X+RyUdsVjaEx1msYhUHW
         go3kLzfmFPuPvkku8gRIpdDyYYNdwMmdgVZB9QlXFtSofFEohlourVBv2hS2snKDSsSO
         fhDyPW92w8VD46yU3K+4iLcz2fHsFA6wxkpCa+VZ8h8IOjDOtkn+jSxCTU70Wscrfag9
         js3aLpuVHIKux1acUZs43mD92s+WFIJw/jOXaZ9+LQeTP11NvnadHD0HJ5wdkbz8uAnn
         /FvA==
X-Gm-Message-State: AOAM533FrJa5zS6DhQx3NtYtxsN1ykU84PnSdTTLIrB9vSGXYEYGgiPr
        9egcS1xS0fn4J12Hsh1c48FPqjuWxUxg6A==
X-Google-Smtp-Source: ABdhPJzSN7x8xqn84ju4eisTSjh56thSDZ38ni6PbjQwMB6iDF23Gy54W16+kkXCpc99iVz/VkhfdA==
X-Received: by 2002:ac2:548d:: with SMTP id t13mr2299635lfk.602.1600802834729;
        Tue, 22 Sep 2020 12:27:14 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r132sm3770013lff.167.2020.09.22.12.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:27:13 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Milo Kim <milo.kim@ti.com>
Subject: [PATCH 5/8] mfd: lp8788: Constify static struct resource
Date:   Tue, 22 Sep 2020 21:26:56 +0200
Message-Id: <20200922192659.14535-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a couple of static struct resource. The only usage of the
structs is to assign their address to the resources field in the
mfd_cell struct. This allows the compiler to put them in read-only
memory. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/lp8788.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index 768d556b3fe9..c223d2c6a363 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -34,7 +34,7 @@
 	.num_resources = num_resource,				\
 }
 
-static struct resource chg_irqs[] = {
+static const struct resource chg_irqs[] = {
 	/* Charger Interrupts */
 	{
 		.start = LP8788_INT_CHG_INPUT_STATE,
@@ -58,7 +58,7 @@ static struct resource chg_irqs[] = {
 	},
 };
 
-static struct resource rtc_irqs[] = {
+static const struct resource rtc_irqs[] = {
 	{
 		.start = LP8788_INT_RTC_ALARM1,
 		.end   = LP8788_INT_RTC_ALARM2,
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43880272048
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIUKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgIUKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4D7C0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so12109667wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0BzTczQmHpS8t1I+BEXhbnRvatw/mGTEVui5t5Npsm8=;
        b=MaGfrgp7PHlwm0A3ZkZ8h7GGR0RRi37Yiy+yOd5x5uXY0+HcDxdjSml1+xef0vvkdj
         tS3sXina++U+mHFVDNOpo4FxR+MKEuxMpMHJCiPfbi1M9UFYsGR2tGbxTmGawX8YfVhT
         nKo7z8pNaOdCKG8B5Pn2VUl1tuxJoxxgNGxHZwnWbKtFj7m98v8TJRBs8RYcvOAKLS4p
         ZnFF3w70EHp62lTH+unebW+knQa6DFB/0HfzeJgPprU7N5ZJ4dLwia0vADFLPrzISADS
         v+H8iUci900i8d5403aBVru8s47NLPmFzKenxG9h0uSNpOTIPTAGXRKSOvcH4eFpMICM
         bhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0BzTczQmHpS8t1I+BEXhbnRvatw/mGTEVui5t5Npsm8=;
        b=fvH4LCSRAlEaLQKikOAwVEh/qjtyOj2W0DwnARNycIuck2cY+8uszeL4zI2hLvAB8y
         Fe306xlcqJsVgHy9wmM3DYJKn9Lfuj31J+f4lBIUuexYOld+S+fombaEYuWKFTLtV/37
         XiJWFfBHfAU7jyH/nW0oLTcLXnZvvoRo7Uoqo/vkVXcO6EV2zTHj53wYuHrd9xx59q8O
         2H282LlOy9/zbRi4LfC83y3ce2fa5gM8/knxqChY/YWrmxe1sJ+S3AU6jGBb1ElrtXaO
         HdReUTngvnzwIREkfuH2Ce2Pj8D2Mea/PwrsOmpV/X3zQixOH5rPgdqTwuI3bYMRXh89
         /Wzw==
X-Gm-Message-State: AOAM532zG6dda41Pj+mB1WOK5GSRlo6MQJ0nvNvJL6rCSZuWhDdU74+N
        sbwLSWorkn+Nnc1ucyUQufyMqg==
X-Google-Smtp-Source: ABdhPJxO38VZN2Eb0UXu4Mfek/wdnnRWiA/oi1U24WVDHA8DvtyjmmeYlDpoZllXQtDhZEg5Bs/1qQ==
X-Received: by 2002:adf:f508:: with SMTP id q8mr49455553wro.233.1600683635970;
        Mon, 21 Sep 2020 03:20:35 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:35 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 04/49] staging: media: zoran: Documentation: fix typo
Date:   Mon, 21 Sep 2020 10:19:39 +0000
Message-Id: <1600683624-5863-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some typo in doc.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/media/v4l-drivers/zoran.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/v4l-drivers/zoran.rst b/Documentation/media/v4l-drivers/zoran.rst
index a0586514cd8a..2b82b9a47a71 100644
--- a/Documentation/media/v4l-drivers/zoran.rst
+++ b/Documentation/media/v4l-drivers/zoran.rst
@@ -119,7 +119,7 @@ Pinnacle/Miro DC10+
 * Analog Devices adv7176 TV encoder
 
 Drivers to use: videodev, i2c-core, i2c-algo-bit,
-videocodec, sa7110, adv7175, zr36060, zr36067
+videocodec, saa7110, adv7175, zr36060, zr36067
 
 Inputs/outputs: Composite, S-video and Internal
 
@@ -280,7 +280,7 @@ Samsung ks0127 TV decoder
 What the TV encoder can do an what not
 --------------------------------------
 
-The TV encoder are doing the "same" as the decoder, but in the oder direction.
+The TV encoder are doing the "same" as the decoder, but in the other direction.
 You feed them digital data and the generate a Composite or SVHS signal.
 For information about the colorsystems and TV norm take a look in the
 TV decoder section.
-- 
2.26.2


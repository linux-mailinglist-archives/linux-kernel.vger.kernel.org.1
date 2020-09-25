Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A182E279067
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgIYSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgIYSbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:31:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:31:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so2158296pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0BzTczQmHpS8t1I+BEXhbnRvatw/mGTEVui5t5Npsm8=;
        b=N6H+th0biKog1jTa2+v9iPZsN7GgH5ExsPbdxWxyvojQJCyOhGHNOldZZZlOnzFhsS
         +jPC5GKxu1sLszhaLV4IXCUa4lk+3SJYQVTfmXaTgwqNwDItBmQys2ql0OamwR366CHk
         dUxeYKw/4PTxhHycDyiuGNqUTaFcSCJ4kgLiC7/HNSQHl21zmE52qqH/ePs/PEWBBGD6
         9YhRFy5ALtTOXBKJ3vKCVncnweXMuU1RVdSaa39AHV/w/3yqoavs7T0omAYvS/QsQ8Pe
         P2KsQI2cX3mMWZ30cvqtm53gI2HVBSEocpxIl0YaGw6jpEd2kdErwynkUTCq1arKAJ2f
         6PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0BzTczQmHpS8t1I+BEXhbnRvatw/mGTEVui5t5Npsm8=;
        b=SPQowO6Kwc+G4CXWJ7xsum6+UmyLS+PQqqdhRql4jVoLPES82KZpErOQDzgXjIFJQB
         Qlc+QrlKs8jHisDSVmakWtFsLpqVgBGo5OzUYgCRy0njUJPwMGMDhQOdaT8KYwCSW2K8
         BHvo4mw2EW0WrFm7hBrRU7z5vuf5Hkio3I/0CWEVyZ83ygFi09vCdfQYplSvxBVL8gnU
         DGjcCDHXmZI48PR2jDY8NAQXVTYe41dyqmkT1WnFh5DDGYYcOK+HTh1MvrGPyn9V8Gc2
         BMaVDmiDlEdbD+lpGGG2SYvDyN0uzrM9YrJ+1NFwd/ANvItCLfH5CB7kDV8JXa3pcOKg
         ExlA==
X-Gm-Message-State: AOAM530hTtXPA4OAoEmViSl7hsEyhu9d9l9nzD90h/XUtO38RQDyCqHm
        hMttbevDuOjJKCV04HlL3Y4/dg==
X-Google-Smtp-Source: ABdhPJz4yB46vJZ55e8SdDGabTx8iLhxyUZ31qRsNTsuVgUULeN3fknL7bfoRi7h7j8vZfaJ/1Izfg==
X-Received: by 2002:a17:90a:474c:: with SMTP id y12mr768032pjg.150.1601058701069;
        Fri, 25 Sep 2020 11:31:41 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.31.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:31:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 04/47] staging: media: zoran: Documentation: fix typo
Date:   Fri, 25 Sep 2020 18:30:14 +0000
Message-Id: <1601058657-14042-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
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


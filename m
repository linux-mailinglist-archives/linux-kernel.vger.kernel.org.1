Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98BB2D3460
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgLHUi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgLHUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:38:27 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0521C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:37:41 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id s21so15013635pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cOsptZpbaXZdyHeq1KoGUWDMF3slisUiT0yak+RYvVg=;
        b=V1HJf+WKm8xtLqwvNnhsLkSQVipGbGBajM1F2ZUQcrOTQ2iu39pW4KdaTgszCgwjnq
         tGzWVJdaHcBvZzl5aaqYttQ5TUOZCZZeqIs09s44Q9oB+hsnPkOAZotzWpI8i00QVucJ
         ZkqvlVBVZSwtlbZua/brIaYJZ/+yexmmd5LKCv3G/Ku5t2DBPxqLPlTYem2pm7/BQHwc
         Y2739VDQ3AMdHUYiNTI4cIVwWH1a3RA/iMrBvYTFlKq7M7ehhFBWisKxwf1Ty4u4bQp6
         Q+maaFLNMOJu0B6hXcWTKH/5A8HPZ32RGxpfIbbSJvjpSfD8VZYPzolUFR9zjcbs0rIx
         4beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOsptZpbaXZdyHeq1KoGUWDMF3slisUiT0yak+RYvVg=;
        b=qfeNHpD/sT4wv/PwgB+mWFVluujRtrr8GSABKfK/N1eKaNHc4qPNDNrcqgf2ljeTiw
         B88q2G2trCnlKZjmj2CFmd9SsoNwuxdhap4Buy73iWXe1Nffvnp2/b5s/3Zl/NNApril
         /I4EVDeDWQGMmP9iTYLXtYrFBuNUFod+CkMapw+Yt0qW1bDd8XbhZMU1Q9fA2fTWiC6r
         VVqCLRncxt448GiGIpkyUrg1Mt1YoPeVxVpbtMTQ0sKSALCQG66REfyvTrKsiNMTFi7y
         /+4AGpM6kXd3BtOzKDyMO7IrAej/EWZnmIFTTvsl9yTInNXswMe1n6JrfHvpHr3ZrExi
         ooLQ==
X-Gm-Message-State: AOAM530bByNAbTkHCH7Kqyiombqi8pH1dFQ64Q2b0C6Zi4jsjCw6YAMm
        j8QjJlU7ngrtu3qjZS5uOhU8aIhJoR9YGloy
X-Google-Smtp-Source: ABdhPJxyhjHPDKKo2JqsB/7HDITrAO23pyfmgSy+gat1GDFvuRxWeDGk6joJ5fCWRlKZVFhCYSjLzQ==
X-Received: by 2002:a62:7693:0:b029:19d:92fb:4ec1 with SMTP id r141-20020a6276930000b029019d92fb4ec1mr21819903pfc.4.1607455203885;
        Tue, 08 Dec 2020 11:20:03 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id i4sm16499994pgg.67.2020.12.08.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:20:03 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: add i2c3/rtc nodes and vrtc alias to GT-King/GT-King-Pro
Date:   Tue,  8 Dec 2020 11:20:02 -0800
Message-Id: <160745519765.13209.7401462503756984105.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201062135.18241-1-christianshewitt@gmail.com>
References: <20201201062135.18241-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 06:21:35 +0000, Christian Hewitt wrote:
> The GT-King and GT-King-Pro boxes have an RTC chip and power cell, so enable it.
> 
> GTKING:~ # dmesg | grep rtc
> [    5.237245] meson-vrtc ff8000a8.rtc: registered as rtc1
> [    5.261869] rtc-hym8563 0-0051: registered as rtc0
> [    5.265016] rtc-hym8563 0-0051: setting system clock to 2020-11-30T09:16:54 UTC (1606727814)

Applied, thanks!

[1/1] arm64: dts: meson: add i2c3/rtc nodes and vrtc alias to GT-King/GT-King-Pro
      commit: 7704b100719cf0fead976a1bc839c60ee552d045

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

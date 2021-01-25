Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C33303830
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 09:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390390AbhAZIjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 03:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbhAYSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:43:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA2C061786
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:42:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cq1so131626pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrpnZCUbozEfGIxovyWegSL2iDBOBOEkB9CAIPmTQjI=;
        b=Z01yBkBd8lv3PpNWrzlI/SNDtHmy/aH5TQnESkYpYpsGbLxQgEpfIlgluQrHIW9+Pk
         le5YvE8HZKfwVTcQe68Dr38UrgiUQGXiujdO0Sb2H7ACSJByouDnNK9o9TH9I8PrjLYq
         9aWH0j29dbNmixZni7EDsISiNjvogLYSl3MNM+coHAte79N4hHIX0QCrcxeWxwU6d2w1
         73wtJJ0IPF2E0d1M3weyq/4QaduOCvOkog2FBz7RotEMQ+f+kCkWyEqjvk2KBYYpWw3d
         HpGEjKEry+jAtKnH1xtdYFiMDKYSID623ev19DBLQShF58tw2cd/1deNFSJksqu7zGT9
         0n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrpnZCUbozEfGIxovyWegSL2iDBOBOEkB9CAIPmTQjI=;
        b=hB4zIDF092/xYP8XlV46yiFCpdesEnFD/YTzd0GT5g64QQjLaNIEG+HdwrCOyzfqt3
         wVyoq8QiWJBVvrNkASRdbZA48hV127TG4tPq+wc+qH6K8QNl4ZqqvVaKt7okIVjM3UbB
         7zgAXsLWTitYeFufs4Ufv0mWIbg9oNbXqCbRnQGgVHEv9Mt97KhT1uk8imiw7rYaui0l
         BExWT4wGHDmuT5J6VCkZCgIIJYs/UTFnDIic6dJK44KJmFX7gH+hLfXGuYZbgfBfKZsc
         l26hBZC7kxL38uQz2NdkehsGdtRHfS/cI4ySxeaMIBockuAoCjneDILn1EuO5SJWsQTi
         dm7Q==
X-Gm-Message-State: AOAM530wsiO3SAnMpTvmoZi1I6hWlJvddDwrzlygxhr5l0AMrw6KmXzp
        e/W/6QRIDGdsCvXk/PQOM0D9wg==
X-Google-Smtp-Source: ABdhPJzZQCuc9RXUU+fxTF1ebRHHVBoVrZEqZFVDzH+92iBJeHzYPNA4GFXx3s3v4jg7XzgwgrNYZQ==
X-Received: by 2002:a17:902:ba15:b029:df:f346:eac6 with SMTP id j21-20020a170902ba15b02900dff346eac6mr1843563pls.44.1611600147770;
        Mon, 25 Jan 2021 10:42:27 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id c73sm15930853pfb.77.2021.01.25.10.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:42:27 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Thermal zone configuration for Meson8/Meson8b/Meson8m2
Date:   Mon, 25 Jan 2021 10:42:21 -0800
Message-Id: <161160013613.17631.16811353695468732000.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
References: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 19:13:01 +0100, Martin Blumenstingl wrote:
> This adds the thermal zone configuration on Meson8/Meson8b/Meson8m2
> SoCs. The thermal sensor reading is taken from SAR ADC. With
> "generic-adc-thermal" it is then used to configure the thermal zone.
> 
> CPU and GPU frequencies can both be managed. The vendor kernel also
> manages the number of active GPU pixel processor cores. This is not
> supported yet so we skip it.
> 
> [...]

Applied, thanks!

[1/5] ARM: dts: meson: move iio-hwmon for the SoC temperature to meson.dtsi
      commit: e9ced25e41588a2ff95280b4d3dabf3a0865513b
[2/5] ARM: dts: meson: add the ADC thermal sensor to meson.dtsi
      commit: c8559511107120403f7810428f50fc68fd77ed5a
[3/5] ARM: dts: meson8: add the thermal-zones with cooling configuration
      commit: ecdb744b1f819949f783508331ff6ff8a6a45730
[4/5] ARM: dts: meson8b: add the thermal-zones with cooling configuration
      commit: 9073f694efd8733b0e7c97d3396d81161bd05582
[5/5] ARM: multi_v7_defconfig: Enable support for the ADC thermal sensor
      commit: 726731566a862fa375de44313f601e49c4d40377

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

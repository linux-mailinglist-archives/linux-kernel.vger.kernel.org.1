Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E822CCB3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgLCAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLCAsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:48:10 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006AC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 16:47:30 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j1so188209pld.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 16:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=0iSNRCsv4QiujIvck7LYjf+I2m3BZnqlwW9BXnXzbgg=;
        b=fb/2kM6RvKx/QCzksjNVKwIbgLuaxVZ71SfRliwn9NTj2150eRm466siPuBe+587Hz
         WUmeb3sK7JQ34RniAA6QgcIZWbKfNGx/KMMgttWuwU2PkKIHCdSYQOi9S7xQ3FZZ6mCp
         qId5NR09c2AWb0Rr5vIXtkNA9Iy78eUUZby2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=0iSNRCsv4QiujIvck7LYjf+I2m3BZnqlwW9BXnXzbgg=;
        b=Ce19Y1dSaDrCqaJ2gzl2nB/LzVI6u+WDvBSEG5Qf7hYxlbq3O5PjMMgwJYWR50Pb3T
         5owypev7PbmGuWRVRxHY19sBh6PdDV0LN/w7JJLGnpVgoPuiib8wzEt3eH0SsiHzom7S
         ESnOQsy43+t1wZyE3nXU+FwA7gvbLweU8c7QaORHVcoEZ5Y9SObHAIhcB4JV4dXKxcOY
         JwKt90EyUudwTCUxNrxZdI2mZpXkIeqwkwNmeAU7biLU/TvzZdPWcQyZxTH3kf+O8Oqp
         5RX9WreYU2T4pQVTXCmyr3hc7X28JjdObFxdniE+LecQ/vj7Cjs7rLwVV/k2bJs+uW8n
         4uMg==
X-Gm-Message-State: AOAM531ddjbONSVsnd8Tp3D+hQhXdkG3vYVMv35JzQcqbSf3K1MDJWIA
        qyRmwtXiqnpdT/b7YVlidgwv2Q==
X-Google-Smtp-Source: ABdhPJyv6jlyr3LJAukcdyuq16gEaaYmf9e1YpSO8VOsuY9Xi/2YetHzz+4GVXUde2fs5UvNR5MaAQ==
X-Received: by 2002:a17:902:b70f:b029:da:b944:f3b7 with SMTP id d15-20020a170902b70fb02900dab944f3b7mr746054pls.82.1606956449808;
        Wed, 02 Dec 2020 16:47:29 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l190sm227210pfl.205.2020.12.02.16.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:47:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <160695172591.2717324.17788035024164242534@swboyd.mtv.corp.google.com>
References: <20201202214935.1114381-1-swboyd@chromium.org> <CAHNYxRwMD4XahHXWW9z7b=VCOEsdPe5Df4CohNwmBy_ijWJ62g@mail.gmail.com> <160695172591.2717324.17788035024164242534@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Use the new method of gpio CS control
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
To:     Alexandru M Stan <amstan@chromium.org>
Date:   Wed, 02 Dec 2020 16:47:27 -0800
Message-ID: <160695644776.2717324.633265815704005177@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-12-02 15:28:45)
> Quoting Alexandru M Stan (2020-12-02 14:18:20)
> > Unfortunately this patch makes my cros-ec (the main EC that used to
> > work even before my debugging) also fail to probe:
> > [    0.839533] cros-ec-spi spi6.0: EC failed to respond in time
> > [    1.040453] cros-ec-spi spi6.0: EC failed to respond in time
> > [    1.040852] cros-ec-spi spi6.0: Cannot identify the EC: error -110
> > [    1.040855] cros-ec-spi spi6.0: cannot register EC, fallback to spid=
ev
> > [    1.040942] cros-ec-spi: probe of spi6.0 failed with error -110
> >=20
> > I wasn't closely looking at this part closely when I was using my
> > other spi port with spidev, so this is why I haven't noticed it
> > before.
> > Doug suggests this might be a polarity issue. More scoping to be had.
> >=20
>=20
> Ah I see. It looks like the cs-gpios polarity is wrong for the DTS on
> sc7180. That's a patch that Doug has sent in for the qcom tree, commit
> 37dd4b777942 ("arm64: dts: qcom: sc7180: Provide pinconf for SPI to use
> GPIO for CS") and it is pending for the next release (v5.11). Doug says
> he will send in a fix for the DTS side, but this patch is still "good"
> as far as I can tell. It moves us to use gpio descriptors and also finds
> bugs like this in the DTS file that we would have missed otherwise
> because the legacy mode doesn't look at the polarity flags in DT.

And that is wrong. With even more investigation and Doug's eagle eyes it
seems that the cros-ec driver is overriding the spi::mode to clear out
the SPI_CS_HIGH bit that the spi core sets in there when using the gpio
descriptors. I'll send a patch for cros-ec-spi shortly.

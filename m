Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A7826E072
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgIQQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgIQQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:16:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA32C061223
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:16:14 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so3033466eds.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXtED6WfkK75LMSgQ8vQsHgOI0yBBTxcCbphfrryf6M=;
        b=pxXpcpXnfAa9lQiUbT1N7VNoozm1D6PgfhboSOd3HXlWtPP7dYn2AhERiYfxBWj37j
         jsduSgKo3fSswcu5jj7rT8R/p1UoiktZNMLCBziOtWuDhQCPfVIjzVBeazVgnC7kRgvb
         cGOIN9WJf/fdeKcuLTS4+4caBpl9TCTVBd0AvPoYPAUTCm0L5Eu+6tCTUkWqTzKAN6Sg
         6hVKODArf8j6huwlEWsNCAN0SmhEWJP+z7xiTEXP/xs+c+C93cyj03dm9fgx6GGdgbZP
         L1l6cPnrFPnghuoXMbTxtMYD3X5cX0CpEDPNPU8W+/vBUg07fEYXXi8zmHuICCNykgYh
         Ljsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXtED6WfkK75LMSgQ8vQsHgOI0yBBTxcCbphfrryf6M=;
        b=LtfPJobu/pBq3CPoALS8yNNwh6fm304L/wOO3KTHnZ4l3zDTrY1bA0I7DjIIEf+y9g
         0lSSy82gO85Pz5cMOQ84lUXRCbeqE30mkVL8M9RuFDBKlDLiPV8UzijtekP/1MPdRO8a
         q0x5WXxNsLvkgDbIX0MlOJHqHFo3furIm0iwWyBPV+eMoultRw54YBrba7ftj0QnAJnz
         WQSOdtGW5nP/nglmOoWEIt8YvgrXrlNZBKtUxOkHz4QPdI5GxgSVPOShXX4y3YRsGUme
         YpnPyiIiA/xogYzBr+IK3okJIchFn7pn23DCKfTDKPyvKajacF9Uf3LJe3aNFpnXNBFs
         daGw==
X-Gm-Message-State: AOAM530Z9tsntDYyk+hA8H1m7j6ZUrIpwyWfyedrpfdUCJ91fum77Ghe
        pGbqGISR/n2mRaZlAIAJOWzQ/x+vh2FQ6I8x2wTDNQ==
X-Google-Smtp-Source: ABdhPJwfOaudC9vLJAbRhRYhSHh7q4n3U/sNpTA5Q1/lxT2SwoFxppQHiVyye1h5POHhmPDl/bW1IEH53reBheDklw4=
X-Received: by 2002:a50:9b44:: with SMTP id a4mr32910561edj.12.1600359373655;
 Thu, 17 Sep 2020 09:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200914154601.32245-2-brgl@bgdev.pl> <20200917155336.23ECD221E3@mail.kernel.org>
In-Reply-To: <20200917155336.23ECD221E3@mail.kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 17 Sep 2020 18:16:02 +0200
Message-ID: <CAMpxmJVhfVZLmepERHSVg9qnuWUJj+BwiOKc_7QopREbHvAZpQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] rtc: rx8010: don't modify the global rtc ops
To:     Sasha Levin <sashal@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 5:53 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag
> fixing commit: ed13d89b08e3 ("rtc: Add Epson RX8010SJ RTC driver").
>
> The bot has tested the following trees: v5.8.9, v5.4.65, v4.19.145, v4.14.198, v4.9.236.
>
> v5.8.9: Build OK!
> v5.4.65: Build OK!
> v4.19.145: Failed to apply! Possible dependencies:
>     9d085c54202d ("rtc: rx8010: simplify getting the adapter of a client")
>
> v4.14.198: Failed to apply! Possible dependencies:
>     9d085c54202d ("rtc: rx8010: simplify getting the adapter of a client")
>
> v4.9.236: Failed to apply! Possible dependencies:
>     9d085c54202d ("rtc: rx8010: simplify getting the adapter of a client")
>
>
> NOTE: The patch will not be queued to stable trees until it is upstream.
>
> How should we proceed with this patch?
>
> --
> Thanks
> Sasha

I sent out a backport for v4.X branches.

Bartosz

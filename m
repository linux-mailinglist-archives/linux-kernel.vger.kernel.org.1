Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1D2A8056
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgKEOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgKEOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:03:56 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0E7C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:03:56 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id d24so1674516ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vpw1xKcWPIDCCoX9GPHpUdBLY9mfAcDxFQiVjHuc6eE=;
        b=NCAhTINjzEmAOE0J1abW8CRieoLkMOdPtwEzxZGpiAoskI+xO45EVaWXdhDLiWUsPe
         wA0oP5P8cIxCD6BK1O17L1r+1SaCLR9UKgZyHC1QlEhULZasIE5WrRVEJ0NtaDDRTqg4
         +VDnsXOsXXDibG7ztG/yozEqcecgZIAn9hq6UzpjdLb19nZFdjElBgo5VEksITpIbOOc
         8eMaUb2S0oJWLmx3a6aKbUgb3JRKkr1EAmKaNghBiU66JNLnM5Gnf4nM1G+wTwqZck18
         wAQkiKUSK2yhjDhr9rkjo50j5QO0U7U4u7u7VU7BpoodE16vh4QWS4r09r1QD2IAJK/R
         22HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vpw1xKcWPIDCCoX9GPHpUdBLY9mfAcDxFQiVjHuc6eE=;
        b=CAVxDJq647MdRhJZyQX7oM0KTFmi1Za76CuY7LRLO6htvUkMSB/qONp5Iy3ovDr/y1
         rOMetVpbksRhvCT1m1pZfoawdKk5JTUmJrkfqPlI6Tz1Y1yrxKPA/kV41tRWglSihIse
         0hQtYzDugTwMDPh54Ip4ZMbP/MBVcywMRqkR0J07OgZ4zHVCzKET1yjsBRgny//CtUE4
         qe0jsKjimvBGdP7Uq6uT7/mFXZ/HqxpqA+aQ11vfIlMf2kBwMgk9rvBoODBpirNHL0lh
         Bgq6M7iLQZYuqbVeMccQ/7DKI8gHuw7kslFkXAdYLTVAUxTHbSVV4h0yiKv9GOWuuR+x
         gGYw==
X-Gm-Message-State: AOAM532axmN6QuOBPpv/irH4Ino0I3YKtiSf7LU+npJLzhtdyZnjqVlF
        /Dhzv7DG9zGJP+ht+J+JahPTb8vAjyimzH4e+euf9KpxTUiSuA==
X-Google-Smtp-Source: ABdhPJw6CRp1lnXXZXYg5qaYlO84yznObo8m7XyqUTshcqNlV6bZul3Xf0rhOWenICFa4DbJ8ndU2IX2cRLNOHmFK+M=
X-Received: by 2002:a2e:8905:: with SMTP id d5mr925043lji.144.1604585033201;
 Thu, 05 Nov 2020 06:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20201029074654.227263-1-coiby.xu@gmail.com> <20201029074654.227263-4-coiby.xu@gmail.com>
In-Reply-To: <20201029074654.227263-4-coiby.xu@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 15:03:42 +0100
Message-ID: <CACRpkdarE9f92nF10vZrPsgMatUT21vXN0coHCUxCp6gnneXYg@mail.gmail.com>
Subject: Re: [PATCH 4/5] i2c: nomadik: remove unnecessary CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        "moderated list:ARM/NOMADIK/U300/Ux500 ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 8:47 AM Coiby Xu <coiby.xu@gmail.com> wrote:

> SET_LATE_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

I don't know about the state of sleep/pm callback macros, but I
assume you know what you're doing.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

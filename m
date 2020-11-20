Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC412BB97A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgKTWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgKTWxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:53:09 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:53:09 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id v9so3645399uar.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VppCy+LvcqmPJ0j+BmKuuLjWYOd4m4mcycAyos72/iM=;
        b=VTgoiecSsLHv+TIXTOEbu0waHvUIa8pBnLMmt9VhHqkhOj8jhHEK9AOBRMiyLkibNE
         qNTpwfEQJRmKzWwJISUwv5Jd8DoOrnncnrQufFxkGf2AGwnXrnvFZdkqraHTnrcZOivE
         xdL+iIlNESvQaISCikOJs273gb3+PYmo0YVic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VppCy+LvcqmPJ0j+BmKuuLjWYOd4m4mcycAyos72/iM=;
        b=kYK4dcELXZhX0SHfgNqrJ96eE3C0CTfUiqC8tuQCNiggehENZv6yA+a/D8CAbV8bhi
         0fRXS1IrHiDA6KuBed6CIqoenuwuIWpZboo3glVCXh32YSBIH4KsnhE9feQ+Ytq03OGG
         wYL0BcMSL0bmM9z6tACW124EhbgOiPdWfAOalIYzdetz+DKVTjq6Kre5u3+matK23XiR
         QlBKkg3P7Y8Uo8cKlk0vMfGVLUiwzwos9kj/YZjYbHYbEPlmLG5DSc6B9+dA2wpzGaUD
         pM3jwVz+H1SmMNAR9yYDjaBe8WvM90FM1df38sgfeNBgd6fJjNqcvTC3dPPl2CZYiITb
         vxGQ==
X-Gm-Message-State: AOAM531kf+JVC78MfIGJ19ZNko5RwkI9VMRuBfOj4xdKl6Acf6FAh0rJ
        izDvfnY3CkcZq/Asj+BafuwX7QwU5G9wnA==
X-Google-Smtp-Source: ABdhPJy1f0RSiz4zBQOQlKO/FnAxN1q15I4CI2TvdGXB4oKa/dOA1VfsaJW8SlAHQ1Yl3MWJRb710A==
X-Received: by 2002:ab0:5a10:: with SMTP id l16mr13859770uad.0.1605912788473;
        Fri, 20 Nov 2020 14:53:08 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id x6sm537665vkb.23.2020.11.20.14.53.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 14:53:07 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id w67so2590581vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:53:07 -0800 (PST)
X-Received: by 2002:ac5:cd58:: with SMTP id n24mr15138352vkm.17.1605912787245;
 Fri, 20 Nov 2020 14:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20201120200913.618274-1-swboyd@chromium.org>
In-Reply-To: <20201120200913.618274-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Nov 2020 14:52:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vu-oaLk-6C4o8mDzJ0edx0ch5CbW8cve0-j4MZ0WQ6LQ@mail.gmail.com>
Message-ID: <CAD=FV=Vu-oaLk-6C4o8mDzJ0edx0ch5CbW8cve0-j4MZ0WQ6LQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Remove double pull-up on p-sensor-int-l
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 20, 2020 at 12:09 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This interrupt has an external pull-up so we don't need to pull it up
> again. Drop the internal pull here. Note I don't think this really
> changes anything, just noticed while looking at this irq pin.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

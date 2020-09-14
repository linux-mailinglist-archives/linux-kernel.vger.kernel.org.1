Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01F2696B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgINUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgINUSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:18:11 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3800C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:18:08 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id 77so284891uaj.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRAd4TkY3E5awHOzVDefEmGhmwZQ3nO0bhizEoI0HSk=;
        b=GAIXLWY1Gkag3cBGyczpELHlw5MF0yNt5vDmgLJoF87oRETi1yDXkgPQkHDRGWqsx4
         QrQ/dSZ7d4/bQlCV3/8x3foAPwYavqzDw59vRHLTL6mi54R0MfZDMKNuNak3XWqP9ME/
         3tfFnCHsI5R9ObHlpAsLlAG+CaSJ4SJ8R4wqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRAd4TkY3E5awHOzVDefEmGhmwZQ3nO0bhizEoI0HSk=;
        b=h/sihXqeSeRh0Hj5+HGzOefw3w22e8ua4KCtN8mLaNl+kOneRghglPs+IsWiQNMKF3
         pShJ0y/jCmQ4lWhRSlEFINZdTW0PGY9lLN8+/jGo2E6x95myyoH4S4cDftu4hpFlrKt5
         O9RKGDC8SbiS06geGVqA/nXEvoA6uV3LWkboTvj3lia4DhDuSGGQwISed0/D+qGSU7OO
         fi3Wht2w4H+0iaPDnZaNNqpxmHDHHLgIktR0KVNOBcZEv2qxNDYYbTXRhbWvU2ZpozBD
         UOSugd3Mqtlv2uCx3JuQDpakghROJFpNrdzIyIgY+xRj46NEqj7khfPR75mQ7qR8TVxm
         fYlA==
X-Gm-Message-State: AOAM532VHd7aJYXmk7BYeT5E3Gx18S45x0uStOYhtFdvr5FhmNgWNODX
        rTqYoSH6Ik135AZA6DWo61ixok6xWX2e6g==
X-Google-Smtp-Source: ABdhPJy5ONHwHuqvBKMT9ity4OEuJzaqq+YQuKBqKIGL9+y+NE87YDeBw1qXwM+GMI1avbxKiNICSw==
X-Received: by 2002:ab0:73da:: with SMTP id m26mr7874580uaq.136.1600114687777;
        Mon, 14 Sep 2020 13:18:07 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id f2sm1790059vsc.23.2020.09.14.13.18.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 13:18:07 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id b4so267404vkh.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:18:06 -0700 (PDT)
X-Received: by 2002:a1f:bf53:: with SMTP id p80mr8344769vkf.5.1600114686429;
 Mon, 14 Sep 2020 13:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200813080345.1.I85bb28f9ea3fa3bf797ecaf0a5218ced4cfaa6e2@changeid>
In-Reply-To: <20200813080345.1.I85bb28f9ea3fa3bf797ecaf0a5218ced4cfaa6e2@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Sep 2020 13:17:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQP4bFSEuYMUyDqj4BAB6Kk52FdZQ9r+67jBnJn5uX6A@mail.gmail.com>
Message-ID: <CAD=FV=UQP4bFSEuYMUyDqj4BAB6Kk52FdZQ9r+67jBnJn5uX6A@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: socinfo: add SC7180 entry to soc_id array
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, Aug 13, 2020 at 8:04 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Add an entry for SC7180 SoC.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/soc/qcom/socinfo.c | 1 +
>  1 file changed, 1 insertion(+)

Any status update on this patch?  It's tiny but it'd be nice to get
landed!  :-)  Thanks!

-Doug

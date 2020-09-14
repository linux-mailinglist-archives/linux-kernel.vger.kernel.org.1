Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103A6268B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgINNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgINMqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:46:39 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8E5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:45:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so6912690edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJYOAv934b1m0EJs345WNFe82VUSXirAUPxRlXYyP8s=;
        b=oUiG5GMw3O7k6gNTEOaC8CnW8SxRh33605u1rld4KgxnmccUNZ5vG/05CY1tp4sq1s
         KtmQw2Z8hBlB5pA/0LWjZodkz4tbcp0bIhPhWD4mC6nZ0VZh8grxd2/KH2azDkpv0xRP
         YRP0Vxl38TZVTwwwAiLcq2BSwH5WpvdsPgLOter2vNSCtzbIGzMoWi6SvDQKfJtRcMkK
         t8Ic9Yw1eAXEvLcNYczm6lQBC3jU6zdTnFp0H1wlXwg3fErn3oba4ew6Qgi9wuX26XCg
         BdPLjzrj35lLejsteq2OprlnN7W4/Hl4tbCWT1fINQvH5T/PszsVMqx30M6skmkVmsxa
         9C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJYOAv934b1m0EJs345WNFe82VUSXirAUPxRlXYyP8s=;
        b=kYJ/+uMP1FZs1Sq26SRoEPYzULHN2yhZUK5jVelMda0AiIrr+uOeeCeIbPiTjDmLFK
         Jnaq80e/uIjNOVNt7UZrqbLToNxx6j4ibXwDtsQzjKXRPw+ybPdqgJcqL46Ey4GaqaqL
         PlsQ/8vY25ZyVwG7ThvQU8SA0urXyG75bKQdi8wnw6LJSVS6lqOeNfnIpgIUekpRwpQw
         LCXU1wuIJjvzN3UBO6tD7JObl2fnNo7TLMFZnpWIHmDWSFHtPFyGsPXtSSAoYW1zMjVi
         gIoDV1ohdOh8DhA75YdgQHNZ+hwL1GzDLvMSGoGszVax5Tcfmz4mz1atkA95unHaHIA5
         fnbA==
X-Gm-Message-State: AOAM530TVPIV4eHMeoc3V6B12c8fETYVIs92awkVRDMet5Id4Gdj10Bk
        sYA93EXmZ2FI7SlEawOBb1dTsENqc6tnzT51Y9ARJw==
X-Google-Smtp-Source: ABdhPJxnZ5B0KEWaICwJ7TKdTypan+wzbzyPeKR6yjJOJResCLHcgnHZmggOYV1YRnnYyOFwz2GCO/iWVWU7/AUyi1o=
X-Received: by 2002:a50:9b44:: with SMTP id a4mr16569943edj.12.1600087541952;
 Mon, 14 Sep 2020 05:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200909102640.1657622-1-warthog618@gmail.com>
In-Reply-To: <20200909102640.1657622-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 14 Sep 2020 14:45:31 +0200
Message-ID: <CAMpxmJW182gOs9LQoGHq8zq5scw+i1_X8WLoEPP=YRxhY8dvnA@mail.gmail.com>
Subject: Re: [PATCH v8 00/20] gpio: cdev: add uAPI v2
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 12:27 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> This patchset defines and implements a new version of the
> GPIO CDEV uAPI to address existing 32/64-bit alignment issues, add
> support for debounce, event sequence numbers, and allow for requested
> lines with different configurations.
> It provides some future proofing by adding optional configuration fields
> and padding reserved for future use.
>
> The series can be partitioned into three blocks; the first two patches
> are minor fixes that impact later patches, the next eleven contain the
> v2 uAPI definition and implementation, and the final seven port the GPIO
> tools to the v2 uAPI and extend them to use new uAPI features.
>
> The more complicated patches include their own commentary where
> appropriate.
>
> Cheers,
> Kent.
>

If there are no objections, I'd like to queue this series later this
week to give it some time in next before the merge window.

Bartosz

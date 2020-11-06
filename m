Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832AF2A973F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgKFNtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgKFNtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:49:25 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4DFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 05:49:24 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so1993811lfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22OIdEFUCyt4H3KQWqTyCb3vVMeDhkPiacWpzyCBWYo=;
        b=kmHCNlz35nAFF0GkwKonjMa/BUk+1EOVQYoXBTZfLhFVh9nr/sz9dyu3BD2g2NG/l6
         D7MJ5hOXsYKiAJf8rWpv5vPOlfr5C6dmn9thpIjh7RKDQe9ibyFFhf4T+lhh6ij6lwTr
         iyb2XSbdel6hKpngK2AnrN58GUVUE+ETChlAbXAQFV56TTu938591orYsjm0Z593ymDq
         L5jR6YetcH21OTORqdlX6N7mTzckjHBm5yv90pHgAeGtLZE0IaI4rPMPr9DBqVxSRmg5
         wu3gwF3Hw9OEL4ZgGexfllFdNiQOWul0PGxlkAV0JnPB43gVCLH8Il7VNgmAibKahAFR
         orew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22OIdEFUCyt4H3KQWqTyCb3vVMeDhkPiacWpzyCBWYo=;
        b=Qc1MFZhwK8UbSTYiLRCmKzVxyvjzrufBrAcXifuRkPZCFs+9/iMMHROQ0Ap8mr4qnu
         ZfWsMJw2RxIeCldYcmVuvGROvW/0JgRZ50G7ER5XyismCShr0FGTSx+hJVRYuWR40M0j
         rDciGL3qOzicg0haUABOO0tu+Yc2Wbvvo2lP64lfieyrO8kJ0KgBs380m+gZ3SDc2WT7
         +hwT/4xfdw76NJSdHMUl2IV8Gc2GhWiAE3pJDIsTN1bPvJY2fSsOKlx+sEcdA4kfRKBi
         CqEI6nD3mvUReE/Ix6YD62bHCslbTRB/glph5nobOJ1RvV63GXdx/RmhrjizfoH0XcYW
         7/tw==
X-Gm-Message-State: AOAM533kcWKoOUcKpPdLGTiM0FfnCMKdUv4FCG7nwi9FR3v6Un2700u0
        uv751Z60Wc6qxhRRHuT+QtYlN/WR2XSOJzC9eAmsIribzJY+5w==
X-Google-Smtp-Source: ABdhPJwm3Xd7nf58h8q44ytLIskUkZZWdezej9K9s3tuJjII7XbZbLMt4ufSdT47OHwPZE8FoX7luU3/Objd/SjTU0I=
X-Received: by 2002:a05:6512:322d:: with SMTP id f13mr878802lfe.571.1604670563316;
 Fri, 06 Nov 2020 05:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20201014231158.34117-1-warthog618@gmail.com> <CACRpkdbTsN6p4n3f9SJrgAjdkzDu2S67rU3tLWwX0X50ekjctQ@mail.gmail.com>
 <20201028232211.GB4384@sol> <CAMpxmJX61dRE_d2Eyu2nXKx64rNrrTfScrdg=Cc-N-R_FKfUNg@mail.gmail.com>
 <CAMpxmJXiObcKyoE264oyiZOs08=uRYno6siMzz6BH+jmT_NKgQ@mail.gmail.com> <20201031000139.GA7042@sol>
In-Reply-To: <20201031000139.GA7042@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Nov 2020 14:49:12 +0100
Message-ID: <CACRpkdZ2MoV04YCVxCxG-wPTgNAORkN6D+AXVOC1vEqsdGqo8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: cdev: allow edge event timestamps to be
 configured as REALTIME
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 1:01 AM Kent Gibson <warthog618@gmail.com> wrote:
> On Fri, Oct 30, 2020 at 03:52:24PM +0100, Bartosz Golaszewski wrote:

> > The series no longer applies on top of v5.10-rc1. Could you rebase and resend?
>
> Nuts, it relies on my doc tidy-up series that Linus has pulled into
> fixes, and so will likely go into v5.10-rc2??

If I have time to get the GPIO fixes into -rc2. Otherwise -rc3
and then I need to merge the resulting -rc into the devel branch
before applying.

I will get to it sooner or later, I think Bartosz might have some
more GPIO fixes that I need to pull first before sending any
fixes upstream.

Yours,
Linus Walleij

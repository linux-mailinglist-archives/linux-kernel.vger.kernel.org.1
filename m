Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308AC1AF791
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 08:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDSGdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 02:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgDSGdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 02:33:39 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66446C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 23:33:39 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id g184so3927137vsc.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=olj6unh6IYZuJdIs2F04EMuJOg0rJtmlozehjb/ljo4=;
        b=qakdRyWAosXa2M8Dnt6NrNgssX4Mv+jtWt0D3fs/rm0IIjaMrkMu8DOW94Vlyc4EXs
         HBbOWXb/ouVdhHAY97dK9AYHONKklSbOZapIi7CqYxYlHdgmanPnZ8BmJrZhJqyq9JM1
         laESH5scPswVS2ZJDptWwCJeAGCOjh0MnIbEaQIfpPWMFHBBtKSl2A0rcyTUZ6aDMTs1
         J+CjhOizqYKJgnCjnbHv/Fj38pHQSyuqxW9HhK/G7KTT5qZe8MiMf9XE/m6uzsHRViLQ
         s99hIvNmf69mF4Mt7Ikj5WHLYFUmrIO3KUZfs1e1aaYw2NYINJ5F5oDP1sE6enQU60/e
         zfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=olj6unh6IYZuJdIs2F04EMuJOg0rJtmlozehjb/ljo4=;
        b=GwJYI8JQ2dLdBuOXVNH1c5E4r22YgWJE2qH+cbDliZfPNU9mjyEoR48HCQbDCqcNlZ
         clTYoN//CTTSuOkKFj3XjilRzhBE6nkNBIXBE2l7VY70Au61NeMSc3XJLwEwzqddAXYz
         u5WGgVqDtXN5YAk8VfJDBU2HF3/rpGG5fpKt+GEQKO1luC1bgCK56zWu/s/k4f433tnX
         /tIGWnV+Qdlct0LF/0NGnkV/dHl5qG00P5em29zk6aMY7yPt3LHMdmyNWBdoOMMYDcf6
         shuz9JBtYDYrwneZ5YvwwkJxzhsMwUxkfQFJdM9/dw3qBsGNMXquED5+m2jrU/l6o2vJ
         9cTQ==
X-Gm-Message-State: AGi0PuamSZkFvh0+W1vtOg5N7cbrjTyCzOE0Vv4GyujBYRIjCKkPisWW
        rGUJM4BAYoFeDx0ggr+jx3jWkfXfai+rG0H0A1xi4Q==
X-Google-Smtp-Source: APiQypLLd9TBFMBrw30qYiOJQAHyqzFTi2q/XtAiUO90be53KPVwHYQ8gR58pUThHEtu56HBCMW5SjgyVyLbABMpJgM=
X-Received: by 2002:a67:ebd6:: with SMTP id y22mr184815vso.193.1587278018514;
 Sat, 18 Apr 2020 23:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200418104343.GA5132@amd> <DB6PR0802MB2533670AFC1473E5C5EDAD28E9D60@DB6PR0802MB2533.eurprd08.prod.outlook.com>
 <VI1PR08MB3584451F0B0B21E00ACF56A7FED70@VI1PR08MB3584.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB3584451F0B0B21E00ACF56A7FED70@VI1PR08MB3584.eurprd08.prod.outlook.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 19 Apr 2020 09:33:26 +0300
Message-ID: <CAOtvUMfNgdYZF5VaqgF-51b0+KtxqgUFD6njXFX7evz1yAJc9A@mail.gmail.com>
Subject: Re: Fw: Arm CryptoCell driver -- default Y, even on machines where it
 is obviously useless
To:     Gilad Ben Yossef <Gilad.BenYossef@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hadar Gat <hadar.gat@arm.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -----Original Message-----
> > From: Pavel Machek <pavel@ucw.cz>
> > Sent: Saturday, 18 April 2020 13:44
> > To: kernel list <linux-kernel@vger.kernel.org>; Hadar Gat
> > <Hadar.Gat@arm.com>; herbert@gondor.apana.org.au
> > Subject: Arm CryptoCell driver -- default Y, even on machines where it =
is
> > obviously useless
> >
> > Hi!
> >
> > I'm configuring kernel for x86, and I get offered HW_RANDOM_CCTRNG with
> > default=3DY, and help text suggesting I should enable it.
> >
> > That's... two wrong suggestions, right?
> >
> > Best regards,
> > Pavel
...
> ________________________________________
> From: Hadar Gat <Hadar.Gat@arm.com>
> Sent: Saturday, April 18, 2020 11:31 PM
> To: Pavel Machek; kernel list; herbert@gondor.apana.org.au
> Cc: Ofir Drang; Gilad Ben Yossef; nd
> Subject: RE: Arm CryptoCell driver -- default Y, even on machines where i=
t is obviously useless
>
> Hi Pavel,
> I think you got it right..
> Indeed, Arm CryptoCell CCTRNG driver couldn't be used and obviously usele=
ss if the Arm CryptoCell HW does not exist in the system.

There's a delicate point here though - CryptoCell is an independent
hardware block, it is not tied to a particular CPU architecture.
There are SoCs with none-Arm architecture CPU using it.

So I would say whatever the answer is, it should be the same for any
generic embedded style HW block.

And the help text is not architecture specific anyway, is it not..?

Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!

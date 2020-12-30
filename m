Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03B32E7B18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL3QiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 11:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3QiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:38:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7DC061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 08:37:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r5so15868708eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVfEscTWrcnRAUstVk+z5rIH4LVN1OhWfrh4poNpSPs=;
        b=SfxFSDGwuvyRNjoH1YpU4kpbjG2jbCDsWHfZ52vYMlLhmC8I+oyFWw5PGpO4k2AlqS
         QCs4gIrH619ABi+iWSJ6L1DjQ1rAmYr1cddMD/JzOnckEQH1H+Jna6SHZfAXjCSCuA6h
         DdgqB0LZDa80/wzyfG6FzzEvO7n/5AuzMw+UqLJrZUwb0GXjNy9h/PDM0wifHfHqjYfc
         qeZBtMNwb2XiYKE//GgIWckm4p9VKgjdzzDwKclcNp2DVbFM7KD2rpRaDaAzTO0kGte7
         4NBWNnoszfmyHDmd4mHltcDMFxE0RFteaupXC+eBIlP/rHZzbvkmuiKI+rONSDLpy9Uw
         g3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVfEscTWrcnRAUstVk+z5rIH4LVN1OhWfrh4poNpSPs=;
        b=FTnvqu8u84FLeWS9A56zapahAkCPulOriJjgOYP1AqlezI1UzbmqyqmBpIa7Eu5ekV
         1IY/lxfZtnQwF0jvYHT8WhAHnEPXKxZqYJ3FjRcPTG/P+Fn+PzYPptEd1pSeq4MwqDlh
         Y+ayssJnlVVwsqjccl2BroAlFgOq7Qoc2FlISuG3NG30eGUCUrDbAc1LFP9WZ3aQwTAT
         lMqD0U2FjMVUyJxhDgRbSfqeuFi7QktkQJXv2setllZCvWjO338i0/K4dCl2sE477ee+
         RqiXX6xr4QsZ0/aUuWvacK+775Ac+lyjnl4DAg2QMlP/2/db2Sw9Y200KAZvCxcieFwK
         gWJQ==
X-Gm-Message-State: AOAM531iGs8eAbc2j0PmU2V7IWsuX7+AMOJ9Y9btNztIVZDH/9d6BQLL
        HH5SPq0pVZfp2vBQSTQ9B23VCluoUrUU6N/McufUSFL3LxbHr5Bm
X-Google-Smtp-Source: ABdhPJy142y7dTWtR2nBRm+gQnFosp7I37kTzfXDPUvW+oDCxsl5piD4yPR61pLoAgQsWB7TVmtJyA9h34pYFJrZPCA=
X-Received: by 2002:a05:6402:1597:: with SMTP id c23mr51945363edv.212.1609346248773;
 Wed, 30 Dec 2020 08:37:28 -0800 (PST)
MIME-Version: 1.0
References: <1609191951-15590-1-git-send-email-tharvey@gateworks.com>
 <20201229130629.GD4786@sirena.org.uk> <CAJ+vNU3hWOdXUoogCH0U_WvYaMMaFBYs8D30KEg96ctgkhBqyQ@mail.gmail.com>
 <20201230131402.GA4428@sirena.org.uk>
In-Reply-To: <20201230131402.GA4428@sirena.org.uk>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 30 Dec 2020 08:37:17 -0800
Message-ID: <CAJ+vNU0rC65wCpt3m+_pp6Qufw8Ni97Z4o5j3n3LTqBYzCvyxg@mail.gmail.com>
Subject: Re: [PATCH] regmap: irq: do not allow setting irq bits during ack
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 5:14 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Dec 29, 2020 at 08:23:00AM -0800, Tim Harvey wrote:
> > On Tue, Dec 29, 2020 at 5:06 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > I can't understand what this commit message is trying to say, sorry.
> > > Which bits are you talking about when you say "if bits are set"?  Isn't
> > > acknowleding the interrupt clearing the bits asserting the interrupt?  I
> > > can't tell what the problem you're trying to fix is.
>
> > If for example status=0x01 the current code for ack_invert will write
> > a 0xfe to clear that bit which ends up setting all other interrupt
> > bits keeping the interrupt from ever being de-asserted. With the patch
> > applied a status=0x01 will result in a 0x00 written to clear that bit
> > and keep other's from being set.
>
> But that's not an inverted ack as far as I can see?  That's writing back
> the bit you're trying to clear which is the default ack.  Why do you
> believe this is an inverted ack?  In any case the changelog for the
> patch needs to be clear.

Mark,

It 'is' inverted ack because the device I have requires a '0' to be
written to clear the interrupt instead of a '1'.

The chip I'm using has a status register where bit values of 1
indicate an interrupt assertion and to clear it you write a 0 (where
as the typical non-ack-invert case you write a 1 to clear). The chip
I'm using also allows you to 'set' (by writing a 1) to bits that were
not already set which would keep it from de-asserting it's interrupt.

Honestly I thought the commit message was very clear. What exactly is
your suggestion? It is of course confusing when talking about code
that handles both ack invert and the normal case (let alone the new
case of 'clear_ack').

Best regards,

Tim

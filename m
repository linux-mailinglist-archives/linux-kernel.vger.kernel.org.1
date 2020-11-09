Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0312F2AB47A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgKIKJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:09:39 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ADDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 02:09:39 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c20so7663357pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 02:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qk5gi/5yo+bHb4dIhLsQnA/TlaWVF810gIQamYhDZ7I=;
        b=UM8eunoxfH/HxDe2hIkj78Qi2aQs+b1NQ0Wy1uvRP1l8nNbeLAE+bIDGPT8qL6tg0S
         mbP/n5BfRlDkyBGfVF4H6cpauzhjixYUu6lLoiRqeWQxAzxe3X4krf0jgzhW5DGk42Z/
         +c5b5bJYHXI2hsHfBhQ3DxLUHOCYcTy8yBVaszuBAv6SreNiF/xOnwjGkJ6wP+xuENZg
         MJZCdZ5KLkOI0UJ3CbOEWy7XO/AyFkoUQXj+mBG7baUc1Kd8/HXLkyLNuF00YAtfIDRc
         YLG44EuMtJXl/Fwk0EuYwpSaLD9CTaJG1Pkd3qMomn/CGV6s/7yBXJTeA24E6NB8rPc8
         rtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qk5gi/5yo+bHb4dIhLsQnA/TlaWVF810gIQamYhDZ7I=;
        b=K1zx0eYkp3pQPidrV08/0zsbbl4HZhF/+UUTiFT5rQKj2eCNd0L9CASbxqVmPo222Y
         AdW7cUMtKrB0b+K2mxNtewIBeUo4b/hkWOaykbzyqnna8D72MRABXwEbZsxPo0lKeC5A
         Z91hUNjDAQldMczAlR5FGdJs+SK17mkU400PzL1NHQ6vyFTAqwb+Qby7ylWSDFVlgYSG
         LERQcrcUQo5y42ALdkVJl1cYOvZ9FMB9zD6mL2U+QXnrxjPMNa8wOFEnv8Hy+4FORV3l
         uHngoRKX4HG2WGimvVUoCICLa+eKC6rhb8DSIYEN0/dzEwMxuKtk3SPkrsRuaqjmcnb8
         3YMA==
X-Gm-Message-State: AOAM531Czq4z64SLKNqccMmBMYD0FJjfJAVuUP0pmS4cIE0GQy3yjSSR
        dxSVG4+sKB3IZbQ4TRlXipr9A85sf75VgFZeF0I=
X-Google-Smtp-Source: ABdhPJyDnGZEvcbhTVamscgLvoDFTToOnyu7dWB0UrPc0n5/YAMeVbIvXYnJy3ivFsASIQIW72IoPKNwyHlT/PM0SfI=
X-Received: by 2002:a17:90a:4816:: with SMTP id a22mr2641442pjh.228.1604916578802;
 Mon, 09 Nov 2020 02:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com> <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
 <56794a31-26ed-39eb-4082-75b5ec7cf28a@kernel.org>
In-Reply-To: <56794a31-26ed-39eb-4082-75b5ec7cf28a@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Nov 2020 12:10:27 +0200
Message-ID: <CAHp75VeO6inzfRGSEBWgW0OCzjE9uT6LoXeQzHDdg4FiRemYWQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 11:57 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 06. 11. 20, 17:06, Andy Shevchenko wrote:
> > On Fri, Nov 6, 2020 at 5:35 PM David Laight <David.Laight@aculab.com> wrote:
> >> From: Andy Shevchenko
> >>> Sent: 06 November 2020 14:36
> >>>
> >>> There are few places when GENMASK() or BIT() macro is suitable and makes code
> >>> easier to understand.

Thanks for the review, my answers below.

> >> ...
> >>> -     if ((d & ~0xff) == BRL_UC_ROW) {
> >>> -             if ((ch & ~0xff) == BRL_UC_ROW)
> >>> +     if ((d & ~GENMASK(7, 0)) == BRL_UC_ROW) {
> >>> +             if ((ch & ~GENMASK(7, 0)) == BRL_UC_ROW)
> >>>                        return d | ch;
> >>
> >> Do you really think that makes it more readable?
> >
> > Yes. Because this tells explicitly how many bits are used for metadata
> > vs. data.
>
> No, because ~0xff is clearly what it is. GENMASK(7, 0) is:
> 1) longer to read & parse by brain with result: "GENMASK undefined"
> 2) terrible in this particular use case

Maybe #define with a proper name can bring some shed of light here?

> Another instance of an even worse switch:
> -               if (arg & ~0x77)
> +               if (arg & ~(GENMASK(6, 4) | GENMASK(2, 0)))

It exactly shows what bits we are accepting and what are not. 0x77 you
need to translate to the bitmap and then figure out the bit numbers.
This is error prone as shown in some cases.

> OTOH, the switch to BIT is legit in all cases except the comparisons
> with keycode:
> -       if (keycode > 127)
> +       if (keycode >= BIT(7))
> -               if (keycode < 128) {
> +               if (keycode < BIT(7)) {
>
> That's horrid and non-sense too.

Isn't it the exact threshold about keycodes that we only use 7-bit value?

> sorry,

Consider this then as RFC.
What about the rest of the series?


-- 
With Best Regards,
Andy Shevchenko

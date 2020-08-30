Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE11256F53
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgH3QWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 12:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgH3QWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 12:22:24 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9381AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 09:22:23 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u48so588795uau.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z06b0kU9wn19cfBXnF5Y+xrjYDF9DOBSpgPz6QyB+UE=;
        b=e6gDQeM+scr90I8EBtpkiubS50gqjj1637ZJiexV9K+RaCcCN9QW2/FNQhlcWitbE2
         u/DHZ7xjURb5sKwMwYWnfThwBItFTs1ibu477EpbwoEY/oWjmluCks0AvrFrjf+sjdOR
         WKwpjVk8LbLc85cQTkazXFRedDSGV0cHQjudI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z06b0kU9wn19cfBXnF5Y+xrjYDF9DOBSpgPz6QyB+UE=;
        b=WIX9WUgjiuOsOA5gz4O/fb6Bn9w8BiBejHlXYQNm5hz8K4NzusnTIPBba/tRXDv8en
         rFCZ21WW7X5A1WewKVtpmYeVy1l2gS2taLI8abrssQT5w4PKutgpDQmYj5M3EB6lmeL3
         Yb3QJO6D3DOjpupAmveIx4cWU8wqcUN+xJC0hVhPb4K9mqEx1qaKf5w5DfZ/BiHV0mJ0
         NcyGY3lPMHCGMOpUANXMmP0Mq1iQ3HpHHNePeTVcHWztZnJvnSSvxqi3HKDGk7sRkW+k
         fSz+6b1/1bM1S2gc4b+mv4LygRYCb4hQRW5kAa4ezol2rGqQUusTWSQ+R4rKYoWZvZrA
         SWHw==
X-Gm-Message-State: AOAM531o2pb7HFK5aH5Ub4BW+Mf6DxMtR3cm6XKnMG1qmmxCGP9ha6vC
        +fuf6ghrgqEjqSDavUPjLH3vzK5qfpKRyQ==
X-Google-Smtp-Source: ABdhPJyrtsYzMjWN8vPfLdkG8hJidiB+Exd8arTNn+xVrLCelog9pS/V7BLAaw3qt3gEYOkcgT48Eg==
X-Received: by 2002:ab0:804:: with SMTP id a4mr3760724uaf.3.1598804536153;
        Sun, 30 Aug 2020 09:22:16 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id k12sm980864vke.4.2020.08.30.09.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 09:22:15 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id y3so2080115vsn.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 09:22:15 -0700 (PDT)
X-Received: by 2002:a67:1c86:: with SMTP id c128mr3728071vsc.219.1598804534454;
 Sun, 30 Aug 2020 09:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
 <CAFv8NwL-s0c_nFWKHmBKgPVeLXwGWdgV+fUtw8MLBJw2D3ox1w@mail.gmail.com>
In-Reply-To: <CAFv8NwL-s0c_nFWKHmBKgPVeLXwGWdgV+fUtw8MLBJw2D3ox1w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sun, 30 Aug 2020 09:22:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WTUKfcoBdVhpWm1ULyh8PvJj1O8eDxHTG_EBUbkNj9xw@mail.gmail.com>
Message-ID: <CAD=FV=WTUKfcoBdVhpWm1ULyh8PvJj1O8eDxHTG_EBUbkNj9xw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Prefer async probe
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 30, 2020 at 4:05 AM Cheng-yi Chiang <cychiang@chromium.org> wrote:
>
> > @@ -294,6 +294,7 @@ static struct i2c_driver rt5682_i2c_driver = {
> >                 .name = "rt5682",
> >                 .of_match_table = rt5682_of_match,
> >                 .acpi_match_table = rt5682_acpi_match,
> > +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>
>
> One thing I am wondering is that there has not been any usage in codec
> driver for this.
> I think every codec driver can use this, and take the benefit of a
> possible faster boot time ?

One possibility is that they are all enabled as modules instead of
builtin to the kernel so nobody ever thought to do it.  Modules are
always probed asynchronously, so this flag is basically a no-op there
(and, in fact, for anything that can be built as a module we have even
more certainty that async probe is safe).

In the case of the Chrome OS 5.4 tree it's possible this driver should
be moved to a module.  However, even if we do that my patch is still
fine and would be helpful if anyone has a reason to build this driver
in.  Similar patches could likely be made to other codecs and would
similarly speed up boots in cases where codecs were builtin.

-Doug

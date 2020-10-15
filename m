Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE00828F927
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 21:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbgJOTEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 15:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbgJOTEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 15:04:51 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E21C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 12:04:51 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id j15so1130173uaa.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsqHAs58x4trJhhHbsTmRDV/y8bm/KqBtxUEW7L/rUE=;
        b=YNNWaoUtxTP/GIofNOCaOHVKhI6pyeffEbAmx886qQVLDGA3jsArPDvJf/qbzSWmCc
         C5JfSYJSVtYWs6UJQCeHi99QiHWdoFYMYViyrs4GkHdbebB9lvRoT5MsmnuVEbrv5sQ5
         xyBdn1KZD+RztL6gagqXOC5GBULxTxnMWP+g3mewAA2K+kcEaPCupv4dBfWaESKTZ0q4
         F/jljeAcNeIyh+7o++HQGpupYtGu3HVDJc3LL7YW5gHdbei4cJBlby+rSSR2WQbMITIL
         Y200lB9YcKNGyyeCJEg3TIV4W7HQoW+8SvWycOmJ5NiqvujbAt6k1iobSf04Y5uPkCOq
         SULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsqHAs58x4trJhhHbsTmRDV/y8bm/KqBtxUEW7L/rUE=;
        b=cavxL5wubU4gj7OxsQB85kvzNR8qwY09szwglHGW1M6a3ucz2rARySN6e1YEXzGYUX
         mZBUXQd58zzKfx5wljFerv2V+/gXAxNc3k3Lt4RkAHMRuSLWY2xR/47bK+OpG8JEgLI5
         HVGQq/wfLjCLzHmkuYXK0Vas1/6lgvGM42liJp0SiC0tfcq5q1DhUyYQR9XjGCIs0QAV
         u6KxNq9GtkjlW5Y9NoEVeU96C+aounuQ7xPYsuvFW5q8Z+DgoZ9gRuIYVYPagLTsSrSp
         nPKq7p8Q9gGSC6B9BYni3vIYvsjJPNnDRpDJgQrZwJJwpzIcgNov9stbVFvU8Lg4y9PY
         Hh9w==
X-Gm-Message-State: AOAM532NBXe9i92R4Z3tsj0AbhNevkn1cET0qAe8VBFp96/SSXdoT852
        xev3IFEBPUOurLw3i9hb5CHRYNN2K0I=
X-Google-Smtp-Source: ABdhPJymi+IyOhWP8oSBxPVFkDDm+K4VCyeRKLJN+TZn8HykviN6ajRmGf70IS6Pb68MKNfZNM2O/Q==
X-Received: by 2002:ab0:36ab:: with SMTP id v11mr67914uat.5.1602788690188;
        Thu, 15 Oct 2020 12:04:50 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id l28sm34195vkm.0.2020.10.15.12.04.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 12:04:48 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id l6so62098vsr.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 12:04:48 -0700 (PDT)
X-Received: by 2002:a67:d84:: with SMTP id 126mr3522829vsn.51.1602788688034;
 Thu, 15 Oct 2020 12:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201007101726.3149375-1-a.nogikh@gmail.com> <20201007101726.3149375-2-a.nogikh@gmail.com>
 <20201009161558.57792e1a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CACT4Y+ZF_umjBpyJiCb8YPQOOSofG-M9h0CB=xn3bCgK=Kr=9w@mail.gmail.com>
 <20201010081431.1f2d9d0d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CACT4Y+aEQoRMO6eA7iQZf4dhOu2cD1ZbbH6TT4Rs_uQwG0PWYg@mail.gmail.com>
 <CADpXja8i4YPT=vcuCr412RYqRMjTOGuaMW2dyV0j7BtEwNBgFA@mail.gmail.com> <20201013095038.61ba8f55@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201013095038.61ba8f55@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 15 Oct 2020 15:04:11 -0400
X-Gmail-Original-Message-ID: <CA+FuTSf2kfvdYydXYJNCCfE62q9DXXOBMh_ZSO5W=L9GK478HA@mail.gmail.com>
Message-ID: <CA+FuTSf2kfvdYydXYJNCCfE62q9DXXOBMh_ZSO5W=L9GK478HA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: store KCOV remote handle in sk_buff
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Aleksandr Nogikh <a.nogikh@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        David Miller <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 12:50 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 13 Oct 2020 18:59:28 +0300 Aleksandr Nogikh wrote:
> > On Mon, 12 Oct 2020 at 09:04, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Sat, Oct 10, 2020 at 5:14 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Sat, 10 Oct 2020 09:54:57 +0200 Dmitry Vyukov wrote:
> > > > > On Sat, Oct 10, 2020 at 1:16 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > [...]
> > > > > > Could you use skb_extensions for this?
> > > > >
> > > > > Why? If for space, this is already under a non-production ifdef.
> > > >
> > > > I understand, but the skb_ext infra is there for uncommon use cases
> > > > like this one. Any particular reason you don't want to use it?
> > > > The slight LoC increase?
> > > >
> > > > Is there any precedent for adding the kcov field to other performance
> > > > critical structures?
> >
> > It would be great to come to some conclusion on where exactly to store
> > kcov_handle. Technically, it is possible to use skb extensions for the
> > purpose, though it will indeed slightly increase the complexity.
> >
> > Jakub, you think that kcov_handle should be added as an skb extension,
> > right?
>
> That'd be preferable. I understand with current use cases it doesn't
> really matter, but history shows people come up with all sort of
> wonderful use cases down the line. And when they do they rarely go back
> and fix such fundamental minutiae.
>
> > Though I do not really object to moving the field, it still seems to
> > me that sk_buff itself is a better place. Right now skb extensions
> > store values that are local to specific protocols and that are only
> > meaningful in the context of these protocols (correct me if I'm
> > wrong). Although this patch only adds remote kcov coverage to the wifi
> > code, kcov_handle can be meaningful for other protocols as well - just
> > like the already existing sk_buff fields. So adding kcov_handle to skb
> > extensions will break this logical separation.
>
> It's not as much protocols as subsystems. The values are meaningful to
> a subsystem which inserts them, that doesn't mean single layer of the
> stack. If it was about storing layer's context we would just use
> skb->cb.
>
> So I think the kcov use matches pretty well.

skb_extensions was the first thing that came to mind when I read this
patchset too. It is not specific to protocols.

We have long stopped growing sk_buff size.

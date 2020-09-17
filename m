Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C4B26E5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIQUAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIQUAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:00:30 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92990206CA;
        Thu, 17 Sep 2020 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600371978;
        bh=vLUDDjwECCEPbdewF2TSzCzX/HPHD5QUcQcBoQGzVgo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WKi4jiJfXfTUoPhYSWcv/ZqFLRG3+Pz9kZWZYqNS5Ybk9qZvSWOguuRaPoWreIpAS
         pQHExGGitHyN2uJKQh60lG+2dyrkRnTp2yamG7LazxfMfJ3kJEW0Jpv3uEUfWpY3OG
         b49Ljutu97sGVGjQ11QTkTTWKmRN4Ppr+93BhbXc=
Received: by mail-ed1-f46.google.com with SMTP id n13so3697623edo.10;
        Thu, 17 Sep 2020 12:46:18 -0700 (PDT)
X-Gm-Message-State: AOAM5305TK+n29is3nKu9vUmSaW0l9PCmHhVhiOIFi4oweYV+msz8zl3
        5PU8Cv+sNDIM2oIA4RIEUHFBiWf02/j0a7s359k=
X-Google-Smtp-Source: ABdhPJy0Ys3CvLAf9kCxBAt3LTp0VLr/+5ZI1NsvVnqTGE96KBjLVf7ItbKInpyfZEA7zM2TNM9Ra1FAXZ+tr6VOFZ0=
X-Received: by 2002:aa7:da16:: with SMTP id r22mr35659897eds.132.1600371977177;
 Thu, 17 Sep 2020 12:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200914061353.17535-1-lukas.bulwahn@gmail.com>
 <20200916165357.GA18287@kozik-lap> <alpine.DEB.2.21.2009162140130.14568@felia>
In-Reply-To: <alpine.DEB.2.21.2009162140130.14568@felia>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 17 Sep 2020 21:46:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeSeo5dL1+=Jf1bY=xNmBpPk7jVN2x1o9N=Pr-FWPHhKg@mail.gmail.com>
Message-ID: <CAJKOXPeSeo5dL1+=Jf1bY=xNmBpPk7jVN2x1o9N=Pr-FWPHhKg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mark linux-samsung-soc list non-moderated
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 at 21:46, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
>
>
> On Wed, 16 Sep 2020, Krzysztof Kozlowski wrote:
>
> > On Mon, Sep 14, 2020 at 08:13:53AM +0200, Lukas Bulwahn wrote:
> > > In fifteen entries mentioning linux-samsung-soc@vger.kernel.org in
> > > MAINTAINERS, seven entries mention the list being moderated for
> > > non-subscribers and eight entries do not. Clearly only one can be right,
> > > though.
> > >
> > > Joe Perches suggested that all vger.kernel.org are not moderated for
> > > non-subscribers.
> > >
> > > Remove all the remarks from the entries following Joe's suggestion.
> > >
> > > Link: https://lore.kernel.org/lkml/da6f30896a8fd78635b3ca454d77a5292a9aa76d.camel@perches.com/
> > > Suggested-by: Joe Perches <joe@perches.com>
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > > applies cleanly on v5.9-rc5 and next-20200911
> > >
> > > Krzysztof, please pick this minor non-urgent cleanup patch.
> > >
> > > This patch submission will also show me if linux-samsung-soc is moderated
> > > or not. I have not subscribed to linux-samsung-soc and if it shows up
> > > quickly in the archive, the list is probably not moderated, and hence,
> > > validating the patch.
> >
> > Please use scripts/get_maintainers.pl (for example on files in modified
> > maintainers section) to get the addresses of people.  This mail missed
> > all my filters and got archived immediately because you sent it to
> > unusual address (how did you get this address, BTW? It does not appear
> > in the sources since few years).
> >
>
> Sorry, I usually do use ./scripts/get_maintainers.pl and you are right
> there is no way one could pick up that email address from the repository.
>
> It was difficult to recall where I got the address from, but then I
> finally remembered.
>
> I wanted to know who is responsible for the linus-samsung-soc mailing
> list for this patch. So I went to:
>
> https://patchwork.kernel.org/project/linux-samsung-soc/
>
> And there in 'About this project', it still lists your gmail address. I
> did not crosscheck that mail address with .mailmap, get_maintainers.pl
> etc., but just send the patch out.

Oh, thanks, I will try to update it.

Best regards,
Krzysztof

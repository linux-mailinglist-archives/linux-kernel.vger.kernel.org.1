Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC35F2A50A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgKCUDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgKCUDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:03:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E55C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 12:03:13 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l2so23967056lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcG44gg9JsBMcXwjHb9lFTw4mEeTDRbo5E0yF7tkVWM=;
        b=IlnaKg9pnQyq0XUhrMVsb14/FfEzSGxZgCGRFpNWpo0uhl/vXHX/tQm5vYGv5dWTFJ
         GKogd8GDu22uIOaPdGPGkL1Noh5+YlHSCNA6BFxfWdlZLRI04t6OwpEq/arYeti4M3j6
         9aNcXUFYVIDR76sfBfVmD/XU0AnosmmaEPl2pddcOMgn+5tjPeNG1kCOn7tl+FqHkCUJ
         6fai9CFex2KGCDSkW5hS4lEipbq7S9Th+80kKKaULtkkORrKztFPpw7JBn8RNM07jNaL
         sabXXa8ThiDQMraZ8yXB3uVHIoMTj5FBH9KqRab3ge25ceqIRO7KP8bNNOyd5yY1Ce4p
         aIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcG44gg9JsBMcXwjHb9lFTw4mEeTDRbo5E0yF7tkVWM=;
        b=NHszxW+Zf5fVTbuggpBDc/ZYIazS20B7t+7z2Y6I2csc9D8oYlmQfDICXuihUYr78K
         kMZcQRfml4TSmJnJ1YjWb/jFYOgv4hU2kLwsRI6DrNk6JQULnN6CsJtXk9fG9TAqbP4M
         iAo+BomsM+UYVSx1yIFIDLTvcdzRNkm0kd1RKSPiwiGK53+OnyuXL2z/qFFhZ2iz0Cjc
         tM7K87r9hWtViUYNzXmp/OxYUQu+XkdH7L/9Aq0YERMHSj8UR5lyNORHuoVUvl8B39zs
         d0MWoPxrwzEeDs1X8N/qfypIuwxWwxD3qK1nZ4MHY3z2gnbtjg7Ws/735mBly2842uW2
         qtmw==
X-Gm-Message-State: AOAM531xC9oqoLbctdYCznyWDNGRCv6Bk9+FUOEo1RowpAHiCq6Zev1f
        6sVb5Hvp8xHUDcnPkBeM3ubN3s6t4YsgkG9C0eqWR/4ANTiWzw==
X-Google-Smtp-Source: ABdhPJycWFdT224NrSwndSwQpqkFFygXdjoqovHnnFXfJksc8uvzfhyps3gDpGQo2rQBVrc/co9YDPwlOQUVk+JVbIA=
X-Received: by 2002:a19:834e:: with SMTP id f75mr7941538lfd.111.1604433792181;
 Tue, 03 Nov 2020 12:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20201103054810.21978-1-dwaipayanray1@gmail.com>
 <CABJPP5DkJ3gwZDW+FBShs3Yo8z6GfP4LSMRW4hO5hL+fVXjShQ@mail.gmail.com>
 <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com>
 <CAKXUXMwH+tEBSV6xA952xQQFe+HvdJ5ew6V=n63sk89enj6p7Q@mail.gmail.com> <6c275d95c3033422addfc256a30e6ae3dd37941d.camel@perches.com>
In-Reply-To: <6c275d95c3033422addfc256a30e6ae3dd37941d.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 4 Nov 2020 01:32:41 +0530
Message-ID: <CABJPP5D3xVKGC2ESwQbgO4_5eEB5A1JFxKB-ghCOsWGU3FoEbg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: improve email parsing
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 1:02 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-11-03 at 09:10 +0100, Lukas Bulwahn wrote:
> > Maybe you can coordinate among each other who would want to create
> > suitable fix rules here?
>
> Yes please.
>
> > Also, start with the class of the most frequent mistakes for
> > unexpected content after email addresses.
> >
> > I imagine that a maintainer can simply run a tag sanitizing script
> > which just cleans up those stupid mistakes before creating their git
> > trees or sending git pulls to Linus.
>
> Does anyone really do that?
> It generally requires rebasing or post processing each commit after
> being committed before another commit occurs.
>
> > Let us try to add these
> > sanitizing rules to checkpatch.pl with fix options for now; if that
> > sanitizing feature becomes a monster script of its own within
> > checkpatch.pl, we can refactor that into an independent script for
> > cleaning up.
>
> I rather doubt an independent script is going to be worthwhile
> as these rules shouldn't be all that complex.
>
> The only prefixes acceptable for a stable address should be
> CC:|Cc:|cc:.  There are 2 uses in the last 100k commits for
> Signed-off-by: and Acked-by: with stable addresses, those should have a
> message/warning emitted in the future.
>
> The forms used with those cc: stable addresses:
>
> 2777    stable without comment
> 1381    stable # comment
> 74      stable [ comment ]
>
> So I suggest standardizing on no comment and # comment with any other
> style getting a warning.
>
> For non-stable <foo>-by: and cc: addresses and other signatures:
>
> Likely any content after a email address other than a parenthesized
> block should have some checkpatch message emitted.
>
> This should be OK:
>
> Signed-off-by: Full Name (comment) <address@domain.tld> (maintainer:...)
>
> But perhaps this should not be OK:
>
> Signed-off-by: Full Name (comment) <address@domain.tld> # comment
>
> There are 316 uses of this # comment style in the last 100k commits
> and 103 with (comment) after the address.
> Maybe the # use should be ok, maybe not.
>
> And anyone that uses a multiple comments in a name or a even
> a single comment in the email address should also get warned.
>
> The below should not be OK even if actually valid address forms:
>
> Signed-off-by: Full (comment1) Name (comment2) <address@domain.tld>
> Signed-off-by: Full Name <address@(comment)domain.tld>
>

Thanks for your time and review.

I will try to handle these in my next iteration.
Probably there could be extra warnings under
BAD_SIGN_OFF to handle these cases.

Am currently looking to achieve the following:
- unexpected content after email
- Use of multiple name comments
- Use of comments in between address
- stable@vger signoffs

Thanks & Regards,
Dwaipayan.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ACD2785E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgIYLcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:32:23 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgIYLcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:32:13 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MvsMz-1kcL0R1AZj-00svBP; Fri, 25 Sep 2020 13:32:08 +0200
Received: by mail-qk1-f172.google.com with SMTP id c2so2351821qkf.10;
        Fri, 25 Sep 2020 04:32:08 -0700 (PDT)
X-Gm-Message-State: AOAM533pkys8b2Lid9uQbJAD7ezFyLenFz/rIQSCMtnGRxxwuH5OVGm8
        2mLnuN3RFo1KwyI6vK8F85vq2Kf6CZyn2SoydfM=
X-Google-Smtp-Source: ABdhPJx6ewrlWaRTSHIqlQrw+rKO7nXCIyzMa6HgJMLyR6GVXtL8m3RFlHN9L9HcuFDN5VDSQuUZf+KvXWM6om9D0g0=
X-Received: by 2002:ae9:c30d:: with SMTP id n13mr3632853qkg.138.1601033527016;
 Fri, 25 Sep 2020 04:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200918100812.1447443-1-arnd@arndb.de> <20200918124808.GD438822@phenom.ffwll.local>
 <20200924205436.GP1223313@ravnborg.org>
In-Reply-To: <20200924205436.GP1223313@ravnborg.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Sep 2020 13:31:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1P=oY9XexnXjk6F_wcbm8OnZ=70rXPTRED+Z6LjU9_QA@mail.gmail.com>
Message-ID: <CAK8P3a1P=oY9XexnXjk6F_wcbm8OnZ=70rXPTRED+Z6LjU9_QA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fbdev: stop using compat_alloc_user_space
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mK9JJ4zRKrsJacf1kWV+j/IVwr3I225w8Edv+3Fd/rdctE5BPxV
 AbKC7XWzjk9f7C3cU/8l7eJbEFxj+qzXlckOhoEwlRzhTTJjJ+VwCaZiBeKGlNFBkkBJj8S
 Ys4WgyASQQgloKycTDgLRjWCRkF+Zius+T+wueJh4jziCGMW6Y3xyL/TCGiMa4msiCKCdXp
 Na812kwFxphrNkKGxKADA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Qrkn/JJTig=:5K/CVRffclcsx0NLhCQhYu
 r6Jltzn/WW2UmE6ibP7V6Yg5N8injEthBzIebK5u9yfXqOgXYYJr1b58HpY34xmbKkx4yhacT
 NfJspSoHTnAmmYC+NtiUjvL4aMyGfsuhsF2S/9Af7e/7s5BXimQmd7dVB0lhN5y+udlbrLeRW
 bP6ldL2UVPBRGsVa9cq7UyFzjfROTgSI6182HjEOMvaN+rKkteqplwQzZINllxX+Ue4MUF8ca
 h0OgwbS9XUKzPJ+wpNfGf8p4SzA4PG1ar+6AtimMXxp537qZBpvK7CjLtBTaR86Bx+X8SHRSz
 4hbZByZVfYuNfXi/ksdCTC610xBlbJz1kOVwZlhLLhJF6vvXP1HNML/uOAygiURtgcse3dcRV
 FGySca7fM9IZi2hnvCApS/Y/PmnAyaKqnWxtpARkjzuXmwRlt8gPOpjaKdg00e35Jr0jmsPOA
 foTQ/y77d1Gya2DcDcuOPw2kjn7Z8XoKpemgApTfUgUZQXKUi581RGJdXGJ6XD4yWnN0ek9QR
 XtGzNbA4dq6RWoUffwqZk/CWk7b+2DtUAv3BmpbCUYNTFa4x0/ZHHtA2dMB8RonRP0Mfu6rz+
 86mMOcGeocNLNOCQhfJBRiinsPN5eDnuAnQ0PfpXyblOLH0dWnPWgnrPuJSdJLMmAaxQl/a82
 bOam/i+EN49bNYSZ3itciu9QBOYECqjOnVuYtPUByO8wcDOmob836yqR39H99gGm2pbvnBAoK
 7pWYPp274EWsk4Li/WC+kFxtycMs5aWWI2nZ2u+p0FZAob1u+OZY3nymz/mNe9/7o4/NS3O89
 v7+hRGLH31aoXQfnjBIa4g1Qy9X750lQ6WLwjOhm0M18lF45Wn482FJGKiHC1Y2k6IHPn2a0w
 KI5Vcl6uuBlaIl50nVFda1HWQs+yd0SXafBG6gBaLQ96sCpm5FsIKbDZk5NIZqQbffot1A0Tu
 aTjtDEBFkoD5tUbm5EIpBHGoyByk871YpqGfKzlwEQxSX+NLz7Mx5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:54 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Daniel/Arnd.
>
> On Fri, Sep 18, 2020 at 02:48:08PM +0200, Daniel Vetter wrote:
> > On Fri, Sep 18, 2020 at 12:08:10PM +0200, Arnd Bergmann wrote:
> > > The fbdev code uses compat_alloc_user_space in a few of its
> > > compat_ioctl handlers, which tends to be a bit more complicated
> > > and error-prone than calling the underlying handlers directly,
> > > so I would like to remove it completely.
> > >
> > > This modifies two such functions in fbdev, and removes another
> > > one that is completely unused.
> > >
> > >     Arnd
> > >
> > > Arnd Bergmann (3):
> > >   fbdev: simplify fb_getput_cmap()
> > >   fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
> > >   fbdev: sbuslib: remove compat_alloc_user_space usage
> >
> > Looks all good, but we're also kinda looking for a new volunteer for
> > handling fbdev patches ... drm-misc commit rights, still not interested?
>
> Hi Daniel - I read the above as an a-b. And Arnd did not take the bait
> it seems.

Ah right, I meant to reply but then forgot about it.

I don't really want commit access, thanks for the offer.

> Hi Arnd. checkpatch complained about some whitespace, which I fixed
> while applying.
> Will push to drm-misc-next tomorrow unless I hear anything else.

Great, thanks!

        Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB001284495
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgJFEXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJFEXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:23:25 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB25C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 21:23:25 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n2so11223086oij.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 21:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ANwFhziA6NRWy7lZW13LCK/3C4mrNKWe01LnUy/PyPE=;
        b=ubeQDXA0Cxgx/7bsZrkCxUu/6MyXungEnZFJh68eu2VOKv2s62eO/QDVQwlfjlA2/y
         yZVEYLo1pgOebppHxYSjR3kZGHGr06j82PPJWb686YC/YKIBKsUcld2rw7JLfG4JDItw
         G7EamMDZgIYjasgdCxQ4ctLYbcniFRDkwpumD5YqGplcmwvSxQRG3EzMz6N7mB4y02lw
         ZZ83xUduJh3zyyCTvbxUOoyQdG6Gc5XmPLySGddsHD9QUS+FctDCLUJo5H+2bnd7Az8M
         Wvq3NbBy/T3t42RHf8OJ0pPWcDVacw7lLYgdYLT0sUSmmUHMvtg3DbATYd6fmueho05w
         xHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ANwFhziA6NRWy7lZW13LCK/3C4mrNKWe01LnUy/PyPE=;
        b=QePvG1x0hrMgVajyqjPWlPmgt1fZmcM5987z/2xRIRrv84NRNIKK+KgSRK57q0tkMn
         /DwGrV+Qf1h8dbPs8qwYnQJlc0unZMwMJnRXRCSh6w8+NEYiLkdWRNDq2qYoekvEGmuW
         0OZ3SIOwwJOfPaTwL0eDAbcglkCEAZ9vdqCzrIvFRKlk01Ghc+tWjy3kQccxAnIUfhAu
         RDcAlrM2ZP3t3xBx25skak6wcq42VGwp0L/MUV7eXwvFgQ9tGCMDFXYHGvIVvFiLJq0i
         WOdOyZ75sTXnhDA/Ctkox3G5+wvLWoSnHguM7QBkZAhkcBRVVWkwcP+erTEK0Ykdo81v
         igIA==
X-Gm-Message-State: AOAM530bF8p0ONQG2+skstdFpOYTniAtI1V0cT2VDwOSsNXvjWY2IHdE
        dvRO0ded9smiRCLRFEDZWYx71zpfEK9MDTtGqoUIsCiVlwl5omkA
X-Google-Smtp-Source: ABdhPJw+GnvJSuib5NZuUVCEofN25qGMWIfm6hYEVa4I/0D7Ei5FiW4+DLQ7RPRKVLx3zTga+m/WOUE/ce5/0AQqPJE=
X-Received: by 2002:aca:ea44:: with SMTP id i65mr1536012oih.117.1601958204442;
 Mon, 05 Oct 2020 21:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201005192409.192317-1-dwaipayanray1@gmail.com>
 <1d8396cb33b33c3d0107ba701b7e597041dfdbc2.camel@perches.com>
 <CABJPP5DDmurU9c2qCoJcg7hvwnkYo4LCx+TW6xKG2G23Uf_Cxw@mail.gmail.com> <c1ca28e77e8e3bfa7aadf3efa8ed70f97a9d369c.camel@perches.com>
In-Reply-To: <c1ca28e77e8e3bfa7aadf3efa8ed70f97a9d369c.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 6 Oct 2020 09:53:01 +0530
Message-ID: <CABJPP5AmvDPFQhWfxC8TA7SCGtwzurVykR5mtPx0ytm-PJDmYA@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 2:39 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-10-06 at 01:37 +0530, Dwaipayan Ray wrote:
> > On Tue, Oct 6, 2020 at 1:07 AM Joe Perches <joe@perches.com> wrote:
> > > On Tue, 2020-10-06 at 00:54 +0530, Dwaipayan Ray wrote:
> > > > The author signed-off-by checks are currently very vague.
> > > > Cases like same name or same address are not handled separately.
> > >
> > > When you run tests for this, how many mismatches are
> > > caused by name formatting changes like:
> > >
> > > From: "Developer, J. Random" <jrd@bigcorp.com>
> > > ...
> > > Signed-off-by: "J. Random Developer" <jrd@bigcorp.com>?
> > >
> > > Should these differences generate a warning?
> > >
> >
> > Hi,
> > I ran my tests on non merge commits between v5.7 and v5.8.
> >
> > There were a total of 250 NO_AUTHOR_SIGN_OFF Warnings
> >
> > 203 of these were email address mismatches.
> > 32 of these were name mismatches.
> >
> > So for the name mismatches, the typical cases are like:
> >
> > 'From: tannerlove <tannerlove@google.com>' !=3D 'Signed-off-by: Tanner
> > Love <tannerlove@google.com>'
> > 'From: "=E6=9C=B1=E7=81=BF=E7=81=BF" <zhucancan@vivo.com>' !=3D 'Signed=
-off-by: zhucancan
> > <zhucancan@vivo.com>'
> > 'From: Yuval Basson <ybason@marvell.com>' !=3D 'Signed-off-by: Yuval
> > Bason <ybason@marvell.com>'
> > 'From: allen <allen.chen@ite.com.tw>' !=3D 'Signed-off-by: Allen Chen
> > <allen.chen@ite.com.tw>'
> >
> > I didn't find the exact formatting change you mentioned in my commit ra=
nge.
> > But I did find something like:
> >
> > 'From: "Paul A. Clarke" <pc@us.ibm.com>' !=3D 'Signed-off-by: Paul
> > Clarke <pc@us.ibm.com>'
> >
> > So it's like some have parts of their names removed, some have language
> > conflicts, and yet some have well different spellings, or initials,
> > etc. It's like
> > a wide variety of things happening here.
> >
> > I think considering these, it should be warned about, and let people kn=
ow
> > that there might be something wrong going on.
> >
> > What do you think?
>
> Except for comments and quotes like:
>
>         From: J. Random Developer (BigCorp) <jrd@bigcorp.com>
>         Signed-off-by: "J. Random Developer" <jrd@bigcorp.com>
>
> I think any time there's a mismatch, there
> should be a warning emitted.
>
> That includes any subaddress detail difference.
>
>
Hi,
Yeah these cases are being handled.

Comments and quotes don't generate any warning message but
all the other mismatches do.

Only the check for subaddress generates a --strict check message.
others are all WARN messages. It was followed from our discussion at
https://lore.kernel.org/linux-kernel-mentees/7b52e085f0b69ad1742966f8eacd02=
deb9299b96.camel@perches.com/

So does it need to be changed to a WARN or is it fine like that?

Thanks,
Dwaipayan.

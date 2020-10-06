Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CEA284500
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgJFEiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgJFEiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:38:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF1C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 21:38:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so15648883eja.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UX3RCPrcGPIrqbUR3n59SCIf8TFoEsCauVyzo+DA3ec=;
        b=BtbI7jxuD2tSaxYjg9Y1Q/u0svxxBJ2fTSfMePeuhgX0R67Oubt+RaNzbgbLVEhTZS
         VYrLlMyt62cgemHc2wY80mXdcgbgaOUvPgJAOwvZ4jfOwLiKaUaz1xzROfNIkbnO9TzO
         9gAzVHe643wT5urCjG+EQ4dJHXHFW20Vi+m3IfaNvBKBPqIiyHsP9GtWKRXDP1hXKLUw
         AfgDcu2nkeBD+NWOnm2jhGpQ7SHrMiQoPBkR1nKDjpR9W6ebixHE/c6tpqw+DFmVVoGp
         l/vl/NcjdW0x3ojClvU3UBDb8CKKNixQ4Ymkwn7Z0Pm5joZszHItgy1TT/AsMPIe1iEe
         nI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UX3RCPrcGPIrqbUR3n59SCIf8TFoEsCauVyzo+DA3ec=;
        b=Zja5JcaRE/S9od0TQbGbaptcpHJQ0ddZPib74yN3kjeDOV1y9eHBzYTMbxnp7eW+OH
         0WrXip1+HNtLH/LGKurtI/qfCybI6Mzdn3ikI5U0jxHZ7Img9l5W6VhnwmFdRxps9Eze
         gavXMeSiaWq1GwGG7oZaQtFuHwVZYQ3eZhsSC+0fX6QlVHQf1OcnQCF7HJiBcuq3QHKs
         XOMNYvg263znzd4SYKdZV0HYrA/lYRDqPJm4YhzBGH/AYqPEMzNvgZFJXhpIQdmgy+BW
         dmwqKKtJu9IfnyyJ/kp2je/mNe9SP0vYYoUISQRQ1q18iATT9B4t1ToKP/Ya+ZArQiRY
         xq9g==
X-Gm-Message-State: AOAM533MMw9Dsji3hNY7MQIOHH4CxOvsFo0DfeQYBeDKdC5X1LE/33iX
        aS/OkSfsNR27qALPlg1mF1of9ftna6Tj6A==
X-Google-Smtp-Source: ABdhPJxiSxU0j/zKJ0sQ+aLdTW8YRHvbvpeOl5LpshvHzdwmskFIFWRh25dkohjVxsLMhZJKe/te/w==
X-Received: by 2002:a17:906:1a4c:: with SMTP id j12mr3156834ejf.372.1601959084888;
        Mon, 05 Oct 2020 21:38:04 -0700 (PDT)
Received: from felia ([2001:16b8:2d91:5500:d137:30b3:dfba:6d8f])
        by smtp.gmail.com with ESMTPSA id a19sm1366382edb.84.2020.10.05.21.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 21:38:04 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 6 Oct 2020 06:38:02 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] checkpatch: add new warnings to author signoff
 checks.
In-Reply-To: <CABJPP5AmvDPFQhWfxC8TA7SCGtwzurVykR5mtPx0ytm-PJDmYA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2010060635000.10609@felia>
References: <20201005192409.192317-1-dwaipayanray1@gmail.com> <1d8396cb33b33c3d0107ba701b7e597041dfdbc2.camel@perches.com> <CABJPP5DDmurU9c2qCoJcg7hvwnkYo4LCx+TW6xKG2G23Uf_Cxw@mail.gmail.com> <c1ca28e77e8e3bfa7aadf3efa8ed70f97a9d369c.camel@perches.com>
 <CABJPP5AmvDPFQhWfxC8TA7SCGtwzurVykR5mtPx0ytm-PJDmYA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-908877500-1601959084=:10609"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-908877500-1601959084=:10609
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 6 Oct 2020, Dwaipayan Ray wrote:

> On Tue, Oct 6, 2020 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Tue, 2020-10-06 at 01:37 +0530, Dwaipayan Ray wrote:
> > > On Tue, Oct 6, 2020 at 1:07 AM Joe Perches <joe@perches.com> wrote:
> > > > On Tue, 2020-10-06 at 00:54 +0530, Dwaipayan Ray wrote:
> > > > > The author signed-off-by checks are currently very vague.
> > > > > Cases like same name or same address are not handled separately.
> > > >
> > > > When you run tests for this, how many mismatches are
> > > > caused by name formatting changes like:
> > > >
> > > > From: "Developer, J. Random" <jrd@bigcorp.com>
> > > > ...
> > > > Signed-off-by: "J. Random Developer" <jrd@bigcorp.com>?
> > > >
> > > > Should these differences generate a warning?
> > > >
> > >
> > > Hi,
> > > I ran my tests on non merge commits between v5.7 and v5.8.
> > >
> > > There were a total of 250 NO_AUTHOR_SIGN_OFF Warnings
> > >
> > > 203 of these were email address mismatches.
> > > 32 of these were name mismatches.
> > >
> > > So for the name mismatches, the typical cases are like:
> > >
> > > 'From: tannerlove <tannerlove@google.com>' != 'Signed-off-by: Tanner
> > > Love <tannerlove@google.com>'
> > > 'From: "朱灿灿" <zhucancan@vivo.com>' != 'Signed-off-by: zhucancan
> > > <zhucancan@vivo.com>'
> > > 'From: Yuval Basson <ybason@marvell.com>' != 'Signed-off-by: Yuval
> > > Bason <ybason@marvell.com>'
> > > 'From: allen <allen.chen@ite.com.tw>' != 'Signed-off-by: Allen Chen
> > > <allen.chen@ite.com.tw>'
> > >
> > > I didn't find the exact formatting change you mentioned in my commit range.
> > > But I did find something like:
> > >
> > > 'From: "Paul A. Clarke" <pc@us.ibm.com>' != 'Signed-off-by: Paul
> > > Clarke <pc@us.ibm.com>'
> > >
> > > So it's like some have parts of their names removed, some have language
> > > conflicts, and yet some have well different spellings, or initials,
> > > etc. It's like
> > > a wide variety of things happening here.
> > >
> > > I think considering these, it should be warned about, and let people know
> > > that there might be something wrong going on.
> > >
> > > What do you think?
> >
> > Except for comments and quotes like:
> >
> >         From: J. Random Developer (BigCorp) <jrd@bigcorp.com>
> >         Signed-off-by: "J. Random Developer" <jrd@bigcorp.com>
> >
> > I think any time there's a mismatch, there
> > should be a warning emitted.
> >
> > That includes any subaddress detail difference.
> >
> >
> Hi,
> Yeah these cases are being handled.
> 
> Comments and quotes don't generate any warning message but
> all the other mismatches do.
> 
> Only the check for subaddress generates a --strict check message.
> others are all WARN messages. It was followed from our discussion at
> https://lore.kernel.org/linux-kernel-mentees/7b52e085f0b69ad1742966f8eacd02deb9299b96.camel@perches.com/
> 
> So does it need to be changed to a WARN or is it fine like that?
>

I will repeat what I suggested before:

I think the complete mismatch where we cannot even find a name or an email 
match the author deserves to be reported as ERROR.

Dwaipayan, if Joe does not disagree, could you change that in your PATCH v4?

Lukas
--8323329-908877500-1601959084=:10609--

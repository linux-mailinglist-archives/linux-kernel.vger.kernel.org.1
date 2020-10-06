Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A59B284C5C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJFNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:15:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 06:15:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x69so12507724oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PQDR6xEkwdf8z21ZSAjpXNnKLZEbtQBlFLv4LSaZxY=;
        b=Pum2+WRGwkZnNacWNwd4EdFzBwLvaRZLjeyPAk+dol4O81w7EEIh1r9FeXqMnevyuc
         bW44jmIJbHgUMavHk2d7g65TX5FKXAonlXyjtQ7NDsD82AbT8sm8SJMH7qWcRwBGVKTw
         higDWlSELtLB5rvXAucZb7l7fNxYTAFL1LTSTnoNAuhQpb1YP1cN9xri5YMGqM5emVRX
         QOLeTu5b4niYPkzbM0QguaifBjoRUqzXFerBuLEJd2Xmtk9Pa90zW5gQefVkqJNFA3fm
         zLgGDBz+MsE0EZBJVrItFDmOA3hdXMy6bYIu1pMot3JWRC0Ks/F4Uzk2HHVI7jyaMJql
         1/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PQDR6xEkwdf8z21ZSAjpXNnKLZEbtQBlFLv4LSaZxY=;
        b=QiDPa1+9/q6iLGdRYUhFtNOlP+Eald/C8s9gwAHPVI+B0cel+LFcLUz90/1h4ELNHZ
         0RP6F3vTFZoad/m+YEbdaX//QwfkXUk9+FTN0jcYn+XDq/9ScXschZg8Y8aNdz+AG5PT
         Wb91Wci+m+1uIkgYQHeIap1Qpwpk34KAePA+8o2JZrK6717x6VQXIXFYE2gpEmCskKwk
         BYbt89tJsw7C6o5yX8JDC35t7sXRnmsY3lkf4+Ov5shbmzBK/A3xb7EkBtV4cM1E+t/T
         NtXaGe3OgscdQA24/U3fXPW973U2N5gQ4YEUnlhC5DUNxruKPdA+JMqB6SiimToXofWz
         vFUw==
X-Gm-Message-State: AOAM533WIlJgx25pFigtvNQsLtyzjpQCAkok7dGksi0KzNLNuF3vxu9L
        rqDJJ2ZX0MYxO+lQwu0uksa15DPt4q4rX9itrXlpNoF0mYhVqQ==
X-Google-Smtp-Source: ABdhPJxXT29W0nR6ZmhQVN5laWvvvvsskZjceEF6/vckR1lgtFXx9eAOW9Z9CeDCa1um2vSWw8ZkCvGaFb6GhezFjYw=
X-Received: by 2002:aca:cc54:: with SMTP id c81mr2732805oig.74.1601990123878;
 Tue, 06 Oct 2020 06:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201005192409.192317-1-dwaipayanray1@gmail.com>
 <1d8396cb33b33c3d0107ba701b7e597041dfdbc2.camel@perches.com>
 <CABJPP5DDmurU9c2qCoJcg7hvwnkYo4LCx+TW6xKG2G23Uf_Cxw@mail.gmail.com>
 <c1ca28e77e8e3bfa7aadf3efa8ed70f97a9d369c.camel@perches.com>
 <CABJPP5AmvDPFQhWfxC8TA7SCGtwzurVykR5mtPx0ytm-PJDmYA@mail.gmail.com> <alpine.DEB.2.21.2010060635000.10609@felia>
In-Reply-To: <alpine.DEB.2.21.2010060635000.10609@felia>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 6 Oct 2020 18:45:00 +0530
Message-ID: <CABJPP5AkdKekb2mRuiDm1-GOuqZ1vL=eNt=OJZN2iAPH1yNytQ@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add new warnings to author signoff checks.
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Except for comments and quotes like:
> > >
> > >         From: J. Random Developer (BigCorp) <jrd@bigcorp.com>
> > >         Signed-off-by: "J. Random Developer" <jrd@bigcorp.com>
> > >
> > > I think any time there's a mismatch, there
> > > should be a warning emitted.
> > >
> > > That includes any subaddress detail difference.
> > >
> > >
> > Hi,
> > Yeah these cases are being handled.
> >
> > Comments and quotes don't generate any warning message but
> > all the other mismatches do.
> >
> > Only the check for subaddress generates a --strict check message.
> > others are all WARN messages. It was followed from our discussion at
> > https://lore.kernel.org/linux-kernel-mentees/7b52e085f0b69ad1742966f8eacd02deb9299b96.camel@perches.com/
> >
> > So does it need to be changed to a WARN or is it fine like that?
> >
>
> I will repeat what I suggested before:
>
> I think the complete mismatch where we cannot even find a name or an email
> match the author deserves to be reported as ERROR.
>
> Dwaipayan, if Joe does not disagree, could you change that in your PATCH v4?
>

Yes sure I hope to do that after Joe gives his affirmation.

To summarize it, two changes that could be made are
the CHK for subaddress extension could be converted to
a WARN, and the WARN in case of a missing author signoff
could be converted to an ERROR.

Thanks,
Dwaipayan.

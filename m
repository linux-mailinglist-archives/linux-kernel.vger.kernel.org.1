Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF29E2A3504
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKBUSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgKBUSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:18:10 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E666C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:18:10 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id u19so16242090ion.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+E8A8DVtztpBmTMQJ+pHtBxLqNBtmuuMWOzOUvWGms=;
        b=ByDR9S1OCahLAAM99pTvRDskenJ7sTNxyBTZTm5JxJElqqILDAcN4utlP22zDNRNkG
         A71A4fBww6lH3XhROom8Jy2xyJHf0N3rWKZp3CogiG0m5wD4GLywda94ng/LK0cYDtC9
         68QDMDwSlroltiwi58dtbbtV2fr6zpNmoMDLrQpN9q8tdq3sF1ph/okMtAOsf7nL663T
         jIpsMw3OjNwvMTLrOiiB2X5pIBNh6z05IEl6PSJVMfN1rf8ZVd24oHHNcBIvPvJ7Hlnt
         AYSTeQy16OHN4tIEYBRw6MXWVG715gHP68kW+MYIkF4iAp8F/kBxz8ciqpRcgF1TTpIM
         ImPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+E8A8DVtztpBmTMQJ+pHtBxLqNBtmuuMWOzOUvWGms=;
        b=bzWxSDobO78nz+fbLMeL2YRXv8jkbHE/jniK54upIJ5Gy2z3TMiIrjm7zz0iP5X25J
         5ZxZWU/mAswPk3CBjKlcXxF3U8FTSZFY6zNlL4YDzWEni6Ci9HJhOAWDrYj/Wb4zZnFN
         +d1oEXqtcgT5CWbpDPUCITLtAtHAfWzJmKCjNyVUJKsn8cjGSLpAeNnJBbK/k4JMHeyV
         pn/iiiOFMtUY3pgIRpKnMAkxw9zXbWF/2Rkoem7ROhW0yVXd+pNuab8ocUHSwKH74GF2
         b7Ksu1xlXe83yZLYE1LC2HJbfO4J41Jd8/pLvjkt2KTeLhAMklPV9VIuQVjY5HMJnt0T
         TRpg==
X-Gm-Message-State: AOAM531VrfWdj4V+d1g48hBCaf80qNhPkyNl4yfvasDaYq9DdvTstkfR
        9QhPAJ6miHxOzgDDCFcMwtKSI3l8ms90tgr40EUbBWEqn/U=
X-Google-Smtp-Source: ABdhPJxHSRySy9oxEryOb7vNWptEsi6sqTU8dN6/OWWVliGrmajlxNiJ7M/JjFI0M1kC7+oFISCMd+o6KKLJBPVGHi0=
X-Received: by 2002:a6b:6001:: with SMTP id r1mr11373468iog.144.1604348289975;
 Mon, 02 Nov 2020 12:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20201023211604.159074-1-ztong0001@gmail.com> <1966437.kWHqOGhHGQ@alarsen.net>
In-Reply-To: <1966437.kWHqOGhHGQ@alarsen.net>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 2 Nov 2020 15:17:59 -0500
Message-ID: <CAA5qM4AnWZ_bayGk3SbNYqWZb=JBVGo432AbJyrOYfQazxCZ7g@mail.gmail.com>
Subject: Re: [PATCH] qnx4: do not interpret -EIO as a correct address
To:     Anders Larsen <al@alarsen.net>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Anders!
I'm sending out another patch fixing other callers as suggested.
- Tong

On Mon, Nov 2, 2020 at 4:12 AM Anders Larsen <al@alarsen.net> wrote:
>
> On Friday, 2020-10-23 23:16 Tong Zhang wrote:
> > qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
> > not interpret -EIO as a correct address
> >
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >  fs/qnx4/inode.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> > index e8da1cde87b9..d3a40c5b1a9a 100644
> > --- a/fs/qnx4/inode.c
> > +++ b/fs/qnx4/inode.c
> > @@ -59,6 +59,8 @@ static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_h
> >       QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%ld] iblock=[%ld]\n",inode->i_ino,iblock));
> >
> >       phys = qnx4_block_map( inode, iblock );
> > +     if (phys == -EIO)
> > +             return -EIO;
> >       if ( phys ) {
> >               // logical block is before EOF
> >               map_bh(bh, inode->i_sb, phys);
>
> The fix looks sane to me, but how about the two other callers of
> qnx4_block_map(), are they not affected as well?
>
> Cheers
> Anders
>
>

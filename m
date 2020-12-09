Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271742D4520
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgLIPJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728593AbgLIPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607526496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlCuNhyg8UPyeR0OIa80s3EAeM8QXW2ZJz4Mla5QY7w=;
        b=Egy2/a/miyxiBP9WyqBqZnoBoEOX/tfDLHSVTR9OZxB76WITYZyEVyusQfMAaTTxBpIH/1
        8Ny+jHzWrOj/VLcoVFUknz6UBC0tweJysqWYqwIOUxNKZfkZTap7JJ/+TJuP/g7HQC3orm
        Ab0I2MhLaJFvzyLIV60szfrRsc4idBA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-dD6E3rbxOaeySWpqrxWpHw-1; Wed, 09 Dec 2020 10:08:15 -0500
X-MC-Unique: dD6E3rbxOaeySWpqrxWpHw-1
Received: by mail-oo1-f70.google.com with SMTP id p32so906006ooi.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 07:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlCuNhyg8UPyeR0OIa80s3EAeM8QXW2ZJz4Mla5QY7w=;
        b=REfTIFLZbIGLV3z+KOOfvZo28egjNl7bwskQu+dUbagADX9BmgwrfcrteWmiJ/wock
         l0r20GNceq5GslPt/kgWds110lXu7fIVspNriuJ3YFzuJFs8KP20u+0sgRzFC2tW9lni
         8p8B9huotC3ewgZ1EuvOKh2gZ5x5WAX6LUKMHO4fNy1YKka/ZsUJ5a1iLv8ZATi7242x
         SghUn+s1Ob8UkQraMAvBqrqi+DUuvX9YjxF+kIodnmRwuOR3l2aCwNUUSuYhgsq8Z22s
         UqskfQ02PrIYODX5yK92vLiC11tXMw+jPb4qxaJyhdqaWkyD7XBsvRSBhkzbCf0oE1ha
         VGdA==
X-Gm-Message-State: AOAM530673unZT3Aatq2D/bVAWE8AsO60xjJ+cl6ltmy48FdXW69BM66
        96UjpYWplroNhmRxGxzuF2couPpggdtubCKvmgbsWudmYl2gWgXtKFoacL6aHxbn6AijMNsl6KU
        uJe90qRtiAIxo1Ha20WDDV96Rrh2axexAPrTUjbRt
X-Received: by 2002:a9d:6642:: with SMTP id q2mr2099032otm.172.1607526494564;
        Wed, 09 Dec 2020 07:08:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxEf/UEjzXAFpYgMIza30IQJ6ydfWBGKkP+VB9KkIFoD89iMMwB8+euqGo84lFPEoO4zS3AadAdoDeKFmo26g=
X-Received: by 2002:a9d:6642:: with SMTP id q2mr2099001otm.172.1607526494280;
 Wed, 09 Dec 2020 07:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20201205234354.1710-1-jarod@redhat.com> <20201208113820.179ed5ca@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201208113820.179ed5ca@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 9 Dec 2020 10:08:05 -0500
Message-ID: <CAKfmpSe1o9_eFu70PPHT9MF5tMYjZqgajCfpDHCnsHQBUdcW0Q@mail.gmail.com>
Subject: Re: [PATCH net] bonding: reduce rtnl lock contention in mii monitor thread
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mahesh Bandewar <maheshb@google.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 2:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat,  5 Dec 2020 18:43:54 -0500 Jarod Wilson wrote:
> > I'm seeing a system get stuck unable to bring a downed interface back up
> > when it's got an updelay value set, behavior which ceased when logging
> > spew was removed from bond_miimon_inspect(). I'm monitoring logs on this
> > system over another network connection, and it seems that the act of
> > spewing logs at all there increases rtnl lock contention, because
> > instrumented code showed bond_mii_monitor() never able to succeed in it's
> > attempts to call rtnl_trylock() to actually commit link state changes,
> > leaving the downed link stuck in BOND_LINK_DOWN. The system in question
> > appears to be fine with the log spew being moved to
> > bond_commit_link_state(), which is called after the successful
> > rtnl_trylock().
>
> But it's not called under rtnl_lock AFAICT. So something else is also
> spewing messages?
>
> While bond_commit_link_state() _is_ called under the lock. So you're
> increasing the retry rate, by putting the slow operation under the
> lock, is that right?

Partially, yes. I probably should have tagged this with RFC instead of
PATCH, tbh. My theory was that the log spew, being sent out *other*
network interfaces when monitoring the system or remote syslog or ssh
was potentially causing some rtnl_lock() calls, so not spewing until
after actually being able to grab the lock would lessen the problem
w/actually acquiring the lock, but I ... don't know offhand how to
verify that theory.


> Also isn't bond_commit_link_state() called from many more places?
> So we're adding new prints, effectively?

Ah. Crap. Yes. bond_set_slave_link_state() is called quite a few
places, and that in turn calls bond_commit_link_state().


> > I'm actually wondering if perhaps we ultimately need/want
> > some bond-specific lock here to prevent racing with bond_close() instead
> > of using rtnl, but this shift of the output appears to work. I believe
> > this started happening when de77ecd4ef02 ("bonding: improve link-status
> > update in mii-monitoring") went in, but I'm not 100% on that.
> >
> > The addition of a case BOND_LINK_BACK in bond_miimon_inspect() is somewhat
> > separate from the fix for the actual hang, but it eliminates a constant
> > "invalid new link 3 on slave" message seen related to this issue, and it's
> > not actually an invalid state here, so we shouldn't be reporting it as an
> > error.
>
> Let's make it a separate patch, then.

Sounds like Jay is confident that bit is valid, and I shouldn't be
ending up in that state, unless something else is going wrong.

-- 
Jarod Wilson
jarod@redhat.com


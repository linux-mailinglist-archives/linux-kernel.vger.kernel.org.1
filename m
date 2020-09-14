Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1E26988D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgINWGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgINWGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:06:32 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25480C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:06:32 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di5so704950qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bvww47pszRQ19uPC5VMxxJpNqbHcfb7SBJv4kxWLrqo=;
        b=YbUSiTJ0MBEMgQ3jCQXEz3udq5jss7fKe4qvrR/7l6lGx+KjLbJqq3OzrUhPQdD0Go
         5CrqQwpJXFk7nuEQmsoSQEYLbCJYjqwdmFmM36n1j/OuDHA5EHwQ7wsUA9uSy9SDr5HE
         KjoGBN4JnM6eJxgmqMFS/t+V/fl9FchV9tOAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bvww47pszRQ19uPC5VMxxJpNqbHcfb7SBJv4kxWLrqo=;
        b=Mft2V4cX7k380E9ZDb6YR5WJ6H/Rk+DzLrpMyxWTrR/weWRhMthwwlyDZ1szEot6LV
         REbdcYxa0tvfiJOfRst5vbgyd7mHVy219oxZPQQKGTf/6T3FNjnliSalqD1YrWFfsDfh
         e6sJqK1WXmeLuqPCHtovfAOZ1DV/eHVhEc/zmpaNz1TCXcFv4etLxUh86fLe9RK88U5f
         XABuLl7TQNDfhFwcerWSzAEgNRKK7DmMLqs/Hqebda/R4gNJ/jzVe1OgdxDXEiMKE9Ys
         UtzthNv7y5W8O4dyJLBnL++QCVUvkG3vHnE8zMubxygYXqPrfK8pHQ/x8d+U9jZ9y7Dl
         SuHQ==
X-Gm-Message-State: AOAM532i0Stch/LBsdhYFGle1V7U/pzRQSa7tb42vG98P5ceut1H/LJC
        V7cY6sIYs1oSiPFxFf28KLts1qZgiqEJJ91oJZb1yg==
X-Google-Smtp-Source: ABdhPJwtUlC2gt7OThNBezusn+sBOm6lH6YsxewcXPFD+oGZRKF5JQOHKsKIL5Nz2A9Q4zTK3mJApI8w7RWiyqy1/jo=
X-Received: by 2002:ad4:4c0a:: with SMTP id bz10mr15322361qvb.14.1600121190939;
 Mon, 14 Sep 2020 15:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-2-git-send-email-moshe@mellanox.com> <CAACQVJochmfmUgKSvSTe4McFvG6=ffBbkfXsrOJjiCDwQVvaRw@mail.gmail.com>
 <20200914093234.GB2236@nanopsycho.orion> <CAACQVJqVV_YLfV002wxU2s1WJUa3_AvqwMMVr8KLAtTa0d9iOw@mail.gmail.com>
 <20200914112829.GC2236@nanopsycho.orion> <20200914143100.06a4641d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200914143100.06a4641d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 14 Sep 2020 15:06:19 -0700
Message-ID: <CACKFLinODtbqezEeYdiEwcgkTdCa66D3D5_Xx+OjT23qsLi4Og@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v4 01/15] devlink: Add reload action option
 to devlink reload command
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jiri Pirko <jiri@resnulli.us>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 2:31 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 14 Sep 2020 13:28:29 +0200 Jiri Pirko wrote:
> > >> Instead, why don't you block in reload_up() until the reset is complete?
> > >
> > >Though user initiate "devlink dev reload" event on a single interface,
> > >all driver entities undergo reset and all entities recover
> > >independently. I don't think we can block the reload_up() on the
> > >interface(that user initiated the command), until whole reset is
> > >complete.
> >
> > Why not? mlxsw reset takes up to like 10 seconds for example.
>
> +1, why?

Yes, we should be able to block until the reset sequence is complete.
I don't see any problem.  I will work with Vasundhara on this.

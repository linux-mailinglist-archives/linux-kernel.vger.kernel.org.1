Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6ED2F871C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbhAOVCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:02:39 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:17836 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388647AbhAOVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610744308;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=uB/tpfMBdiRL3si0IpHoGQcyStjWnMUZmLDyQ3lyu3U=;
        b=mJikrieCu/bAMJmAWhKnSnOPz89vFTkHNwMJSoyMUgYBVv1P51qTGocjxR6pf0p8Xv
        09JsTOwgCkqywtICVmSbNAPt6Gcs7svqJWh0Mvo7jDEPxKBUbpUhkBtFk06fOdzLzlvC
        1aKRSB9J1TJ0QyAoAD+hPfvmRdSsPacWn4+5UkhFrqMPePXqCRLOFJjTGkJgpuMBKcoW
        Yi1vSxYNuLTRns1Nw2zwlZHDNG22OOcCotarmn5Xd/M2b0Zew+4GUCWO+S5qu5bydNvW
        sPLhc6kFeFV58sBRGliKn6xxLOdC9bEZNpEQOVOpI2HBHhn3Trk/v11OtJNjCZX4vbaR
        uisA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j9Ic/Cboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id R0a218x0FKwSsMX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 15 Jan 2021 21:58:28 +0100 (CET)
Date:   Fri, 15 Jan 2021 21:58:21 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
Message-ID: <YAIB7QYibwwRZ039@gerhold.net>
References: <2073294.4OfjquceTg@kreacher>
 <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
 <YAFmoinbKocE9Jf5@gerhold.net>
 <CAJZ5v0hgmrN_zWBrX7FsfP=7mZHf_BYm+Qe+E3Ti4k0mK7t2MA@mail.gmail.com>
 <CAGETcx_A9YLmiMeizsrJEcdTMSZpJU03twAdRSdGeco83Z5uCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_A9YLmiMeizsrJEcdTMSZpJU03twAdRSdGeco83Z5uCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 09:20:54AM -0800, Saravana Kannan wrote:
> On Fri, Jan 15, 2021 at 5:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Jan 15, 2021 at 11:03 AM Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Thu, Jan 14, 2021 at 11:31:12AM -0800, Saravana Kannan wrote:
> > > > On Thu, Jan 14, 2021 at 10:41 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > When adding a new device link, device_is_dependent() is used to
> > > > > check whether or not the prospective supplier device does not
> > > > > depend on the prospective consumer one to avoid adding loops
> > > > > to the graph of device dependencies.
> > > > >
> > > > > However, device_is_dependent() does not take the ancestors of
> > > > > the target device into account, so it may not detect an existing
> > > > > reverse dependency if, for example, the parent of the target
> > > > > device depends on the device passed as its first argument.
> > > > >
> > > > > For this reason, extend device_is_dependent() to also check if
> > > > > the device passed as its first argument is an ancestor of the
> > > > > target one and return 1 if that is the case.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > > > > ---
> > > > >  drivers/base/core.c |   12 +++++++++++-
> > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > >
> > > > > Index: linux-pm/drivers/base/core.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/base/core.c
> > > > > +++ linux-pm/drivers/base/core.c
> > > > > @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
> > > > >  #endif
> > > > >  #endif /* !CONFIG_SRCU */
> > > > >
> > > > > +static bool device_is_ancestor(struct device *dev, struct device *target)
> > > > > +{
> > > > > +       while (target->parent) {
> > > > > +               target = target->parent;
> > > > > +               if (dev == target)
> > > > > +                       return true;
> > > > > +       }
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * device_is_dependent - Check if one device depends on another one
> > > > >   * @dev: Device to check dependencies for.
> > > > > @@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
> > > > >         struct device_link *link;
> > > > >         int ret;
> > > > >
> > > > > -       if (dev == target)
> > > > > +       if (dev == target || device_is_ancestor(dev, target))
> > > > >                 return 1;
> > > > >
> > > > >         ret = device_for_each_child(dev, target, device_is_dependent);
> > > > >
> > > >
> > > > The code works, but it's not at all obvious what it's doing. Because,
> > > > at first glance, it's easy to mistakenly think that it's trying to
> > > > catch this case:
> > > > dev <- child1 <- child2 <- target
> > > >
> > >
> > > Isn't this pretty much the case we are trying to catch? I have:
> > >
> > >   78d9000.usb <- ci_hdrc.0 <- ci_hdrc.0.ulpi <- phy-ci_hdrc.0.ulpi.0
> > >
> > > then something attempts to create a device link with
> > > consumer = 78d9000.usb, supplier = phy-ci_hdrc.0.ulpi.0, and to check if
> > > that is allowed we call device_is_dependent() with dev = 78d9000.usb,
> > > target = phy-ci_hdrc.0.ulpi.0.
> > >
> > > Note that this case would normally be covered by the device_for_each_child().
> > > It's not in this case because the klist_children of 78d9000.usb
> > > is updated too late.
> >
> > Exactly.
> 
> Stephan,
> 
> What device/driver is this? Is this a dwc3 device/driver? That driver
> does some weird/incorrect stuff the last time I checked.
> 

I described my situation in this mail thread:
https://lore.kernel.org/lkml/X%2FycQpu7NIGI969v@gerhold.net/

It's USB, but chipidea on apq8016-sbc in this case. The situation is
definitely kind of weird, but not sure if it is wrong per-se.

Thanks,
Stephan

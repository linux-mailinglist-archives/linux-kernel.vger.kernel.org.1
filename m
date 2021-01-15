Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0D2F7622
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbhAOJ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:59:46 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:29326 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbhAOJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610704548;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=pQJUbSnglx6jrVEG/uzEMF/4a7MagxWfC490ZSlRcXE=;
        b=LwuonCwlR5oQhAfMTVYCA+JEmLvVXaqVXdgdKFVLwYPh64ilEne0HgAhbl/S7QuBfx
        ajFniRu/GLR+r+okpTTJoRNMDO5zGcGm2RH2V814PVJtEztXS2Im5Z2e+V3RKA7GpqTe
        FydKth6WxVV7H9fK3sn+G+GovvmumSnor+UDKoIp7ziG0W7EMddYeiLc40lG0lCADgHy
        Aqk8JwBkPSbkuZq16s1kdwO9RwM6wzVuJTdFl/YnMWigMwB1cOcJp0RiIuo4I/V0X5Fc
        fCQ7ZvwQd/wce3c97NW+QRmwL5AW64ANEA+y1n7AevmjzMQMny5ZYQVgLFJYSMwHrKfs
        Iqbg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j4IcrHBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id R0a218x0F9tmpP8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 15 Jan 2021 10:55:48 +0100 (CET)
Date:   Fri, 15 Jan 2021 10:55:46 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
Message-ID: <YAFmoinbKocE9Jf5@gerhold.net>
References: <2073294.4OfjquceTg@kreacher>
 <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 14, 2021 at 11:31:12AM -0800, Saravana Kannan wrote:
> On Thu, Jan 14, 2021 at 10:41 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When adding a new device link, device_is_dependent() is used to
> > check whether or not the prospective supplier device does not
> > depend on the prospective consumer one to avoid adding loops
> > to the graph of device dependencies.
> >
> > However, device_is_dependent() does not take the ancestors of
> > the target device into account, so it may not detect an existing
> > reverse dependency if, for example, the parent of the target
> > device depends on the device passed as its first argument.
> >
> > For this reason, extend device_is_dependent() to also check if
> > the device passed as its first argument is an ancestor of the
> > target one and return 1 if that is the case.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  drivers/base/core.c |   12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/base/core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/core.c
> > +++ linux-pm/drivers/base/core.c
> > @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
> >  #endif
> >  #endif /* !CONFIG_SRCU */
> >
> > +static bool device_is_ancestor(struct device *dev, struct device *target)
> > +{
> > +       while (target->parent) {
> > +               target = target->parent;
> > +               if (dev == target)
> > +                       return true;
> > +       }
> > +       return false;
> > +}
> > +
> >  /**
> >   * device_is_dependent - Check if one device depends on another one
> >   * @dev: Device to check dependencies for.
> > @@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
> >         struct device_link *link;
> >         int ret;
> >
> > -       if (dev == target)
> > +       if (dev == target || device_is_ancestor(dev, target))
> >                 return 1;
> >
> >         ret = device_for_each_child(dev, target, device_is_dependent);
> >
> 

Thanks for the patch, Rafael! I tested it and it seems to avoid the
circular device link (and therefore also the crash). FWIW:

Tested-by: Stephan Gerhold <stephan@gerhold.net>

> The code works, but it's not at all obvious what it's doing. Because,
> at first glance, it's easy to mistakenly think that it's trying to
> catch this case:
> dev <- child1 <- child2 <- target
> 

Isn't this pretty much the case we are trying to catch? I have:

  78d9000.usb <- ci_hdrc.0 <- ci_hdrc.0.ulpi <- phy-ci_hdrc.0.ulpi.0

then something attempts to create a device link with
consumer = 78d9000.usb, supplier = phy-ci_hdrc.0.ulpi.0, and to check if
that is allowed we call device_is_dependent() with dev = 78d9000.usb,
target = phy-ci_hdrc.0.ulpi.0.

Note that this case would normally be covered by the device_for_each_child().
It's not in this case because the klist_children of 78d9000.usb
is updated too late.

> Maybe it's clearer if we do this check inside the loop? Something like:
> 
>                 if (link->consumer == target ||
> device_is_ancestor(link->consumer, target))
>                         return 1;
> 

I tried to test this with the diff below (let me know if I got it wrong).
It does not seem to make any difference though, the circular device link
is still created and without the reorder commit reverted it crashes.

Thanks!
Stephan

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14f165816742..7af4ef5f89e7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
 #endif
 #endif /* !CONFIG_SRCU */
 
+static bool device_is_ancestor(struct device *dev, struct device *target)
+{
+	while (target->parent) {
+		target = target->parent;
+		if (dev == target)
+			return true;
+	}
+	return false;
+}
+
 /**
  * device_is_dependent - Check if one device depends on another one
  * @dev: Device to check dependencies for.
@@ -232,7 +242,7 @@ int device_is_dependent(struct device *dev, void *target)
 		if (link->flags == (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
 			continue;
 
-		if (link->consumer == target)
+		if (link->consumer == target || device_is_ancestor(link->consumer, target))
 			return 1;
 
 		ret = device_is_dependent(link->consumer, target);


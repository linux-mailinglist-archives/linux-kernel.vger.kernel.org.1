Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6A2BBBCD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgKUCBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgKUCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:01:14 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD07C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:01:13 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id g15so10345088ybq.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJxZ6w6/zaA+DRTyYeAyLLTmSLsD8m+KVMVBliZmrDI=;
        b=ehTkqaGNM8Hrf8tS8vWKP2N8U2ALQooRcd2pt7kat6HeSs39ILQ9wkBFn17L1rjIQP
         b9FchazIIvOB5MKggiFsjB6XWE6qDZKZyu8nYaY0Deaq/bGL9zixlz1PLA42WfDEShcH
         D9lbaUbXb0ufmxNl0k8qkYaKA9+oXVmRTn5F8AbS4+NUJn2f/49VTOlBWRVO7By/x9Oo
         GkHw5l7h/Pd6ztTPgAfQ6bPwQUbaBqBXiytO0qpcu4pTgq8lHwgjzdEOF3Jqr+YI5cs+
         x946uWbFMYaCsG6z+KESnY6NdUbtI9qZu24vvItI2Ni3iqs9lTSeRBH9dAm0fW32/Qjb
         QmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJxZ6w6/zaA+DRTyYeAyLLTmSLsD8m+KVMVBliZmrDI=;
        b=ilm9NJVOch/84CFApz/eUgAK94rwSGvpWXIJDGWErYrrfedabAM+yz1rb3R2kY3Jyz
         LTH2dRNIT3UypgRoN4IddVy8RyP7C+fXIZUvYeuqtf7YgQtZcDV4OV6EgxwCAdfw26F8
         4a9pliybRODnhqospTbOryBsH27Oa6o9KKv+XavsScfIubMEhUqM/SCdjDo+HgpecbAy
         JecVSHGF7VH9jAJO+y73o+c+H054qaxzq/bQxmTiXuJM0UtVot3oTGwM2eE+eiSOG+jj
         xO9wPKtw0MgPky0DEJvUxGAznkcYh+gkMEwOvol/lzlDiusS7Sc+cqPYL9ndE6wqfAJR
         1YEA==
X-Gm-Message-State: AOAM531b2Nvmu9Ch+KKw2bu9VNAX9djo3w71qpKsC0fZIyy5c2XCJwam
        i0LF+KFjoknhnhQagR5J9ng6tEywZ7ISjKFEnus25w==
X-Google-Smtp-Source: ABdhPJwfG2sGNnRS52EgcRLh4J/iiR6UL1aDWSNTYXBPHduW02ZJE+LxxwNTXdGAZ5bfoMFWlEWF+kOf5URorWjBbaY=
X-Received: by 2002:a25:268e:: with SMTP id m136mr25207052ybm.346.1605924072908;
 Fri, 20 Nov 2020 18:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-14-saravanak@google.com> <CAJZ5v0hVRd2pYfGwpa4FLwhtrS2pj9Ng2a2gf61BO5F-94PPXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hVRd2pYfGwpa4FLwhtrS2pj9Ng2a2gf61BO5F-94PPXQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 20 Nov 2020 18:00:37 -0800
Message-ID: <CAGETcx-nHiYLJLW+oUBgH8dm5eoQkEjhQUQu5OKZi9=ym5LvHQ@mail.gmail.com>
Subject: Re: [PATCH v1 13/18] driver core: Add fwnode_get_next_parent_dev()
 helper function
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 8:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Given a fwnode, this function finds the closest ancestor fwnode that has
> > a corresponding struct device. The function returns this struct device.
> > This function will be used in a subsequent patch in this series.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> I would combine this one with patch [10/18].

Ack.

-Saravana




-Saravana

>
> > ---
> >  drivers/base/core.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index ee28d8c7ee85..4ae5f2885ac5 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1562,6 +1562,31 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
> >                 fw_devlink_parse_fwtree(child);
> >  }
> >
> > +/**
> > + * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
> > + * @fwnode: firmware node
> > + *
> > + * Given a firmware node (@fwnode), this function finds its closest ancestor
> > + * firmware node that has a corresponding struct device and returns that struct
> > + * device.
> > + *
> > + * The caller of this function is expected to call put_device() on the returned
> > + * device when they are done.
> > + */
> > +static struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
> > +{
> > +       struct device *dev = NULL;
> > +
> > +       fwnode_handle_get(fwnode);
> > +       do {
> > +               fwnode = fwnode_get_next_parent(fwnode);
> > +               if (fwnode)
> > +                       dev = get_dev_from_fwnode(fwnode);
> > +       } while (fwnode && !dev);
> > +       fwnode_handle_put(fwnode);
> > +       return dev;
> > +}
> > +
> >  static void fw_devlink_link_device(struct device *dev)
> >  {
> >         int fw_ret;
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >

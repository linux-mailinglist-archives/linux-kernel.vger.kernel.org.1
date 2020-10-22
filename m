Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7F2958DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505541AbgJVHOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440190AbgJVHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:14:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:14:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t9so379590qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8ZahsRhcRMRC8XNykubNJNQMd1r9sbRVvueXpG14ZA=;
        b=mCnNiqDQHX7ZB8b20CugtiH9eozW/lhQLrFYQKBXOegOZXwqohRzY4+EY+2jl845WU
         kFNpzt9Mjfbxyi+1HXaecZZ3/ECF6tkIKNkLUYzdzWjCUpin9VeGMjn+CyDUQEtKbg/R
         +oAXWMOCcjGl0LR+XIqVCiW6S0QPbHCHy6cHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8ZahsRhcRMRC8XNykubNJNQMd1r9sbRVvueXpG14ZA=;
        b=GVnbUoE0+sO8CMo95GDJBH8oSYB0L7AoSR1n88jchS9jFZIejNUKH5vXWRfGf+ZGgl
         KDyqVWWr+gubdOa0yDeHfz0WCL1BAyLd+I+0qL0VXake58XoUmXOd+3bpo9KeaujI5Xu
         0LJmB9Oh7RSQjm5Kk9A9CUK7JBc2wP2xtRPZpuUjQ5g5OA2HP9PPh8fnT87aIdRlTvS+
         QrPyisyeIBuROTkgyqj0BUdHJEFxmSFsZn1vVg78xJn5Zv/JhjdwdL0MqDBGvW4h3azq
         35DK1g6jzSoP4VeZ2SaufzbpmS0Pr03980/3yqx2xP7BtWQa0cMnyqGiX8cKs71yycYQ
         YFXw==
X-Gm-Message-State: AOAM532tC9jUI/8oV4k4WDnhVLMtXjl1uCpee0gRMwbe9lA71CeiKScr
        cOADPZpp7Cp6V2zLEU1xJy1t3FZELTkMQyjxNR6qaDG84b8=
X-Google-Smtp-Source: ABdhPJybaSXbBQnwXFgQ1XB+8AohFTU/JC7kYuUUEEfsqvaJDnGIMOCZSnEypXTX0cyyrnJYXk8+iVcBpBKv3cLvgRg=
X-Received: by 2002:aed:3ae5:: with SMTP id o92mr719123qte.265.1603350845643;
 Thu, 22 Oct 2020 00:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201022061554.3418060-1-pmalani@chromium.org> <20201022065719.GA1440360@kroah.com>
In-Reply-To: <20201022065719.GA1440360@kroah.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 22 Oct 2020 00:13:54 -0700
Message-ID: <CACeCKacvhtSfQ=hGYHi3AdrTT+XY2RpKmPHuYWoxNVmRWMeBBA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: Expose Product Type VDOs via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the patch, Greg.

On Wed, Oct 21, 2020 at 11:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 21, 2020 at 11:15:54PM -0700, Prashant Malani wrote:
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > index b834671522d6..16440a236b66 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -170,6 +170,14 @@ Description:
> >               will show 0 until Discover Identity command result becomes
> >               available. The value can be polled.
> >
> > +What:                /sys/class/typec/<port>-partner/identity/product_type_vdo
> > +Date:                October 2020
> > +Contact:     Prashant Malani <pmalani@chromium.org>
> > +Description:
> > +             Product Type VDOs part of Discover Identity command result. 3 values
> > +             are displayed (for the 3 possible Product Type VDOs), one per line.
>
> sysfs is "one value per file", not "one value per line".  This is not
> ok.

I see. Would listing these out as three separate vdos (i.e vdo0, vdo1,
vdo2) be better?
>
> > +             The values will show 0s until Discover Identity command result becomes
> > +             available. The values can be polled.
>
> It can be polled?  Did you try that?  I don't see the logic for that in
> your patch.

To be honest, no. I followed the pattern used by the other identity
VDOs (cert_stat, id_header and product),
and re-used their description assuming it to be accurate.

>
>
> >
> >  USB Type-C cable devices (eg. /sys/class/typec/port0-cable/)
> >
> > @@ -230,6 +238,15 @@ Description:
> >               will show 0 until Discover Identity command result becomes
> >               available. The value can be polled.
> >
> > +What:                /sys/class/typec/<port>-cable/identity/product_type_vdo
> > +Date:                October 2020
> > +Contact:     Prashant Malani <pmalani@chromium.org>
> > +Description:
> > +             Product Type VDOs part of Discover Identity command result. 3 values
> > +             are displayed (for the 3 possible Product Type VDOs), one per line.
> > +             The values will show 0s until Discover Identity command result becomes
> > +             available. The values can be polled.
>
> Why are you describing the same value in two different locations?

Both cable and partner can have Discover Identity VDOs and they are
listed separately in sysfs.
The other VDOs (id_header, cert_stat and product) have separate
descriptions for cable and partner too.
Perhaps there is a case for consolidating the listings here (factor
out the ones which are common to cable and partner).

>
> > +
> >
> >  USB Type-C port alternate mode devices.
> >
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 35eec707cb51..37fa4501e75f 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -122,10 +122,20 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(product);
> >
> > +static ssize_t product_type_vdo_show(struct device *dev, struct device_attribute *attr,
> > +                                  char *buf)
> > +{
> > +     struct usb_pd_identity *id = get_pd_identity(dev);
> > +
> > +     return sprintf(buf, "0x%08x\n0x%08x\n0x%08x\n", id->vdo[0], id->vdo[1], id->vdo[2]);
>
> Note, for future sysfs stuff, always use sysfs_emit().
>
> But again, this is not allowed as you have multiple values per a single
> file.

Noted. I will keep that in mind for future versions.

Best regards,

>
> thanks,
>
> greg k-h

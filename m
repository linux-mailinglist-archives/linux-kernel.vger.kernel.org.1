Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAD2B0ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgKLQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgKLQvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:51:08 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEBDC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:51:07 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q5so5842171qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UULMa69Cha07mkg9eirozXg6Mg78pzprVXlk+8aQkM=;
        b=dvsccChuE3wiK+OshV+vABrj1Afl8QjdNGNFHbbhR0lhgYGNWoyn+TWB7YZk8uz7FU
         O73DLJ8W3AxrdrwcsDP7Dm6FqAFVf8866PbeLRGKHJWH4qz89ARYKYycgixmy470el8S
         Do2zFVA8D6pYCRjGmI5KaihgM07SQvPBq8JCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UULMa69Cha07mkg9eirozXg6Mg78pzprVXlk+8aQkM=;
        b=l+GQZ4Od2oRatoTviEHP/kIjZiUwa9CT4vXDPO1QDbp+rvHB4pTB7+drZOSoYtW+su
         9z46C4u6Ah6CxPJvnnViWf+Lu9HRojCqcyCaiPQ3j1D6p3KXQuHdzsUUlp/XPrZmHQN2
         CJHXVeDJxNKvHqB4lhwzf3t1s0avHy3hD7BKoT3zJ9IrtvhZIXzuLVDb0yvb7onqIfQ0
         ShElZe5eyTOYfqKEKp9OawugQ0D/c5ormSRqZv8mlhQ1mTaSohnTLAJTqIBJKyhsSexB
         0UFUDUcPlC8henejz8CMzKH7ld91yAEJ3UFMPiB8yELHkFJdOakd4/P0btv+JWfWANaf
         b07A==
X-Gm-Message-State: AOAM531t6SOSRyXHDtNGZLaJ+pEo43vXUzucxdMaA58ZCT+8MEuELf5c
        Qc+Egkukc5CKSBpM3mU7n7L82zQYuY7pgomwiHXDmQ==
X-Google-Smtp-Source: ABdhPJyvp5RU9RgCm4JgruJfjcPXdy15Gz74XVwau7R0EMqFVublUMeQ1Bk/QxIwCTcx579bQL4sxseB/LKFp6qKZ8M=
X-Received: by 2002:a05:620a:248c:: with SMTP id i12mr621929qkn.179.1605199866960;
 Thu, 12 Nov 2020 08:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org> <20201110115453.GI1224435@kuha.fi.intel.com>
 <20201112024055.GA1367855@google.com> <20201112124345.GS1224435@kuha.fi.intel.com>
In-Reply-To: <20201112124345.GS1224435@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 12 Nov 2020 08:50:55 -0800
Message-ID: <CACeCKafKODtbhCinwD=uwDa==atQoJFyXGwMhJEczh2NWq4NMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Thu, Nov 12, 2020 at 4:43 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Nov 11, 2020 at 06:40:55PM -0800, Prashant Malani wrote:
> > Hi Heikki,
> >
> > On Tue, Nov 10, 2020 at 01:54:53PM +0200, Heikki Krogerus wrote:
> > > On Fri, Oct 23, 2020 at 02:43:28PM -0700, Prashant Malani wrote:
> > >
> > > I've now come to the conclusion that this is not the correct approach.
> > > Instead, the whole identity, all six VDOs, should be supplied
> > > separately with a "raw" sysfs attribute file after all.
> > >
> > > The three attribute files that we already have - so id_header,
> > > cert_stat and product - can always supply the actual VDO as is,
> > > regardless of the product type, so they are fine. But these new
> > > attribute files, product_type_vdoX, would behave differently as they
> > > supply different information depending on the product type. That just
> > > does not feel right to me.
> >
> > OOI: I'd like to understand the reservations around this approach. Can't
> > userspace just read these and then interpret them appropriately according
> > to the id_header as well as PD revision (and version number) if that's exposed?
> > The only thing I see changing is how we name those product_type_vdoX
> > sysfs files, i.e product_type_vdo0 == passive_cable_vdo OR active_cable_vdo1
> > depending on the product type.
> >
> > That said, perhaps I'm missing some aspect of this.
>
> I don't think the userspace should have to interpret any of these
> VDOs. If the userspace has to interpret the information, then the
> userspace should interpret everything for the sake of consistency (so
> the "raw" attribute file).
>
> But I still think that defining separate device types for every
> product type would be the best way to handle the identity. We could
> then have sysfs attribute files that are specific for each product
> type. It does not even matter that some of the product types are going
> to be removed. We will have to handle all of them in any case,
> including the ones that were removed. This way things would be much
> more clear for the userspace.
>
> The only problem IMO with the separate device types for each product
> type is that we don't always have access to the Discover Identity
> result. It means depending on your system we will claim the
> partner device type is "default" (no identity information) or the
> actual product type. That is also a bit inconsistent, but is is
> acceptable? I would really like to here what Greg thinks about all
> this.

Thanks for explaining the rationale.
Of course, I defer to Greg & your decision on this :)

I'm yet unable to grasp what benefit userspace gets from having the kernel parse
and present this data in appropriately named sysfs files when the userspace has
enough info to do so itself.

For that reason and also because the "raw" approach is IMO a bit more
resilient to the changes
we talk about (some product type VDOs being dropped off across PD spec
uprevs [1] etc)
the "raw" proposal sounded appealing to me.

>
> > > So lets just add the "raw" sysfs attribute file. We can think about
> > > extracting some other details from the product type VDOs once the
> > > specification has settled down a bit and we can be quite certain that
> > > those details will always be available.
> > >
> > > Would this be OK to you? I think we should be able to dump the data to
> > > the "raw" sysfs attribute file with something like hex_dump_to_buffer().
> >
> > FWIW, "raw" option SGTM (the product type VDOs can be parsed from the
> > buffer since the format is fixed).
>
> Well, I'm starting to think that what if we just prepare patches where
> we propose separate device type for every product type? Of course, if
> they are OK to you?
>
SG. To clarify, will you prepare these patches?

Thanks & best regards,

-Prashant

[1]: https://lore.kernel.org/linux-usb/CANLzEkskrWXWLC+csObYwB+JUFdH+p6V6giMHtsKY-L61cTG9g@mail.gmail.com/

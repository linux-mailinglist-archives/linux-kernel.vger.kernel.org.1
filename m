Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304532FE6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbhAUJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbhAUJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:49:44 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37ECC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:49:03 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id h22so1060758qkk.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iZLr0v9O1rvkfQeB3DSvxH8ICzhuSdV/jEGC9+YKQw=;
        b=mHYXvQBPTIQQRnvBYOHQ8UysiGpCK3V2AL+RKOOWTpKQjRLEbQHlSsf1J5cs2Y2ODF
         tws5bxJndsIEw0B24vJ/eLTAbjnC3iXwyJkVc9Msd5L3EOrIZD2IsaJXqMwEWjiAeX0C
         l2cIox8sbbEaDi3+mb957WSbAqp/gcgJb4AaPMuo5SJhbZg1bvPWgPBQYD9mBKBy+Jux
         jDlpxKutpCev0x3PwfJ5/Gk+gL3RMnhQYVoz3YBusJb7HcZ5u7uYAzIBVuTIsFWlCwh4
         JFYtoCKhPAUZlXXnfKuzaxwrVhOaBOmf2ewjKjKWT5/YL0urXjNEJ0PX7a+IGe0apbqh
         Yjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iZLr0v9O1rvkfQeB3DSvxH8ICzhuSdV/jEGC9+YKQw=;
        b=EBNETXS0Vk0k5RvPRwnUtjlUtHv7R+Ca4kUbSmngT6yanZSJHF1SYv2fzCPgg4lsb9
         r8JKPeZ5fP4Lke7+dH5YiT5a1y8wF0h/3pCbOuJPhL0Bn55uSWzMoHIM3KCZSEu446xD
         VaTs6I+173xt3gxIMHoAm3oufjyA84cqEQNmWiKfypPQzTN5xu2WORMjQbygQly5kLJ2
         vf//v6wyeO7pF3CE7jDtWMzj7/IIAVRXo0H3vsMYeMOpJ/hs3fgZkp5dK8xh5d2Egqe9
         /DXZ8Cy8fHhLEtEK3naTzaG/Wcp+tFauRmAbjpv2GufRgU+Jqq4aL0R17s6tXi+gWXaQ
         gmJQ==
X-Gm-Message-State: AOAM532MqKcLYMqGQwXjoS/a3BtcWSuDGHDRrTQZsG8E2u/QIkDJHmd4
        twgFQqLb2ouE4IDuokMZT2EZHAJWhpAAM70bNbBOOw==
X-Google-Smtp-Source: ABdhPJwd2SrNVlF/ZOu9B9uCESbyB3db9/E7Qgq+yX9OO+x6vAl/7OB4qWRCvpv+8XIXeShg9GVyR16HG4SFMHUb4Ho=
X-Received: by 2002:a37:2f82:: with SMTP id v124mr13247230qkh.212.1611222542722;
 Thu, 21 Jan 2021 01:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20210115163311.391332-1-kyletso@google.com> <20210121084101.GC423216@kuha.fi.intel.com>
In-Reply-To: <20210121084101.GC423216@kuha.fi.intel.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Thu, 21 Jan 2021 17:48:46 +0800
Message-ID: <CAGZ6i=0M6=cZpfm=Eu4s4XTjwz5GPbpStNNOdjnPAkJ1y2MRRA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Create legacy PDOs for PD2 connection
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 4:41 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Kyle,
>
> On Sat, Jan 16, 2021 at 12:33:11AM +0800, Kyle Tso wrote:
> > If the port partner is PD2, the PDOs of the local port should follow the
> > format defined in PD2 Spec. Dynamically modify the pre-defined PD3 PDOs
> > and transform them into PD2 format before sending them to the PD2 port
> > partner.
>
> I guess it's not possible for the system to supply separate static
> PDOs for each PD revision?
>
We can do that for sure. But a problem is that if there are more PD
revisions in the future, we will need to add more PDO arrays.
For backward compatibility, the new revision usually uses the
previously-reserved bits for the new features.
From my perspective, the better way to achieve the backward
compatibility is to just clear the bits if those are reserved in the
previous revision.

I can submit another patch which adds another PDO array for PD2 if you
think it is more appropriate.

> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 62 +++++++++++++++++++++++++++++------
> >  include/linux/usb/pd.h        |  1 +
> >  2 files changed, 53 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 22a85b396f69..1220ab1ed47d 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -911,13 +911,47 @@ static int tcpm_set_pwr_role(struct tcpm_port *port, enum typec_role role)
> >       return 0;
> >  }
> >
> > +/*
> > + * Transform the PDO to be compliant to PD rev2.0.
> > + * Return 0 if the PDO type is not defined in PD rev2.0.
> > + * Otherwise, return the converted PDO.
> > + */
> > +static u32 tcpm_forge_legacy_pdo(struct tcpm_port *port, u32 pdo, enum typec_role role)
> > +{
> > +     switch (pdo_type(pdo)) {
> > +     case PDO_TYPE_FIXED:
> > +             if (role == TYPEC_SINK)
> > +                     return pdo & ~PDO_FIXED_FRS_CURR_MASK;
> > +             else
> > +                     return pdo & ~PDO_FIXED_UNCHUNK_EXT;
> > +     case PDO_TYPE_VAR:
> > +     case PDO_TYPE_BATT:
> > +             return pdo;
> > +     case PDO_TYPE_APDO:
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> >  static int tcpm_pd_send_source_caps(struct tcpm_port *port)
> >  {
> >       struct pd_message msg;
> > -     int i;
> > +     u32 pdo;
> > +     unsigned int i, nr_pdo = 0;
>
> Side note. I think this driver uses the "reverse christmas tree"
> style with the variables.

I will change the order (if there is a next version)

thanks,
Kyle

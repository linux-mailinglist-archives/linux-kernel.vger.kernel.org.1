Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636A72D2106
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLHCmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgLHCmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:42:15 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69625C061794;
        Mon,  7 Dec 2020 18:41:35 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id p12so7621010qvj.13;
        Mon, 07 Dec 2020 18:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XjVgTEL8rQFOCFz+jo+PbV3JFHakTiNHErSrpfLt1A=;
        b=R78Hyn5Hm0zClT4oLPvwmmGHJ/NZnYOq6YvJ3dok83R6lub3MTs9UuYFq7rJKd39OT
         Th4OFMSuZKTpC0cqaqwmpfV2DS7shAM4jCyZWVRxKpGLd1fV13sLnIe5xLw9Id19UCZt
         nQ0hD2CxSht8NDoK/cVvJ+4NFojkfU6qVWK8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XjVgTEL8rQFOCFz+jo+PbV3JFHakTiNHErSrpfLt1A=;
        b=Hx/rWQMj8zA4OZ/08bUaxcLSeFBDe+WES7vQeDMvVXgGh698oqx+JZuKnmSOCVoRyH
         ibqEtCzPkBL2T7FKzIROTbgd/ttHIIEO5sh22FyHoPKMpUdA4nt0wjbdg0u3Hek92pjj
         0HCGxpnghr1TiEN88a+DlxG9CawleQ7UeQ5JPE9aX3RNkCCmiUWL3kPSUavrFv6EeI1u
         esk/413Zg8l4LRKI676QG3ZstJaC5AGeeHssyhJ904S1fUfE/PTQH9Pea0IarOw/Qbb1
         Okv9DDnhv9/yzblKoS+4mG9Tj5dsH4A7kM61uuFwnnknWl6hOuY1n20tuJrJtmEr0siq
         Kfjw==
X-Gm-Message-State: AOAM530bXklNzm4/i075mlncOuIbTkRrLH5lnPzWQupphOQAf550OZoW
        p+d76IaZZCwB+5VRf/ZebT1bsmSQv8QoFP2+6FE=
X-Google-Smtp-Source: ABdhPJxLCLgZLW9LLx4nvn+gh95HaohAb8GesxEGpkQOEjwV4hpPMVrOR5UZf+E5QY+yePtIaXRVmkkT9IVqdA05/aA=
X-Received: by 2002:a05:6214:c66:: with SMTP id t6mr19789047qvj.43.1607395294632;
 Mon, 07 Dec 2020 18:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20201120010315.190737-1-joel@jms.id.au> <20201121185150.GD114144@roeck-us.net>
In-Reply-To: <20201121185150.GD114144@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Dec 2020 02:41:22 +0000
Message-ID: <CACPK8Xcf1xhPZNqpxuZE22uqDFR7rb1Wv-RW802bx2S-nphpzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] occ: Add support for P10
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Nov 2020 at 18:55, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Nov 20, 2020 at 11:33:12AM +1030, Joel Stanley wrote:
> > Hi Guenter, here's v2 of this series on behalf of Eddie. I made the
> > change to the compatible string that we spoke about in v2, and I'm happy
> > for these to go through the hwmon tree.
> >
>
> I'll be happy to do that, as soon as we get a Reviewed-by: tag for the DT
> change.

Rob has sent that through now, so this should be good to go in.

Thank you.

>
> Thanks,
> Guenter
>
> > v1: https://lore.kernel.org/linux-hwmon/20200501150833.5251-1-eajames@linux.ibm.com/
> >
> > The OCC in the P10 has a number of differences from the P9. Add some logic to
> > handle the differences in accessing the OCC from the service processor, and
> > support the new temperature sensor type.
> >
> > Eddie James (3):
> >   dt-bindings: fsi: Add P10 OCC device documentation
> >   fsi: occ: Add support for P10
> >   hwmon: (occ) Add new temperature sensor type
> >
> >  .../devicetree/bindings/fsi/ibm,p9-occ.txt    |  12 +-
> >  drivers/fsi/fsi-occ.c                         | 125 +++++++++++++-----
> >  drivers/hwmon/occ/common.c                    |  75 +++++++++++
> >  3 files changed, 172 insertions(+), 40 deletions(-)
> >
> > --
> > 2.29.2
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA1283F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgJETVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgJETVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:21:03 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F202100A;
        Mon,  5 Oct 2020 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601925662;
        bh=UYjbQGmutI9n0tukloJzoV/memCV8ajMt9gG7xWBFJw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PcbFOoOgnLv/WTYXMQT9v4dCvLuQaxx3CGqIeujKA85Ow12m3ci6va0c2mfroZ7QX
         jvCQtA29awLsrdw9TBBtusd00x7eUG2LV6uxU5CLEBWoLLO6CjTAsui/uBH10qZLO9
         eHagMI206YrnqlQg8fHyHcze6hlMPtyzsuGvw1Rw=
Received: by mail-oi1-f174.google.com with SMTP id t77so6357530oie.4;
        Mon, 05 Oct 2020 12:21:02 -0700 (PDT)
X-Gm-Message-State: AOAM533WtaVnSu6wwGK1H9cwHHbn34+I+2bgsvvOW2E2IoIIa3emSJbk
        ehdyS9B5cuMV1TbuQ44epUuz6U3EOVNatfqBuA==
X-Google-Smtp-Source: ABdhPJzyT9s7KCi30/O2p06f6/Edp/garab0Pb8tcZFi3As0cTPafZ217G6nXdjbEIWZTNmQ4TaCRScv744oOrifqVE=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr540803oia.147.1601925661970;
 Mon, 05 Oct 2020 12:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200929220912.GF1621304@google.com> <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com> <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu> <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
 <20201003124142.GA318272@rowland.harvard.edu> <20201005160655.GA4135817@google.com>
In-Reply-To: <20201005160655.GA4135817@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 5 Oct 2020 14:20:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKbUcCxvdSov=ZPzkBM9ZZ-TRDBSpCudjkb5OREiWR3fw@mail.gmail.com>
Message-ID: <CAL_JsqKbUcCxvdSov=ZPzkBM9ZZ-TRDBSpCudjkb5OREiWR3fw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 11:06 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Sat, Oct 03, 2020 at 08:41:42AM -0400, Alan Stern wrote:
> > On Fri, Oct 02, 2020 at 05:58:22PM -0500, Rob Herring wrote:
> > > On Fri, Oct 2, 2020 at 1:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > Regardless of how the situation is represented in DT, there remains the
> > > > issue of where (i.e., in which driver module) the appropriate code
> > > > belongs.  This goes far beyond USB.  In general, what happens when one
> > > > sort of device normally isn't hooked up through a power regulator, so
> > > > its driver doesn't have any code to enable a regulator, but then some
> > > > system does exactly that?
> > > >
> > > > Even worse, what if the device is on a discoverable bus, so the driver
> > > > doesn't get invoked at all until the device is discovered, but on the
> > > > new system it can't be discovered until the regulator is enabled?
> > >
> > > Yep, it's the same issue here with USB, MDIO which just came up a few
> > > weeks ago, MMC/SD which hacked around it with 'mmc-pwrseq' binding
> > > (not something I want to duplicate) and every other discoverable bus.
> > > What do they all have in common? The kernel's driver model being
> > > unable to cope with this situation. We really need a common solution
> > > here and not bus or device specific hack-arounds.
> >
> > To me this doesn't seem quite so much to be a weakness of the kernel's
> > driver model.
> >
> > It's a platform-specific property, one that is not discoverable and
> > therefore needs to be represented somehow in DT or ACPI or something
> > similar.  Something that says "Device A cannot operate or be discovered
> > until power regulator B is enabled", for example.
> >
> > The decision to enable the power regulator at system startup would be
> > kernel policy, not a part of the DT description.  But there ought to be
> > a standard way of recognizing which resource requirements of this sort
> > should be handled at startup.  Then there could be a special module (in
> > the driver model core? -- that doesn't really seem appropriate) which
> > would search through the whole DT database for resources of this kind
> > and enable them.
>
> This might work for some cases that only have a single resource or multiple
> resources but no timing/sequencing requirements. For the more complex cases
> it would probably end up in something similar to the pwrseq series
> (https://lore.kernel.org/patchwork/project/lkml/list/?series=314989&state=%2A&archive=both),
> which was nack-ed by Rafael, Rob also expressed he didn't want to go
> down that road.

TBC, I'm against repeating a 'pwrseq binding' like MMC has which is a
separate node. That's how the referenced binding started out IIRC, but
I was fine with what's in v16. I'm not against common/generic code for
handling pwrseq for 'simple' cases, but we need to allow for complex
cases and not try to keep extending some generic binding to handle
every last quirk.

Rob

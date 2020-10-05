Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6E4283FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgJET7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgJET7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:59:17 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92FED2100A;
        Mon,  5 Oct 2020 19:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601927956;
        bh=lZLALtjavDkXurE9Is+8RTaRVsXxwohHJkUhoRrYMA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NyeL888xOvfoVXZGiW1dPmrcZ9gswWQQqe+nc6Ex5K0Ie0kJXh7C32oTCfqyX1jLj
         gDVpFxS5geiuCdw89ui6zzL1ud1xBE2Etcw44DYvPOonUEY/wUGW18XykhmcUlcGvI
         QzHbNQMA+kHhTw1nen3JBk7XDTQLuSvDkQ80xYi4=
Received: by mail-oi1-f169.google.com with SMTP id c13so9977640oiy.6;
        Mon, 05 Oct 2020 12:59:16 -0700 (PDT)
X-Gm-Message-State: AOAM532P4DLmnUmg0MTCoe53dMKqrbVomTtC0ucHHynrD9ppiMS46hgx
        pZ1YaU9GqiE9PS3ABME9fhhg/nf0WlgLigsZYw==
X-Google-Smtp-Source: ABdhPJxEl1lGVEtl2PfV0oWDWrsUbMTd7JVujQTh7El1xeMA1UkxI2WFTrP8Sa5CQ5G7EJnljCPTP1NbDiDj5mNWn9g=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr653207oiy.106.1601927955868;
 Mon, 05 Oct 2020 12:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu> <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
 <20201003124142.GA318272@rowland.harvard.edu> <20201005160655.GA4135817@google.com>
 <20201005161527.GI376584@rowland.harvard.edu> <20201005191812.GB4135817@google.com>
 <20201005193611.GA389867@rowland.harvard.edu>
In-Reply-To: <20201005193611.GA389867@rowland.harvard.edu>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 5 Oct 2020 14:59:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK8V9PUCUD1iZQr52b28G39JraY=doZWzk0gNvu15qW-g@mail.gmail.com>
Message-ID: <CAL_JsqK8V9PUCUD1iZQr52b28G39JraY=doZWzk0gNvu15qW-g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
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

On Mon, Oct 5, 2020 at 2:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Oct 05, 2020 at 12:18:12PM -0700, Matthias Kaehlcke wrote:
> > On Mon, Oct 05, 2020 at 12:15:27PM -0400, Alan Stern wrote:
> > > The conclusion is that we need to have code that is aware of some
> > > detailed needs of a specific device but is not part of the device's
> > > driver.  I'm not sure what the best way to implement this would be.
> >
> > Wouldn't it be possible to load the module when the DT specifies that
> > the device exists? For USB the kernel would need the VID/PID to identify
> > the module, these could be extracted from the compatible string.
>
> Loading a driver module whenever DT says a device exists?  Not a bad
> idea.  I don't know what would be involved, but no doubt it is possible.

MODULE_DEVICE_TABLE mostly as I mentioned in my other reply.

> Note that, except for a few special cases, the kernel identifies the
> appropriate driver for USB hubs not by the VID/PID but instead by the
> device class or interface class.  I suppose the compatible string could
> include that information too?

We can go back to 1998 OpenFirmware and it's already there[1].
'usb,class9' for a hub. There's a few other variations defined.

> > Having the initialization code outside of the driver could lead to code
> > duplication, since the driver might want to power the device down in
> > certain situations (e.g. system suspend).
>
> True.  On the other hand, how common do you think it would be for
> drivers not to want to mess with the power settings?

I think in that case you'd generally want firmware to enable things
and the kernel then does no power control.

We have ~1500 boards using DT and maybe ~10 with USB devices described
in DT. So the whole thing is not common to begin with.

Rob

[1] https://www.devicetree.org/open-firmware/bindings/usb/usb-1_0.ps

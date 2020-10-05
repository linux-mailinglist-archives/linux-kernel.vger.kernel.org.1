Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45554283FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgJETg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbgJETg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:36:59 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D2F208C3;
        Mon,  5 Oct 2020 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601926618;
        bh=vreY1y62/ItgoHOJ39jEJGGc3di0cHUuXUf77P7UR1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S+9CifhFTwQLlw+6zIJ9ah8Z/6N/m341dhtALdQOvNKiRh0NqMZRe2a+eFAq9ykxm
         oKaoMYWUT21eE5jdZgPAtIWeCuiKlSv9mopIwmVEyO6a9okjX9CrZm3OipQP9x0TZ4
         xWhltWEP/Ta37jIywC0h0YXDh8dNUciQEGbabPGw=
Received: by mail-oi1-f179.google.com with SMTP id l85so9897630oih.10;
        Mon, 05 Oct 2020 12:36:58 -0700 (PDT)
X-Gm-Message-State: AOAM531YWB3blrqy0JH6Cx/Bur8en8lD2pPZ2AIGzH9JViyUm4HMc+qK
        53yqImM1SetbSNy6sGn3AUdeIND/wU7BQyUCOw==
X-Google-Smtp-Source: ABdhPJz240L0hq+6F8XKH9jRgQJVciEISdxexf5/3GhR8YRDq3mAALJWx+vwopo1kJq2T637u6DxmRyHxDXEwJqE/UA=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr598009oiy.106.1601926617529;
 Mon, 05 Oct 2020 12:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200930124915.GA1826870@google.com> <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu> <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
 <20201003124142.GA318272@rowland.harvard.edu> <20201005160655.GA4135817@google.com>
 <20201005161527.GI376584@rowland.harvard.edu> <20201005191812.GB4135817@google.com>
In-Reply-To: <20201005191812.GB4135817@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 5 Oct 2020 14:36:45 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+-kcDoFjp7a9ESa78Ar-ObLapXfuzn-WFNT-8rro_bJQ@mail.gmail.com>
Message-ID: <CAL_Jsq+-kcDoFjp7a9ESa78Ar-ObLapXfuzn-WFNT-8rro_bJQ@mail.gmail.com>
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

On Mon, Oct 5, 2020 at 2:18 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Mon, Oct 05, 2020 at 12:15:27PM -0400, Alan Stern wrote:
> > On Mon, Oct 05, 2020 at 09:06:55AM -0700, Matthias Kaehlcke wrote:
> > > On Sat, Oct 03, 2020 at 08:41:42AM -0400, Alan Stern wrote:
> > > > The decision to enable the power regulator at system startup would be
> > > > kernel policy, not a part of the DT description.  But there ought to be
> > > > a standard way of recognizing which resource requirements of this sort
> > > > should be handled at startup.  Then there could be a special module (in
> > > > the driver model core? -- that doesn't really seem appropriate) which
> > > > would search through the whole DT database for resources of this kind
> > > > and enable them.
> > >
> > > This might work for some cases that only have a single resource or multiple
> > > resources but no timing/sequencing requirements. For the more complex cases
> > > it would probably end up in something similar to the pwrseq series
> > > (https://lore.kernel.org/patchwork/project/lkml/list/?series=314989&state=%2A&archive=both),
> > > which was nack-ed by Rafael, Rob also expressed he didn't want to go
> > > down that road.
> > >
> > > It seems to me that initialization of the resources needs to be done by
> > > the/a driver for the device, which knows about the sequencing requirements.
> > > Potentially this could be done in a pre-probe function that you brought up
> > > earlier.
> >
> > One of the important points of my suggestion was that the resource init
> > should be done _outside_ of the device's driver, precisely because the
> > driver module might not even be loaded until the resources are set up
> > and the device is discovered.
> >
> > The conclusion is that we need to have code that is aware of some
> > detailed needs of a specific device but is not part of the device's
> > driver.  I'm not sure what the best way to implement this would be.
>
> Wouldn't it be possible to load the module when the DT specifies that
> the device exists? For USB the kernel would need the VID/PID to identify
> the module, these could be extracted from the compatible string.

You don't even have to do that. Just add the MODULE_DEVICE_TABLE with
the compatible strings and module loading will just work once you walk
the USB bus in DT. Though probably you'd still need the VID/PID to
create the device.

Rob

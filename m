Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F427DDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgI3Bcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:32:31 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57367 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726689AbgI3Bca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:32:30 -0400
Received: (qmail 194760 invoked by uid 1000); 29 Sep 2020 21:32:29 -0400
Date:   Tue, 29 Sep 2020 21:32:29 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20200930013229.GB194665@rowland.harvard.edu>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus>
 <20200929220912.GF1621304@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929220912.GF1621304@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 03:09:12PM -0700, Matthias Kaehlcke wrote:
> Hi Rob,
> 
> On Tue, Sep 29, 2020 at 03:17:01PM -0500, Rob Herring wrote:
> > As I said in prior version, this separate node and 'hub' phandle is not 
> > going to work. You are doing this because you want a platform driver for 
> > "realtek,rts5411". That may be convenient for Linux, but doesn't reflect 
> > the h/w.
> 
> I agree that the hardware representation isn't totally straightforward, however
> the description isn't limited to Linux:
> 
> - there is a single IC (like the Realtek RTS5411)
> - the IC may require several resources to be initialized in a certain way
>   - this may require executing hardware specific code by some driver, which
>     isn't a USB device driver
> - the IC can 'contain' multiple USB hub devices, which can be connected to
>   separate USB busses
> - the IC doesn't have a control bus, which somewhat resembles the
>   'simple-audio-amplifier' driver, which also registers a platform device
>   to initialize its resources
> 
> - to provide the functionality of powering down the hub conditionally during
>   system suspend the driver (whether it's a platform driver or something else)
>   needs know which USB (hub) devices correspond to it. This is a real world
>   problem, on hardware that might see wide distribution.
> 
> There were several attempts to solve this problem in the past, but none of them
> was accepted. So far Alan Stern seems to think the driver (not necessarily the
> binding as is) is a suitable solution, Greg KH also spent time reviewing it,
> without raising conceptual concerns. So it seems we have solution that would
> be generally landable from the USB side.
> 
> I understand that your goal is to keep the device tree sane, which I'm sure
> can be challenging. If you really can't be convinced that the binding might
> be acceptable in its current or similiar form then please offer guidance
> on possible alternatives which allow to achieve the same functionality.

You're really trying to represent this special IC in DT, right?  Maybe 
if you don't call it a "hub" but instead something that better reflects 
what it actually is and does, the description will be more palatable.

Alan Stern

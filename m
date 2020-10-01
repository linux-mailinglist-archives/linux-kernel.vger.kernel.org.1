Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4B28097E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgJAVkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgJAVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:40:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3AC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 14:40:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so78616pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ip4I9Zi92cmMy48EZDjEqPXg+PzOqP4wFP+0NOc0leE=;
        b=WTnFo6h7qTDLtJzYjwKVAtNU/occKNeoida7yMLlmzoxLe2fzaVVWqANDfs1zj7PTO
         l60FsvpvT6bTSvVsvd55fbacf4g+a/Rwpi1mLXQW40gO6w1Vl5ySDrXRBQC5+mAbKquH
         2SKHIZocesnNABZLexOctr5c/hPDP6/0m1Fj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ip4I9Zi92cmMy48EZDjEqPXg+PzOqP4wFP+0NOc0leE=;
        b=ugKzLETg52BM7GgACHxjNJmwEacjjGWG1EPrf3q/QsB3pl5wzVabNu1jFTi0bFfyvm
         yr8rBtoCEpNGmBfKivwAb7m0bXTjbXRWm/0cvrL/qPCUXF3bBnuegNPi+a/n2zwiIDZX
         F4WL3w8aWLUGv4T+S8E2aIujR1PNOtMAh9f9QP+KPQbs7HQkz7hQRi6Jr2r/9T6Iftnh
         yTbJUBbhV4UDDfUFq5nuZpgGA5EyDa4CfLX1BzZ7IDknonDTqIKz77P4Cnj+ERUat06C
         f1GAi93+Qa7oY140/3HBiBdtig0+AoBDnlY0KcDBFII6s3LN1v5hRES7NkRw0eb6/DfD
         T0KA==
X-Gm-Message-State: AOAM533Te1DyJMVd1K92rMY+eRLBJdu77ctyVk3E+krBBxzI3uCU9lME
        j/r04M4wwKFBe2RcwJw8qpgu/g==
X-Google-Smtp-Source: ABdhPJwsFXq6zSWxUWlEvb8LGWzKnUYFfTMmDFpm+t6KJ1yD7cy92p01ZXNxTyikGyl26sHg5FwE/Q==
X-Received: by 2002:a17:90b:891:: with SMTP id bj17mr1876241pjb.11.1601588399703;
        Thu, 01 Oct 2020 14:39:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id k7sm788262pjs.9.2020.10.01.14.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:39:58 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:39:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20201001213957.GA2362632@google.com>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus>
 <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAD=FV=WhowcppEhmd=QG7YFk5iSVaCKsfGJkGBQJTwMs=bwekA@mail.gmail.com>
 <CAL_Jsq+mzUV53U1h6YixT=d+Q6oouNNNeFGHvpauMh054x-3Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+mzUV53U1h6YixT=d+Q6oouNNNeFGHvpauMh054x-3Jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 02:19:32PM -0500, Rob Herring wrote:
> On Wed, Sep 30, 2020 at 1:00 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > > On Wed, Sep 30, 2020 at 7:44 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > We already have hubs in DT. See [1][2][3][4]. What's new here?
> >
> > After I sent my response I kept thinking about this and I realized
> > that I have prior art I can point out too!  :-)  Check out
> > "smsc,usb3503a".  That is describing a USB hub too and, at least on
> > "exynos5250-spring.dts" is is a top level node.  Since "smsc,usb3503a"
> > can be optionally connected to an i2c bus too, it could be listed
> > under an i2c controller as well (I believe it wasn't hooked up to i2c
> > on spring).
> >
> > Interestingly enough, the USB Hub that Matthias is trying to add
> > support for can _also_ be hooked up to i2c.  We don't actually have
> > i2c hooked up on our board, but conceivably it could be.  Presumably,
> > if i2c was hooked up, we would have no other choice but to represent
> > this chip as several device tree nodes: at least one under the i2c
> > controller and one (or two) under the USB controller.  Just because
> > (on this board) i2c isn't hooked up doesn't change the fact that there
> > is some extra control logic that could be represented in its own
> > device tree node.  To me, this seems to give extra evidence that the
> > correct way to model this device in device tree is with several nodes.
> >
> > I'll point out that on "exynos5250-spring.dts" we didn't have to solve
> > the problem that Matthias is trying to solve here because we never
> > actually supported waking up from USB devices there.  Thus the
> > regulator for the hub on spring can be unconditionally powered off in
> > suspend.  On newer boards we'd like to support waking up from USB
> > devices but also to save power if no wakeup devices are plugged into
> > USB.  In order to achieve this we need some type of link from the
> > top-level hub device to the actual USB devices that were enumerated.
> 
> Yes, in a prior version I mentioned we already had 2 ways to describe
> hubs. I view this as a 3rd way.

The description of the onboard hub driver is essentially the same as
that for the 'smsc,usb3503a'. Ths driver doesn't require the USB device
nodes, but they could as well exist, they are only omitted most of the
time because USB does discovery, some DT files include these implicit
nodes though.

It would be possible to rewrite the onboard_usb_hub driver in a way that
it wouldn't require phandles of the 'usb_hub' (or whatever) node, and
instead provide the 'usb_hub' with phandles of the USB devices. The
hub would be specified exactly once:

{
	usb_hub: usb-hub {
		compatible = "realtek,rts5411", "onboard-usb-hub";
		usbdevs = <&usb_1_udev1>, <&usb_1_udev2>;
		vdd-supply = <&pp3300_hub>;
        };

	&usb_1_dwc3 {
		usb_1_udev1: usb@1 {
        		reg = <1>;
		};

		usb_1_udev2: usb@2 {
			reg = <2>;
	        };
	};
}

The only difference with the 'smsc,usb3503a' would be that the nodes of
the (existing!) USB devices would be specified (without any custom
properties).

I'm not convinced that 'pre-probes' can solve the entire problem on the
driver side and keep thinking that there needs to be a single non-USB
instance that controls the power state, particularly for the
suspend/resume case. I will provide some more details in another reply
to this thread.

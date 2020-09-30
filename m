Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3BF27E8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgI3MtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgI3MtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:49:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB824C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:49:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so1112568pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hi0H92Bq2J25J0s0e+A1at2PAKtZ7XP1o/TSnDx73G4=;
        b=m7yGzf02GWGB8fsRcfy7TJmA52mscCE9I5Fnon+Y8DyuRviSmLR7H3VOHu9S19kJ/m
         Gjnl/S1bkYmnbchn+2a9F97f/mlCm7DENsseOJUfN9RTS1GRLPh/02w1sF3zPxqIxMJ6
         Zi4/zKf5JL4U9IGNbHWQY0rkagzsZnvjnPfI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hi0H92Bq2J25J0s0e+A1at2PAKtZ7XP1o/TSnDx73G4=;
        b=obsXGS6FEq43y/wavoiDQ8dbJ2YVEyH+WGoeRtqAaOykzP2hJhggkC4kQPfZFpb8v/
         P4EwATVNZV2n0sPtOKfTUsQWwf/t+ruT7hbTRk9vnlqSer6yCkggrWTLN6o3EawONzcL
         XD5X5kLaMJInwBK3iZW3Dq+K+0GjmGuD3Ui8G83kGTcKUUH9CYf6NJ/NlpDrRw/UX1fb
         MvKEt+AwGYClR0WDWhzDLQUwsL4xi+UKKRK1WYHGNkZF8/V+7uYxS/dZA8tPq3GiWDXC
         oBxg53krO8EpQ7qUBruQJcnngyxHkGRqwTzwq3N+Q3TOvuZiPCjUQCYyAj/iajPI6opO
         b6zA==
X-Gm-Message-State: AOAM533LntLN3IAs2Zwgb1iJX/9ILrhA9rJ0cwTGl24UP66Y54PiU4VD
        R7T/9aoqVAJ1+S19CPcLFE6s6g==
X-Google-Smtp-Source: ABdhPJymormMJMSPNAs6rJNZj5EscLA8KEholgWxwRSoNZQq+bnaxxpvS/LRfGgLiRMuyAWMJtuiog==
X-Received: by 2002:a63:1958:: with SMTP id 24mr1271947pgz.326.1601470157196;
        Wed, 30 Sep 2020 05:49:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id a1sm2471540pfr.12.2020.09.30.05.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 05:49:16 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:49:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20200930124915.GA1826870@google.com>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus>
 <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930013229.GB194665@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Sep 29, 2020 at 09:32:29PM -0400, Alan Stern wrote:
> On Tue, Sep 29, 2020 at 03:09:12PM -0700, Matthias Kaehlcke wrote:
> > Hi Rob,
> > 
> > On Tue, Sep 29, 2020 at 03:17:01PM -0500, Rob Herring wrote:
> > > As I said in prior version, this separate node and 'hub' phandle is not 
> > > going to work. You are doing this because you want a platform driver for 
> > > "realtek,rts5411". That may be convenient for Linux, but doesn't reflect 
> > > the h/w.
> > 
> > I agree that the hardware representation isn't totally straightforward, however
> > the description isn't limited to Linux:
> > 
> > - there is a single IC (like the Realtek RTS5411)
> > - the IC may require several resources to be initialized in a certain way
> >   - this may require executing hardware specific code by some driver, which
> >     isn't a USB device driver
> > - the IC can 'contain' multiple USB hub devices, which can be connected to
> >   separate USB busses
> > - the IC doesn't have a control bus, which somewhat resembles the
> >   'simple-audio-amplifier' driver, which also registers a platform device
> >   to initialize its resources
> > 
> > - to provide the functionality of powering down the hub conditionally during
> >   system suspend the driver (whether it's a platform driver or something else)
> >   needs know which USB (hub) devices correspond to it. This is a real world
> >   problem, on hardware that might see wide distribution.
> > 
> > There were several attempts to solve this problem in the past, but none of them
> > was accepted. So far Alan Stern seems to think the driver (not necessarily the
> > binding as is) is a suitable solution, Greg KH also spent time reviewing it,
> > without raising conceptual concerns. So it seems we have solution that would
> > be generally landable from the USB side.
> > 
> > I understand that your goal is to keep the device tree sane, which I'm sure
> > can be challenging. If you really can't be convinced that the binding might
> > be acceptable in its current or similiar form then please offer guidance
> > on possible alternatives which allow to achieve the same functionality.
> 
> You're really trying to represent this special IC in DT, right?

Yes

> Maybe  if you don't call it a "hub" but instead something that better reflects
> what it actually is and does, the description will be more palatable.

Thanks for your suggestion.

Datasheets from different manufacturers refer to these ICs as "USB hub
controller". Calling the node "usb-hub-controller" would indeed help to
distinguish it from the USB hub devices and represent existing hardware.
And the USB device could have a "hub-controller" property, which also
would be clearer than the current "hub" property.

Rob, would this help to convince you?

Thanks

Matthias

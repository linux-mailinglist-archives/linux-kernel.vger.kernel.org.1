Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4482737D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgIVBIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:08:14 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47571 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728854AbgIVBIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:08:13 -0400
Received: (qmail 1238377 invoked by uid 1000); 21 Sep 2020 21:08:12 -0400
Date:   Mon, 21 Sep 2020 21:08:12 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200922010812.GA1238082@rowland.harvard.edu>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200917195416.GA1099735@rowland.harvard.edu>
 <20200922004158.GC21107@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922004158.GC21107@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:41:58PM -0700, Matthias Kaehlcke wrote:
> > > +	put_device(hub->dev);
> > 
> > Is there a matching get_device somewhere (like in _find_onboard_hub)?
> > If so, I didn't see it.  And I don't see any reason for it.
> 
> Yes, implicitly, of_find_device_by_node() "takes a reference to the
> embedded struct device which needs to be dropped after use."

Okay.  In that case it probably would be better to do the put_device()
right away, at the end of _find_onboard_hub().

There would be no danger of the platform device getting freed too soon 
if you make onboard_hub_remove unbind the associated USB hub devices.  
But there would still be a danger of those devices somehow getting 
rebound again at the wrong time; this suggests that you should add a 
flag to the onboard_hub structure saying that the platform device is 
about to go away.

Alan Stern

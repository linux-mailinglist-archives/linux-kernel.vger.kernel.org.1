Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC552BBED6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgKUMKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgKUMKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:10:45 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDC122226;
        Sat, 21 Nov 2020 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605960644;
        bh=pLtOpTjqaSBqVkIMo4IbPawnLHJWlqUmIWLK+EBv8j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1hE4JGMV5qPuxoVu/sr0h3uY/XgZLXfFiYzLUZA1qnrKSCOyTbqG9WQZvL+HZhZZ2
         FBi7xXNgkfAkYfU4KeImXv8l9ntga8LO+XJUsGCJlmvIe92gg3r0R+Vqn0ms5PJnR+
         IX+yYyEShjoKB4AsQhRsG8j3MjoXpfNOXcmd+evg=
Date:   Sat, 21 Nov 2020 17:40:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        NeilBrown <neil@brown.name>
Subject: Re: [PATCH v5 0/4] MT7621 PCIe PHY
Message-ID: <20201121121039.GA8403@vkoul-mobl>
References: <20201119154337.9195-1-sergio.paracuellos@gmail.com>
 <CAMhs-H8bUuSQ+ROr4PNJXYaGFnjG2=zpjGK7UAAfoPMPbFBb1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H8bUuSQ+ROr4PNJXYaGFnjG2=zpjGK7UAAfoPMPbFBb1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-20, 17:20, Sergio Paracuellos wrote:
> Hi Vinod,
> 
> On Thu, Nov 19, 2020 at 4:43 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > This series adds support for the PCIe PHY found in the Mediatek
> > MT7621 SoC.
> >
> > There is also a 'mt7621-pci' driver which is the controller part
> > which is still in staging and is a client of this phy.
> >
> > Both drivers have been tested together in a gnubee1 board.
> >
> > This series are rebased on the top of linux-next:
> > commit 4e78c578cb98 ("Add linux-next specific files for 20201030")
> >
> > Changes in v5:
> >   - PATCH 1/4: Recollect Rob's Reviewed-by of bindings.
> >   - PATCH 4/4: Recollect Greg's Acked-by for removing stuff from
> >     staging area.
> >   - Make Vinod's review comments changes in [0]:
> >     * Use FIELD_GET and FIELD_PREP apis and avoid multiple *_VAL and
> >       *_SHIFT custom definitions.
> >     * Remove phy-read and phy-write internal functions and directly
> >       call regmap_read and regmap_write in 'mt7621_phy_rmw'.
> >     * Change some traces from info to debug log level.
> >     * Note that I have maintained 'mt7621_phy_rmw' instead of use
> >       'regmap_update_bits'. This is because in order to get a reliable
> >       boot registers must be written event the contained value in
> >       that register is the same. I have preferred doing in this way
> >       instead of using 'regmap_update_bits_base' passing 'false' for
> >       async and 'true' for the force write. If this way of using
> >       'regmap_update_bits_base' is preferred just let me know.
> 
> I notice we already have 'regmap_write_bits' function. I will use this
> and avoid mt7621_phy_rmw
> and send v6 of this series.
> 
> Also, do you have any preference of where you want this series to be rebased on?

Phy-next please

-- 
~Vinod

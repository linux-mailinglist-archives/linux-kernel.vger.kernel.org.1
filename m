Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5944F2AC227
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbgKIRZq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 12:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbgKIRZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:25:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3882C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:25:45 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kcAvF-0007PG-FW; Mon, 09 Nov 2020 18:25:41 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kcAvE-0008DX-H5; Mon, 09 Nov 2020 18:25:40 +0100
Message-ID: <2ee2fb9170e127d583e19062a791f3b1767d44fc.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] reset: brcmstb rescal: implement {de}assert()
 instead of reset()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 09 Nov 2020 18:25:40 +0100
In-Reply-To: <CA+-6iNzMAbvhODSX_Kn_DWe_T=9F3xzu5khdh-zdGNPyPs6FdA@mail.gmail.com>
References: <20201106191743.40457-1-james.quinlan@broadcom.com>
         <20201106191743.40457-2-james.quinlan@broadcom.com>
         <64aa1f860bf60ddac7a2015c87896c8a7b13b161.camel@pengutronix.de>
         <CA+-6iNzMAbvhODSX_Kn_DWe_T=9F3xzu5khdh-zdGNPyPs6FdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 11:21 -0500, Jim Quinlan wrote:
> On Mon, Nov 9, 2020 at 5:05 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Hi Jim,
> > 
> > On Fri, 2020-11-06 at 14:17 -0500, Jim Quinlan wrote:
> > > Before, only control_reset() was implemented.  However, the reset core only
> > > invokes control_reset() once in its lifetime.  Because we need it to invoke
> > > control_reset() again after resume out of S2 or S3, we have switched to
> > > putting the reset functionality into the control_deassert() method and
> > > having an empty control_assert() method.
> > > 
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > 
> > You are switching to the wrong abstraction to work around a deficiency
> > of the reset controller framework. Instead, it would be better to allow
> > to "reactivate" shared pulsed resets so they can be triggered again.
> 
> True.
> > 
> > Could you please have a look at [1], which tries to implement this with
> > a new API call, and check if this can fix your problem? If so, it would
> > be great if you could coordinate with Amjad to see this fixed in the
> > core.
> > 
> > [1] https://lore.kernel.org/lkml/20201001132758.12280-1-aouledameur@baylibre.com/
> 
> Yes, this would work for our usage.  Amjad please let me know if I can
> help here.  The only "nit" I have is that I favor the name 'unreset'
> over 'resettable' but truly I don't care one way or the other.

Both unreset and resettable are adjectives, maybe it would be better to
have an imperative verb like the other API functions. I would have liked
reset_control_trigger/rearm as a pair, but I can't find anything I like
that fits with the somewhat unfortunate reset_control_reset name in my
mind.
In that sense, I don't have a preference one way or the other either.

regards
Philipp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24D22B4B57
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbgKPQgT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Nov 2020 11:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbgKPQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:36:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF98C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:36:18 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kehUG-0005k5-BS; Mon, 16 Nov 2020 17:36:16 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kehUF-00028h-EU; Mon, 16 Nov 2020 17:36:15 +0100
Message-ID: <48332a44241f3c06966420277060b6048c1f77d0.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: make shared pulsed reset controls
 re-triggerable
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Date:   Mon, 16 Nov 2020 17:36:15 +0100
In-Reply-To: <1jima91e92.fsf@starbuckisacylon.baylibre.com>
References: <20201112230043.28987-1-aouledameur@baylibre.com>
         <0f679c62aa48603ea43a8fa4819d688baa802d73.camel@pengutronix.de>
         <1jima91e92.fsf@starbuckisacylon.baylibre.com>
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

On Fri, 2020-11-13 at 16:13 +0100, Jerome Brunet wrote:
> On Fri 13 Nov 2020 at 16:04, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> 
> > On Fri, 2020-11-13 at 00:00 +0100, Amjad Ouled-Ameur wrote:
> > > The current reset framework API does not allow to release what is done by
> > > reset_control_reset(), IOW decrement triggered_count. Add the new
> > > reset_control_rearm() call to do so.
> > > 
> > > When reset_control_reset() has been called once, the counter
> > > triggered_count, in the reset framework, is incremented i.e the resource
> > > under the reset is in-use and the reset should not be done again.
> > > reset_control_rearm() would be the way to state that the resource is
> > > no longer used and, that from the caller's perspective, the reset can be
> > > fired again if necessary.
> > > 
> > > Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> > > Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> > > ---
> > > Change since v1: [0]
> > > * Renamed the new call from reset_control_(array_)resettable to 
> > > reset_control_(array_)rearm
> > > * Open-coded reset_control_array_rearm to check for errors before
> > > decrementing triggered_count because we cannot roll back in case an
> > > error occurs while decrementing one of the rstc.
> > > * Reworded the new call's description.
> > 
> > Thank you, applied to reset/next.
> 
> Hi Philipp,
> 
> Would it be possible to get an immutable branch/tag with this ?
> It would allow to move forward on the USB side, without waiting for the
> next rc1.

Here you go,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.pengutronix.de/git/pza/linux.git reset/shared-retrigger

for you to fetch changes up to 557acb3d2cd9c82de19f944f6cc967a347735385:

  reset: make shared pulsed reset controls re-triggerable (2020-11-16 17:05:28 +0100)

----------------------------------------------------------------
Amjad Ouled-Ameur (1):
      reset: make shared pulsed reset controls re-triggerable

 drivers/reset/core.c  | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/reset.h |  1 +
 2 files changed, 74 insertions(+)

regards
Philipp

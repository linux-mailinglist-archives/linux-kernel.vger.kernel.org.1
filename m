Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3491FCBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgFQLDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 07:03:43 -0400
Received: from v6.sk ([167.172.42.174]:49994 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQLDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:03:42 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id AD621610B4;
        Wed, 17 Jun 2020 11:03:10 +0000 (UTC)
Date:   Wed, 17 Jun 2020 13:03:08 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Geiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] mfd: Add ENE KB3930 Embedded Controller driver
Message-ID: <20200617110308.GA1036641@furthur.local>
References: <20200616224404.994285-1-lkundrak@v3.sk>
 <6ce028567aead7e5270c7d62b4f201bc686c0b3e.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce028567aead7e5270c7d62b4f201bc686c0b3e.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 10:58:28AM +0200, Lucas Stach wrote:
> Hi Lubomir,
> 
> Am Mittwoch, den 17.06.2020, 00:44 +0200 schrieb Lubomir Rintel:
> > Hi,
> > 
> > please consider applying the patches chained to this message. It's the
> > fifth version of the driver for the ENE KB3930 Embedded Controller.
> > 
> > This version is essentially a resend of v4. The only actual change is the
> > addition of the Rob's Reviewed-by tag which I failed to do previously.
> > Detailed change logs are in the individual patch descriptions.
> 
> I don't think you wanted this to go to the etnaviv list and
> maintainers, right?

Indeed, a case of git send-email --embarass-yourself.

Sorry about that and thanks for letting me know.

Lubo

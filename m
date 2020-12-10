Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE87D2D55CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbgLJIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388254AbgLJIxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:53:04 -0500
Date:   Thu, 10 Dec 2020 09:53:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607590343;
        bh=nxGC5oDfWX7SQTsEDna33GWTasKZJzTW0vQHeSfesl0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=2WcQ3HLwyyqJT3DWIkk703YV0L3lMfyYNNCsJqVCvpQeyTpjCek4xCA0HrmyI7O5y
         AkthjWTCgy5Q3xcMM5bngz7prRoL4Vs+50LPG+8IPHQQtrh5EimliITalFuOXcw3lp
         XOZHOKkw8kZmil6VRgCIJU0kTnpun5IgQbhmdS6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thorsten Scherer <thorsten.scherer@eckelmann.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] siox: two cleanups
Message-ID: <X9HiEf9UqqdT8QJz@kroah.com>
References: <20201125093106.240643-1-u.kleine-koenig@pengutronix.de>
 <20201125144720.5imcc3atcqpegk4i@ws067.eckelmann.group>
 <X9Edf/Fm6umQ7whL@kroah.com>
 <20201210083859.wqeuf3ijghbwtyuw@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210083859.wqeuf3ijghbwtyuw@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:38:59AM +0100, Uwe Kleine-König wrote:
> On Wed, Dec 09, 2020 at 07:54:55PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 25, 2020 at 03:47:20PM +0100, Thorsten Scherer wrote:
> > > Hello,
> > > 
> > > On Wed, Nov 25, 2020 at 10:31:04AM +0100, Uwe Kleine-König wrote:
> > > > Hello,
> > > >
> > > > compared to v2 sent starting with Message-Id:
> > > > 20201124141834.3096325-1-u.kleine-koenig@pengutronix.de:
> > > >
> > > >  - fix typo in commit log of patch 1
> > > >  - add Ack by Thorsten for patch 1
> > > >
> > > > Uwe Kleine-König (2):
> > > >   siox: Use bus_type functions for probe, remove and shutdown
> > > >   siox: Make remove callback return void
> > > 
> > > Successfully ran our siox testcases on v3.
> > > 
> > > Tested-by: Thorsten Scherer <t.scherer@eckelmann.de>
> > 
> > Are you going to take these patches, or do you need/want me to take them
> > through one of my trees?
> > 
> > Either is fine for me.
> 
> There is no repo for SIOX and up to know you were our upstream. So if
> you could take them that would be great.

Ok, will do, I can't remember what trees I am "upstream" for anymore, I
seem to be collecting more and more of them these days :)

thanks,

greg k-h

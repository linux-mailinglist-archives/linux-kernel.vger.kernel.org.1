Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A705D2D4986
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbgLISyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbgLISyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:54:20 -0500
Date:   Wed, 9 Dec 2020 19:54:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607540020;
        bh=JkSh+8nouJ9z1fToQbr8I5QR+DTJ/b/oaWvVkGAzt78=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8KxFlknd8vOpwJLKy/OwmthqbVCBeY5HQufcZrAWhnNbi35rvYZoDLyUujFEJiJi
         zEbvWVJpyD15UJgdm3N8G/K0bw+fToBfv00wXhQ1lOGq2HXzrdMb+L9LU9Hxo8esFs
         Ke0pk7OPB/lzSPkDx+ZmTff0QuyQz6dO6zcuUprA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thorsten Scherer <thorsten.scherer@eckelmann.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] siox: two cleanups
Message-ID: <X9Edf/Fm6umQ7whL@kroah.com>
References: <20201125093106.240643-1-u.kleine-koenig@pengutronix.de>
 <20201125144720.5imcc3atcqpegk4i@ws067.eckelmann.group>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125144720.5imcc3atcqpegk4i@ws067.eckelmann.group>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:47:20PM +0100, Thorsten Scherer wrote:
> Hello,
> 
> On Wed, Nov 25, 2020 at 10:31:04AM +0100, Uwe Kleine-König wrote:
> > Hello,
> >
> > compared to v2 sent starting with Message-Id:
> > 20201124141834.3096325-1-u.kleine-koenig@pengutronix.de:
> >
> >  - fix typo in commit log of patch 1
> >  - add Ack by Thorsten for patch 1
> >
> > Uwe Kleine-König (2):
> >   siox: Use bus_type functions for probe, remove and shutdown
> >   siox: Make remove callback return void
> 
> Successfully ran our siox testcases on v3.
> 
> Tested-by: Thorsten Scherer <t.scherer@eckelmann.de>

Are you going to take these patches, or do you need/want me to take them
through one of my trees?

Either is fine for me.

thanks,

greg k-h

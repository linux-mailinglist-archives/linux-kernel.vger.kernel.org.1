Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE482220EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbgGOOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 10:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbgGOOKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:10:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE96205CB;
        Wed, 15 Jul 2020 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594822222;
        bh=A66RLT4w/WW8bo0ykuWzP30GpTf1urXpWepa4WoWfJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0LWPB1jWAyJcSvlCIcF9Q/U+g9ogr5zUvOeBXsti7fcwsIJxZSpe6E9im0oCLc22R
         34rq7a3GpTkiXiiCeEah5gJnzVqcLhdonqv2iUaSSwMPWrubCCdcdp7z2PJUqvx3p8
         suSfUzUVFYzCaL/E4BN3WM8rE8tB336v/Tu48hE0=
Date:   Wed, 15 Jul 2020 16:10:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 0/6] staging: dpaa2-ethsw: cleanup of link state and MAC
 addresses
Message-ID: <20200715141018.GA3377845@kroah.com>
References: <20200714133431.17532-1-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714133431.17532-1-ioana.ciornei@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 04:34:25PM +0300, Ioana Ciornei wrote:
> This patch set is cleaning up the link state handling of the switch
> ports in patches 1-4. The last two patches are setting up the MAC
> addresses of the switch ports automatically so that the user is not
> forced to manually add them before adding them to a bridge.

This feels like adding new functionality to this code.  What is keeping
it from getting out of staging at this point in time?  I would prefer
for it to be moved out before adding new stuff to it.

thanks,

greg k-h

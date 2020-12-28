Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA62E41CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441078AbgL1PNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:13:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438382AbgL1PND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 10:13:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64D32207A1;
        Mon, 28 Dec 2020 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609168343;
        bh=2l2ajyTtWTReLOI1PQL6uq1D0hSa3y576mpy/wVfckI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksme+kAsHUga2OwHa3+sUIWU/Kr5q04uiv7ZCdEkkLW0Ni5JosMMMhNJK4RDLKpj+
         DLN9odZmYPd8TTNApVvlYe2GxLVRPNUEFvOO+LoszE52pm7XgP3GgNPiZotSv3Q1A0
         JXMd6o/84CvNXAbR2+9UTjL+CLkzOw55/i+MLw6U=
Date:   Mon, 28 Dec 2020 16:13:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Sistik <sistik@3ksolutions.sk>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support
Message-ID: <X+n2KCMCR9l1bZyk@kroah.com>
References: <20201221231848.55259-1-sistik@3ksolutions.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221231848.55259-1-sistik@3ksolutions.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 12:18:48AM +0100, Ivan Sistik wrote:
> This patch is ported and corrected version of my previous patch which can
> be reviewed here:
> https://lore.kernel.org/lkml/20200106235203.27256-1-sistik@3ksolutions.sk/
> 
> I have been waiting for some time to see if Lukas Wunner <lukas@wunner.de>
> will create patch with his own solution.
> 
> Now I am successfully running my imeplementation for almost one year in
> production environment. There are no problems with it. I have made
> corrections to patch according to notes from Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>.
> 
> Patch content:

All of the above should not be in the changelog body, but rather below
the --- line.

Please fix this up and resend a v2 with that moved so I don't have to
hand-edit the patch to be able to apply it!

thanks,

greg k-h

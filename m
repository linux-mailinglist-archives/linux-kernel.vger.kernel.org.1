Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CAC302343
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAYJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbhAYJZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:25:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68F692223E;
        Mon, 25 Jan 2021 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611566712;
        bh=mD7lOJznxAY80DHH4l/imiGO1itOVPS2p1dUvHaN6QI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvTBvSnAYsb3rsPOyx9epkqs1ubThO6ToRQSOzuTrwnyfjSzuHkp4VM4HSgUHItDV
         xUv9KopGQpf+QgPzoIyFxBP6gayQ81F4tGHNCBBM9ldQbssCjRAF5bDPzhm+BiBw3N
         NSDXCaNNnpgnaZtgLt4Wpl1LpGGV3PVcwsvovEZw=
Date:   Mon, 25 Jan 2021 10:25:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: Rename all existing 'memhp' into 'mhp'
Message-ID: <YA6Odp5BKyPP4OaR@kroah.com>
References: <1611554093-27316-1-git-send-email-anshuman.khandual@arm.com>
 <YA6AqupAWINtNckx@kroah.com>
 <3dc093e6-e037-c67c-f2f9-c534fdabdd99@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc093e6-e037-c67c-f2f9-c534fdabdd99@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:21:02PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/21 1:56 PM, Greg Kroah-Hartman wrote:
> > On Mon, Jan 25, 2021 at 11:24:53AM +0530, Anshuman Khandual wrote:
> >> This renames all 'memhp' instances to 'mhp' except for memhp_default_state
> >> for being a kernel command line option. This is just a clean up and should
> >> not cause a functional change.
> > 
> > THat says _what_ you are doing, but I have no idea _why_ this is needed
> > for anything...
> 
> There is a series [1] which adds some new hotplug functions starting
> with mhp_ (after deciding in its favor rather than memhp_). We should
> have a common naming scheme either memhp_ based or mhp_ based but not
> mixed. As it was proposed [2] to go with mhp_ based names instead, all
> the existing memhp_ needed renaming. Hence the this patch.

And how was I supposed to know any of this by reading the changelog
text?  (hint, it needs to go in there...)

thanks,

greg k-h

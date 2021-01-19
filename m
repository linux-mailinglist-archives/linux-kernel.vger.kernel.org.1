Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083042FBBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbhASP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391784AbhASP45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:56:57 -0500
X-Greylist: delayed 604 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Jan 2021 07:56:12 PST
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42835C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:56:12 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1626C450; Tue, 19 Jan 2021 16:46:05 +0100 (CET)
Date:   Tue, 19 Jan 2021 16:46:01 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: IOMMU Maintainership
Message-ID: <20210119154601.GA3229@8bytes.org>
References: <20201117100953.GR22888@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117100953.GR22888@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:09:53AM +0100, Joerg Roedel wrote:
> Hi,
> 
> last week I spent in the hospital and had an unplanned surgery from
> which I am recovering now. The recovery will take a few weeks, which
> unfortunatly does not allow me to fulfill my IOMMU maintainer duties or
> do any other serious work in front of a computer.
> 
> Luckily Will Deacon volunteered to handle incoming IOMMU patches and
> send them upstream. So please Cc him on any patches that you want to
> have merged upstream for the next release and on important fixes for
> v5.10. The patches will go through another tree for the time being, Will
> can share the details on that.

I am happy to announce that my recovery has gone well and I can now
return to my duties as the maintainer for IOMMU. Will already sent me a
list of pending stuff I will go through soon.

Thanks a lot to everyone who helped to keep things going through my
absence, and especially Will Deacon who picked up the work to collect
everything and sending it upstream!


Regards,

	Joerg

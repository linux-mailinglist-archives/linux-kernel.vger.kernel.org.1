Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30042CAA41
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgLARx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgLARx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:53:57 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBDF21D42;
        Tue,  1 Dec 2020 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606845196;
        bh=GN5P47PpQGHK/+AIXSlKGZHgLNY/ldlwTq9CilCOShw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeNAnrj8JjEWnCMFBVsigg2yDGkHzt6T09CipVHPbCKbKiTSXmeD4dq9G4nqvGAP9
         2HvbFF/nQADnQPVulOowL2UJpDHkaFoloEAuGXto1vvOzI/KZEz88A9ZFojfioMLIl
         MpfhksDWLHHbXugNfIsgVNGVGLlwzXBOQfsHtO7I=
Date:   Tue, 1 Dec 2020 18:54:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     mark gross <mgross@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, markgross@kernel.org,
        adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Message-ID: <X8aDVALdoi/Mg2LA@kroah.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
 <20201130230707.46351-8-mgross@linux.intel.com>
 <X8YXMVD1i90VWaPa@kroah.com>
 <20201201174542.GB56560@mtg-dev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201174542.GB56560@mtg-dev.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 09:45:43AM -0800, mark gross wrote:
> On Tue, Dec 01, 2020 at 11:13:05AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 30, 2020 at 03:06:52PM -0800, mgross@linux.intel.com wrote:
> > > From: Srikanth Thokala <srikanth.thokala@intel.com>
> > > 
> > > Add PCIe EPF driver for local host (lh) to configure BAR's and other
> > > HW resources. Underlying PCIe HW controller is a Synopsys DWC PCIe core.
> > > 
> > > Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> > > Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > 
> > <snip>
> > 
> > Again, you sent this twice?  And it never got to lore.kernel.org nor the
> > mailing lists?
> In my excitement of sorting out my MTA misconfiguration work around I actually
> hit entry without including the magic fix
> "--envelope-sender=mgross@linux.intel.com" in my git send-email command line. 
> > 
> > And I can't see a 00/XX email anywhere explaining this, and I didn't get
> > the whole series?
> https://lore.kernel.org/lkml/20201130230707.46351-1-mgross@linux.intel.com/
> 
> Did I mess up on who all should get the 00/xx email?

Yes, you need to include the people that you want to review the
individual patches, otherwise we have no idea :(

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB32C9EDF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgLAKMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:12:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388050AbgLAKMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:12:34 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 635FE20770;
        Tue,  1 Dec 2020 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606817513;
        bh=TQwRiimAiTWNqCIydUn/CaDIsHushIA5w8RlYTZQUD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yYUcka660mcYWCujct4Zxb30mgZ6Oce1qZcsWhNE5QU1QF6mW7B8fcnKO2PMv+NL1
         IH2xsTpFwipy6stGNc+7hbXZQ2vx83e8LBFeEfXn/HVY2shLrRidaUr9/Ip77Vgv4H
         S5Y7rJJ7he4dIbatGLuzineGCfh6AfkWp0nIfpZ4=
Date:   Tue, 1 Dec 2020 11:13:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, markgross@kernel.org,
        adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Message-ID: <X8YXMVD1i90VWaPa@kroah.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
 <20201130230707.46351-8-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130230707.46351-8-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 03:06:52PM -0800, mgross@linux.intel.com wrote:
> From: Srikanth Thokala <srikanth.thokala@intel.com>
> 
> Add PCIe EPF driver for local host (lh) to configure BAR's and other
> HW resources. Underlying PCIe HW controller is a Synopsys DWC PCIe core.
> 
> Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>

<snip>

Again, you sent this twice?  And it never got to lore.kernel.org nor the
mailing lists?

And I can't see a 00/XX email anywhere explaining this, and I didn't get
the whole series?

Something is really wrong on your end with your email client
configuration, please fix that up and send this so that we can actually
see it all, and know what the heck we are supposed to be reviewing...

thanks,

greg k-h

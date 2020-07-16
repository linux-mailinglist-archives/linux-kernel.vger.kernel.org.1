Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A56221CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 09:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgGPHFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 03:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPHFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:05:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404502067D;
        Thu, 16 Jul 2020 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594883113;
        bh=Z5RhkkqLX0D9XYZKqSxiQ7QYhDFUhsRN5R5vtcfRhec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5zAmkh8wu5Nyyl5cprsTdFtEXaolIRhWe8a3K0gQQPvIaeq2KOcgDPksGPkR0fs4
         +qXez5kL+vKEJG1Hl2QZbeZwkg2v2a2mb6oXUmJNr211Nqkk69y2zllc4nBzPEoNUU
         pVa3OAe2I5nT4OTAKHZgmA4Ja2B4SqzyLNRmDv7w=
Date:   Thu, 16 Jul 2020 09:05:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajmohan Mani <rajmohan.mani@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, pmalani@chromium.org,
        bleung@chromium.org
Subject: Re: [PATCH 2/2] usb: typec: intel_pmc_mux: Check the port status
 before connect
Message-ID: <20200716070508.GB962748@kroah.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
 <20200716003310.26125-3-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716003310.26125-3-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 05:33:10PM -0700, Rajmohan Mani wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> The PMC microcontroller that we use for configuration, does
> not supply any status information back. For port status we
> need to talk to another controller on the board called IOM
> (I/O manager).
> 
> By checking the port status before configuring the muxes, we
> can make sure that we do not reconfigure the port after
> bootup when the system firmware (for example BIOS) has
> already configured it.
> 
> Using the status information also to check if DisplayPort
> HPD is still asserted when the cable plug is disconnected,
> and clearing it if it is.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

You can't just forward on patches from others without also adding your
signed-off-by to them, right?

Please fix up this series and try again.

thanks,

greg k-h

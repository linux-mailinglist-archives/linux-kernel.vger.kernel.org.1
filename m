Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140BE2C9EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgLAKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbgLAKRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:17:10 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F45220705;
        Tue,  1 Dec 2020 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606817783;
        bh=qrNFAh5imBzfRBKwCYZgo2ZvoCghWML1W9q53ZGbJfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4siKwbV/ix8sTlooqsipuXDD21XKTXlm3bm0F7kl+HShQesOP0m8yXmuh38mKWev
         PVUjLNAyScGzmJOHPlr1po8zSqR0EfH6Ap74T4ffRY6qAjfsd/LulPowKcMNGpVRnm
         dB9qDgLBkigGYF0GURScW3WDYuweornyuDkNsouA=
Date:   Tue, 1 Dec 2020 11:17:35 +0100
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
Message-ID: <X8YYPxK9gnTvubTJ@kroah.com>
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
> +#define XPCIE_VERSION_MAJOR 0
> +#define XPCIE_VERSION_MINOR 5
> +#define XPCIE_VERSION_BUILD 0
> +#define _TOSTR(X) #X
> +#define _VERSION(A, B, C) _TOSTR(A) "." _TOSTR(B) "." _TOSTR(C)
> +#define XPCIE_DRIVER_VERSION \
> +	_VERSION(XPCIE_VERSION_MAJOR, XPCIE_VERSION_MINOR, XPCIE_VERSION_BUILD)
> +
> +struct xpcie_version {
> +	u8 major;
> +	u8 minor;
> +	u16 build;
> +} __packed;

Now that the driver will be in the tree, there is no need for this
structure or these fields, right?  It will just be the version of the
kernel.  Otherwise something like this will never be correct, given
stable kernel releases and enterprise kernel releases, and loads of
other messy backported trees.  Just stick to the kernel release number
please, that's the only sane thing.

thanks,

greg k-h

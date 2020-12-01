Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F972C9EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgLAKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:15:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLAKPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:15:18 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961422080A;
        Tue,  1 Dec 2020 10:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606817678;
        bh=qtZsjGdA8TK/liXXJA19EI//MwYTuoMfPbtlZG95RuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KndmX1PpEHdoG+/JH3OTSCdQ9qPX/wNwkXCatn5J0LhR5kE0G7nyCQM9tEan6VVRg
         l7m+ldVvhntL6XiF9pF7GjGgnQra6M/L5QrHkCMQHvz1wKN0amvM6xrRJl8yREg1XA
         V78/kF4rhyBBPdiQSf8PYqzZW8AmFsQ2kj/1T1p4=
Date:   Tue, 1 Dec 2020 11:15:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, markgross@kernel.org,
        adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/22] misc: xlink-pcie: lh: Add core communication logic
Message-ID: <X8YX1q3ExjhBGd3+@kroah.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
 <20201130230707.46351-10-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130230707.46351-10-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 03:06:54PM -0800, mgross@linux.intel.com wrote:
> +static int rx_pool_size = SZ_32M;
> +module_param(rx_pool_size, int, 0664);
> +MODULE_PARM_DESC(rx_pool_size, "receiving pool size (default 32 MiB)");
> +
> +static int tx_pool_size = SZ_32M;
> +module_param(tx_pool_size, int, 0664);
> +MODULE_PARM_DESC(tx_pool_size, "transmitting pool size (default 32 MiB)");
> +
> +static int fragment_size = XPCIE_FRAGMENT_SIZE;
> +module_param(fragment_size, int, 0664);
> +MODULE_PARM_DESC(fragment_size, "transfer descriptor size (default 128 KiB)");
> +
> +static bool tx_pool_coherent = true;
> +module_param(tx_pool_coherent, bool, 0664);
> +MODULE_PARM_DESC(tx_pool_coherent,
> +		 "transmitting pool using coherent memory (default true)");
> +
> +static bool rx_pool_coherent;
> +module_param(rx_pool_coherent, bool, 0664);
> +MODULE_PARM_DESC(rx_pool_coherent,
> +		 "receiving pool using coherent memory (default false)");

This is not the 1990's anymore, please never use module parameters for
new drivers as they do not work well (i.e. they do not work at all on a
individual device basis.)

Make this all "just work" so that userspace does not have to "tune"
anything.  But if you really must allow configuration like this, then
use configfs, as that's what it is there for.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560032CB4E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgLBGQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgLBGQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:16:48 -0500
Date:   Wed, 2 Dec 2020 07:16:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606889768;
        bh=w88Z8qiwP1Q3/7iGzMHomPYc2L7dOX2UF24eFWJG+Yk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCxLPEy5HQuULfk+PQvKXIzmwxpTeLIaH8D4AiFpxuunhwSNPpH5gzdvl87zB60Sr
         iGMvyoOakzuDsfp/OhA0bjy2KrdtRpF2VH6OCfLQEik8rib1xwodUfoii2svUGxkAu
         d25G3WDL/w8ixiIha5bVCZLpYLEgyLGEi255oObY=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <X8cxNA3GTi/LrTt/@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201223511.65542-4-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8955,6 +8955,14 @@ M:	Deepak Saxena <dsaxena@plexity.net>
>  S:	Maintained
>  F:	drivers/char/hw_random/ixp4xx-rng.c
>  
> +INTEL KEEM BAY IPC DRIVER
> +M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +M:	Mark Gross <mgross@linux.intel.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> +F:	drivers/soc/intel/keembay-ipc.c
> +F:	include/linux/soc/intel/keembay-ipc.h

Sad that Intel is not going to actually pay you all to do this
maintenance work for a brand new subsystem you are wanting to add to the
tree :(

Does this mean you all will have to do it on your own time and not as
part of your work at Intel?  If so, why not just use your personal email
addresses instead to make it a bit more obvious?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323C42B1E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbgKMPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605280660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dEz/mWgfsjb50E6KuqiHHe4wptEHxMhHaGcYcD6c3Xs=;
        b=MyI6+xJDonr4Up1qE/NY/dwT+L/LX/NA8SAKPZqpnl7x3u61E2uzc1wKPBBugVe0nnAsqu
        vjmFf2t6syjK0VRURE4B/DRb0uzfNaOQCHHtrZVt9p1+jCID7kpbOqJNMEzk4mx3l4tEZy
        5CnR4S5xm9NUoOmViidZnJNAwhYaw9c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-Ar2rUvxxNEuwtG7_YZ8rtg-1; Fri, 13 Nov 2020 10:17:38 -0500
X-MC-Unique: Ar2rUvxxNEuwtG7_YZ8rtg-1
Received: by mail-wm1-f72.google.com with SMTP id o19so4121043wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dEz/mWgfsjb50E6KuqiHHe4wptEHxMhHaGcYcD6c3Xs=;
        b=Z49fbvy0bv8HBz4EhtGMv59jdUG/npx16e5Ibf2ABnbfDEvIpt7gXSD5RfSULo1GEe
         r2Z9NTXvlNU3t8Yh7+KQwLdL7cZWHM6P9AaSL60G5du3GHvehjT17+XvKAC3R/qcy0Gl
         YTjqeyEbH4amdl0nmYWfByvJm6lq39hv6mGfuqNP672qrx7jO9KPo2W2EMzpJ2u1Cnl1
         sDH8VlM7sHdIai2ELxP9dSq7LLIAAazxjnzVOVbvE3ceqlZCOLZa2lQ+RZehS2BzoXKD
         bxk+3TPGEu0jAC7faBnstFh+/j2QmWCg4JBUT67Jmi8HJff2k6l7ldd9SXX/gYPPVgEh
         hOsA==
X-Gm-Message-State: AOAM531RQoaM7UcY1BRSiH55Ns3AKTuWqoup9j0OxzuLfkw8cZu1n8QI
        IEPvTEObNk8QJ2AmXIdFwv8a539v3Vvoz+8oP6rIImnW8s0A/a6i/c4vKYhA/OIXUF4B7eHGU4c
        NWBN5fIOiLa1JC7M5g6T3AaZP
X-Received: by 2002:adf:d0c8:: with SMTP id z8mr4169119wrh.288.1605280654107;
        Fri, 13 Nov 2020 07:17:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSUe+mswqNyiANGqO6FwtEAB5Nnihh7E8LhuWsgUNxXyPoxw0jG1kXeEdgynZAyIHrURImnw==
X-Received: by 2002:adf:d0c8:: with SMTP id z8mr4169080wrh.288.1605280653656;
        Fri, 13 Nov 2020 07:17:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id t9sm11412843wrr.49.2020.11.13.07.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:17:33 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:17:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: ERROR: modpost: "mac_pton" undefined!
Message-ID: <20201113101712-mutt-send-email-mst@kernel.org>
References: <202011131937.7Fy1Jnv1-lkp@intel.com>
 <71f5ec23-a1a7-8981-b924-412f4bbed9f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f5ec23-a1a7-8981-b924-412f4bbed9f6@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 01:38:40PM +0100, Laurent Vivier wrote:
> On 13/11/2020 12:58, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> > commit: 0c86d774883fa17e7c81b0c8838b88d06c2c911e vdpasim: allow to assign a MAC address
> > date:   2 weeks ago
> > config: openrisc-randconfig-r035-20201113 (attached as .config)
> > compiler: or1k-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c86d774883fa17e7c81b0c8838b88d06c2c911e
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 0c86d774883fa17e7c81b0c8838b88d06c2c911e
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> >>> ERROR: modpost: "mac_pton" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> >
> 
> I think something like this might fix the problem.
> 
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index d7d32b656102..d2de1cefd5cb 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -13,6 +13,7 @@ config VDPA_SIM
>         depends on RUNTIME_TESTING_MENU && HAS_DMA
>         select DMA_OPS
>         select VHOST_RING
> +       select NET
>         default n
>         help
>           vDPA networking device simulator which loop TX traffic back


NET isn't usually selected, maybe depends on NET

> I'm going to test with .config and post a patch.
> 
> thanks,
> Laurent


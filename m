Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926992B1B40
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKMMiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgKMMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605271129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzdBi8p3tnxokHIUaT1Sh0zVZ3u8QkFB32h297I4gak=;
        b=U90RlWAzLOj7fGvredBzjzNKU/SdTvdHDX0AOWZI0RajpMwBeCJloQV+mTv26vq6f7e47g
        fjx9ZIRGWvdRrQ8e2NGo4d3jLnydjRnUM0uDoVkVTP0cqvFyIfKswVQ+wJPDPshiEKe38i
        lrLn+WCNXjyX3l9gyDRIhxcDTxbj440=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-l1yh-oVPP4m3IG6pJMrYYA-1; Fri, 13 Nov 2020 07:38:47 -0500
X-MC-Unique: l1yh-oVPP4m3IG6pJMrYYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 423AB8030A8;
        Fri, 13 Nov 2020 12:38:46 +0000 (UTC)
Received: from [10.36.113.83] (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0B66EF66;
        Fri, 13 Nov 2020 12:38:41 +0000 (UTC)
Subject: Re: ERROR: modpost: "mac_pton" undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <202011131937.7Fy1Jnv1-lkp@intel.com>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <71f5ec23-a1a7-8981-b924-412f4bbed9f6@redhat.com>
Date:   Fri, 13 Nov 2020 13:38:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202011131937.7Fy1Jnv1-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2020 12:58, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> commit: 0c86d774883fa17e7c81b0c8838b88d06c2c911e vdpasim: allow to assign a MAC address
> date:   2 weeks ago
> config: openrisc-randconfig-r035-20201113 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c86d774883fa17e7c81b0c8838b88d06c2c911e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0c86d774883fa17e7c81b0c8838b88d06c2c911e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "mac_pton" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
>

I think something like this might fix the problem.


diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index d7d32b656102..d2de1cefd5cb 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -13,6 +13,7 @@ config VDPA_SIM
        depends on RUNTIME_TESTING_MENU && HAS_DMA
        select DMA_OPS
        select VHOST_RING
+       select NET
        default n
        help
          vDPA networking device simulator which loop TX traffic back

I'm going to test with .config and post a patch.

thanks,
Laurent


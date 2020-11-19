Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7772B9EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKSXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgKSXvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:51:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224EAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mUpl2EVqwkZXlMHMTBUXiF4XzrFuv8HX1hAlyt+IaO8=; b=qYPLj0LfBheB3/+0HmOQFVzeSP
        wFLM6ckoxcgbblPFtZNvSzV8GiNRdcgFcGgZ5f4gmqCRj0byAWBBqMFzUbGjhJifnoXvjrRWAYDhR
        U7aYIoIYYjZ6y5ye4scZOC/6yZDCouTH+qA9xw2LlKktflmOTGe8emB+MNE6kjOR9IzTeNAWGn4x1
        l0YaMP6SnL3OXv1TPUAfKut+wITl+nY4GpPKlWSbRphJaNVB6yj+X0YCp3peU+Wa+YC58FjvJEStO
        1l8NGQsJNp2lwt4HrHYEn3JkzPFyIAxq4yTnZdtPXm9m0egaF08abRwMtAORFjN9OjHis2TOMEEhQ
        +OMrAezw==;
Received: from [2601:1c0:6280:3f0::c395] (helo=dragon.site)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kftiA-0008DP-FH; Thu, 19 Nov 2020 23:51:34 +0000
Subject: Re: powerpc64-linux-ld: arch/powerpc/mm/numa.o:undefined reference to
 `coregroup_enabled'
To:     kernel test robot <lkp@intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
References: <202011200207.3PUoc4Gf-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e9a3cd97-5a26-7b43-0077-22f909986141@infradead.org>
Date:   Thu, 19 Nov 2020 15:51:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202011200207.3PUoc4Gf-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 10:26 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c2e7554e1b85935d962127efa3c2a76483b0b3b6
> commit: f9f130ff2ec93c5949576bbfb168cc9530c23649 powerpc/numa: Detect support for coregroup
> date:   9 weeks ago
> config: powerpc64-randconfig-c003-20201104 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9f130ff2ec93c5949576bbfb168cc9530c23649
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout f9f130ff2ec93c5949576bbfb168cc9530c23649
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> powerpc64-linux-ld: arch/powerpc/mm/numa.o:(.toc+0x0): undefined reference to `coregroup_enabled'
>     powerpc64-linux-ld: mm/page_alloc.o:(.toc+0x0): undefined reference to `node_reclaim_distance'
>     powerpc64-linux-ld: mm/khugepaged.o:(.toc+0x0): undefined reference to `node_reclaim_distance'

Hm, OK.
CONFIG_NUMA=y
# CONFIG_SMP is not set

Michael, Gautham, does anyone care about this config combination?


Thanks.

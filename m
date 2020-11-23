Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04A22BFDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgKWBN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 20:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKWBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 20:13:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C1C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 17:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=EH8qXWN4Y4VrU8+zuuCH0RGfzxSOU1QsRFTP+2lfbsI=; b=ZQHETsRNaV5CFoPSkJ8gL5K5PC
        WKUfm7x7VvtCTHr0e4MHUnbfy+4AOiKDEDadp9dFXtswx9yHcrqAccSo6f2CTc3aDYzlYse72ZuN/
        wezs6rlZApON2236lr49bE8NargqPP/vOPEISwYYzwrSRlIwA5F02hlzLZsKGNllH7msJlPKwwb9Q
        zA7bBhZUbFIwgJtdM3WD8d96Bz0JQRwhCfx7GeUaW3fDC/Xo4ODIEC6oyuagqB4F/simHotkgkIV8
        ORVmAlvPMcqODaMVMFCTn1j6A1uLx8Alu6irmfH0+x/+IZLnyZ3ILi52yAyucrz2q/cShPWXLvcIg
        +CGKn99A==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kh0QS-00019e-2C; Mon, 23 Nov 2020 01:13:52 +0000
Subject: Re: undefined reference to `start_isolate_page_range'
To:     kernel test robot <lkp@intel.com>, Michal Simek <monstr@monstr.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <202011210906.WVDfrAtS-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4860e097-f90e-fdf6-454f-514e4a7c3c68@infradead.org>
Date:   Sun, 22 Nov 2020 17:13:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202011210906.WVDfrAtS-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 5:26 PM, kernel test robot wrote:
> Hi Michal,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4ccf7a01e805f04defd423fb410f47a13af76399
> commit: 2602276d3d3811b1a48c48113042cd75fcbfc27d microblaze: Wire CMA allocator
> date:   10 months ago
> config: microblaze-randconfig-s031-20201121 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-134-gb59dbdaf-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2602276d3d3811b1a48c48113042cd75fcbfc27d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 2602276d3d3811b1a48c48113042cd75fcbfc27d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=microblaze 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    microblaze-linux-ld: mm/page_alloc.o: in function `alloc_contig_range':
>>> (.text+0xa1fc): undefined reference to `start_isolate_page_range'
>>> microblaze-linux-ld: (.text+0xa40c): undefined reference to `test_pages_isolated'
>>> microblaze-linux-ld: (.text+0xa47c): undefined reference to `undo_isolate_page_range'


FTR:  This is a Kconfig problem in drivers/gpu/drm/aspeed/Kconfig
and it is fixed in linux-next and drm-misc-next.

https://lore.kernel.org/dri-devel/20201011230131.4922-1-rdunlap@infradead.org/

-- 
~Randy


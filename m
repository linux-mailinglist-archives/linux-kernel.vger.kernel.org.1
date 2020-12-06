Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30242D0670
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 19:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLFSCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 13:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgLFSCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 13:02:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10E6C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 10:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uPUKHsxDpxpcTFpPgVM7xBtfqGHu8IXyB2bXcUtNIhc=; b=O3Quj6ZrA/Ie7Sf2ABCp0jBrtH
        xAl/4LjR9mOuSr5cjLERO0iyf9Nk4L9SJdqdPFIfRsvbjyo1MjsKt32DfcaFKcRn2+iRiOaYmT9ng
        727h7zFUn1FQHJGxUNbe29Es82MHvC/r3bidoiApqOaAzN5HEN6wh0YhvE4k50HMZjzJ/b/Mhs9+O
        kgdL12d8gPqtxMtgdjFAgddZf4WUeKg3yfRYj0ZxdarGTCCUCaXrdyv72mJiF4pJBtgO5uYepVhsB
        PRFi/UCbCFYO3RZFTZ7DDDNAAqxNdlKsrdvBrSzlESMo3kc9X+02m6KeNMIzGuJq3EMp1eDQ2aSXf
        6uavB+Mg==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klyM8-00023l-CM; Sun, 06 Dec 2020 18:01:56 +0000
Subject: Re: undefined reference to `devm_mux_control_get'
To:     kernel test robot <lkp@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
References: <202012070124.pyQeUIVa-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ec30591-ea93-3e53-a92d-05193daf307a@infradead.org>
Date:   Sun, 6 Dec 2020 10:01:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202012070124.pyQeUIVa-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/20 9:25 AM, kernel test robot wrote:
> Hi Serge,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7059c2c00a2196865c2139083cbef47cd18109b6
> commit: abf00907538e21c469a10809dc2991982673fcbf spi: dw: Add Baikal-T1 SPI Controller glue driver
> date:   8 weeks ago
> config: parisc-randconfig-r004-20201207 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=abf00907538e21c469a10809dc2991982673fcbf
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout abf00907538e21c469a10809dc2991982673fcbf
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    hppa-linux-ld: drivers/spi/spi-dw-bt1.o: in function `dw_spi_bt1_sys_init':
>>> (.text+0x1c): undefined reference to `devm_mux_control_get'
> 
> ---


Serge's patch has been:

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

[1/1] spi: dw-bt1: Fix undefined devm_mux_control_get symbol
      commit: 7218838109fef61cdec988ff728e902d434c9cc5


-- 
~Randy


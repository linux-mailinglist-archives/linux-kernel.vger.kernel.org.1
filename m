Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61D22F1B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbhAKQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389085AbhAKQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:44:17 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF89C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:43:37 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h19so81254qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=txuQoBp0nNONCO5E3N2c+O/s/d9J64QZ2sEFMrrplNA=;
        b=j/YZhaO01GXAGhhw6yx1xvzgprtk8Gdvwibr1JIMgbIF2iyDqq1vRt4XzTv7fiF7oM
         K5XcXNdheDfmzCi1HCpm9YEwPkHtyZXddhuXwl8iyc6eXCcvPdSbc5gDSW4PcYBt5pwZ
         K8BG2hF2jiR16VMxoHUy9dZQpPEZgNhqMxpigxwCyPm++wKkKhkzVc2KlDW0pxJzSHZ2
         Jfvi4FzHWmhYrTTFshlFRqg3cbvwRDRleH7QFuKX55oMjdWF871M1uTou2WScVFQnc4J
         wNPtllac3N2HNOxDZZU8sZCgtLyDIWvvgbBfSJtYcZALw+UgtDquqHHuC6+O+orlf6AH
         8+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=txuQoBp0nNONCO5E3N2c+O/s/d9J64QZ2sEFMrrplNA=;
        b=Vk5qoinED4YZpqrA2wbX7HnHhMSZaMCp3wsPKsaSmiFsgxhSPaq8/rPR02BVxrtz/i
         6c57Pd0UK5OSpSy9523H2KkxtKxV/3UclXGy2yckxfd0lUvnKi4bZaLiJauj+d8GdlnT
         Z+MrRrKKaZ7/g5etQHGehh/kPaxJYHadHB3BFMa0dfxT/IacgSdma5SfO1C/+CKMcGB1
         9fRPgF4zPnzBaM0JhAymNfBW8Nghwz1PYpxFyYgCJUMrQvHamzXSZPRmkSCeg3gN7FVW
         1LtwYeWwogTJ05yeRObGG55+fJgXO20SM8ANoFnjsNntVZhwa/KG1MUBmTD8mJX8CsNV
         tsFQ==
X-Gm-Message-State: AOAM5308TkmfPqwGmabXNX+v/cyhA/gJLXr3iZFGa6q+Zr5lLBjXIdv+
        oDqZ9oLertxVFQiWWfgSkVM=
X-Google-Smtp-Source: ABdhPJzlCptEldVASIcxeHlYWALNRdzYpae5OPS7tx0lRCQdZiGdtmmSPz/SCzpGv/O6HFNEjCmOsQ==
X-Received: by 2002:aed:212d:: with SMTP id 42mr488791qtc.106.1610383416110;
        Mon, 11 Jan 2021 08:43:36 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id n5sm160945qkh.126.2021.01.11.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:43:35 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:43:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Mateusz Holenko <mholenko@antmicro.com>
Subject: Re: drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: unused
 variable 'litex_soc_ctrl_of_match'
Message-ID: <20210111164334.GA1322395@ubuntu-m3-large-x86>
References: <202101070445.8Kz6oJcS-lkp@intel.com>
 <20210111123055.GA2002709@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111123055.GA2002709@lianli.shorne-pla.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:30:55PM +0900, Stafford Horne wrote:
> On Thu, Jan 07, 2021 at 04:04:47AM +0800, kernel test robot wrote:
> > Hi Pawel,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> > commit: 22447a99c97e353bde8f90c2353873f27681d57c drivers/soc/litex: add LiteX SoC Controller driver
> > date:   8 weeks ago
> > config: x86_64-randconfig-a001-20210107 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5c951623bc8965fa1e89660f2f5f4a2944e4981a)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=22447a99c97e353bde8f90c2353873f27681d57c
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 22447a99c97e353bde8f90c2353873f27681d57c
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: unused variable 'litex_soc_ctrl_of_match' [-Wunused-const-variable]
> >    static const struct of_device_id litex_soc_ctrl_of_match[] = {
> >                                     ^
> >    1 warning generated.
> > 
> > 
> > vim +/litex_soc_ctrl_of_match +143 drivers/soc/litex/litex_soc_ctrl.c
> > 
> >    142	
> >  > 143	static const struct of_device_id litex_soc_ctrl_of_match[] = {
> >    144		{.compatible = "litex,soc-controller"},
> >    145		{},
> >    146	};
> >    147	
> > 
> 
> I don't use clang but GCC, and I cannot reproduce this warning.
> 
> $ make drivers/soc/litex/litex_soc_ctrl.o 
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CC      drivers/soc/litex/litex_soc_ctrl.o
> 
> Also, I can see litex_soc_ctrl_of_match is used.  I am not sure what is going on
> here.
> 
> -Stafford
> 

You need W=1

$ make -skj"$(nproc)" W=1 olddefconfig drivers/soc/litex/litex_soc_ctrl.o
drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: ‘litex_soc_ctrl_of_match’ defined but not used [-Wunused-const-variable=]
  143 | static const struct of_device_id litex_soc_ctrl_of_match[] = {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~

$ rg "CONFIG_OF|CONFIG_LITEX_SOC_CONTROLLER" .config
1124:# CONFIG_OF is not set
4673:CONFIG_LITEX_SOC_CONTROLLER=y

This variable is used in two places in that file, in the
MODULE_DEVICE_TABLE macro and the of_match_ptr macro. When CONFIG_OF is
disabled, of_match_ptr evaluates to NULL. When the file is built into
the kernel image, MODULE_DEVICE_TABLE evaluates to nothing, leaving this
variable defined but unused in the final preprocessed source.

Hope that helps!

Cheers,
Nathan

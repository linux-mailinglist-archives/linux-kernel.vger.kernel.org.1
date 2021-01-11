Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0162F2197
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbhAKVPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbhAKVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:15:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B99C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:14:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w1so489585pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tBBYBALNeTXmfoXgIuvASWSb43rmlp3hgP0L/sV8MGk=;
        b=Y5IXc+PenEJZOu5pV/qLhcb6NXi6vvQHsWg3gGUxA6jHxPzRiWxtrgngQJgrpnGv0e
         a15Gr1GQXYYE3qIR6ty2NH9NOHtvSGsC04wEZmxPZdznZJ7cjYaDqDhs5XTFTJMZ47GN
         wvgSu3smqUHSXbR6dxZXF+aA3vomrxPEuoVjzYUUXKa7X0OP5lcDgrgRxFMSKqi7OTmI
         DxBsXcBL6ULcqZgSDqVe9RlOGW20yie/3ILVFqZbtfCR8zOegBa8fP8/V54IgH8gHxyl
         UP4Uf6SF4335zm/bpnCGEJZD1M+2LAO5U7fc2guqYBcfXjiAA7Nl41HizWdVT9CKkd+5
         8+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tBBYBALNeTXmfoXgIuvASWSb43rmlp3hgP0L/sV8MGk=;
        b=ruFEA6zVHn9k4Ac6BvTNOs2IsrMX18aFbMFbaCLnULrr58/OPJH9dvVuEnYXs6CNTG
         Dd4nzDf6xsi5WlQcte0mYHR/HZ+Sg/xqTmLX/Qg3h624hcN8A1qKTMIF899JiX0OyGOr
         E3++1Y941sFlo7Xa9u8zN2OFKRz2zG8uAmDmKNds+EyUwOjiIJiyFnHTjiOK5h4uo45r
         zi0C9JNXqQHD7L89suLQ9hlDc7cuC4pBwlb6QVl89qIXW9JCJpQIPRYImzLhxpPbzTG3
         GRcJMN0qxFLTb7aaTAN45pntcKSRRNkgnH17zpggRqUEuVwx11sl45fALcyhkmwww/5G
         aTeQ==
X-Gm-Message-State: AOAM5325PjBqYCv7O6Orv9OJGyneOz6B/1ZzGK0Yqt9qZVim1aOF9L67
        GoVQ3uHFMmj34gpmbj2LC1zt4iKimFY=
X-Google-Smtp-Source: ABdhPJzpJHdKjBXTiGLqg1FD+czXc2VXnMCI6J24bUH8QLdMXQSJAFFTIzNiwrpfJ8hBe8hnTxMmbA==
X-Received: by 2002:a17:90a:c084:: with SMTP id o4mr772591pjs.165.1610399694897;
        Mon, 11 Jan 2021 13:14:54 -0800 (PST)
Received: from localhost (g178.219-103-173.ppp.wakwak.ne.jp. [219.103.173.178])
        by smtp.gmail.com with ESMTPSA id o11sm336964pjs.36.2021.01.11.13.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:14:54 -0800 (PST)
Date:   Tue, 12 Jan 2021 06:14:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Mateusz Holenko <mholenko@antmicro.com>
Subject: Re: drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: unused
 variable 'litex_soc_ctrl_of_match'
Message-ID: <20210111211452.GB2002709@lianli.shorne-pla.net>
References: <202101070445.8Kz6oJcS-lkp@intel.com>
 <20210111123055.GA2002709@lianli.shorne-pla.net>
 <20210111164334.GA1322395@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111164334.GA1322395@ubuntu-m3-large-x86>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:43:34AM -0700, Nathan Chancellor wrote:
> On Mon, Jan 11, 2021 at 09:30:55PM +0900, Stafford Horne wrote:
> > On Thu, Jan 07, 2021 at 04:04:47AM +0800, kernel test robot wrote:
> > > Hi Pawel,
> > > 
> > > FYI, the error/warning still remains.
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> > > commit: 22447a99c97e353bde8f90c2353873f27681d57c drivers/soc/litex: add LiteX SoC Controller driver
> > > date:   8 weeks ago
> > > config: x86_64-randconfig-a001-20210107 (attached as .config)
> > > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5c951623bc8965fa1e89660f2f5f4a2944e4981a)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install x86_64 cross compiling tool for clang build
> > >         # apt-get install binutils-x86-64-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=22447a99c97e353bde8f90c2353873f27681d57c
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 22447a99c97e353bde8f90c2353873f27681d57c
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: unused variable 'litex_soc_ctrl_of_match' [-Wunused-const-variable]
> > >    static const struct of_device_id litex_soc_ctrl_of_match[] = {
> > >                                     ^
> > >    1 warning generated.
> > > 
> > > 
> > > vim +/litex_soc_ctrl_of_match +143 drivers/soc/litex/litex_soc_ctrl.c
> > > 
> > >    142	
> > >  > 143	static const struct of_device_id litex_soc_ctrl_of_match[] = {
> > >    144		{.compatible = "litex,soc-controller"},
> > >    145		{},
> > >    146	};
> > >    147	
> > > 
> > 
> > I don't use clang but GCC, and I cannot reproduce this warning.
> > 
> > $ make drivers/soc/litex/litex_soc_ctrl.o 
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> >   CC      drivers/soc/litex/litex_soc_ctrl.o
> > 
> > Also, I can see litex_soc_ctrl_of_match is used.  I am not sure what is going on
> > here.
> > 
> > -Stafford
> > 
> 
> You need W=1
> 
> $ make -skj"$(nproc)" W=1 olddefconfig drivers/soc/litex/litex_soc_ctrl.o
> drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: ‘litex_soc_ctrl_of_match’ defined but not used [-Wunused-const-variable=]
>   143 | static const struct of_device_id litex_soc_ctrl_of_match[] = {
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~
> 
> $ rg "CONFIG_OF|CONFIG_LITEX_SOC_CONTROLLER" .config
> 1124:# CONFIG_OF is not set
> 4673:CONFIG_LITEX_SOC_CONTROLLER=y
> 
> This variable is used in two places in that file, in the
> MODULE_DEVICE_TABLE macro and the of_match_ptr macro. When CONFIG_OF is
> disabled, of_match_ptr evaluates to NULL. When the file is built into
> the kernel image, MODULE_DEVICE_TABLE evaluates to nothing, leaving this
> variable defined but unused in the final preprocessed source.
> 
> Hope that helps!

That helps, I noticed it was only used in those macros so that was fishy.  I
forgot to add W=1.

We will need to surround the definition in:

#if defined(CONFIG_OF)
#endif /* CONFIG_OF */

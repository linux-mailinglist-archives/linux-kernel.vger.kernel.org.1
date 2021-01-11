Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBBF2F1252
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbhAKMbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbhAKMbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:31:40 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DBDC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:31:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c132so12449841pga.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MQIcMMQr4fBdNn/n7xtKL3xisvfpOYXLZCgeqAib7vs=;
        b=thTK+QwCItEq3I8wVJHTDhKVF+aeXltkSBKfOLzbv/D9m5QIAWwaKkaoKdiYTY4K8+
         Y3RJUSTFLmCbcMvr5kUWy93Alha+ZQ4S1g57UWDQn1F1/FUwmsAGsUCwrDx2dZyKrWdq
         mhPv8BFd8fXzpewT18pQ6PwOQyz7WQbLvos9upnGg588eT73+baNrkn6m+qgM6xQPQ9y
         kvl71upblM+Bo1xCNtcNWXacB4adFJIe/fhrIcb5aGNv7EB46qKrCffuh0ZX9k0jQLCL
         aFX1oUD9kdoTgG2xy2KBTyIksq2eFU77+uG3xz0Yu9/saEdjPVYnzDhc9uRKF6eikoTV
         ZQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MQIcMMQr4fBdNn/n7xtKL3xisvfpOYXLZCgeqAib7vs=;
        b=bNW0E8WtMI3XAe9NmnFc5jfnOmp//39mWUC2+cgKJ0DA6avFJQT9FImXHQSzPemPTA
         OZQWCvspJoCwDSOFtHdMpd57wcaUP/AgmYruVHEnYNbs/IqW35e5ExwH1Kt4NrX5oY+Q
         Uu3k0dk1CdsZwOS1H5PLvIx+Rvnf9d+DDcZfd2iI3TCY527UCfhv/oeVuHiIbbjf3QB5
         sBQIsgt9Gl0DRcjrguasI7rkhABwAqy7eVBd/B/yWQXMMNKt6yZPp9Lp/3Lk3wbvg4w3
         ieCz32DiJISQ4gNbZr1nFGBq0fX3Oooye6BmQYqVU2RS41ylgYqsjJtDtbCeDaYVQGnK
         znJA==
X-Gm-Message-State: AOAM532e1PZHk0W1INFDS8qV8Adr7xJHYWZ+Vm/ggzhTXey9EygaDuYM
        k7AzUIBsEOhzZTDCf0ZVSuD0ExlgeH0=
X-Google-Smtp-Source: ABdhPJxy+MlzE0EMXskV1vPmdREUGxJMuIhI11lWSfTYkyn2ewh4mSqTwlafOO15NUQutvnsLBJYyA==
X-Received: by 2002:a65:64ce:: with SMTP id t14mr19691144pgv.36.1610368259531;
        Mon, 11 Jan 2021 04:30:59 -0800 (PST)
Received: from localhost (g178.219-103-173.ppp.wakwak.ne.jp. [219.103.173.178])
        by smtp.gmail.com with ESMTPSA id e5sm18420926pfc.76.2021.01.11.04.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 04:30:58 -0800 (PST)
Date:   Mon, 11 Jan 2021 21:30:55 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Mateusz Holenko <mholenko@antmicro.com>
Subject: Re: drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: unused
 variable 'litex_soc_ctrl_of_match'
Message-ID: <20210111123055.GA2002709@lianli.shorne-pla.net>
References: <202101070445.8Kz6oJcS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101070445.8Kz6oJcS-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 04:04:47AM +0800, kernel test robot wrote:
> Hi Pawel,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> commit: 22447a99c97e353bde8f90c2353873f27681d57c drivers/soc/litex: add LiteX SoC Controller driver
> date:   8 weeks ago
> config: x86_64-randconfig-a001-20210107 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5c951623bc8965fa1e89660f2f5f4a2944e4981a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=22447a99c97e353bde8f90c2353873f27681d57c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 22447a99c97e353bde8f90c2353873f27681d57c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: unused variable 'litex_soc_ctrl_of_match' [-Wunused-const-variable]
>    static const struct of_device_id litex_soc_ctrl_of_match[] = {
>                                     ^
>    1 warning generated.
> 
> 
> vim +/litex_soc_ctrl_of_match +143 drivers/soc/litex/litex_soc_ctrl.c
> 
>    142	
>  > 143	static const struct of_device_id litex_soc_ctrl_of_match[] = {
>    144		{.compatible = "litex,soc-controller"},
>    145		{},
>    146	};
>    147	
> 

I don't use clang but GCC, and I cannot reproduce this warning.

$ make drivers/soc/litex/litex_soc_ctrl.o 
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      drivers/soc/litex/litex_soc_ctrl.o

Also, I can see litex_soc_ctrl_of_match is used.  I am not sure what is going on
here.

-Stafford

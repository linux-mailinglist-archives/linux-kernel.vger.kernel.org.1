Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37F929A267
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 02:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504179AbgJ0Bxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 21:53:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35288 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504172AbgJ0Bxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 21:53:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id 140so10381531qko.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 18:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jaq2W3xchM9KI6J/OXjGhaLPINcfLLrG9R/EockJfhY=;
        b=amUt/D8WttPJoGNqqtqscorrRabLD8gwaJZVPtUFGCIDYjDk/Oc2wK+sV/tK+Fvunj
         RjGC4TO0Yf/T/Q7upACal38eL1ZoDRCti9nEq6a3Yp7tY7bR14xg0MAutHjQ6DaWuEHn
         IafR0rcaQhHR3cQ/2ROHVtTe1dt3BWGO6ndXSmWszovlqshd776slXQ2lx1cwYyM1M9P
         MPcU0YN9N06PSHjfXy7SpI9Zt31EuX1LNywA6Ao6ZDGGVoPQ7JTZZMIPxKHwX02K2dOj
         MaLiu+ZMIxteMu6EinFs3SBTHSZjceZa4Yfc1GArnMGsLpgITluqPZmIQpUQRD/exw6s
         x5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jaq2W3xchM9KI6J/OXjGhaLPINcfLLrG9R/EockJfhY=;
        b=VjLWGOSyOE8jRE7nffK1wEu9tBzglE4FToYEsjwTXTCV6cgTXeyoZp8KfkUCV1J+44
         3FWVSeMzF3FYOMmayx8T13muNNwfzdl2p3NUSw2tf0Mf5iQJSdfkkHNPSDzd5AsqDBWj
         FUqrc0Hy/gA2mDG6y2ZL1Ue4xB/8s0dt6iT+v/z2nkMXRGO6HAwIVIUUX76DgNwKL5G5
         f7fNX7l+o7L7uFPiGhrE7/fIUsrVm5gKMy+6I2M2PMcm5md78aEgEELhBOeJjtC060y6
         KZdilSGjeLAXAYclAPyWb+3hgAf4BYcGGAF8KEtzMLEWYQvrOcn1t/jDfjaMbKD1Vjnn
         OM7A==
X-Gm-Message-State: AOAM5326t3pqhYeiyD3iUyLUVXl7C+K7Q4SOEhspq8yjx63YbQLnQQj+
        iL8oHaoAm0svRxgaSi6XZ78=
X-Google-Smtp-Source: ABdhPJyjpu/1U3selnx44bdEwa8qooSewwyVPwM87ZQEKgstrdCD1o4lugou/nINyn3ITnfJZYS58w==
X-Received: by 2002:a37:6cc1:: with SMTP id h184mr16165qkc.18.1603763616750;
        Mon, 26 Oct 2020 18:53:36 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45d1:2600::3])
        by smtp.gmail.com with ESMTPSA id z2sm7788367qkl.22.2020.10.26.18.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 18:53:36 -0700 (PDT)
Date:   Mon, 26 Oct 2020 18:53:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [rcu:rcu/test 76/76] drivers/dax/super.c:21:1: error: use of
 undeclared identifier '___srcu_struct_ptrs'
Message-ID: <20201027015334.GA842991@ubuntu-m3-large-x86>
References: <202010270828.0bL3aIGL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010270828.0bL3aIGL-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Oct 27, 2020 at 08:50:52AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/test
> head:   784a6343c3660446ae62db13628b20e9f876100f
> commit: 784a6343c3660446ae62db13628b20e9f876100f [76/76] Merge commit '3650b22' into rcu/test
> config: arm-randconfig-r026-20201026 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project f2c25c70791de95d2466e09b5b58fc37f6ccd7a4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=784a6343c3660446ae62db13628b20e9f876100f
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu rcu/test
>         git checkout 784a6343c3660446ae62db13628b20e9f876100f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/dax/super.c:21:1: error: use of undeclared identifier '___srcu_struct_ptrs'
>    DEFINE_STATIC_SRCU(dax_srcu);
>    ^
>    include/linux/srcutree.h:135:34: note: expanded from macro 'DEFINE_STATIC_SRCU'
>    #define DEFINE_STATIC_SRCU(name)        __DEFINE_SRCU(name, static)
>                                            ^
>    include/linux/srcutree.h:127:13: note: expanded from macro '__DEFINE_SRCU'
>                    __section(___srcu_struct_ptrs) = &name
>                              ^
>    drivers/dax/super.c:70:6: warning: no previous prototype for function '__generic_fsdax_supported' [-Wmissing-prototypes]
>    bool __generic_fsdax_supported(struct dax_device *dax_dev,
>         ^
>    drivers/dax/super.c:70:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    bool __generic_fsdax_supported(struct dax_device *dax_dev,
>    ^
>    static 
>    drivers/dax/super.c:168:6: warning: no previous prototype for function '__bdev_dax_supported' [-Wmissing-prototypes]
>    bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
>         ^
>    drivers/dax/super.c:168:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
>    ^
>    static 
>    drivers/dax/super.c:452:6: warning: no previous prototype for function 'run_dax' [-Wmissing-prototypes]
>    void run_dax(struct dax_device *dax_dev)
>         ^
>    drivers/dax/super.c:452:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void run_dax(struct dax_device *dax_dev)
>    ^
>    static 
>    3 warnings and 1 error generated.

Please drop commit c1370c128cf4 ("srcu: Avoid escaped section names"),
it has been fixed in a different way as of v5.10-rc1, in
commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
to __section("foo")").

Cheers,
Nathan

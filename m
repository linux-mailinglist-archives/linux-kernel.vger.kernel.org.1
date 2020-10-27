Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7017029A34A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504966AbgJ0D0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443595AbgJ0D0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:26:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941D72075B;
        Tue, 27 Oct 2020 03:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603769209;
        bh=5BO0dwH6mf6ZgWS7FLZVrsB9fahdnICHgLW2RS33wP4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mzOK29ulXQMdDor/dDFbRSVWZv7C1j/m3b/tv0hQLFfDcpkkT6/RRFh1FNZKwIviv
         I6aOgCj1p940o+nVa8awe3olQS8XtP3k4uMNnvGZUKNFsSaN7TutYjllW8TCKX+255
         TIDIJPt6oCcczxLyRU8etN85ag+9GIo09RjVMGbs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 46C4C35226C8; Mon, 26 Oct 2020 20:26:49 -0700 (PDT)
Date:   Mon, 26 Oct 2020 20:26:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [rcu:rcu/test 76/76] drivers/dax/super.c:21:1: error: use of
 undeclared identifier '___srcu_struct_ptrs'
Message-ID: <20201027032649.GW3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202010270828.0bL3aIGL-lkp@intel.com>
 <20201027015334.GA842991@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027015334.GA842991@ubuntu-m3-large-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:53:34PM -0700, Nathan Chancellor wrote:
> Hi Paul,
> 
> On Tue, Oct 27, 2020 at 08:50:52AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/test
> > head:   784a6343c3660446ae62db13628b20e9f876100f
> > commit: 784a6343c3660446ae62db13628b20e9f876100f [76/76] Merge commit '3650b22' into rcu/test
> > config: arm-randconfig-r026-20201026 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project f2c25c70791de95d2466e09b5b58fc37f6ccd7a4)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=784a6343c3660446ae62db13628b20e9f876100f
> >         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> >         git fetch --no-tags rcu rcu/test
> >         git checkout 784a6343c3660446ae62db13628b20e9f876100f
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/dax/super.c:21:1: error: use of undeclared identifier '___srcu_struct_ptrs'
> >    DEFINE_STATIC_SRCU(dax_srcu);
> >    ^
> >    include/linux/srcutree.h:135:34: note: expanded from macro 'DEFINE_STATIC_SRCU'
> >    #define DEFINE_STATIC_SRCU(name)        __DEFINE_SRCU(name, static)
> >                                            ^
> >    include/linux/srcutree.h:127:13: note: expanded from macro '__DEFINE_SRCU'
> >                    __section(___srcu_struct_ptrs) = &name
> >                              ^
> >    drivers/dax/super.c:70:6: warning: no previous prototype for function '__generic_fsdax_supported' [-Wmissing-prototypes]
> >    bool __generic_fsdax_supported(struct dax_device *dax_dev,
> >         ^
> >    drivers/dax/super.c:70:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    bool __generic_fsdax_supported(struct dax_device *dax_dev,
> >    ^
> >    static 
> >    drivers/dax/super.c:168:6: warning: no previous prototype for function '__bdev_dax_supported' [-Wmissing-prototypes]
> >    bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
> >         ^
> >    drivers/dax/super.c:168:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
> >    ^
> >    static 
> >    drivers/dax/super.c:452:6: warning: no previous prototype for function 'run_dax' [-Wmissing-prototypes]
> >    void run_dax(struct dax_device *dax_dev)
> >         ^
> >    drivers/dax/super.c:452:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    void run_dax(struct dax_device *dax_dev)
> >    ^
> >    static 
> >    3 warnings and 1 error generated.
> 
> Please drop commit c1370c128cf4 ("srcu: Avoid escaped section names"),
> it has been fixed in a different way as of v5.10-rc1, in
> commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
> to __section("foo")").

Thank you, and will do!

							Thanx, Paul

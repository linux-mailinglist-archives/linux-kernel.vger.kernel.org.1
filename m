Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDC2AF8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgKKTRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKKTRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:17:45 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C2C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:17:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w14so2191679pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kf+IhFTPyZTTlDyox8J9Z56FZQkaP/Km5ujsS42dgok=;
        b=tEx3+cUwpvNtUnXA+bqYF3NXUS0j5gN2/ougmnipDqLgACJF4s3ejfqiAbeuTpvmEO
         EY3C89iv9krhYkV6TrYl6U/KGY00B5UYkLibz+LgYG7QtNLSDiKQDf9yHEKMWgY3ivwT
         2AJOgXzXrAt5yy/DSW+bdGrBWGsjMyv+ae/gQzYLe+FTHj6YqzFQ8QQQB+rgdxZgeKi0
         w0lnt3qSYAJrVcLwBCgHY4Ub0JXohx7gYOL2iP9pe8/6TpVdh43ZGoWFb8+dAXt7Y4sd
         DRuUIMOSMNhfFg7fxGJN8eVjsHnDGX9drsU6dSrt/4DkfIP0lQK/FWcH7nGZYxdNRwJi
         jBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kf+IhFTPyZTTlDyox8J9Z56FZQkaP/Km5ujsS42dgok=;
        b=AmYG14TAdrVZWRbtmZJbJm34lA+3k5tJhHOHiRsDHHn39SB4fnMYNjEZFdnWhWkp2Q
         PZESQvnCJUEJVgHYQpgRfKVZ/6Av738FVUgprZMVKCFACj7iIUDQ8WcuJyuCjJewcqWZ
         0QdYvkhdvZdBVrY7pyvWQxvSBiB4te2E6WhusEHUeRZ8X/hIHRKopLuYe2jvPyq4K0pV
         FmTNgapfNDzgLyHCMeP8QZFkK9TnyPwmKQNd4o8GkYxLGFPMah17Npf1K5wbNMwxDNxm
         qWwRYuHbK2Vd03MDGYNknpFHsdcKG/VdbmrKMYTdStc4AfKu1oKpd/cY+P3RMLIlGxa6
         YeUg==
X-Gm-Message-State: AOAM530EOIIYic1kisMGQfZCWQqdxmRjyz9N230s0mIjUqhkLJFbb29e
        QpM4Sq06of/uXJCrk3j3/jUBz5Ns7WF0HdEpgmYFFw==
X-Google-Smtp-Source: ABdhPJyWI+iv0mpwXh4n2G44NuK2sizsE1TMXA5YEpHr0ZeLQUW1UTYfj1SrIugsYjKPRd4wKItX2anUbiXFvCq47SE=
X-Received: by 2002:a63:b55e:: with SMTP id u30mr22270319pgo.381.1605122265157;
 Wed, 11 Nov 2020 11:17:45 -0800 (PST)
MIME-Version: 1.0
References: <202011111359.9269wNfz-lkp@intel.com>
In-Reply-To: <202011111359.9269wNfz-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 Nov 2020 11:17:33 -0800
Message-ID: <CAKwvOd==c6XLZaVXECet6pfVLTLaBDbH-J0xKVR4QvkLXCiHWQ@mail.gmail.com>
Subject: Re: arch/s390/include/asm/atomic_ops.h:56:45: error: invalid operand
 for inline asm constraint 'i'
To:     kernel test robot <lkp@intel.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Ulrich, Jonas

On Tue, Nov 10, 2020 at 9:29 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Vasily,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   eccc876724927ff3b9ff91f36f7b6b159e948f0c
> commit: f0cbd3b83ed47803df941865f720934c69abb803 s390/atomic: circumvent gcc 10 build regression
> date:   3 months ago
> config: s390-randconfig-r013-20201110 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 4d81c8adb6ed9840257f6cb6b93f60856d422a15)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f0cbd3b83ed47803df941865f720934c69abb803
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout f0cbd3b83ed47803df941865f720934c69abb803
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/tty/tty_buffer.c:8:
>    In file included from include/linux/tty.h:5:
>    In file included from include/linux/fs.h:6:
>    In file included from include/linux/wait_bit.h:8:
>    In file included from include/linux/wait.h:7:
>    In file included from include/linux/list.h:9:
>    In file included from include/linux/kernel.h:12:
>    In file included from include/linux/bitops.h:29:
>    In file included from arch/s390/include/asm/bitops.h:39:
> >> arch/s390/include/asm/atomic_ops.h:56:45: error: invalid operand for inline asm constraint 'i'
>    __ATOMIC_CONST_OPS(__atomic_add_const, int, "asi")
>                                                ^
>    1 error generated.
>
> vim +/i +56 arch/s390/include/asm/atomic_ops.h
>
> 126b30c3cb476c Martin Schwidefsky 2016-11-11  51
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  52  #define __ATOMIC_CONST_OPS(op_name, op_type, op_string)                       \
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  53        __ATOMIC_CONST_OP(op_name, op_type, op_string, "\n")            \
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  54        __ATOMIC_CONST_OP(op_name##_barrier, op_type, op_string, "bcr 14,0\n")
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  55
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24 @56  __ATOMIC_CONST_OPS(__atomic_add_const, int, "asi")
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  57  __ATOMIC_CONST_OPS(__atomic64_add_const, long, "agsi")
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  58
>
> :::::: The code at line 56 was first introduced by commit
> :::::: eb3b7b848fb3dd00f7a57d633d4ae4d194aa7865 s390/rwlock: introduce rwlock wait queueing
>
> :::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
> :::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202011111359.9269wNfz-lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers

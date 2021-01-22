Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0F2FFD16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAVHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbhAVHJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:09:10 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE53C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:08:05 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 143so4255579qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vmMfFppZkK3hlDi2fZ5GjzFDLVbQdDDB/UVAy+8OTqM=;
        b=qOlTtoh2ifp+vrwRLafKlcs7u7ow24t42sgGQN5CvjSZon7wGrZrI1Xf5/ECoxpE+B
         qwbVUeA2APICKw8L+0wS+Wo1yluh7e/BzZyMJH43dcSdP+bjDHkPE1+K+qHnCcHhcJrW
         UslHNuEL9Qbhn+9A9hO/+LqQ7iYoy18ojTq4wwSwijTRWxWMGt2dGYmF1pUpStznpwHJ
         UXPnc4Dds4pzfjntl/e9KBAJtdkNf6MGmqvKjOrUr6iCbQCj5Mdp9zfD1qZJH3XlP2/r
         mJJRpoj5spiYpeYubvZnFQF0JCEqz5+5pEg7I8mGhsVYTq58Z7H0XBv0wv23CNmkJ4OZ
         mYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vmMfFppZkK3hlDi2fZ5GjzFDLVbQdDDB/UVAy+8OTqM=;
        b=bnciBnSLmqP8SSm5JpgxoN3GwcWXCW+F1iDb9S7+5Lb4RW8YmUTbitKMPpK8sEDGOM
         TZQKaU4+JQxzBpWe2ouF9zYUOoBi+U9YkKOBT8prrKp8K/oF2/lAzeRBbVTIi/2mEVFf
         IY7kTA5+wIvUbZcPqt3KTdUX4HZ1kXhsjfYLiR7RRjj5iyzCKFA2qi7wQEgXN1xSZSD4
         PY65OePaObGh23UVm1cBwfjkW8tkcYBYaWkeasvK5JbOQ9yyWhA1mFL1LsD8tvA0/rZe
         TTaeHnGQjC6Vd0k9QLUsOuXbS+pHq/JWZsjNWqdIad0xAdQ3m3Axme1xih4abDUtxRP7
         YYkA==
X-Gm-Message-State: AOAM5314sfBb9Fp+CeRTKVyQ+BoKhTJbLai0ayU+kbbgFkbUt7tazW4Z
        9uD16Cw6X+8tqRvsQRjm9P8=
X-Google-Smtp-Source: ABdhPJzKx/9coP2XhSdhGhY7f4egl552OTbbUZkQxzjIoieZ0l+Ew7yL9ZuJAvlIpBt5ZPHXGr7Ahg==
X-Received: by 2002:a05:620a:16d5:: with SMTP id a21mr3629728qkn.188.1611299284630;
        Thu, 21 Jan 2021 23:08:04 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id c7sm5548702qkm.99.2021.01.21.23.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 23:08:03 -0800 (PST)
Date:   Fri, 22 Jan 2021 00:08:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: arch/riscv/kernel/vdso/vdso-syms.S:2: Error: junk at end of
 line, first unrecognized character is `@'
Message-ID: <20210122070802.GA3498705@ubuntu-m3-large-x86>
References: <202101220925.JILgZfQl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101220925.JILgZfQl-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 09:41:35AM +0800, kernel test robot wrote:
> Hi Palmer,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9f29bd8b2e7132b409178d1367dae1813017bd0e
> commit: c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c RISC-V: Fix the VDSO symbol generaton for binutils-2.35+
> date:   3 months ago
> config: riscv-randconfig-r002-20210122 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project bd3a387ee76f58caa0d7901f3f84e9bb3d006f27)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/riscv/kernel/vdso/vdso-syms.S: Assembler messages:
> >> arch/riscv/kernel/vdso/vdso-syms.S:2: Error: junk at end of line, first unrecognized character is `@'
>    arch/riscv/kernel/vdso/vdso-syms.S:4: Error: junk at end of line, first unrecognized character is `@'
>    arch/riscv/kernel/vdso/vdso-syms.S:6: Error: junk at end of line, first unrecognized character is `@'
>    arch/riscv/kernel/vdso/vdso-syms.S:8: Error: junk at end of line, first unrecognized character is `@'
>    arch/riscv/kernel/vdso/vdso-syms.S:10: Error: junk at end of line, first unrecognized character is `@'
>    arch/riscv/kernel/vdso/vdso-syms.S:12: Error: junk at end of line, first unrecognized character is `@'
>    clang-12: error: assembler command failed with exit code 1 (use -v to see invocation)
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

I believe this is https://github.com/ClangBuiltLinux/linux/issues/1266.

Cheers,
Nathan

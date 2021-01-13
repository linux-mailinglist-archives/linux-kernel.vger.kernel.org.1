Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261382F413C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbhAMBcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbhAMBcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:32:13 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F35C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:31:33 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z11so274233qkj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fq9Plgov79IhfrzoAKOz8rulKlgb6ke/+f1nKnQxxW0=;
        b=Z5V6pwugh8tpNgcEBRyoj+Y6Z5AJg6B0zPtKXl64DjRA3KzMducbX7nTwFGIAMeinn
         OJ5UxJDRPPgeiEUD59NOxYKDcmjU681HofoD+pZcTdXdjrOBGK2zYONOtnVArf4hSNbp
         bDMD5G67TN8/sI+6XN8v6ysAMejiveE29xmXw6Xa46Yl5Tx0avjB9U0g0iwKzH6IoJnr
         2rDY2OpNlgN8LdWGEg8JHBWD9ge1MPbVDdh7vs7kF9HwTmomO1vt0YzodX8tAh/cM0+Z
         ajsVUggdrrI7vUnD2vPsd8rt0PU6ko1ygWfTPs+GUMDk0eoq3v4MpHiy1+2KGCqQ21w8
         cSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fq9Plgov79IhfrzoAKOz8rulKlgb6ke/+f1nKnQxxW0=;
        b=tsqDxU+wLCDqcgr2rxBLP1kZTu5tUsoymG8VCFNU/1X2tjSm7NwuEIpCP0UC2HCQ5z
         juDuBTwe38lw5o/TqoiORMQH7q0DdIew/9BnhUfJzK250dFDk2hCT01jZZRNuTI82cIK
         9dgGnNNVoEXJEQZVu/laCrp9B8JSa6yu1Cm64YdltAJEq6nNcw6IKI3kzOLEfxG7bR7U
         Ij9eb9m/A+ZSOW8IqmTWWMgDROwMNGz6EYAi5aS+4depmlA1ZpuWGaq4+ibcQvtGJeK2
         opVMlPjzZWwJGonm9s+JpxNuOhd7GzGLOpslSe8YOuuLSBXRbF5KX90a+KCWwMlJqEeY
         ZKpg==
X-Gm-Message-State: AOAM532XK0/pCb2V1J6pkbHGPHAxOnWVcFafERYHSNsAdjRQLmDXfgEE
        F9nNWJis4fS9N0vVkxYd1hM=
X-Google-Smtp-Source: ABdhPJxLwlEhkHUnqWeAiKaHu6jH5hxYS83PqqIV5mX9qhLsuLjCu2BU4yHY7ertRC4ihze41+Gy6A==
X-Received: by 2002:a37:9b8a:: with SMTP id d132mr2556778qke.81.1610501492549;
        Tue, 12 Jan 2021 17:31:32 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id p15sm248369qtu.26.2021.01.12.17.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 17:31:31 -0800 (PST)
Date:   Tue, 12 Jan 2021 18:31:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
Message-ID: <20210113013130.GA3446359@ubuntu-m3-large-x86>
References: <20210112205542.1375847-1-natechancellor@gmail.com>
 <202101130859.JSORPQUn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101130859.JSORPQUn-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 08:39:52AM +0800, kernel test robot wrote:
> Hi Nathan,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on 7c53f6b671f4aba70ff15e1b05148b10d58c2837]
> 
> url:    https://github.com/0day-ci/linux/commits/Nathan-Chancellor/ubsan-Implement-__ubsan_handle_alignment_assumption/20210113-055714
> base:    7c53f6b671f4aba70ff15e1b05148b10d58c2837
> config: arm64-randconfig-r031-20210112 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 32bcfcda4e28375e5a85268d2acfabcfcc011abf)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/775adad26a60878926c0ee6cd460a1375bbe51e6
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Nathan-Chancellor/ubsan-Implement-__ubsan_handle_alignment_assumption/20210113-055714
>         git checkout 775adad26a60878926c0ee6cd460a1375bbe51e6
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    lib/ubsan.c:192:6: warning: no previous prototype for function '__ubsan_handle_add_overflow' [-Wmissing-prototypes]
>    void __ubsan_handle_add_overflow(void *data,
>         ^
>    lib/ubsan.c:192:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void __ubsan_handle_add_overflow(void *data,
>    ^
>    static 
>    lib/ubsan.c:200:6: warning: no previous prototype for function '__ubsan_handle_sub_overflow' [-Wmissing-prototypes]
>    void __ubsan_handle_sub_overflow(void *data,
>         ^
>    lib/ubsan.c:200:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void __ubsan_handle_sub_overflow(void *data,
>    ^

Given that these are compiler inserted functions, there is not much of a
point to having prototypes to them. If people feel shutting these
warnings up is worthwhile, we can just add the prototypes right above
the function definition in a follow up patch.

Cheers,
Nathan

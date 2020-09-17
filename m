Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95F26DC95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIQNOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:14:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60177 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgIQNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:12:48 -0400
X-Greylist: delayed 1059 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 09:12:47 EDT
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kItR7-0003qS-OW
        for linux-kernel@vger.kernel.org; Thu, 17 Sep 2020 12:54:53 +0000
Received: by mail-oo1-f71.google.com with SMTP id r3so1094710ooq.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qvtx1Dw39OYs5aOUHC+fg8agAEsZenZTX5vKZkyOU9s=;
        b=UKIg4KsWrs7nWIBIl664a1tV225suOlsAw5ln7EADsojNib3EQPxJ79ciXTZKNj6fc
         pFFW/wWbgCyk0PFflpdZdOyen28ahoUo5yfPIksazkl+1KGAPZzW3cwn5dWbbfTVLUsB
         1CtygcOdX/4Ie3HxezlN5H1d9foYRjYA5H59iBm32wqMHHQ5R307KUTt/uIqyVR/JwxI
         WJh/qDTRBWOUO6OmVHeI0KsEF/cXwujdQx7XXMcGRXVQka5olO04FYOI6dmuwsDMoNbH
         2lzJwy02wQyZRosinCA2o8ozKBZhocKbNBWwr5xka9AM9ixW8xcduKdB0CSCuSXG4wyR
         Uskw==
X-Gm-Message-State: AOAM532k0m8lG6J5akyXP9/uDmG811L+EiM3tK9ahXBPXhH92HWJDc2V
        W3d3DvQ34oose9MwkDD7EYb6lDmG5ObR8QsW2VE4CvwS5jOjqYgTZuUBj2zx83AdqJsKHhJF7Yi
        NvCrRIRi8t2gs9c5u+CkIndr78FkQ821cC4KpTONH+g==
X-Received: by 2002:aca:843:: with SMTP id 64mr6229923oii.135.1600347292700;
        Thu, 17 Sep 2020 05:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh6KjccBZl5W9X0X9YrClsArM7xybnlSW3VEUFeKIhv9qqHi6wD4If97szIyRO4rGFle9HYQ==
X-Received: by 2002:aca:843:: with SMTP id 64mr6229907oii.135.1600347292463;
        Thu, 17 Sep 2020 05:54:52 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:c48f:8c0b:cb29:e546])
        by smtp.gmail.com with ESMTPSA id s196sm11797740oih.26.2020.09.17.05.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 05:54:51 -0700 (PDT)
Date:   Thu, 17 Sep 2020 07:54:50 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: resolve_btfids breaks kernel cross-compilation
Message-ID: <20200917125450.GC4820@ubuntu-x1>
References: <20200916194733.GA4820@ubuntu-x1>
 <20200917080452.GB2411168@krava>
 <20200917083809.GE2411168@krava>
 <20200917091406.GF2411168@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917091406.GF2411168@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:14:06AM +0200, Jiri Olsa wrote:
> On Thu, Sep 17, 2020 at 10:38:12AM +0200, Jiri Olsa wrote:
> > On Thu, Sep 17, 2020 at 10:04:55AM +0200, Jiri Olsa wrote:
> > > On Wed, Sep 16, 2020 at 02:47:33PM -0500, Seth Forshee wrote:
> > > > The requirement to build resolve_btfids whenever CONFIG_DEBUG_INFO_BTF
> > > > is enabled breaks some cross builds. For example, when building a 64-bit
> > > > powerpc kernel on amd64 I get:
> > > > 
> > > >  Auto-detecting system features:
> > > >  ...                        libelf: [ [32mon[m  ]
> > > >  ...                          zlib: [ [32mon[m  ]
> > > >  ...                           bpf: [ [31mOFF[m ]
> > > >  
> > > >  BPF API too old
> > > >  make[6]: *** [Makefile:295: bpfdep] Error 1
> > > > 
> > > > The contents of tools/bpf/resolve_btfids/feature/test-bpf.make.output:
> > > > 
> > > >  In file included from /home/sforshee/src/u-k/unstable/tools/arch/powerpc/include/uapi/asm/bitsperlong.h:11,
> > > >                   from /usr/include/asm-generic/int-ll64.h:12,
> > > >                   from /usr/include/asm-generic/types.h:7,
> > > >                   from /usr/include/x86_64-linux-gnu/asm/types.h:1,
> > > >                   from /home/sforshee/src/u-k/unstable/tools/include/linux/types.h:10,
> > > >                   from /home/sforshee/src/u-k/unstable/tools/include/uapi/linux/bpf.h:11,
> > > >                   from test-bpf.c:3:
> > > >  /home/sforshee/src/u-k/unstable/tools/include/asm-generic/bitsperlong.h:14:2: error: #error Inconsistent word size. Check asm/bitsperlong.h
> > > >     14 | #error Inconsistent word size. Check asm/bitsperlong.h
> > > >        |  ^~~~~
> > > > 
> > > > This is because tools/arch/powerpc/include/uapi/asm/bitsperlong.h sets
> > > > __BITS_PER_LONG based on the predefinied compiler macro __powerpc64__,
> > > > which is not defined by the host compiler. What can we do to get cross
> > > > builds working again?
> > > 
> > > could you please share the command line and setup?
> > 
> > I just reproduced.. checking on fix
> 
> I still need to check on few things, but patch below should help

It does help with the word size problem, thanks.

> we might have a problem for cross builds with different endianity
> than the host because libbpf does not support reading BTF data
> with different endianity, and we get:
> 
>   BTFIDS  vmlinux
> libbpf: non-native ELF endianness is not supported

Yes, I see this now when cross building for s390.

Thanks,
Seth

> 
> jirka
> 
> 
> ---
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index a88cd4426398..d3c818b8d8d3 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  include ../../scripts/Makefile.include
> +include ../../scripts/Makefile.arch
>  
>  ifeq ($(srctree),)
>  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> @@ -29,6 +30,7 @@ endif
>  AR       = $(HOSTAR)
>  CC       = $(HOSTCC)
>  LD       = $(HOSTLD)
> +ARCH     = $(HOSTARCH)
>  
>  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
>  
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD14302D37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbhAYVFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:05:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:42891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732419AbhAYVBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611608393;
        bh=GS2SqmZoo1tKDzhaBtPEacjl0sbq+XTvYs0KINWX7Kw=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:Date:In-Reply-To;
        b=dM9APaUBhidvSRDQmgtqbMYfpzy0MdEBpu3a6PlA9fsfrDkb73PDvXdTSflZ3U+BR
         1L+knf1bvKO9PphXwjzhZpuwQdE3xj3xBw8Iqekzfq9UAW6tKSsqSh0qTplMQeyHZu
         QAu1xbCv0JumOEtbEOLiSE9W1t5p0K7O6K/TSq+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.109]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDnI-1l94eV02TW-00Cm3I; Mon, 25
 Jan 2021 21:59:53 +0100
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
Cc:     John David Anglin <dave.anglin@bell.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <202101162230.XswE8zOX-lkp@intel.com>
 <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
 <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
 <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
 <20210125204720.GA28462@ls3530.fritz.box>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <4bdf35de-f804-4e9d-cde9-cc6785840a60@gmx.de>
Date:   Mon, 25 Jan 2021 21:59:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210125204720.GA28462@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:98Ex2RBc7xDCHg8rBbMZOgBxGuGEdHQD097HPRackJ4tGJZIFsY
 hcP/A49XqweDR9i2FJ0tJOZaK5tXCQPK8icsJHdo/zVUIOIqubtYwHJrG6TcH548RwxCe1x
 Gmnl/j50ObNxRedb0Fwi1n+IRpJ2p1Zw+YUqXUWPuZlThOyJBwS632Zxffvkprx4vrPA7P6
 qgWk4xEXKQm+1YQFEA89A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EGWYKlnlBCs=:u9R9Lm8BVPh5W9krE4Ac4Z
 fZ2iUPhylL+hIE3dxYE+fh2tyt7EJQJ6vXTmVdouu4+1DJNTEp6GrDDhYUorMaY4XycVB2dBV
 4JIHr7xQcQXJgu5IDVcci58Oe/yQ/4df7Xbczmqqz/FJPwnp7peJcY6dpgN+upg0m5uU6wLPo
 u6Tavxb3azoQzfQxaRCqgJ9/E2uKZ44HdcYJ77/Wpd0njNnYEt1YM5z0/fU5NsbyG6WGuGmDz
 QupDBqPP0wB6EImWDFKDjIBUaGZWpgw7eOoTqa0TvqavSKGqf3/IsWZj/D0TQca66E6JqI7fe
 I9K835zT/RUq1aQp0WNk3m2FXqrujVsk/xXnn1PPvqjy0sQSuaAOv6JXsDpo+722rZsMIhsPm
 eRfjxYAuOmYot6ZSvHwWj7IWYP2O4MXsMmfW8B1JpEWGdcwPwFqNPR1/mZ/wX2I5IG2AOXuKM
 Q2Tc6hY4IZvzwMgEF45A3jiT6KxFXx+Me8kquacpKU0/I49Tn9jAam3V5x7EbtXCRutKJkySm
 V9XKqRvnCSJo7suKwavOvp8013ugvLq50zLWs81LcewpFtAvCWbGmiGn9zmEhv6Qm4dSxGnds
 dYhYrcut9gu3j/DdYM1WvNDb95K/cdE5EHOxwm0pZSlthFq7rVgAJYYbH4o1bgfkeGw/uzKE3
 J+hfkwRNH90YBb/04IRf99KdVzXLY7Ozz/EMrhnXNSwyGx8a7XajlnSjw0rGzr9AjjC8dpCun
 JKhL8M99BLY1WYrm/PVBH4yVPTdXyK07ivqEt7cTfWXumNjRwRSDIn94XtQDq0EbZf991FlY1
 fTVADz9jM+TpKaJ5TENR4s6zmknijlZSIk1hNiuNA37I9/g5suW7zGss9gKobdvLCX3vWUyyX
 XY4N9yMQJ16xB3kchJ1Q==
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:47 PM, Helge Deller wrote:
>>>> On Sat, Jan 16, 2021 at 6:37 AM kernel test robot <lkp@intel.com> wro=
te:
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git master
>>>>> head:   1d94330a437a573cfdf848f6743b1ed169242c8a
>>>>> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add =
PGO and AutoFDO input sections
>>>>> date:   5 months ago
>>>>> config: parisc-randconfig-r032-20210116 (attached as .config)
>>>>> compiler: hppa64-linux-gcc (GCC) 9.3.0
>>>>> reproduce (this is a W=3D1 build):
>>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/maste=
r/sbin/make.cross -O ~/bin/make.cross
>>>>>         chmod +x ~/bin/make.cross
>>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/commit/?id=3Deff8728fe69880d3f7983bec3fb6cea4c306261f
>>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/ke=
rnel/git/torvalds/linux.git
>>>>>         git fetch --no-tags linus master
>>>>>         git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
>>>>>         # save the attached .config to linux build tree
>>>>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make=
.cross ARCH=3Dparisc
>>>>>
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>> All errors (new ones prefixed by >>):
>>>>>
>>>>>    hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x110): cannot reach u=
nknown
>>>>>    hppa64-linux-ld: mm/memblock.o(.text+0x27c): cannot reach __warn_=
printk
>>>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xc4): cannot reach =
printk
> ....
>
> The problem with this .config is, that both CONFIG_MODULES and
> CONFIG_MLONGCALLS are set to "n".
> The Kconfig autodetection needs fixing to enable CONFIG_MLONGCALLS in
> this case.
>
>
> This patch fixes it for me:
>
> [PATCH] Require -mlong-calls gcc option for !CONFIG_MODULES
>
> When building a kernel without module support, the CONFIG_MLONGCALL
> option needs to be enabled. This patch fixes the autodetection in the
> Kconfig script and uses a far call to preempt_schedule_irq() in
> intr_do_preempt().
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reported-by: kernel test robot <lkp@intel.com>

There's a small bug in the code below:
	BL	preempt_schedule_irq
needs to be
	BL	preempt_schedule_irq, %r0

I'll do some more testing and will push the final version
through the parisc tree.

Helge


> ---
>
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 78b17621ee4a..278462186ac4 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -202,9 +202,8 @@ config PREFETCH
>  	depends on PA8X00 || PA7200
>
>  config MLONGCALLS
> -	bool "Enable the -mlong-calls compiler option for big kernels"
> -	default y if !MODULES || UBSAN || FTRACE
> -	default n
> +	def_bool y if !MODULES || UBSAN || FTRACE
> +	bool "Enable the -mlong-calls compiler option for big kernels" if MODU=
LES && !UBSAN && !FTRACE
>  	depends on PA8X00
>  	help
>  	  If you configure the kernel to include many drivers built-in instead
> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
> index beba9816cc6c..6320f6a8397c 100644
> --- a/arch/parisc/kernel/entry.S
> +++ b/arch/parisc/kernel/entry.S
> @@ -997,10 +997,19 @@ intr_do_preempt:
>  	bb,<,n	%r20, 31 - PSW_SM_I, intr_restore
>  	nop
>
> -	BL	preempt_schedule_irq, %r2
> -	nop
> +	/* ssm PSW_SM_I done later in intr_restore */
> +#ifdef CONFIG_MLONGCALLS
> +	ldil    L%intr_restore, %r2
> +	load32	preempt_schedule_irq, %r1
> +	bv	%r0(%r1)
> +	ldo     R%intr_restore(%r2), %r2
> +#else
> +	ldil    L%intr_restore, %r2
> +	BL	preempt_schedule_irq
> +	ldo     R%intr_restore(%r2), %r2
> +#endif
> +
>
> -	b,n	intr_restore		/* ssm PSW_SM_I done by intr_restore */
>  #endif /* CONFIG_PREEMPTION */
>
>  	/*
>
>


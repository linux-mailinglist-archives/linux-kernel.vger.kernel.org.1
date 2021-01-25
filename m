Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F83302CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbhAYUuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:50:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:57591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbhAYUtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611607645;
        bh=DAY+WNigKLP4mWxKBRyZ6pV9pUohQsqcFCCfAJl5jnQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZFpw9cjeN+QHcEGTYvCwSQEhe1FeEkJGEq6eJIV8uYT478zL1/qOYVwcTt9UxZL1D
         S80qbzik4yR55QSqx2eGRSOpQOyEsIoySdZoN6ydDGjpJo5Oora8sbHbsfi2HKfXFm
         AZ4tPytxYA0JTA6jY+9sbKTR89NC9XrFXIQqSorA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.169.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1lWEH122pe-00Xccd; Mon, 25
 Jan 2021 21:47:25 +0100
Date:   Mon, 25 Jan 2021 21:47:20 +0100
From:   Helge Deller <deller@gmx.de>
To:     Helge Deller <deller@gmx.de>
Cc:     John David Anglin <dave.anglin@bell.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
Message-ID: <20210125204720.GA28462@ls3530.fritz.box>
References: <202101162230.XswE8zOX-lkp@intel.com>
 <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
 <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
 <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
X-Provags-ID: V03:K1:i4tezV9kgFY/JQWRhziV6Id6z88ZZuqWXAylzYQNUEw7yjIjk3q
 czv+jEPIziOaKditysLk/KuE232Ax/k6KnxnrmXzUPtWY9CBCoWYY5NWcW6C4Fyxl+sEyUU
 b6m/6Lwy0a/mK2e/Z3CeUmv9qqfPob2B6M/AfkZGsaXdpfBDYSKhBWedjfhGjvc7SZC75CA
 knmiDY6ITKIVrenMWIq6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YTPN/gwnEMQ=:iNNJmUyzg+g6k55/gec/tu
 Uak8apdmTnCha0+zjIBK/zQtOkEsFXF/xuj2lZwpDv4iB7XVcw3o0q7YVhakNzNBE8G2btfaK
 9H+M7/QI4uecvnpBzdsyzIMCajW/T+dAMOJI2nuPgbBFlJWhIixw5WiCGzNTA8ioNQF04g55R
 B6/l0hECykOiY9DE+v0driR0zdqgipfvdntH+lMNLN03raqH6mNTHqZ/gbWpWhdolt+W3NHW9
 8kWt01g++D1ByrjtP6Yk4LVLgPNXHfyw2v61qIDq3wGpygFOi4WHwot87JhjDFbYY8vGZ1+Di
 bGzmbJDlc+S/iRSXEQPa90cq9L8XZs4FXaXHWMUIioibby4K5kRLLcaU2xJRpCYM97yxnXn+n
 dkWEko1rKicoeqCkzTesWz0kVE/fgKn07JtLWgXOnYEQjcyCaiGcEzWmemNWiwq6OsBtj4iQN
 KdS3njUFNN/tydq97aK4qoqPl926jYYAN0Edk25zPVclY+QK2WFVEhwrMhOtryR+byrj/Uv/E
 YJ0YVbivhAPkiV6OueCeAdG7QOCjfGeJ1vyUdau/7Wm8FDN2/JQkN5vvVUYPcnpPICC7eROJN
 k90SAFmA0mVO0t1z4RdLAmh7bQH4Tb5RSPBsYNbic+MNrnxpW3OHK5yWqu4AGyNd+vbYOtv7T
 BjmErwxz21bclcmZToxFRrm2WSdq46Af8uiGssAG8iQr7MChcAxBbbY5ACvmPeqpLA3A+rNBb
 axN6A5gUu6aZx4w3J44ArEx8zlxvC9DkBIc4Qs+OojRUpgWRurbLzUlZT8+CthRyhkhVKKq3D
 tdaUUSqFmokDwB1nXcTK0F0ZOGq6+SpXpvr+qzyWKmoa13dg1u74iNQxDoDuAB9YdWnCYZepI
 v59Kr/JYToYqiE+y+tZA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> On Sat, Jan 16, 2021 at 6:37 AM kernel test robot <lkp@intel.com> wro=
te:
> >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git master
> >>> head:   1d94330a437a573cfdf848f6743b1ed169242c8a
> >>> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add =
PGO and AutoFDO input sections
> >>> date:   5 months ago
> >>> config: parisc-randconfig-r032-20210116 (attached as .config)
> >>> compiler: hppa64-linux-gcc (GCC) 9.3.0
> >>> reproduce (this is a W=3D1 build):
> >>>         wget https://raw.githubusercontent.com/intel/lkp-tests/maste=
r/sbin/make.cross -O ~/bin/make.cross
> >>>         chmod +x ~/bin/make.cross
> >>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/commit/?id=3Deff8728fe69880d3f7983bec3fb6cea4c306261f
> >>>         git remote add linus https://git.kernel.org/pub/scm/linux/ke=
rnel/git/torvalds/linux.git
> >>>         git fetch --no-tags linus master
> >>>         git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
> >>>         # save the attached .config to linux build tree
> >>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make=
.cross ARCH=3Dparisc
> >>>
> >>> If you fix the issue, kindly add following tag as appropriate
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>>
> >>> All errors (new ones prefixed by >>):
> >>>
> >>>    hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x110): cannot reach u=
nknown
> >>>    hppa64-linux-ld: mm/memblock.o(.text+0x27c): cannot reach __warn_=
printk
> >>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xc4): cannot reach =
printk
....

The problem with this .config is, that both CONFIG_MODULES and
CONFIG_MLONGCALLS are set to "n".
The Kconfig autodetection needs fixing to enable CONFIG_MLONGCALLS in
this case.


This patch fixes it for me:

[PATCH] Require -mlong-calls gcc option for !CONFIG_MODULES

When building a kernel without module support, the CONFIG_MLONGCALL
option needs to be enabled. This patch fixes the autodetection in the
Kconfig script and uses a far call to preempt_schedule_irq() in
intr_do_preempt().

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: kernel test robot <lkp@intel.com>

=2D--

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 78b17621ee4a..278462186ac4 100644
=2D-- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -202,9 +202,8 @@ config PREFETCH
 	depends on PA8X00 || PA7200

 config MLONGCALLS
-	bool "Enable the -mlong-calls compiler option for big kernels"
-	default y if !MODULES || UBSAN || FTRACE
-	default n
+	def_bool y if !MODULES || UBSAN || FTRACE
+	bool "Enable the -mlong-calls compiler option for big kernels" if MODULE=
S && !UBSAN && !FTRACE
 	depends on PA8X00
 	help
 	  If you configure the kernel to include many drivers built-in instead
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index beba9816cc6c..6320f6a8397c 100644
=2D-- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -997,10 +997,19 @@ intr_do_preempt:
 	bb,<,n	%r20, 31 - PSW_SM_I, intr_restore
 	nop

-	BL	preempt_schedule_irq, %r2
-	nop
+	/* ssm PSW_SM_I done later in intr_restore */
+#ifdef CONFIG_MLONGCALLS
+	ldil    L%intr_restore, %r2
+	load32	preempt_schedule_irq, %r1
+	bv	%r0(%r1)
+	ldo     R%intr_restore(%r2), %r2
+#else
+	ldil    L%intr_restore, %r2
+	BL	preempt_schedule_irq
+	ldo     R%intr_restore(%r2), %r2
+#endif
+

-	b,n	intr_restore		/* ssm PSW_SM_I done by intr_restore */
 #endif /* CONFIG_PREEMPTION */

 	/*



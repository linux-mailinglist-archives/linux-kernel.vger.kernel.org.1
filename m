Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973F427F619
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgI3XmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:42:20 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:58822 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgI3XmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:42:13 -0400
Date:   Wed, 30 Sep 2020 19:42:12 -0400
From:   Rich Felker <dalias@libc.org>
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>, musl@lists.openwall.com
Subject: Re: [musl] [PATCH 1/1] linux/sysinfo.h: Add guarder for struct
 sysinfo
Message-ID: <20200930234212.GK17637@brightrain.aerifal.cx>
References: <20200930214636.186132-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930214636.186132-1-petr.vorel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:46:36PM +0200, Petr Vorel wrote:
> for all but glibc libc.
> 
> This fixes redefinition on MUSL which also defines struct sysinfo when
> including <linux/netlink.h> (which includes <linux/sysinfo.h> via
> <linux/kernel.h>) and <sys/sysinfo.h>.
> 
> glibc loads <linux/sysinfo.h> in <sys/sysinfo.h>.
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  include/uapi/linux/sysinfo.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> index 435d5c23f0c0..c8ab18cd36b2 100644
> --- a/include/uapi/linux/sysinfo.h
> +++ b/include/uapi/linux/sysinfo.h
> @@ -5,6 +5,8 @@
>  #include <linux/types.h>
>  
>  #define SI_LOAD_SHIFT	16
> +
> +#if defined(__KERNEL__) || defined(__GLIBC__)
>  struct sysinfo {
>  	__kernel_long_t uptime;		/* Seconds since boot */
>  	__kernel_ulong_t loads[3];	/* 1, 5, and 15 minute load averages */
> @@ -21,5 +23,6 @@ struct sysinfo {
>  	__u32 mem_unit;			/* Memory unit size in bytes */
>  	char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];	/* Padding: libc5 uses this.. */
>  };
> +#endif
>  
>  #endif /* _LINUX_SYSINFO_H */
> -- 
> 2.27.0.rc0

I don't think this is the right way to do it. It prevents getting
access to the kernel uapi structure (which may be wanted) if you're
not using glibc or if you include kernel headers before any libc
headers. Rather, <linux/kernel.h>, whose only real purpose is
providing this structure to legacy applications that don't know the
renamed name for it, should not be implicitly included by other
headers. There's an existing thread on the topic but I don't have the
link handy. IIRC I proposed moving the alignment macros or whatever
other useful stuff is in <linux/kernel.h> to a separate header and
getting rid of all the indirect inclusions of <linux/kernel.h>.

Rich

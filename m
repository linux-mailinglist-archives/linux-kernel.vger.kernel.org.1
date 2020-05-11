Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A551CCFE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 04:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgEKCxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 22:53:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:15696 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgEKCxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:53:39 -0400
IronPort-SDR: SaWGmu2/GPWmrimSH9z0Kb0tq2zAvfcZFi15VnZ3ARHufFpk5KTnW2PAZZYKVx698DLx5cThqp
 9PYw1gxlFmYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 19:53:38 -0700
IronPort-SDR: xpz1MBOyTve2Yi014woff74d4fibI1XxFdgYbe1xJfc2FdwzW8PAvDDMUi1L9EO8il9IriHxVH
 fK+DVivYQqdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,378,1583222400"; 
   d="scan'208";a="261613973"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2020 19:53:38 -0700
Date:   Sun, 10 May 2020 19:53:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Chris Zankel <chris@zankel.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Huang Rui <ray.huang@amd.com>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: vmwgfx: include linux/highmem.h
Message-ID: <20200511025337.GA1823106@iweiny-DESK2.sc.intel.com>
References: <20200508220150.649044-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508220150.649044-1-arnd@arndb.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 12:01:31AM +0200, Arnd Bergmann wrote:
> In order to call kmap_atomic() etc, we need to include linux/highmem.h:
> 
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c: In function 'vmw_bo_cpu_blit_line':
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:377:4: error: implicit declaration of function 'kunmap_atomic'; did you mean 'in_atomic'? [-Werror=implicit-function-declaration]
>   377 |    kunmap_atomic(d->src_addr);
>       |    ^~~~~~~~~~~~~
>       |    in_atomic
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:391:5: error: implicit declaration of function 'kmap_atomic_prot' [-Werror=implicit-function-declaration]
>   391 |     kmap_atomic_prot(d->dst_pages[dst_page],
>       |     ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:390:16: warning: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   390 |    d->dst_addr =
>       |                ^
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:403:16: warning: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   403 |    d->src_addr =
>       |                ^
> 
> Fixes: 46385a895322 ("drm: remove drm specific kmap_atomic code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'm curious about the config which failed...  Because this compiled for me.
Regardless it was stupid of me to not include this.

Thanks,

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> index 94d456a1d1a9..1629427d5734 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> @@ -27,6 +27,7 @@
>   **************************************************************************/
>  
>  #include "vmwgfx_drv.h"
> +#include <linux/highmem.h>
>  
>  /*
>   * Template that implements find_first_diff() for a generic
> -- 
> 2.26.0
> 

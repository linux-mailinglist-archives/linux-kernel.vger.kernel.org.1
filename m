Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1F283D33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgJERTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgJERTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:19:43 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9932078E;
        Mon,  5 Oct 2020 17:19:39 +0000 (UTC)
Date:   Mon, 5 Oct 2020 18:19:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     will@kernel.org, james.morse@arm.com, tglx@linutronix.de,
        mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v12 9/9] kdump: update Documentation about crashkernel
Message-ID: <20201005171936.GD14576@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-10-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907134745.25732-10-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:47:45PM +0800, Chen Zhou wrote:
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 2da65fef2a1c..549611abc581 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
[...]
> @@ -316,8 +325,18 @@ Boot into System Kernel
>     kernel will automatically locate the crash kernel image within the
>     first 512MB of RAM if X is not given.
>  
> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone, and
> +   fall back to high allocation if it fails. And go for high allocation
> +   directly if the required size is too large.
> +   We can also use "crashkernel=X,high" to select a high region above
> +   DMA zone, which also tries to allocate at least 256M low memory in
> +   DMA zone automatically.
> +   "crashkernel=Y,low" can be used to allocate specified size low memory
> +   in DMA zone.
> +   For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.

I don't think we should mention non-RPi4 explicitly here. I don't even
understand what the suggestion is since the only way is to disable
ZONE_DMA in the kernel config. I'd just stick to ZONE_DMA description
here.

> +   Use "crashkernel=Y@X" if you really have to reserve memory from
> +   specified start address X. Note that the start address of the kernel,
> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
>  
>  Load the Dump-capture Kernel
>  ============================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1068742a6df..f7df572d8f64 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -727,6 +727,10 @@
>  			[KNL, X86-64] Select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
> +			[KNL, arm64] Try low allocation in DMA zone, fall back
> +			to high allocation if it fails when '@offset' hasn't been
> +			specified. For non-RPi4 platforms, change DMA zone to
> +			DMA32 zone.

Same here, unclear what "change DMA zone to DMA32 zone" means.

>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
> @@ -743,6 +747,8 @@
>  			Otherwise memory region will be allocated below 4G, if
>  			available.
>  			It will be ignored if crashkernel=X is specified.
> +			[KNL, arm64] range in high memory.
> +			Allow kernel to allocate physical memory region from top.
>  	crashkernel=size[KMG],low
>  			[KNL, X86-64] range under 4G. When crashkernel=X,high
>  			is passed, kernel could allocate physical memory region
> @@ -751,13 +757,16 @@
>  			requires at least 64M+32K low memory, also enough extra
>  			low memory is needed to make sure DMA buffers for 32-bit
>  			devices won't run out. Kernel would try to allocate at
> -			at least 256M below 4G automatically.
> +			least 256M below 4G automatically.
>  			This one let user to specify own low range under 4G
>  			for second kernel instead.
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
> -
> +			[KNL, arm64] range in low memory.
> +			This one let user to specify a low range in DMA zone for
> +			crash dump kernel. For non-RPi4 platforms, change DMA zone
> +			to DMA32 zone.

And again here.

-- 
Catalin

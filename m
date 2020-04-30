Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEB1BF5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgD3Kzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 06:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgD3Kzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:55:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A8920784;
        Thu, 30 Apr 2020 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588244134;
        bh=Jf2E0MV7+Cee/Yr+WCOWj3Sx25YjrA0dDWa8faaEZBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+0uazX5I6tjSX08dCz5kK4cwwK3Rz7e/GYkjJzbJWUCskiuz8D0yCnNLNZDKvi2w
         soJb25dbsZYfEtKSgKLquB+uNM/aSBj18mpDee7huMnIStgr4I3XON3TtS8LK9QSyL
         hDbRK3dWnWdZGoe9Vx9QiFjz976f9hbxZygA5OME=
Date:   Thu, 30 Apr 2020 11:55:30 +0100
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kexec_file: print appropriate variable
Message-ID: <20200430105529.GH19932@willie-the-truck>
References: <CGME20200430105048eucas1p129975fe3fd84c4fd2b14117e3474b203@eucas1p1.samsung.com>
 <20200430105034.17513-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430105034.17513-1-l.stelmach@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:50:34PM +0200, Łukasz Stelmach wrote:
> Fixes: 4312057681929 ("arm64: kexec_file: load initrd and device-tree")
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>

-ENOCOMMITMSG

> ---
>  arch/arm64/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index b40c3b0def92..2776bdaa83a5 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -332,7 +332,7 @@ int load_other_segments(struct kimage *image,
>  	image->arch.dtb_mem = kbuf.mem;
>  
>  	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> -			kbuf.mem, dtb_len, dtb_len);
> +			kbuf.mem, dtb_len, kbuf.memsz);

I guess it would make sense to use kbuf.bufsz instead of dtb_len too.
(assuming this is useful to somebody?)

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DD42EC124
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbhAFQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbhAFQX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:23:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12127C06134C;
        Wed,  6 Jan 2021 08:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ANcFAU6fLTSbBpdHj/SLP8iiYS/tB5MLYP8orjFxP3w=; b=Mp2Ns2yCaTgK8O/OM/DclVcPC1
        W67Z88Ot3yofV3FA+t25M3XNusyp9IHvkC3kRPyAx06tUZyAUA/K7Yng/X0GaPY7KZsk4Y8UY1y3D
        L6xpKll2+KTVo3JhdT6TR2Jva+CKku6CGJawYRITxbtCTZsvpGvhQJnb7dB4scktS39HysfYNNio6
        rsumOk9+N0xwZYAu1cLSEBRzdEi6bXflNniJWoGqs7N4xdp24+5l4NS0dbSpsoaLJ/kX6YEd1e9nF
        ZbrWS/lFb7Ue6IgnaiTxe0tajBQON5p+GxJ2SO3UyiIKw71gUef6YHGASiIlhZwuNUMZskj6Rb1nV
        k3WMJX6g==;
Received: from [2601:1c0:6280:3f0::79df]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxBZP-002V8T-VA; Wed, 06 Jan 2021 16:22:41 +0000
Subject: Re: [PATCH/v2] csky: Fix typos in Kconfig
To:     Masanari Iida <standby24x7@gmail.com>, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ae3672c0-84d1-7ee5-1858-33d119544906@infradead.org>
 <20210106100449.237875-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9de77ea7-c7cd-6235-30f3-50e12fa2d8fe@infradead.org>
Date:   Wed, 6 Jan 2021 08:21:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210106100449.237875-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 2:04 AM, Masanari Iida wrote:
> This patch fixes some spelling typos in Kconfig.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  arch/csky/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 7f1721101ea0..e6ddca10e3ee 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -243,9 +243,9 @@ menuconfig HAVE_TCM
>  	bool "Tightly-Coupled/Sram Memory"
>  	select GENERIC_ALLOCATOR
>  	help
> -	  The implementation are not only used by TCM (Tightly-Coupled Meory)
> -	  but also used by sram on SOC bus. It follow existed linux tcm
> -	  software interface, so that old tcm application codes could be
> +	  The implementation is not only used by TCM (Tightly-Coupled Memory)
> +	  but also used by SRAM on SOC bus. It follows the existing Linux TCM
> +	  software interface, so that old TCM application codes could be
>  	  re-used directly.
>  
>  if HAVE_TCM
> 

LGTM. Thanks.
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

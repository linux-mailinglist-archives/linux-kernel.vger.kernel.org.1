Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0942E28C82C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbgJMFOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 01:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgJMFOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 01:14:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F324C0613D0;
        Mon, 12 Oct 2020 22:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=51FiGdGfPVW5r5jYwLCCPTeFRyNe5ccgJtyw7jmaElc=; b=LtAVfdiI0sZgCUR3ee5ggJxaE2
        VdnfQcr8WeEL3ZKC/dUmMLDUMzGS1y/MJleFUoJysf5pg7z1qh7fvDykfP3j8pD3kN4+/ox3gxx2d
        oDNOCmAYaG9aPzrLtAErzudMdKQw3tCiJDTLgmy54vNwGxmrubR5Gjt3ILOiCNxreSb4pA3jYAj4F
        wTNnLObl3Jl+SB8Yo9aXUDfBL/OLLgVlaibqzRAN3nXXIHBQlz1Hgi3bByhnvY7KZl9GBmu6nSV4B
        jWiivsMU8FSardwevE/+wKXUSYF5m7gvv5EM6T/HHisZ6pr6YrDLTkksrxTQbly7CXUNhJKBCYSaN
        IrZ9aBNw==;
Received: from [2601:1c0:6280:3f0::5d1b] (helo=dragon.site)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSCe5-0001gf-Ck; Tue, 13 Oct 2020 05:14:45 +0000
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions;
 use string size
To:     Michael Witten <mfwitten@gmail.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8d8eba94-8d6d-fbad-f24a-e65282403833@infradead.org>
Date:   Mon, 12 Oct 2020 22:14:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

Here are a few corrections for the source code.

On 9/4/20 12:40 PM, Michael Witten wrote:
> The following patch improves the quality and correctness of the openprom code.
> 
> I have neither a machine to test the result nor a toolchain to compile it, and
> that is why it is listed currently as an "RFC". Nonetheless, I believe those

what is your host build system?

https://mirrors.edge.kernel.org/pub/tools/crosstool/

> who do have these tools will find the proposed changes useful; I hope you will
> help me iterate this patch into something worthy of merging (or use it as the
> basis for your own changes).
> 
> Sincerely,
> Michael Witten
> 
> --8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--
> 
...

> 
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>   arch/sparc/include/asm/prom.h   |   2 +-
>   arch/sparc/kernel/prom_common.c |  14 +--
>   drivers/sbus/char/openprom.c    | 263 ++++++++++++++++++++++++++++------------
>   3 files changed, 194 insertions(+), 85 deletions(-)
> 


> diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
> index 30b9751aad30..9bc2877aa09a 100644
> --- a/drivers/sbus/char/openprom.c
> +++ b/drivers/sbus/char/openprom.c


> @@ -120,69 +154,109 @@ static int getstrings(struct openpromio __user *info, struct openpromio **opp_p)

> -static int opromgetprop(void __user *argp, struct device_node *dp, struct openpromio *op, int bufsize)
> +static int opromgetprop(void __user *argp, struct device_node *dp, struct openpromio *op, const size_t bufsize)
>   {
>   	const void *pval;
> -	int len;
> +	int pval_size;
>   
>   	if (!dp ||
> -	    !(pval = of_get_property(dp, op->oprom_array, &len)) ||
> -	    len <= 0 || len > bufsize)
> +	    !(pval = of_get_property(dp, op->oprom_array, &pval_size)) ||
> +	    pval_size <= 0 || pval_size > bufsize) {
> +		#ifdef CONFIG_DEBUG_KERNEL
> +			if (WARN_ON(op->oprom_size))
> +				op->oprom_size = 0;
> +		#endif
>   		return copyout(argp, op, sizeof(int));
> +	}
> +
> +	op->oprom_size = pval_size;
> +	memcpy(op->oprom_array, pval, pval_size);
>   
> -	memcpy(op->oprom_array, pval, len);
> -	op->oprom_array[len] = '\0';
> -	op->oprom_size = len;
> +	#ifdef CONFIG_DEBUG_KERNEL
> +		// If the buffer is larger than needed, then
> +		// the contents should be nul-terminated in
> +		// case the PROM erroneously produces a string
> +		// that is not nul-terminated.
> +		if (pval_size < bufsize)
> +			char *const end = op->oprom_array + pval_size;
> +			if (WARN_ON(*end))
> +				*end = 0;

Missing braces above?

> +	#endif
>   
>   	return copyout(argp, op, sizeof(int) + bufsize);
>   }
>   
> -static int opromnxtprop(void __user *argp, struct device_node *dp, struct openpromio *op, int bufsize)
> +static int opromnxtprop(void __user *argp, struct device_node *dp, struct openpromio *op, const size_t bufsize)
>   {
>   	struct property *prop;
> -	int len;
> +	size_t name_size;
> +	unsigned int uint_name_size;
>   
>   	if (!dp)
> -		return copyout(argp, op, sizeof(int));
> +		goto nothing;
> +
>   	if (op->oprom_array[0] == '\0') {
>   		prop = dp->properties;
> -		if (!prop)
> -			return copyout(argp, op, sizeof(int));
> -		len = strlen(prop->name);
>   	} else {
>   		prop = of_find_property(dp, op->oprom_array, NULL);
> +		if (prop)
> +			prop = prop->next;
> +	}
>   
> -		if (!prop ||
> -		    !prop->next ||
> -		    (len = strlen(prop->next->name)) + 1 > bufsize)
> -			return copyout(argp, op, sizeof(int));
> +	if (!prop)
> +		goto nothing;
>   
> -		prop = prop->next;
> -	}
> +	name_size = 1 + strlen(prop->name);
> +
> +	uint_name_size = name_size;
> +	if (unlikely(uint_name_size != name_size))
> +		goto nothing; // overflow
> +
> +	if (name_size > bufsize)
> +		goto nothing;
>   
> -	memcpy(op->oprom_array, prop->name, len);
> -	op->oprom_array[len] = '\0';
> -	op->oprom_size = ++len;
> +	memcpy(op->oprom_array, prop->name, name_size);
> +	op->oprom_size = uint_name_size;
>   
>   	return copyout(argp, op, sizeof(int) + bufsize);
> +
> +nothing:
> +	#ifdef CONFIG_DEBUG_KERNEL
> +		if (WARN_ON(op->oprom_size))
> +			op-oprom_size = 0;

			op->oprom_size = 0;


> +	#endif
> +	return copyout(argp, op, sizeof(int));
>   }
>   




> @@ -301,6 +384,12 @@ static long openprom_sunos_ioctl(struct file * file,
>   	else
>   		bufsize = copyin(argp, &opp);
>   
> +	#ifdef CONFIG_DEBUG_KERNEL
> +		if (WARN_ON(bufsize == 0))
> +			bufsize = -EFAULT;
> +	#enif

	#endif

> +
> +	static_assert(LONG_MIN <= -(SIZE_MAX/2)-1);
>   	if (bufsize < 0)
>   		return bufsize;
>   



HTH.
--
~Randy


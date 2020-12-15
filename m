Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2362DB17E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgLOQdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbgLOQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:33:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72EEC06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=e9mj8fcSZI6Akj0xGwlMlxIYcxQ8rxTlgS6PlD6PZhY=; b=Ps2AqxrIyKLgfStTwZU714rDzn
        lttO4U8XzgV7y6E+ek2dBC6c9F7yLJh6ezYFNacrWOCw/ieavHkwZUioYTDgePgwcc41hTJYGiP6p
        O0a+T3ay2UTRnnTJRae41Odq3RGF2m5N6EPn3YZa+t5jDOxac2xgIRRjZouEzeCd2w/e7ZtMbItUx
        dv7bO3fAnE3wJcA0MccgAGMLwHNaeMUJwX96haTwb6E0yaq1RX37S9dyLNk/EzWJGD/nEh8WP0BgB
        jVqLd5KwXRx7QYEr+WMNeOrNw2+PX2ukWDbnITQG6YOl7SHNBBgcsKiI9W51IEff+b+dFXskLbi9r
        eB9ZwDGQ==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpDFT-0002nO-3e; Tue, 15 Dec 2020 16:32:27 +0000
Subject: Re: [PATCH] arch: x86: entry: vdso: fix type conversion on printf()
 call
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
References: <20201215160314.18773-1-info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <41ef1cd1-017d-a0d4-91d3-a1183bd2ab01@infradead.org>
Date:   Tue, 15 Dec 2020 08:32:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201215160314.18773-1-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/20 8:03 AM, Enrico Weigelt, metux IT consult wrote:
> Fixing the following compiler warning by explicit conversion to long:
> 
> In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:162:0:
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>                                                     ^
>   CC      mm/filemap.o
> In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:166:0:
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/x86/entry/vdso/vdso2c.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Hi,

size_t is normally printed with %zu.
Is there some reason that isn't being used here?

> diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
> index 1c7cfac7e64a..5c6a4bbc63f9 100644
> --- a/arch/x86/entry/vdso/vdso2c.h
> +++ b/arch/x86/entry/vdso/vdso2c.h
> @@ -35,7 +35,8 @@ static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
>  	if (offset + len > data_len)
>  		fail("section to extract overruns input data");
>  
> -	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> +	fprintf(outfile, "static const unsigned char %s[%lu] = {", name,
> +		(unsigned long)len);
>  	BITSFUNC(copy)(outfile, data + offset, len);
>  	fprintf(outfile, "\n};\n\n");
>  }
> 

thanks.
-- 
~Randy


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D572D64E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392947AbgLJS0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390885AbgLJSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:25:58 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850FBC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:25:18 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so4410565qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uluB0mD/174B1JmgSMgZuinmmEBxrt4PIkK2KNEJKOo=;
        b=tOSj+o+rtLHr0mYnk2x0/AptMtOoigAm7gugCwxIsv6z5PruF3gIGNzLQkTclvyxu+
         tzzt9elwfPh/fydidEQ9Sk/0KDXVkJq2YzIrINmta1HzTS0f7DN90YQ7EVbGx2u+F5Gy
         QFfSAgTWgHQXjC28gQzETma55aB54KfSbc/v8XSTON+5jtkkFk8UQR/KC6JIRUxSuWbo
         1+0fOohfIACX2KFZkI3ThD6bmvskDs9CEQqGojqRXDPpI0ASIPUA0O4tzZvRm/ExPjHy
         BqevTbUKSKy+cP8+ucu2KiXzxfK1OvzxNeJKTCyV89cjB3G6XVLC8vR7cFihsH4bT+G0
         YU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uluB0mD/174B1JmgSMgZuinmmEBxrt4PIkK2KNEJKOo=;
        b=QD+xHGn7/SHXYCnWNF83s4dRoIMqAkGPJc6EkZWrbyOIbTl3iYYw3fs2/hw6Ii8k2T
         GTxdnO3YadPgcVv6P7Tk2riDl+oDE8/QnPl8ZXk/Zu77ot4TFqNR6+gB2QN5139E8/cL
         DJXAREjvU80ik4L/XjjExfaYJXDAHTUPxwbiMA5pCgReWbjCM7ruPfb8ybEuPKZNjnAC
         edYqPgENnBiZ+2ysVWcRmlq0sYCvZ0IGnLaX4Yh2CmUDP994vgSZExqaI1W4RwGTaC/y
         4kHeW3/SQgT3LNPT4v9hhHgPnD5zjowCk6/UsKew8PMQSLagtvd+mw4KFpd6kWz/87Nh
         xiYA==
X-Gm-Message-State: AOAM531hZO3Y1XDMDWqcWo5uglL7MGGvXoqDZcf1zp+NRB0WofO5SXjh
        xFwVZtfGQIksa7HivDghAYeHGg==
X-Google-Smtp-Source: ABdhPJx/Do5bA91lE6f8apE3WArvcwbgH/dVUZItW3VPJqbV0nihvwAd9PJeh1M6rqlwzTkyl7gprw==
X-Received: by 2002:aed:2f67:: with SMTP id l94mr6124949qtd.201.1607624717743;
        Thu, 10 Dec 2020 10:25:17 -0800 (PST)
Received: from [192.168.1.4] ([177.194.48.209])
        by smtp.googlemail.com with ESMTPSA id r8sm4126536qtj.94.2020.12.10.10.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 10:25:17 -0800 (PST)
Subject: Re: [PATCH v2 3/6] elf: Fix failure handling in
 _dl_map_object_from_fd
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>, libc-alpha@sourceware.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        kernel-hardening@lists.openwall.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1606319495.git.szabolcs.nagy@arm.com>
 <8ebf571196dd499c61983dbf53c94c68ebd458cc.1606319495.git.szabolcs.nagy@arm.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
Autocrypt: addr=adhemerval.zanella@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1525639f-560f-2677-b1cb-f904b3552c71@linaro.org>
Date:   Thu, 10 Dec 2020 15:25:12 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8ebf571196dd499c61983dbf53c94c68ebd458cc.1606319495.git.szabolcs.nagy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/11/2020 10:20, Szabolcs Nagy via Libc-alpha wrote:
> There are many failure paths that call lose to do local cleanups
> in _dl_map_object_from_fd, but it did not clean everything.
> 
> Handle l_phdr, l_libname and mapped segments in the common failure
> handling code.
> 
> There are various bits that may not be cleaned properly on failure
> (e.g. executable stack, tlsid, incomplete dl_map_segments).
> ---
>  elf/dl-load.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/elf/dl-load.c b/elf/dl-load.c
> index 21e55deb19..9c71b7562c 100644
> --- a/elf/dl-load.c
> +++ b/elf/dl-load.c
> @@ -914,8 +914,15 @@ lose (int code, int fd, const char *name, char *realname, struct link_map *l,
>    /* The file might already be closed.  */
>    if (fd != -1)
>      (void) __close_nocancel (fd);
> +  if (l != NULL && l->l_map_start != 0)
> +    _dl_unmap_segments (l);
>    if (l != NULL && l->l_origin != (char *) -1l)
>      free ((char *) l->l_origin);
> +  if (l != NULL && !l->l_libname->dont_free)
> +    free (l->l_libname);
> +  if (l != NULL && l->l_phdr_allocated)
> +    free ((void *) l->l_phdr);
> +
>    free (l);
>    free (realname);
>  
> @@ -1256,7 +1263,11 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
>      errstring = _dl_map_segments (l, fd, header, type, loadcmds, nloadcmds,
>  				  maplength, has_holes, loader);
>      if (__glibc_unlikely (errstring != NULL))
> -      goto call_lose;
> +      {
> +	/* Mappings can be in an inconsistent state: avoid unmap.  */
> +	l->l_map_start = l->l_map_end = 0;
> +	goto call_lose;
> +      }
>  
>      /* Process program headers again after load segments are mapped in
>         case processing requires accessing those segments.  Scan program

In this case I am failing to see who would be responsible to unmap 
l_map_start int the type == ET_DYN where first mmap succeeds but
with a later mmap failure in any load command.

> @@ -1294,14 +1305,6 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
>        || (__glibc_unlikely (l->l_flags_1 & DF_1_PIE)
>  	  && __glibc_unlikely ((mode & __RTLD_OPENEXEC) == 0)))
>      {
> -      /* We are not supposed to load this object.  Free all resources.  */
> -      _dl_unmap_segments (l);
> -
> -      if (!l->l_libname->dont_free)
> -	free (l->l_libname);
> -
> -      if (l->l_phdr_allocated)
> -	free ((void *) l->l_phdr);
>  
>        if (l->l_flags_1 & DF_1_PIE)
>  	errstring
> @@ -1392,6 +1395,9 @@ cannot enable executable stack as shared object requires");
>    /* Signal that we closed the file.  */
>    fd = -1;
>  
> +  /* Failures before this point are handled locally via lose.
> +     No more failures are allowed in this function until return.  */
> +
>    /* If this is ET_EXEC, we should have loaded it as lt_executable.  */
>    assert (type != ET_EXEC || l->l_type == lt_executable);
>  
> 

Ok.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710BE2D6618
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393404AbgLJTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390917AbgLJTNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:13:04 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB8C061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:12:24 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so4580150qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i/rwupQvQkYiokDwNb0ikWR1Xxc0O7H0JsJy333WoH4=;
        b=OTtSR5G/9/kciSl+snmBLJQ9DP7IX9WofQtpXWNGgk0cMzostaxi8DeKv8+Fn1kIDt
         8IS41tRh2eR3mk118ordBVemK27vG7EiG+Dh/1uv4mSceM5nB0JI/yz7gt3ua564gsUO
         tAAkDLZESXBQH08GmT1EUWMKcmquQ2ZcCYVeK8Dkg0e6vfUpFg4G5DPdETaH1aRuyiYX
         +RX/E3XbvsAG/GYDbNpiG/Z/+bI2vSjbQvRioYwxZZqLsckT8WsMnptPww8C7CrGy2xM
         0SR35fP01eggY30RL5x8H5g3Lz7TpsZY6EsPpJtmtlt/9Jnkz9U81i+FElxNDJnhXp2J
         wOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i/rwupQvQkYiokDwNb0ikWR1Xxc0O7H0JsJy333WoH4=;
        b=EL0EYSLJTMf9MdseFaZ5pN7mfrmM3aQWWYi99Pv2Mp0lT0HxrRaUXxXE7ZoxGhG3EX
         dU9udafXmHJ648/UIqVG6elXNrHMOB9awVUHPzcZMR5gM/V4k1pNwurLeBgfBWEvwGoy
         0eR2Hk1TkHGMjdleTWT4MsLfIsWJTerUwziccDc3Msafy0OOLtMvY0eiQmOTjoqZfShJ
         nMfocGD3X+98CN+TtFB1mHTMMCUWyrj2x728Kuvq4fODZlBeAPnQM8zXP+PsDr4NiVUo
         yE/Ve4Xx3Tei8fDjmdL1C2XR491yhSpuMU7ezCTPhOG2uoT+1tmoTZT5Djlv+gAg7b2K
         Ks9A==
X-Gm-Message-State: AOAM532JhKmIYQM1610SmPIei44i74xVO459BTN31Htuk0xP5QlM+uQa
        YOLglgyGXnTtuI8RysQxFSywXg==
X-Google-Smtp-Source: ABdhPJzHN6i1DvyTSj0eiiI5RhEzM65xwUXXSurBP58PNZ+XbFPO2iPnlm+BkEJSTPZopTcbE+MxUA==
X-Received: by 2002:ac8:2a8f:: with SMTP id b15mr2239663qta.33.1607627543439;
        Thu, 10 Dec 2020 11:12:23 -0800 (PST)
Received: from [192.168.1.4] ([177.194.48.209])
        by smtp.googlemail.com with ESMTPSA id i68sm1431916qkc.82.2020.12.10.11.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 11:12:22 -0800 (PST)
Subject: Re: [PATCH v3 2/2] aarch64: Use mmap to add PROT_BTI instead of
 mprotect [BZ #26831]
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
References: <ebce134991eae4261bbb32572a2062d3ca56e674.1606319495.git.szabolcs.nagy@arm.com>
 <7e800caa0485fec67b21ebab1e27bb23b2f0d971.1606898457.git.szabolcs.nagy@arm.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
Autocrypt: addr=adhemerval.zanella@linaro.org; prefer-encrypt=mutual; keydata=
 mQINBFcVGkoBEADiQU2x/cBBmAVf5C2d1xgz6zCnlCefbqaflUBw4hB/bEME40QsrVzWZ5Nq
 8kxkEczZzAOKkkvv4pRVLlLn/zDtFXhlcvQRJ3yFMGqzBjofucOrmdYkOGo0uCaoJKPT186L
 NWp53SACXguFJpnw4ODI64ziInzXQs/rUJqrFoVIlrPDmNv/LUv1OVPKz20ETjgfpg8MNwG6
 iMizMefCl+RbtXbIEZ3TE/IaDT/jcOirjv96lBKrc/pAL0h/O71Kwbbp43fimW80GhjiaN2y
 WGByepnkAVP7FyNarhdDpJhoDmUk9yfwNuIuESaCQtfd3vgKKuo6grcKZ8bHy7IXX1XJj2X/
 BgRVhVgMHAnDPFIkXtP+SiarkUaLjGzCz7XkUn4XAGDskBNfbizFqYUQCaL2FdbW3DeZqNIa
 nSzKAZK7Dm9+0VVSRZXP89w71Y7JUV56xL/PlOE+YKKFdEw+gQjQi0e+DZILAtFjJLoCrkEX
 w4LluMhYX/X8XP6/C3xW0yOZhvHYyn72sV4yJ1uyc/qz3OY32CRy+bwPzAMAkhdwcORA3JPb
 kPTlimhQqVgvca8m+MQ/JFZ6D+K7QPyvEv7bQ7M+IzFmTkOCwCJ3xqOD6GjX3aphk8Sr0dq3
 4Awlf5xFDAG8dn8Uuutb7naGBd/fEv6t8dfkNyzj6yvc4jpVxwARAQABtElBZGhlbWVydmFs
 IFphbmVsbGEgTmV0dG8gKExpbmFybyBWUE4gS2V5KSA8YWRoZW1lcnZhbC56YW5lbGxhQGxp
 bmFyby5vcmc+iQI3BBMBCAAhBQJXFRpKAhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJ
 EKqx7BSnlIjv0e8P/1YOYoNkvJ+AJcNUaM5a2SA9oAKjSJ/M/EN4Id5Ow41ZJS4lUA0apSXW
 NjQg3VeVc2RiHab2LIB4MxdJhaWTuzfLkYnBeoy4u6njYcaoSwf3g9dSsvsl3mhtuzm6aXFH
 /Qsauav77enJh99tI4T+58rp0EuLhDsQbnBic/ukYNv7sQV8dy9KxA54yLnYUFqH6pfH8Lly
 sTVAMyi5Fg5O5/hVV+Z0Kpr+ZocC1YFJkTsNLAW5EIYSP9ftniqaVsim7MNmodv/zqK0IyDB
 GLLH1kjhvb5+6ySGlWbMTomt/or/uvMgulz0bRS+LUyOmlfXDdT+t38VPKBBVwFMarNuREU2
 69M3a3jdTfScboDd2ck1u7l+QbaGoHZQ8ZNUrzgObltjohiIsazqkgYDQzXIMrD9H19E+8fw
 kCNUlXxjEgH/Kg8DlpoYJXSJCX0fjMWfXywL6ZXc2xyG/hbl5hvsLNmqDpLpc1CfKcA0BkK+
 k8R57fr91mTCppSwwKJYO9T+8J+o4ho/CJnK/jBy1pWKMYJPvvrpdBCWq3MfzVpXYdahRKHI
 ypk8m4QlRlbOXWJ3TDd/SKNfSSrWgwRSg7XCjSlR7PNzNFXTULLB34sZhjrN6Q8NQZsZnMNs
 TX8nlGOVrKolnQPjKCLwCyu8PhllU8OwbSMKskcD1PSkG6h3r0AquQINBFcVGkoBEACgAdbR
 Ck+fsfOVwT8zowMiL3l9a2DP3Eeak23ifdZG+8Avb/SImpv0UMSbRfnw/N81IWwlbjkjbGTu
 oT37iZHLRwYUFmA8fZX0wNDNKQUUTjN6XalJmvhdz9l71H3WnE0wneEM5ahu5V1L1utUWTyh
 VUwzX1lwJeV3vyrNgI1kYOaeuNVvq7npNR6t6XxEpqPsNc6O77I12XELic2+36YibyqlTJIQ
 V1SZEbIy26AbC2zH9WqaKyGyQnr/IPbTJ2Lv0dM3RaXoVf+CeK7gB2B+w1hZummD21c1Laua
 +VIMPCUQ+EM8W9EtX+0iJXxI+wsztLT6vltQcm+5Q7tY+HFUucizJkAOAz98YFucwKefbkTp
 eKvCfCwiM1bGatZEFFKIlvJ2QNMQNiUrqJBlW9nZp/k7pbG3oStOjvawD9ZbP9e0fnlWJIsj
 6c7pX354Yi7kxIk/6gREidHLLqEb/otuwt1aoMPg97iUgDV5mlNef77lWE8vxmlY0FBWIXuZ
 yv0XYxf1WF6dRizwFFbxvUZzIJp3spAao7jLsQj1DbD2s5+S1BW09A0mI/1DjB6EhNN+4bDB
 SJCOv/ReK3tFJXuj/HbyDrOdoMt8aIFbe7YFLEExHpSk+HgN05Lg5TyTro8oW7TSMTk+8a5M
 kzaH4UGXTTBDP/g5cfL3RFPl79ubXwARAQABiQIfBBgBCAAJBQJXFRpKAhsMAAoJEKqx7BSn
 lIjvI/8P/jg0jl4Tbvg3B5kT6PxJOXHYu9OoyaHLcay6Cd+ZrOd1VQQCbOcgLFbf4Yr+rE9l
 mYsY67AUgq2QKmVVbn9pjvGsEaz8UmfDnz5epUhDxC6yRRvY4hreMXZhPZ1pbMa6A0a/WOSt
 AgFj5V6Z4dXGTM/lNManr0HjXxbUYv2WfbNt3/07Db9T+GZkpUotC6iknsTA4rJi6u2ls0W9
 1UIvW4o01vb4nZRCj4rni0g6eWoQCGoVDk/xFfy7ZliR5B+3Z3EWRJcQskip/QAHjbLa3pml
 xAZ484fVxgeESOoaeC9TiBIp0NfH8akWOI0HpBCiBD5xaCTvR7ujUWMvhsX2n881r/hNlR9g
 fcE6q00qHSPAEgGr1bnFv74/1vbKtjeXLCcRKk3Ulw0bY1OoDxWQr86T2fZGJ/HIZuVVBf3+
 gaYJF92GXFynHnea14nFFuFgOni0Mi1zDxYH/8yGGBXvo14KWd8JOW0NJPaCDFJkdS5hu0VY
 7vJwKcyHJGxsCLU+Et0mryX8qZwqibJIzu7kUJQdQDljbRPDFd/xmGUFCQiQAncSilYOcxNU
 EMVCXPAQTteqkvA+gNqSaK1NM9tY0eQ4iJpo+aoX8HAcn4sZzt2pfUB9vQMTBJ2d4+m/qO6+
 cFTAceXmIoFsN8+gFN3i8Is3u12u8xGudcBPvpoy4OoG
Message-ID: <dc64c60c-aecf-f24f-f423-03499b55e19e@linaro.org>
Date:   Thu, 10 Dec 2020 16:12:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7e800caa0485fec67b21ebab1e27bb23b2f0d971.1606898457.git.szabolcs.nagy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2020 05:55, Szabolcs Nagy via Libc-alpha wrote:
> Re-mmap executable segments if possible instead of using mprotect
> to add PROT_BTI. This allows using BTI protection with security
> policies that prevent mprotect with PROT_EXEC.
> 
> If the fd of the ELF module is not available because it was kernel
> mapped then mprotect is used and failures are ignored.  To protect
> the main executable even when mprotect is filtered the linux kernel
>  will have to be changed to add PROT_BTI to it.
> 
> The delayed failure reporting is mainly needed because currently
> _dl_process_gnu_properties does not propagate failures such that
> the required cleanups happen. Using the link_map_machine struct for
> error propagation is not ideal, but this seemed to be the least
> intrusive solution.
> 
> Fixes bug 26831.

LGTM, thanks.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>

> ---
> v3:
> - split the last patch in two.
> - pushed to nsz/btifix-v3 branch.
> 
>  sysdeps/aarch64/dl-bti.c  | 54 ++++++++++++++++++++++++++-------------
>  sysdeps/aarch64/dl-prop.h |  8 +++++-
>  sysdeps/aarch64/linkmap.h |  2 +-
>  3 files changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/sysdeps/aarch64/dl-bti.c b/sysdeps/aarch64/dl-bti.c
> index 67d63c8a73..ff26c98ccf 100644
> --- a/sysdeps/aarch64/dl-bti.c
> +++ b/sysdeps/aarch64/dl-bti.c
> @@ -19,9 +19,17 @@
>  #include <errno.h>
>  #include <libintl.h>
>  #include <ldsodefs.h>
> +#include <sys/mman.h>
>  
> -static void
> -enable_bti (struct link_map *map, const char *program)
> +/* See elf/dl-load.h.  */
> +#ifndef MAP_COPY
> +# define MAP_COPY (MAP_PRIVATE | MAP_DENYWRITE)
> +#endif
> +
> +/* Enable BTI protection for MAP.  */
> +
> +void
> +_dl_bti_protect (struct link_map *map, int fd)
>  {
>    const size_t pagesz = GLRO(dl_pagesize);
>    const ElfW(Phdr) *phdr;
> @@ -41,19 +49,31 @@ enable_bti (struct link_map *map, const char *program)
>  	if (phdr->p_flags & PF_W)
>  	  prot |= PROT_WRITE;
>  
> -	if (__mprotect (start, len, prot) < 0)
> -	  {
> -	    if (program)
> -	      _dl_fatal_printf ("%s: mprotect failed to turn on BTI\n",
> -				map->l_name);
> -	    else
> -	      _dl_signal_error (errno, map->l_name, "dlopen",
> -				N_("mprotect failed to turn on BTI"));
> -	  }
> +	if (fd == -1)
> +	  /* Ignore failures for kernel mapped binaries.  */
> +	  __mprotect (start, len, prot);
> +	else
> +	  map->l_mach.bti_fail = __mmap (start, len, prot,
> +					 MAP_FIXED|MAP_COPY|MAP_FILE,
> +					 fd, off) == MAP_FAILED;
>        }
>  }
>  

OK. I am not very found of ignore the mprotect failure here, but it 
has been discussed in multiple threads that we need kernel support 
to proper handle it.

> -/* Enable BTI for MAP and its dependencies.  */
> +
> +static void
> +bti_failed (struct link_map *l, const char *program)
> +{
> +  if (program)

No implicit checks.

> +    _dl_fatal_printf ("%s: %s: failed to turn on BTI protection\n",
> +		      program, l->l_name);
> +  else
> +    /* Note: the errno value is not available any more.  */
> +    _dl_signal_error (0, l->l_name, "dlopen",
> +		      N_("failed to turn on BTI protection"));
> +}
> +
> +
> +/* Report BTI protection failures for MAP and its dependencies.  */
>  

Ok.

>  void
>  _dl_bti_check (struct link_map *map, const char *program)
> @@ -61,16 +81,14 @@ _dl_bti_check (struct link_map *map, const char *program)
>    if (!GLRO(dl_aarch64_cpu_features).bti)
>      return;
>  
> -  if (map->l_mach.bti)
> -    enable_bti (map, program);
> +  if (map->l_mach.bti_fail)
> +    bti_failed (map, program);
>  
>    unsigned int i = map->l_searchlist.r_nlist;
>    while (i-- > 0)
>      {
>        struct link_map *l = map->l_initfini[i];
> -      if (l->l_init_called)
> -	continue;
> -      if (l->l_mach.bti)
> -	enable_bti (l, program);
> +      if (l->l_mach.bti_fail)
> +	bti_failed (l, program);
>      }
>  }

Ok.

> diff --git a/sysdeps/aarch64/dl-prop.h b/sysdeps/aarch64/dl-prop.h
> index 2016d1472e..e926e54984 100644
> --- a/sysdeps/aarch64/dl-prop.h
> +++ b/sysdeps/aarch64/dl-prop.h
> @@ -19,6 +19,8 @@
>  #ifndef _DL_PROP_H
>  #define _DL_PROP_H
>  
> +extern void _dl_bti_protect (struct link_map *, int) attribute_hidden;
> +
>  extern void _dl_bti_check (struct link_map *, const char *)
>      attribute_hidden;
>  
> @@ -43,6 +45,10 @@ static inline int
>  _dl_process_gnu_property (struct link_map *l, int fd, uint32_t type,
>  			  uint32_t datasz, void *data)
>  {
> +  if (!GLRO(dl_aarch64_cpu_features).bti)
> +    /* Skip note processing.  */
> +    return 0;
> +
>    if (type == GNU_PROPERTY_AARCH64_FEATURE_1_AND)
>      {
>        /* Stop if the property note is ill-formed.  */
> @@ -51,7 +57,7 @@ _dl_process_gnu_property (struct link_map *l, int fd, uint32_t type,
>  
>        unsigned int feature_1 = *(unsigned int *) data;
>        if (feature_1 & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)
> -	l->l_mach.bti = true;
> +	_dl_bti_protect (l, fd);
>  
>        /* Stop if we processed the property note.  */
>        return 0;

Ok.

> diff --git a/sysdeps/aarch64/linkmap.h b/sysdeps/aarch64/linkmap.h
> index 847a03ace2..b3f7663b07 100644
> --- a/sysdeps/aarch64/linkmap.h
> +++ b/sysdeps/aarch64/linkmap.h
> @@ -22,5 +22,5 @@ struct link_map_machine
>  {
>    ElfW(Addr) plt;	  /* Address of .plt */
>    void *tlsdesc_table;	  /* Address of TLS descriptor hash table.  */
> -  bool bti;		  /* Branch Target Identification is enabled.  */
> +  bool bti_fail;	  /* Failed to enable Branch Target Identification.  */
>  };
> 

Ok.

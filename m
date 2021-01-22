Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954DB300DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbhAVUZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbhAVUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:18:01 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFCC061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:17:20 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u8so624472ior.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EyMAX4RDBgEWkK9rI+suZ/hX/nCJTqw3QIBCBEq4UXk=;
        b=dJwax//rwioNZS4Dzs7YQpeWeK7An50ETJLEKlVIgL3QG+hm8G+dyQmmkNkjlt3PHm
         2DZAFGIUS7sphdsZp4b+cXc+UqLtsFpnuXk297zobBwOVSX7H9YwdVgeAxbG8KTJkuUm
         AaYnexvivNbrYHpNO4SRFpr09nN+JsrBBs4FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EyMAX4RDBgEWkK9rI+suZ/hX/nCJTqw3QIBCBEq4UXk=;
        b=gg8zt7vjPLIUVaON4Pej14nuw0rw2Q/VKJ15+M/Yhqur2d7vx8vbHh37/Dj9FcYW4d
         Kb9WK7nyfiZf1JIdtIifCNJJDPhhXs3JnHhc1gzZgHWGfDoqNgJ1NGQ0+fUQuN7Zaxk0
         zcPbtwVG9ZbsnawvRFBnwAFjUIYce7bt/S1tVCP/d/hbBl8wPXjrda0tFn8fbH2ozR5w
         KT1UMBlcB9V9ZYTE6t1WsW8lSBgLGsYTLU/skkypUDP4kqHUy0OiUXYB9pGuhBZB2BFz
         sXiCZAozfr3q3ChYkn0CciSvchW7CDMGqJTjBtxUcnGojiNmuZ19SAk8pcT92itcYFgi
         TGRA==
X-Gm-Message-State: AOAM533scbwmsW8mHPMdQcv3CAq2VHpz5a6ji+CB6w3ImZew3H05hYbb
        yYROIMPlbKRixGxeWogXU0YNrQ==
X-Google-Smtp-Source: ABdhPJxJ3hKf1xeZDaxdmqh1aqHeVHxWslc3PVpTAKROnI9SiuTH3kg0bLskeGBy+JLTQI8tr4Ql1w==
X-Received: by 2002:a6b:c949:: with SMTP id z70mr2126720iof.80.1611346639525;
        Fri, 22 Jan 2021 12:17:19 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g13sm6635927iln.12.2021.01.22.12.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 12:17:18 -0800 (PST)
Subject: Re: [PATCH 1/8] cpupower: Update msr_pstate union struct naming
To:     Nathan Fontenot <nathan.fontenot@amd.com>, rrichter@amd.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org, trenn@suse.com,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
 <161133711513.59625.9843026563692886689.stgit@ethanol01c7-host.amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a677f0bb-2d17-f372-66a3-65a74494eb6c@linuxfoundation.org>
Date:   Fri, 22 Jan 2021 13:17:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161133711513.59625.9843026563692886689.stgit@ethanol01c7-host.amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 10:38 AM, Nathan Fontenot wrote:
> The msr_pstate union struct named fam17h_bits is misleading since
> this is the struct to use for all families >= 0x17, not just
> for family 0x17. Rename the bits structs to be 'pstate' (for pre
> family 17h CPUs) and 'pstatedef' (for CPUs since fam 17h) to align
> closer with PPR/BDKG naming.

What is PPR/PDKG - would be helpful to know what it is and provide
link to the doc if applicable.
> 
> There are no functional changes as part of this update.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/amd.c |   26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index 7c4f83a8c973..34368436bbd6 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -13,7 +13,8 @@
>   #define MSR_AMD_PSTATE		0xc0010064
>   #define MSR_AMD_PSTATE_LIMIT	0xc0010061
>   
> -union msr_pstate {
> +union core_pstate {
> +	/* pre fam 17h: */
>   	struct {
>   		unsigned fid:6;
>   		unsigned did:3;
> @@ -26,7 +27,8 @@ union msr_pstate {
>   		unsigned idddiv:2;
>   		unsigned res3:21;
>   		unsigned en:1;
> -	} bits;
> +	} pstate;
> +	/* since fam 17h: */
>   	struct {
>   		unsigned fid:8;
>   		unsigned did:6;
> @@ -35,36 +37,36 @@ union msr_pstate {
>   		unsigned idddiv:2;
>   		unsigned res1:31;
>   		unsigned en:1;
> -	} fam17h_bits;
> +	} pstatedef;

Does pstatedef indicate this is pstate default?

>   	unsigned long long val;
>   };
>   
> -static int get_did(int family, union msr_pstate pstate)
> +static int get_did(int family, union core_pstate pstate)
>   {
>   	int t;
>   
>   	if (family == 0x12)
>   		t = pstate.val & 0xf;
>   	else if (family == 0x17 || family == 0x18)
> -		t = pstate.fam17h_bits.did;
> +		t = pstate.pstatedef.did;
>   	else
> -		t = pstate.bits.did;
> +		t = pstate.pstate.did;
>   
>   	return t;
>   }
>   
> -static int get_cof(int family, union msr_pstate pstate)
> +static int get_cof(int family, union core_pstate pstate)
>   {
>   	int t;
>   	int fid, did, cof;
>   
>   	did = get_did(family, pstate);
>   	if (family == 0x17 || family == 0x18) {
> -		fid = pstate.fam17h_bits.fid;
> +		fid = pstate.pstatedef.fid;
>   		cof = 200 * fid / did;
>   	} else {
>   		t = 0x10;
> -		fid = pstate.bits.fid;
> +		fid = pstate.pstate.fid;
>   		if (family == 0x11)
>   			t = 0x8;
>   		cof = (100 * (fid + t)) >> did;
> @@ -89,7 +91,7 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
>   		   int boost_states, unsigned long *pstates, int *no)
>   {
>   	int i, psmax, pscur;
> -	union msr_pstate pstate;
> +	union core_pstate pstate;
>   	unsigned long long val;
>   
>   	/* Only read out frequencies from HW when CPU might be boostable
> @@ -119,9 +121,9 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
>   		}
>   		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
>   			return -1;
> -		if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
> +		if ((cpu_family == 0x17) && (!pstate.pstatedef.en))
>   			continue;
> -		else if (!pstate.bits.en)
> +		else if (!pstate.pstate.en)
>   			continue;
>   
>   		pstates[i] = get_cof(cpu_family, pstate);
> 
> 

thanks,
-- Shuah

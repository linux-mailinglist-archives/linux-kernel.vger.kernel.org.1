Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC322B493F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgKPP1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731429AbgKPP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605540438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+R8S0WweOXQR+OUWh+p2mp3xbX8KKGAJ9nOo8kOgR4=;
        b=QVx1vMe9fBhXRwwMehX4BChgJovBmF8yBVfdORXQwpPWPKuFThJUQ2eTJok75hkY1zIsD3
        KAoqQ/kyEhRb+K0Ceo7/LbIWrFXII2Vy31wBvHRHv69tp+97Spy11fPkt/rcVoyL4Cg3UK
        hqLYfNRFzDpcr3tPCf8qWgqaZZ1phZU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-yAMpu45rMRSW5qnE1UDqog-1; Mon, 16 Nov 2020 10:27:15 -0500
X-MC-Unique: yAMpu45rMRSW5qnE1UDqog-1
Received: by mail-qk1-f200.google.com with SMTP id v134so11794810qka.19
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p+R8S0WweOXQR+OUWh+p2mp3xbX8KKGAJ9nOo8kOgR4=;
        b=aEcM+kHj9G3X8FXsG/ANAWdsY0rKxK0ipdNPjPuYnk1FVtgBXAsZdI4luLVo+4FD8g
         J5hxiXyE2MedOIFfW40EpqvxKUyZtV5UQEXwaa39+lC4X4BIu56SlhRXDFzTnWNcbOk/
         4MA0d2Zjf4NjeSpwogiRaBud/8x7lvxW/G5pzLmrXi+wky4nI5/G8i1BfhWCm2VsDUub
         ZyJaWdVbgGrtCsIFijb9kq6V9l2mAxewzpQgDivOIWrVfAcM+3CgegQLg2auPrZKD5Ml
         OOXDlCMtjp0eTO8Pe4Xi0Lba6WtS7j5rx43M+sbokBFU1zBobwsQXaAzVRc2DT83MKkw
         4ezw==
X-Gm-Message-State: AOAM533ITC5WjeMkUWMQZRWBcV2hLcVlx0IincjXr9PNrj8QjG6OOA+Y
        HDfoEVF7fRNXZECsfLnzAxL+fkVZKRCEM9GcTQwRw6NpWTn4WMS5+Bih3Rs0zaoowdKFVeJfucd
        EI99mwho5EQQaMViN8QIA04jn3JChrf3fNtRO22YI3Ngsi4BemQeUc3CSDthte6HFywrwM+k=
X-Received: by 2002:ac8:1201:: with SMTP id x1mr14518604qti.339.1605540434580;
        Mon, 16 Nov 2020 07:27:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweYUi7z+e1csf1aHOAl0LBwV0fhzYY74cOs4DFOjr1KPvzcJcBf8KAaqsUcutRvmM9V9J4rg==
X-Received: by 2002:ac8:1201:: with SMTP id x1mr14518574qti.339.1605540434310;
        Mon, 16 Nov 2020 07:27:14 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z88sm10751007qtd.46.2020.11.16.07.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 07:27:13 -0800 (PST)
Subject: Re: [PATCH] x86/cpu: remove needless definition for !CONFIG_X86_32
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201116094218.10508-1-lukas.bulwahn@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ef9fc100-78f9-4b8a-7c28-d413db041c1d@redhat.com>
Date:   Mon, 16 Nov 2020 07:27:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201116094218.10508-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 1:42 AM, Lukas Bulwahn wrote:
> The function flag_is_changeable_p() is used in:
>
>   - have_cpuid_p() for its CONFIG_X86_32 definition
>   - identify_cpu_without_cpuid() within its CONFIG_X86_32 ifdef-block

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

a bit of cleanup, identify_cpu_without_cpuid() be moved into the main CONFIG_X86_32 ifdef with stub for x86_64.

>
> So, there is no need to define flag_is_changeable_p() if !CONFIG_X86_32.
> Simply remove this needless definition.
>
> This was discovered with make CC=clang W=1:
>
>   arch/x86/kernel/cpu/common.c:283:19:
>     warning: unused function 'flag_is_changeable_p' [-Wunused-function]
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on current master and next-20201116
>
> Thomas, Boris, please pick this minor non-urgent patch.
>
>  arch/x86/kernel/cpu/common.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 35ad8480c464..b89dbc7ccb0c 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -280,10 +280,6 @@ static int __init x86_serial_nr_setup(char *s)
>  }
>  __setup("serialnumber", x86_serial_nr_setup);
>  #else
> -static inline int flag_is_changeable_p(u32 flag)
> -{
> -	return 1;
> -}
>  static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
>  {
>  }


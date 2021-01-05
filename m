Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067A22EAA2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbhAELs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729620AbhAELsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609847248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ClUuOmIXrBPfDVSqFPOKOMOGcWLMSgCQAXE3Y+wG7Kk=;
        b=ZWDD9FszUOnwQTKvzWU1znMZIiz+tnk7RF5XbM7effrG2DN3XjDobLYuxF52q7XH2RGvGQ
        62SvimLkgbWHKG59ZxzQ5C6RAR5z80LdjIW36mz9yirum3kor3QlMsbel+cTTMItXzEAHA
        r6htS17d+F1+TCFKPdkcYz9uTUL79VU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-W9CDSjZ9NaCr2yPgZyr9Rg-1; Tue, 05 Jan 2021 06:47:26 -0500
X-MC-Unique: W9CDSjZ9NaCr2yPgZyr9Rg-1
Received: by mail-wm1-f69.google.com with SMTP id w204so1155414wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 03:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ClUuOmIXrBPfDVSqFPOKOMOGcWLMSgCQAXE3Y+wG7Kk=;
        b=pP8CTPqTYyXz0sgssSIJboBKvhAQD/iol+HBRk83Ip0h8QFsZhLVoksN41f4y1Ybsa
         hgJ34yShoNQHrmGl7uUsEPV6j4KOIY/91hhHVYYb0IG1W801ztIQl/xi7AnOcn5pDfrQ
         M5mrfV4HOM289NaRdgG0xt2XMfpcboJGGzy2SUoNWIDhH+3QeUrrRBtPP/GOSxoP8737
         7jiFzgix8g725fdmOUKLY4grjfxo/dcFqZX50aeXbUJCdWkCpZT52DR2ARSRkqlXbMB7
         uIsr6B8D+xXFl2ybi4RMjjprERWlPx5/4PIGLpCDFFWo5Z6AqWCUocTb/YBLkbZ2mRu2
         Cb0A==
X-Gm-Message-State: AOAM533GV1O4fOn2Br0RuKubItJ9CZKLDubIrDS2drl0I+dk7lfgVpBs
        jW3r2iZzD0OZ2z7iy7xp3rbvLGvO8mW1hBLFDjDTQMoNr9G0XBKFMq7yxrGVFV+X4mCA5BGHBtZ
        GQCDOvmRm6o7jfrWXTuUoIBZC
X-Received: by 2002:adf:f891:: with SMTP id u17mr85387374wrp.253.1609847245496;
        Tue, 05 Jan 2021 03:47:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9I904n6T6jfhAhM0sgcAhzqezyiAlcELO+BwqoCvvPl9Z7tOkscAOuPKTxJP3uSvTmSjxlw==
X-Received: by 2002:adf:f891:: with SMTP id u17mr85387347wrp.253.1609847245243;
        Tue, 05 Jan 2021 03:47:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f77sm3622230wmf.42.2021.01.05.03.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 03:47:24 -0800 (PST)
Subject: Re: [PATCH 1/2] Enumerate AVX Vector Neural Network instructions
To:     Yang Zhong <yang.zhong@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kyung.min.park@intel.com, x86@kernel.org
References: <20210105004909.42000-1-yang.zhong@intel.com>
 <20210105004909.42000-2-yang.zhong@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fa46290-28d8-5f61-1ce4-8e83bf911106@redhat.com>
Date:   Tue, 5 Jan 2021 12:47:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105004909.42000-2-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/21 01:49, Yang Zhong wrote:
> From: Kyung Min Park <kyung.min.park@intel.com>
> 
> Add AVX version of the Vector Neural Network (VNNI) Instructions.
> 
> A processor supports AVX VNNI instructions if CPUID.0x07.0x1:EAX[4] is
> present. The following instructions are available when this feature is
> present.
>    1. VPDPBUS: Multiply and Add Unsigned and Signed Bytes
>    2. VPDPBUSDS: Multiply and Add Unsigned and Signed Bytes with Saturation
>    3. VPDPWSSD: Multiply and Add Signed Word Integers
>    4. VPDPWSSDS: Multiply and Add Signed Integers with Saturation
> 
> The only in-kernel usage of this is kvm passthrough. The CPU feature
> flag is shown as "avx_vnni" in /proc/cpuinfo.
> 
> This instruction is currently documented in the latest "extensions"
> manual (ISE). It will appear in the "main" manual (SDM) in the future.
> 
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/include/asm/cpufeatures.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index f5ef2d5b9231..d10d9962bd9b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -293,6 +293,7 @@
>   #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
>   
>   /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
> +#define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
>   #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
>   
>   /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
> 

Boris, is it possible to have a topic branch for this patch?


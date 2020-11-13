Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450C62B1A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgKML20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgKML0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605266785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Jz+qn6L2dKOdzkMNeYJ7i10uOGTnka7jGpACGkgmZc=;
        b=IG4lTBmx8LR5smq1hHHZyUNd9qnLVJOvd1JlfScJvJK4VNKqXGMS4SAI1z/Vwxcp8PNyyJ
        TooZj+dU8iyGjhIzr65RHcsEMe9TL7PkmYyqbn0/vskJYJI3A6Rzwbq5eSR410AstlerTb
        bDi+RSGv4ndgEiG3Yv51MjxYogyFGgs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-2wGfXzNZOIWdp31Tjarp-w-1; Fri, 13 Nov 2020 06:26:23 -0500
X-MC-Unique: 2wGfXzNZOIWdp31Tjarp-w-1
Received: by mail-wm1-f70.google.com with SMTP id s3so3761902wmj.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Jz+qn6L2dKOdzkMNeYJ7i10uOGTnka7jGpACGkgmZc=;
        b=NI/kBrZeT9WBi/08+YVGf+nm0+n+IcSAuv2RbP1sOOpYFHZ950wfnfjMKPl6R9ei7e
         g1faYYCO8Q1S0rmJZzPYakW9XAyLNRewvcVGT2qUm8CgVJ4akAwmyEkJCyzG4GVOZBO/
         Cj/Q380BkAQKdWR7MjdxZJJ8ITESHqLl1VbbOyMA+/k+8eofwxZqATZmeX1WDDoQQe8M
         A3yznCkReEkUA/MpMsqZyJ3Qqp9MGGM/ttqWzgVC61VQHXPKwft9p4qQExB+U7Inhws1
         7JQgiVG3u4/fCUV1BEdMjdS8YUDzJ3Szp0jka9Qgr7Mn/XgV0Vi+MV1W63w/m3+rUvX7
         0DDg==
X-Gm-Message-State: AOAM531ZGiKPKEJO44+jvrwZ7iLUxNgR4P4jfNb+lUtGl3sx7W0t22qT
        BGwA0QLyu8l20pzT1foXR6nfGqAOe1/dUF8QDK4G99PfHLMkMzSK7id7SO11QOAcU2Mpt2EmV/C
        /D7Sgg442UvsNcs7/OpNlvMps
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr2968113wrr.64.1605266782231;
        Fri, 13 Nov 2020 03:26:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmXD55VKOmbBrRbr3PNsC5EHvRtkKPqQGlAQnXcj1shncjQCtuO5fjUnS9Cwmq5oQpi6qGqw==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr2968095wrr.64.1605266782064;
        Fri, 13 Nov 2020 03:26:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g186sm19977226wma.1.2020.11.13.03.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:26:21 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: clflushopt should be treated as a no-op by
 emulation
To:     David Edmondson <david.edmondson@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Nadav Amit <namit@cs.technion.ac.il>, x86@kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
References: <20201103120400.240882-1-david.edmondson@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72b96832-634a-56f0-95aa-f9a282d8fbf8@redhat.com>
Date:   Fri, 13 Nov 2020 12:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103120400.240882-1-david.edmondson@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/20 13:04, David Edmondson wrote:
> The instruction emulator ignores clflush instructions, yet fails to
> support clflushopt. Treat both similarly.
> 
> Fixes: 13e457e0eebf ("KVM: x86: Emulator does not decode clflush well")
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   arch/x86/kvm/emulate.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 0d917eb70319..56cae1ff9e3f 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4046,6 +4046,12 @@ static int em_clflush(struct x86_emulate_ctxt *ctxt)
>   	return X86EMUL_CONTINUE;
>   }
>   
> +static int em_clflushopt(struct x86_emulate_ctxt *ctxt)
> +{
> +	/* emulating clflushopt regardless of cpuid */
> +	return X86EMUL_CONTINUE;
> +}
> +
>   static int em_movsxd(struct x86_emulate_ctxt *ctxt)
>   {
>   	ctxt->dst.val = (s32) ctxt->src.val;
> @@ -4585,7 +4591,7 @@ static const struct opcode group11[] = {
>   };
>   
>   static const struct gprefix pfx_0f_ae_7 = {
> -	I(SrcMem | ByteOp, em_clflush), N, N, N,
> +	I(SrcMem | ByteOp, em_clflush), I(SrcMem | ByteOp, em_clflushopt), N, N,
>   };
>   
>   static const struct group_dual group15 = { {
> 

Queued, thanks.

Paolo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A62FA862
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436762AbhARSJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:09:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407429AbhARSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:01:20 -0500
X-Greylist: delayed 85154 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2021 13:01:19 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610992789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2HNFh4tGmunTdtcHPmXNaPVbvrJW2x+rSByPsYMLmg=;
        b=ietSSJ+fcEHBt0sG2hixiLjlM0XY87lFomWIMynGGq9fsB7aRF9jm5NdaJxQNfQVyjdvPJ
        xs5mZPDOXf3dvmUe6k1W7LFL2hE9187FRNPjrFVZpaV5Nyd39qG3knZVEm+hVxXVvYHxuq
        iH0nkQjoyiqlSCXwDM0uwTpUW13d+Q0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-QxxzPROtPLKYNzGI9P4tag-1; Mon, 18 Jan 2021 12:59:47 -0500
X-MC-Unique: QxxzPROtPLKYNzGI9P4tag-1
Received: by mail-ed1-f71.google.com with SMTP id n18so8154722eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T2HNFh4tGmunTdtcHPmXNaPVbvrJW2x+rSByPsYMLmg=;
        b=i03xT8hyx14ZLP+zi2PmQqx4y1vOgk8ST0c9y84dX4vTANFdwj9V8InSnQ1IsfHGEX
         vZhsAXTeMJPuqkEy6pbkMpT5iM6wHsY7TehvmZMfl8DjI/OuJTUHUnNF6eQrCMIj3WLW
         NBQ9aLfg6xOzgRwqteFuK+URPql8CiIA93V5jRudj+lgJyBeH6YT3mGYsartxlYcDe4x
         +wpkvztRBXuZx3Hdo7ShSADJl242jK7mUZfHQ58Us0DfE/CbV/TK9vSLLXFLG6iw+L6d
         RUQWuLn8B+xeozwG2cbsLWbU3SfECweLLzAkLQCdRzm/PrqanzNDlZD0NUHLYAKAV3fb
         AcKQ==
X-Gm-Message-State: AOAM532SCXgyf5Ej7NpCb6r1xyzb1G6OJU8uMxXVNanCIcitMfnUZm/Z
        yf6Msx12NqLn7xuR7EWXr9UbIag80mlv2Ldj8lszNfjNwXh15Sojslv1tHkL+Kir/40km7AbYWa
        LGz2Whizb8Z15o3MLa7KTARU1
X-Received: by 2002:a05:6402:3510:: with SMTP id b16mr486886edd.242.1610992786136;
        Mon, 18 Jan 2021 09:59:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyA7xCdJb5UE0ciBeFtJ9lz3e0ooEmAyU4lBg8uFTIMUoWQdwOCLaoyinlppLP4Jo7SmRAPhA==
X-Received: by 2002:a05:6402:3510:: with SMTP id b16mr486870edd.242.1610992785978;
        Mon, 18 Jan 2021 09:59:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id he38sm9395037ejc.96.2021.01.18.09.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 09:59:45 -0800 (PST)
Subject: Re: [PATCH] x86/sev: Add AMD_SEV_ES_GUEST Kconfig for including
 SEV-ES support
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210116002517.548769-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4deb3ba-5c72-f61c-5040-0571822297c6@redhat.com>
Date:   Mon, 18 Jan 2021 18:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210116002517.548769-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/21 01:25, Sean Christopherson wrote:
> 
> @@ -1527,12 +1527,14 @@ config AMD_MEM_ENCRYPT
>  	select DYNAMIC_PHYSICAL_MASK
>  	select ARCH_USE_MEMREMAP_PROT
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> -	select INSTRUCTION_DECODER
>  	help
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory
>  	  Encryption (SME).
>  
> +	  This also enables support for running as a Secure Encrypted
> +	  Virtualization (SEV) guest.
> +
>  config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>  	bool "Activate AMD Secure Memory Encryption (SME) by default"
>  	default y
> @@ -1547,6 +1549,15 @@ config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>  	  If set to N, then the encryption of system memory can be
>  	  activated with the mem_encrypt=on command line option.
>  
> +config AMD_SEV_ES_GUEST
> +	bool "AMD Secure Encrypted Virtualization - Encrypted State (SEV-ES) Guest support"
> +	depends on AMD_MEM_ENCRYPT
> +	select INSTRUCTION_DECODER
> +	help
> +	  Enable support for running as a Secure Encrypted Virtualization -
> +	  Encrypted State (SEV-ES) Guest.  This enables SEV-ES boot protocol
> +	  changes, #VC handling, SEV-ES specific hypercalls, etc...
> +

Queued, thanks.

Paolo


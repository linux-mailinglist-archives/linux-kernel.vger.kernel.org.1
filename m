Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E9292A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgJSPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729544AbgJSPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603120660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7ovWK7RltKO0KeEsCS0Cs0Y2y32wxq5Sek3JRAbHEo=;
        b=BFezogByj1aLurNcUTebkYtXDjzsB73eU64ggMZGKN7nqp3aTIxubGMeM+9LC2u5Je69FP
        DFu7xf2MB4CANeKIoeLR0SM6bf66r17O2Z/4jO8Kmr1EuFZsKdsvpY/wUX9BUrmVgZ+AEo
        JfG6jegrq4sLxK/G9CqcUpTaxovk+BY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-Py3nXnP9NQOX3SV8KnMG7Q-1; Mon, 19 Oct 2020 11:17:37 -0400
X-MC-Unique: Py3nXnP9NQOX3SV8KnMG7Q-1
Received: by mail-wr1-f71.google.com with SMTP id t17so2728wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a7ovWK7RltKO0KeEsCS0Cs0Y2y32wxq5Sek3JRAbHEo=;
        b=kTJL+/vg3aWZYmSdGUZJEOhY6sOryFZl0k1oprsT4Ap1Jkf9WuzC5l8+t4maD/01GK
         PhZPUVhklyxQCkZRSXNv4l23Pes3Gd925FqRjwRYTu2bYMbFs1Q/YAJDWFloC0oVTpeW
         ZnOWAZAYc5M75p38sx5dvwFucBEAh1QpK+w5MvLI2Qe+btPyXmBUGdhwlHbk7Fmd42eX
         DaXcA7khAUl0flohl0BC+ARnnDPPLllSeBRQcsuG5MdxuHXSYuc0HF1Sm4WIyoSrwkwn
         2ZyXPsAoIkrRax8oA8iVMaGrLxoMLhVyQlJ7Rd6GYGPZIyqflImS8R7YF8UORZXaBj2R
         Q6IQ==
X-Gm-Message-State: AOAM531/dzjjSCq89l0X/Fiwaqy34pi/FXA7Lw0BJxGCbOIUxBuYci9Y
        BpmyR1T5xF/yOP/5giFX6j70Wk1x0ji3TD15qsxHGnHNjfQCXAlfx802XK1h0Et407pRLll67rq
        FphDVQIzFLJJ8Xv0DGCBv3LVs
X-Received: by 2002:adf:9e06:: with SMTP id u6mr46716wre.208.1603120655793;
        Mon, 19 Oct 2020 08:17:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrU3psweUfaYlpWF/qnlaOgo6R+sEWPLIXJNAQAKvV498q6G0djF0HOVliXhPJQxACX0ExFQ==
X-Received: by 2002:adf:9e06:: with SMTP id u6mr46697wre.208.1603120655619;
        Mon, 19 Oct 2020 08:17:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e7sm80707wrm.6.2020.10.19.08.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 08:17:34 -0700 (PDT)
Subject: Re: [PATCH] x86/kvm: hide KVM options from menuconfig when KVM is not
 compiled
To:     Matteo Croce <mcroce@linux.microsoft.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20201001112014.9561-1-mcroce@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ff8bc03-8503-a21d-e2b6-cb730e04c942@redhat.com>
Date:   Mon, 19 Oct 2020 17:17:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001112014.9561-1-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 13:20, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Let KVM_WERROR depend on KVM, so it doesn't show in menuconfig alone.
> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  arch/x86/kvm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index fbd5bd7a945a..f92dfd8ef10d 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -66,6 +66,7 @@ config KVM_WERROR
>  	default y if X86_64 && !KASAN
>  	# We use the dependency on !COMPILE_TEST to not be enabled
>  	# blindly in allmodconfig or allyesconfig configurations
> +	depends on KVM
>  	depends on (X86_64 && !KASAN) || !COMPILE_TEST
>  	depends on EXPERT
>  	help
> 

Queued, thanks.

Paolo


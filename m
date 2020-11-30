Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C392C86E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgK3OfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:35:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbgK3OfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606746835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFkLXb2ck3BWjmucBaw+f/gpFhUWWzy0p9pSm1cDYgw=;
        b=Cd7hXga/SK4SoHx6vmvzgnXRXFM4IeNUFVJ3ipjsaAVzh9D0RRqMS3+7h3/gnHgZoP9nL8
        xgmhMnWvIa4FkZmICKcCZLhmyYrNS0p8XYf9Fd6TH58CZ4GADYCFJtlL6B3d79B7k1H90N
        qBM6rMlG5Zw/KX87zTlL85clAfWubGI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-Wl7zScgjM5afuqeX8mGSZQ-1; Mon, 30 Nov 2020 09:33:51 -0500
X-MC-Unique: Wl7zScgjM5afuqeX8mGSZQ-1
Received: by mail-ej1-f69.google.com with SMTP id y23so5834103ejp.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFkLXb2ck3BWjmucBaw+f/gpFhUWWzy0p9pSm1cDYgw=;
        b=IqV5vicSZ0AZJN12RdgtFEsIHAzoRbSxqRO3vcakZlFmJp/hCqT9HG5psaJbK3739x
         16dzzcA+1DQ4MookHJhGOgsJVfJjpBppzw6OtHXwWJ7TZLdM41dup/YGxpFl/PstyZ5+
         vb8vmRyr2ntQq9V7ZGlKTIGK280e0UVCh9TWey55QehKGlylR70W5VmTXACcvCIJjWqU
         iVBTh6qgcrmZuGwVLCyPPp13D6tW6ItHLFlIrHgEIGruaL84a3upVLbnAVRS3CM91iT2
         aT6oReE3yrGICKY6ULGUWjEoSoaUhBQF/4cmUawfnXbRJqZIk4mKboYynZk+VDj9K7CM
         n89w==
X-Gm-Message-State: AOAM531M34ZucQB2FGgXgjF9GBM+HhJf9m56N14rGv11OxaYDb7K652E
        5NHkYWZS7CKqqJISL93eEbBHwJAkDfE8YSawX6gQQ30j+5c7IywTTRNlgI66v8IEpzJhT8ikjn0
        wTWv8fhwTShtuVGXZIR4tZOl0
X-Received: by 2002:a17:906:a218:: with SMTP id r24mr10440576ejy.372.1606746829959;
        Mon, 30 Nov 2020 06:33:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsu+a/K74PyJGaUN13cu1VH4GJRzXEObx7Bgwg01gB5/PI6z+n0lfbvWmX0Rt/JHx2FjPRLQ==
X-Received: by 2002:a17:906:a218:: with SMTP id r24mr10440470ejy.372.1606746828612;
        Mon, 30 Nov 2020 06:33:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w3sm9211804edt.84.2020.11.30.06.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:33:47 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: x86: implement
 KVM_SET_TSC_PRECISE/KVM_GET_TSC_PRECISE
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Oliver Upton <oupton@google.com>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20201130133559.233242-1-mlevitsk@redhat.com>
 <20201130133559.233242-2-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38602ef4-7ecf-a5fd-6db9-db86e8e974e4@redhat.com>
Date:   Mon, 30 Nov 2020 15:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130133559.233242-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 14:35, Maxim Levitsky wrote:
> +		if (guest_cpuid_has(vcpu, X86_FEATURE_TSC_ADJUST)) {
> +			tsc_state.tsc_adjust = vcpu->arch.ia32_tsc_adjust_msr;
> +			tsc_state.flags |= KVM_TSC_STATE_TSC_ADJUST_VALID;
> +		}

This is mostly useful for userspace that doesn't disable the quirk, right?

> +		kvm_get_walltime(&wall_nsec, &host_tsc);
> +		diff = wall_nsec - tsc_state.nsec;
> +
> +		if (diff < 0 || tsc_state.nsec == 0)
> +			diff = 0;
> +

diff < 0 should be okay.  Also why the nsec==0 special case?  What about 
using a flag instead?

Paolo


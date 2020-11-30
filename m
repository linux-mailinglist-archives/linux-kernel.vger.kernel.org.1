Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587F62C82D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgK3LFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728681AbgK3LFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606734216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZM8hGmh0HYKlxLF1MQnAl60sUuzhNOm03zoIM5nbspw=;
        b=Q2zjh7M4DM2jC2XKQ92cbJVqUI1SjUgT5w9CATvyyjQwEkEVjYvwa7KjkhV1K66O7h8QX4
        M0PUrdw5OYj+c5I+cWmKwskecVPZPwQqbkdJmbNBjF2/23baJhKvm5EkSqfd7QscHopqKa
        EJWx9TTEJiPDgrFCZAIP/VvnBiovtbg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-5sE5DlY4MN2XZBvqE28PTg-1; Mon, 30 Nov 2020 06:03:34 -0500
X-MC-Unique: 5sE5DlY4MN2XZBvqE28PTg-1
Received: by mail-ej1-f71.google.com with SMTP id g18so5597866eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZM8hGmh0HYKlxLF1MQnAl60sUuzhNOm03zoIM5nbspw=;
        b=ccKuvdJIapK9OjpURQZn5dk1pW1FOoOx/2+QcO/n08jzTkuTJmk72XQ/95sMiC6Vs1
         jzoR0rgqxJzFkmNkxRh7Rct2OZNBfl6jAggmpjC+aYVP8a010eoTTjJA+p+0d704uNS8
         DXZP0WD7oRTlUPur0WwTgfvm4MCvJWDeotPeBUMZQIRr3uRcUQkGGdVFYE+BILW/RHLT
         nx+xPDyd8Z2uQu2NKviXFCLKkY46gltq14KE/Z68yqDbm3CnQZkib+x3fXMzdHcU0UBx
         pHCPA0P65b3G8yJ/famJ9oCWlG02wUZQiXSV2SF1zEMpsA2UyQnkuHHw4+AW33FlkB4L
         JA5Q==
X-Gm-Message-State: AOAM532N3NPj5waRNWIYLX/arIaHM2MoOwrXz7inZ2gkvVfvhBYCpOjG
        wdxFcEkWuvdgRYlMpuaaNuZxKD0FW7XLAJH/YFXzNX8D6flEgCDvE65ydzG37NlEDTwmuAT1vti
        HYyFRCW/MljHNBntIJHW+aaZg
X-Received: by 2002:a17:906:4049:: with SMTP id y9mr9370138ejj.442.1606734212929;
        Mon, 30 Nov 2020 03:03:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwk9wPoUjFt1o1YFgMXhH50p+0HXcZVHi6I26KKsHXbrcGubZdrjbVI/wFYANXa1rmhlF9rSQ==
X-Received: by 2002:a17:906:4049:: with SMTP id y9mr9370101ejj.442.1606734212647;
        Mon, 30 Nov 2020 03:03:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id da9sm270504edb.13.2020.11.30.03.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 03:03:31 -0800 (PST)
Subject: Re: [PATCH RFC 01/39] KVM: x86: fix Xen hypercall page msr handling
To:     David Woodhouse <dwmw2@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220201609.28290-2-joao.m.martins@oracle.com>
 <20190222013008.GG7224@linux.intel.com>
 <44b102eb-ea74-7f19-3f4a-41dfc298d372@redhat.com>
 <188a300f8314dd30a3a71857f63f144a3ce69950.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51b7771a-0b76-37e3-a80b-e372a7467aca@redhat.com>
Date:   Mon, 30 Nov 2020 12:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <188a300f8314dd30a3a71857f63f144a3ce69950.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 11:39, David Woodhouse wrote:
> ... except that's a bit icky because that trick of falling through to
> the default case only works for *one* case statement. And more to the
> point, the closest thing I can find to a 'kvm_hyperv_enabled()' flag is
> what we do for setting the HV_X64_MSR_HYPERCALL_ENABLE flag... which is
> based on whether the hv_guest_os_id is set, which in turn is done by
> writing one of these MSRs 

You can use CPUID too (search for Hv#1 in leaf 0x40000000)?

Paolo

> I suppose we could disable them just by letting Xen take precedence, if
> kvm->arch.xen_hvm_config.msr == HV_X64_MSR_GUEST_OS_ID. But that's
> basically what Joao's patch already does. It doesn't disable the
> *other* Hyper-V MSRs except for the one Xen 'conflicts' with, but I
> don't think that matters.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34B2D599B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbgLJLqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgLJLoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607600562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvmqrOo/0XzGZZg0O2HlL38Tea/AMllImc8/xdniceE=;
        b=AY7gRZ+VgdwdfIk4H3IDpOSSAs78yaSj/Vrm9664KOdgtvw/RCqf0Tgs0YNARtopaxjFMx
        IeqOVYryxeEgorDIUaZrDD6V9lceWutt8EIZfqB6aY5wLTSBMhw69oFPa+T0i+dv6KvcE1
        9g72NF3Q4U3h7pTXiZqswCtDkUxFzns=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-gLmjkmH9Mbqrk6I9cV86XQ-1; Thu, 10 Dec 2020 06:42:40 -0500
X-MC-Unique: gLmjkmH9Mbqrk6I9cV86XQ-1
Received: by mail-ed1-f70.google.com with SMTP id c24so2319160edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KvmqrOo/0XzGZZg0O2HlL38Tea/AMllImc8/xdniceE=;
        b=jwnhWmzsQHtlAAClpqFRrKCm7FbvjunncpQSZXTlrPmklouMlckkGi9PxwtV7xSgft
         /4zhglseUR13txR8JqPvWb9pmMEm0rF2nihH5wXC0yhExL9hosUJ6u9VELR5jBGeEa4i
         LJEbNt0j0RZRwxVtyacbkT6N5kIy6dATtOhLRRfcGX51kE64Ym3DG7G1BTTcYFwGLLLD
         PMuhjHKCcdf/0Jr4mSvmWycnORwY9iyCYbH8S9S9kF+rz0ub6w6v10yNPNavS8aTrtuQ
         Fy0zprRVpwVuvY3qqWcJTWyHqNp5wbQz3F0WDEsZc+2W1xYUTQ1MndQIS50hxlHShKw8
         hzLQ==
X-Gm-Message-State: AOAM530M+IoXlpzuh2nuB0BsmSnRJLhblNjYJoVryCGv0qo26az8n7Ol
        1gB56+9vUGQFrSFrAhomJ4BHbIlKNPYAAtDPB2V7ttw8mCCSExsnZlQjZfMmKr+hH07ssp0Qqjb
        YnmnAqoc13yPHMurALS2cV6+s
X-Received: by 2002:aa7:d750:: with SMTP id a16mr6427689eds.252.1607600558893;
        Thu, 10 Dec 2020 03:42:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDnncFNdeBtR5AbuscJDCn2dnIHlks3zjHEtzQPIlcl3+fqWIq6GSh1UXjMTCzrvAo0u6pJA==
X-Received: by 2002:aa7:d750:: with SMTP id a16mr6427668eds.252.1607600558665;
        Thu, 10 Dec 2020 03:42:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id d14sm5110475edn.31.2020.12.10.03.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 03:42:37 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kvm@vger.kernel.org
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <87a6uq9abf.fsf@nanos.tec.linutronix.de>
 <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
 <87im9dlpsw.fsf@vitty.brq.redhat.com>
 <875z5d5x9m.fsf@nanos.tec.linutronix.de>
Message-ID: <b6e0656b-4e3f-cf47-5ec9-eead44b2f2e9@redhat.com>
Date:   Thu, 10 Dec 2020 12:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <875z5d5x9m.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/20 18:41, Thomas Gleixner wrote:
> Right this happens still occasionally, but for quite some time this is
> 100% firmware sillyness and not a fundamental property of the hardware
> anymore.

It's still a fundamental property of old hardware.  Last time I tried to 
kill support for processors earlier than Core 2, I had to revert it. 
That's older than Nehalem.

>> We try to catch such situation in KVM instead of blowing up but
>> this may still result in subtle bugs I believe. Maybe we would be better
>> off killing all VMs in case TSC ever gets unsynced (by default).
> 
> I just ran a guest on an old machine with unsynchronized TSCs and was
> able to observe clock monotonic going backwards between two threads
> pinned on two vCPUs, which _is_ bad. Getting unsynced clocks reliably
> under control is extremly hard.

Using kvmclock?  (Half serious: perhaps a good reason to have per-vCPU 
offsets is to be able to test what happens with unsynchronized TSCs...).

Paolo


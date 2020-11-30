Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B32C8814
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgK3Pd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:33:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgK3Pd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606750322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsipwzBDzb60ARfCi+QI1m4LWf3wJygQ0AAsNDCG40s=;
        b=A42DJ4bRoLoIqI0wXbmsnNkLBIDiuYD6WjjZJljLe2c6I6+tkwDwkGJsIpSrulphQ4STdN
        jkCn5m0eXyD16DITSENY0d6jiebdEfoiuFRxVobZ0lOTwSSx3IE59R/Mk08EsZK0wg1F43
        xNZIv/GzP5db6n+BXgi2w0Vakiop09Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-NR4_KuzoPbSBN4a7ceQqOg-1; Mon, 30 Nov 2020 10:31:58 -0500
X-MC-Unique: NR4_KuzoPbSBN4a7ceQqOg-1
Received: by mail-ed1-f71.google.com with SMTP id g1so6918709edk.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KsipwzBDzb60ARfCi+QI1m4LWf3wJygQ0AAsNDCG40s=;
        b=YUfifw0UhUnq6abHhZdmgKdfwVU5TQoogqjZGcpK+y5FSSEvdEKUP2xXpJN8Cl79Kk
         +CfyUiFp34/odWvqHXtDWCAul6vNycUrzEhVaCXRp1giJTuNfEteGhrVqWKGiIigIfH6
         gpb0e+7wRO7x1A6cMwPldmUhO9q8btD/2syO/p7G6lWGVOpfqjeDrsgKn3mp/o5FAt5h
         2cxDhjPJcUqxghSamZkNZ8fpB4F4Bppodu4hCC+j5+9YZQVwR+mWpj8sCze3Wgo/qs0M
         6U1+EcQCJnAYFOJC10e17ILhzVYPLIJcE6wMSdN4CgJyzY2Ks+L2b12fO1K7s+GzrPwm
         ci6w==
X-Gm-Message-State: AOAM533gaYS/DkuXrTWt2z9s3ZShupWnJ40w39n9dZ6jf/Nh7PIvs0Mg
        H8PPbZku02JKxgsPgh0tjUDf1xtw9AHPKFSXR2S827gXjGmC5rEc8up2pTdvVt7DTkxOe/ujUDd
        C+o86FYV6iz6Y0VJ5noMaeul3
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr13795686eju.305.1606750317522;
        Mon, 30 Nov 2020 07:31:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJAmnB5boOvr5IKy7hOk2umHPy16BXprPN19ur+qcGYoWH+aEvjXuHby4AMDAYp+vPRqAQxw==
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr13795389eju.305.1606750313897;
        Mon, 30 Nov 2020 07:31:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s5sm6581838eju.98.2020.11.30.07.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:31:53 -0800 (PST)
Subject: Re: [RFC PATCH 00/35] SEV-ES hypervisor support
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1600114548.git.thomas.lendacky@amd.com>
 <20200914225951.GM7192@sjchrist-ice>
 <bee6fdda-d548-8af5-f029-25c22165bf84@amd.com>
 <20200916001925.GL8420@sjchrist-ice>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60cbddaf-50f3-72ca-f673-ff0b421db3ad@redhat.com>
Date:   Mon, 30 Nov 2020 16:31:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20200916001925.GL8420@sjchrist-ice>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/20 02:19, Sean Christopherson wrote:
> 
> TDX also selectively blocks/skips portions of other ioctl()s so that the
> TDX code itself can yell loudly if e.g. .get_cpl() is invoked.  The event
> injection restrictions are due to direct injection not being allowed (except
> for NMIs); all IRQs have to be routed through APICv (posted interrupts) and
> exception injection is completely disallowed.
> 
>    kvm_vcpu_ioctl_x86_get_vcpu_events:
> 	if (!vcpu->kvm->arch.guest_state_protected)
>          	events->interrupt.shadow = kvm_x86_ops.get_interrupt_shadow(vcpu);

Perhaps an alternative implementation can enter the vCPU with immediate 
exit until no events are pending, and then return all zeroes?

Paolo


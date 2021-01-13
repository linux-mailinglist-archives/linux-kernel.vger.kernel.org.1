Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB402F4BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAMMzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbhAMMzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610542426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oaU4daw54x5G4bS61Zd9tUbzrhmAYFp/wRzh5x9E2lQ=;
        b=VyN7wpYhFPVkPlGWc6jiCek2RcDwR8K7xHNuZETUwKxE0WuEe0y6ILMkZoUiNpGfxYb1RC
        JtLTAuMnSOh98fTJWKglogwnvFRGdhjQ2I1lGc8ThKAsnVOaqGRGMQ8ofm7LcO6TsQOUSL
        1gyQAlct3vORXdFhVDMOxdGtCLZVxBo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-VTAcKSYGMoKpgczUuOD9LA-1; Wed, 13 Jan 2021 07:53:42 -0500
X-MC-Unique: VTAcKSYGMoKpgczUuOD9LA-1
Received: by mail-ej1-f69.google.com with SMTP id w6so839277ejo.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oaU4daw54x5G4bS61Zd9tUbzrhmAYFp/wRzh5x9E2lQ=;
        b=Jykc+ORRCELYxvGJmC0NprbmEN6/QXAI6BThiA5P6Zp4coz86RZFON0qGA+3rYzX8X
         JIcX2dyeb+ZvVu+egV9SBcNItRBPXiTx1xckzgB0Yec6XAQ15faNgePAgqMi7bI2qQa2
         Yx7tZxKDRa3qolESWkI3KEzu4NyK/Jwryb+utPmGp99bqETDgyvPPNMwJoHd2U0w22up
         KDmkI9FAqomCJvXX80LAO28XHCSuVwf9MuTUTLumC4VDmiWq1nOqQv0HNWQzBQpr4NTl
         zVdxW3ex+70YEOGyD2+nnEYU963+dW8lEgVgKbjzuYPYHMHWFyfh2g1pXJHnzDOd/sUz
         sZWg==
X-Gm-Message-State: AOAM530+tv9rdMTkVrhgv/+Jzl5Qyv5STbGLixof6Kxz06JCDI++SIh3
        0SOz5txKres7ZyGWoY2zPcPmbnhJBUjL7y+hhGUOBhVvXK7ijwNKB9yk7tJRgWa2aSAkpUnNm6r
        HH5KXnvJSygmVNI8Jn/v/pSGrYWbkgGRAO7icaNLhGmYWfqJ4Wja7Nurrq4qP+jONsaJbEmQRLv
        t9
X-Received: by 2002:a17:906:b306:: with SMTP id n6mr1429997ejz.473.1610542421238;
        Wed, 13 Jan 2021 04:53:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1n2c/T7A+Kbcmmtp14/O2acnGP0lhqqlosHEujLypRdqAFWVfOo4RQ48P18lJBu+9jvfw+g==
X-Received: by 2002:a17:906:b306:: with SMTP id n6mr1429982ejz.473.1610542421021;
        Wed, 13 Jan 2021 04:53:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r16sm808674edp.43.2021.01.13.04.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 04:53:40 -0800 (PST)
To:     Jason Baron <jbaron@akamai.com>, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        peterz@infradead.org, aarcange@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1610379877.git.jbaron@akamai.com>
 <ce483ce4a1920a3c1c4e5deea11648d75f2a7b80.1610379877.git.jbaron@akamai.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: x86: introduce definitions to support static
 calls for kvm_x86_ops
Message-ID: <ee071807-5ce5-60c1-c5df-b0b3e068b2ba@redhat.com>
Date:   Wed, 13 Jan 2021 13:53:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <ce483ce4a1920a3c1c4e5deea11648d75f2a7b80.1610379877.git.jbaron@akamai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/21 17:57, Jason Baron wrote:
> +#define DEFINE_KVM_OPS_STATIC_CALL(func)	\
> +	DEFINE_STATIC_CALL_NULL(kvm_x86_##func,	\
> +				*(((struct kvm_x86_ops *)0)->func))
> +#define DEFINE_KVM_OPS_STATIC_CALLS() \
> +	FOREACH_KVM_X86_OPS(DEFINE_KVM_OPS_STATIC_CALL)

Something wrong here?

> +#define DECLARE_KVM_OPS_STATIC_CALL(func)	\
> +	DECLARE_STATIC_CALL(kvm_x86_##func,	\
> +			    *(((struct kvm_x86_ops *)0)->func))
> +#define DECLARE_KVM_OPS_STATIC_CALLS()		\
> +	FOREACH_KVM_X86_OPS(DECLARE_KVM_OPS_STATIC_CALL)
> +
> +#define KVM_OPS_STATIC_CALL_UPDATE(func)	\
> +	static_call_update(kvm_x86_##func, kvm_x86_ops.func)
> +#define KVM_OPS_STATIC_CALL_UPDATES()		\
> +	FOREACH_KVM_X86_OPS(KVM_OPS_STATIC_CALL_UPDATE)
> +
>   struct kvm_x86_ops {
>   	int (*hardware_enable)(void);
>   	void (*hardware_disable)(void);
> @@ -1326,6 +1385,12 @@ extern u64 __read_mostly host_efer;
>   extern bool __read_mostly allow_smaller_maxphyaddr;
>   extern struct kvm_x86_ops kvm_x86_ops;
>   
> +DECLARE_KVM_OPS_STATIC_CALLS();
> +static inline void kvm_ops_static_call_update(void)
> +{
> +	KVM_OPS_STATIC_CALL_UPDATES();
> +}

This would become

#define KVM_X86_OP(func) \
	DECLARE_STATIC_CALL(kvm_x86_##func,	\
			    *(((struct kvm_x86_ops *)0)->func));

#include <asm/kvm-x86-ops.h>

static inline void kvm_ops_static_call_update(void)
{
#define KVM_X86_OP(func) \
   static_call_update(kvm_x86_##func, kvm_x86_ops.func)
#include <asm/kvm-x86-ops.h>
}

If you need to choose between DECLARE_STATIC_CALL_NULL and 
DECLARE_STATIC_CALL, you can have kvm-x86-ops.h use one of two macros 
KVM_X86_OP_NULL and KVM_X86_OP.

#define KVM_X86_OP(func) \
	DECLARE_STATIC_CALL(kvm_x86_##func,	\
			    *(((struct kvm_x86_ops *)0)->func));

#define KVM_X86_OP_NULL(func) \
	DECLARE_STATIC_CALL_NULL(kvm_x86_##func,	\
			    *(((struct kvm_x86_ops *)0)->func));

#include <asm/kvm-x86-ops.h>

...

#define KVM_X86_OP(func) \
   static_call_update(kvm_x86_##func, kvm_x86_ops.func)
#define KVM_X86_OP_NULL(func) \
   static_call_update(kvm_x86_##func, kvm_x86_ops.func)
#include <asm/kvm-x86-ops.h>

In that case vmx.c and svm.c could define KVM_X86_OP_NULL to an empty 
string and list the optional callbacks manually.

Paolo


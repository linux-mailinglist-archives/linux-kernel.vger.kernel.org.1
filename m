Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD542A94EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgKFK4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:56:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgKFK4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604660207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pjlo5JUIOTDUV4ZXiqwdy+qZTg/eMHp+BKLRgYqZ8mE=;
        b=U3GU0V0NwdQ/JylTHNF7veTVZhpTa4AM/AGGT8Q7/D7/50qb7EmpYSXzvKt8IMqV/0poID
        5R1I8w4Apnz7eg2p1qmm3hJTSFn5eGO9ykLtstj18CP9sugG/+17mETH+UcnIP0ZnAk3IX
        uJraK0157FOstSZIwEAeT89qr9m4wxE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-2U9ENbIHMFm6E1xKo69BGQ-1; Fri, 06 Nov 2020 05:56:45 -0500
X-MC-Unique: 2U9ENbIHMFm6E1xKo69BGQ-1
Received: by mail-wr1-f70.google.com with SMTP id q15so336310wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pjlo5JUIOTDUV4ZXiqwdy+qZTg/eMHp+BKLRgYqZ8mE=;
        b=DXuquwoCkZ1WSWE5m2a1q1mwXtKkuPGdmLYwU51Kj+IXS0dmUv9NWXPSd44KdbVFB1
         sVP8MSWusRP4Rj7FUIne+rLVqH1QMAZp0QxeWLO6b340azzaWaT6jj84Igp/Ksp3UmUz
         4YEmenB5svBrk5PEGZdoffqsvwddheeFyfJib5OcV9Ju9JdILM797swTFv6DSC8IbXYE
         Jxaod8Q+3WB+HpUEcMCLKqc7f6aJyPE0hut/AOidTOROGnqmslePoBLoZdMA583lRJ8y
         8EnfONoU2u6TQK4Ilgw2jNo56JYTUjvY6p1sB/+cbXktC6W6y1eDSYD4ChRAWr3fJft4
         O65g==
X-Gm-Message-State: AOAM533GDOQxH3mZkqBq0fOqr0xdoya+VC2bXqOQP+c9NPOyTw+Dynsa
        G0g0bVScFdLQcHzfduLYPAnffmwV3D0bDyI7qAzn3SetShCfZXTqMhyD75qpwZPRWetna0cCa4N
        VQmooesS0NkhPo8cw+o7AndmH
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr1971725wrn.362.1604660203951;
        Fri, 06 Nov 2020 02:56:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLhEYbJDRRuZZgGWT3qR8WnLrV1z/VwRATvbIzR/qs/MGtS5CJWD0uCE9tv38R2N1EHXwZLw==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr1971707wrn.362.1604660203733;
        Fri, 06 Nov 2020 02:56:43 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id b8sm1655312wmj.9.2020.11.06.02.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:56:42 -0800 (PST)
Subject: Re: [PATCH v13 05/14] KVM: X86: Implement ring-based dirty memory
 tracking
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
References: <20201001012044.5151-1-peterx@redhat.com>
 <20201001012222.5767-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a03b7cf0-8847-2a60-ea2b-b83f5d82939a@redhat.com>
Date:   Fri, 6 Nov 2020 11:56:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001012222.5767-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just very few changes:

On 01/10/20 03:22, Peter Xu wrote:
> @@ -6373,3 +6386,107 @@ ranges that KVM should reject access to.
>   In combination with KVM_CAP_X86_USER_SPACE_MSR, this allows user space to
>   trap and emulate MSRs that are outside of the scope of KVM as well as
>   limit the attack surface on KVM's MSR emulation code.
> +
> +8.28 KVM_CAP_DIRTY_LOG_RING
> +---------------------------

Here I made a few edits, but nothing major.  Throughout the patch I 
replaced "collected" with "harvested" since the documentation was using 
it already and it's a bit more unique ("collect" reminds me too much of 
garbage collection and perhaps could be confused with the kernel's 
operation for the reset ioctl).

> +#ifdef CONFIG_X86
> +		return KVM_DIRTY_RING_MAX_ENTRIES * sizeof(struct kvm_dirty_gfn);
> +#else
> +		return 0;
> +#endif

And this can be "#if KVM_DIRTY_LOG_PAGE_OFFSET > 0" instead.

Paolo


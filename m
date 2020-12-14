Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63342D9B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408310AbgLNPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:37:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729041AbgLNPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607960158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DECEVkejvKEgKFI8bOS/4J0XFApjXUaj3h1xvWKx3EE=;
        b=JfqgbFgAVGvF2ngCSZXeDzAs9XZruvneprSav8Ac0l0V/eEAz7bY6Da/dbSF9ERMwRNy2b
        snbHwMuz8XsVyLWvu0Wl3lHUZJVMrvs/FPZIGMd4OXcGZKLco4V9Hy9Z4viW6dmzVJKC29
        sCVSsxrlAWCZOOCWDx/PApKWisMSZhI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-PXWpYkYPN2makIFXC3p9Mw-1; Mon, 14 Dec 2020 10:35:56 -0500
X-MC-Unique: PXWpYkYPN2makIFXC3p9Mw-1
Received: by mail-wr1-f69.google.com with SMTP id q18so6769638wrc.20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DECEVkejvKEgKFI8bOS/4J0XFApjXUaj3h1xvWKx3EE=;
        b=XIZYoLx4YQGepFheHYCIAlB4k+6EHphyxHGNnaHgi1Zjt67rDVXoKZU5K8A8sxbYdx
         SlQylejwYOT9qzkGDgRJnxKHyed0SJUgXhB5A5PGCX4KTm8nl7Jj6vW3aXMHrE0vnHBV
         Q7Q5u3ZfrdwHZFWEup2Xy7HBxXXjAP2EUbpEsLFLG3g9Z+MWI6M5Y82Mh9aiXuqIYQ/U
         mREz0CyyhL9H69jBm4dAA1vT17WGQeyGMTuymfjgNTvAlRA9yhoLA1y2s6qwelfmaJ4f
         JBtmhiqkx+AIz0QiBm9OZpgHSLw4YWaIDtq2jVbPTaP7JZc0N0R+S8KOCJsg8Ymvzxko
         S9Dw==
X-Gm-Message-State: AOAM530w+5ZYc3SImlnBSfW1qv1ltHxRqUffj6sIUUlaNsleFXkJhPr6
        I/Oa0e5evlLE4szN6Ty9vrLpmj6Ka12i6NuBrGWTV/4kXhj3xGhh6GyKk0JGGVSBHIhO1rtcn/N
        ptNmvpD1bVNFHBViBw0dAwIAH
X-Received: by 2002:a5d:6888:: with SMTP id h8mr29806136wru.268.1607960155074;
        Mon, 14 Dec 2020 07:35:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7rdK0PuGBX1sD2m1eDyjCwqF02to1v1sgkA2jv5yfShT33w0gFa3u9Fazf74AnU+H4GRwRQ==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr29806122wru.268.1607960154860;
        Mon, 14 Dec 2020 07:35:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a62sm34615045wmh.40.2020.12.14.07.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 07:35:53 -0800 (PST)
Subject: Re: [PATCH v5 08/34] KVM: SVM: Prevent debugging under SEV-ES
To:     Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1607620209.git.thomas.lendacky@amd.com>
 <8db966fa2f9803d6454ce773863025d0e2e7f3cc.1607620209.git.thomas.lendacky@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98928403-7b70-74bc-e647-0f1a71ec98ca@redhat.com>
Date:   Mon, 14 Dec 2020 16:35:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8db966fa2f9803d6454ce773863025d0e2e7f3cc.1607620209.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 18:09, Tom Lendacky wrote:
> +static inline bool sev_guest(struct kvm *kvm)
> +{
> +#ifdef CONFIG_KVM_AMD_SEV
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +
> +	return sev->active;
> +#else
> +	return false;
> +#endif
> +}
> +
> +static inline bool sev_es_guest(struct kvm *kvm)
> +{
> +#ifdef CONFIG_KVM_AMD_SEV
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +
> +	return sev_guest(kvm) && sev->es_active;
> +#else
> +	return false;
> +#endif
> +}
> +

This code movement could have been done before.

Paolo


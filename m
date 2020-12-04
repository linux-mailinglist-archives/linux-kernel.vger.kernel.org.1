Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814F32CECCE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgLDLMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:12:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgLDLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607080267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/j9o0aMtbK+iCXtL48XT9SzYeWgplswBUn1K4plIIJo=;
        b=fp289rx9wlKJ0rZAg+MVlxjtYf4JaABm/MM/c6VkZ8jdC1ho8HUbmnkcoQGcrkgyNtnTHN
        IBSuuix/FM1TSX4KpO+xOOuZaE45vXBfeq7XB7SEmTMmfnWOruNCbRI9GAO+2daudPNISf
        O2yibLj6+73kr+3bID4HALFiJHLZSE4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-ylqHlADAMzyMErBken8WHg-1; Fri, 04 Dec 2020 06:11:05 -0500
X-MC-Unique: ylqHlADAMzyMErBken8WHg-1
Received: by mail-wr1-f69.google.com with SMTP id m2so2429605wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 03:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/j9o0aMtbK+iCXtL48XT9SzYeWgplswBUn1K4plIIJo=;
        b=ovSo3W+TzS0rDYtZ3Xs0YInQiNEvOQNQ1eKdD3nNuj6lfFny5HGMsqhgbAB3gm+eWm
         yXC9pOWJnyUGR6y+uPZOZJyrszAiTmCfs4mP6YHD8FqXvbPmlQTDa1dk25UnlhwPtb16
         0878CtyF7AO23npFKNMgnOL9kO9OCv0FF3spTQxmq01lCslFm2WtxjEkW0BSa48iTY3L
         7DvxvCAkTNzQ8fsiX4I3yCut6p70LlSLgS6Cst+bV3jUE2scWPWXRRMondXSlDaWKZRr
         y3Mdl3jMYh7UNpTpOC5iS++wJtCap10RCBE73NYb4alun79z7VLzl2hZ8FmpVsMUkWdv
         oQOg==
X-Gm-Message-State: AOAM530WkJahSz2eF8ikm7XXNSo9PkEaDnCuYN1WF9yrvmaTwW4H3+rj
        dJaDCCHOPcIiTssDJ4JNIblQYItqAnOqkjn7Pwy13rgg8OR3ruPClYv6ugerDLPkt8bJn2L3TnR
        tWe/gkKGSITUwm2fbtQ9F3/qS
X-Received: by 2002:adf:e544:: with SMTP id z4mr4399589wrm.83.1607080264428;
        Fri, 04 Dec 2020 03:11:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXI/qgR3hNN+mIU4D+6sj1PheqGHMz0GvaAC0S4MAFIFRza72ft7HZ5AeSVWORKWBqXf4PNA==
X-Received: by 2002:adf:e544:: with SMTP id z4mr4399554wrm.83.1607080264236;
        Fri, 04 Dec 2020 03:11:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y7sm3128192wrp.3.2020.12.04.03.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 03:11:03 -0800 (PST)
Subject: Re: [PATCH v8 18/18] KVM: SVM: Enable SEV live migration feature
 implicitly on Incoming VM(s).
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, Thomas.Lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, rientjes@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
References: <cover.1588711355.git.ashish.kalra@amd.com>
 <a70e7ea40c47116339f968b7d2d2bf120f452c1e.1588711355.git.ashish.kalra@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5af7ca40-69eb-0870-7bf2-9bc17685d03b@redhat.com>
Date:   Fri, 4 Dec 2020 12:11:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a70e7ea40c47116339f968b7d2d2bf120f452c1e.1588711355.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 23:22, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For source VM, live migration feature is enabled explicitly
> when the guest is booting, for the incoming VM(s) it is implied.
> This is required for handling A->B->C->... VM migrations case.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>   arch/x86/kvm/svm/sev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6f69c3a47583..ba7c0ebfa1f3 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1592,6 +1592,13 @@ int svm_set_page_enc_bitmap(struct kvm *kvm,
>   	if (ret)
>   		goto unlock;
>   
> +	/*
> +	 * For source VM, live migration feature is enabled
> +	 * explicitly when the guest is booting, for the
> +	 * incoming VM(s) it is implied.
> +	 */
> +	sev_update_migration_flags(kvm, KVM_SEV_LIVE_MIGRATION_ENABLED);
> +
>   	bitmap_copy(sev->page_enc_bmap + BIT_WORD(gfn_start), bitmap,
>   		    (gfn_end - gfn_start));

Why?  I'd prefer the host to do this manually using a KVM_ENABLE_CAP. 
The hook in patch 12 would also be enabled/disabled using KVM_ENABLE_CAP.

Paolo


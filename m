Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5C2ED5B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAGReZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:34:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbhAGReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610040778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWnOL4WW0a/zTNNmDoc+8E5RK1NTv6x+0aetcVGVDMk=;
        b=inkwDGFxM2FLxVvwzF4F89u9afy1k9M8LMPd7wWOOOhFw8/p//hxcfajL2Z9QhZFOX8Uza
        Dh51PYQPKiApZNURUB6BIFZ357IaFfrKqH4wvaL9HnRCZhdVWOB32AxaV3Fjm7b8nR3OaH
        BwRtG7PjoHiqnMyIAR9zh98pASSICfw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-PRV_VENkNmmFKKOUgvngPA-1; Thu, 07 Jan 2021 12:32:56 -0500
X-MC-Unique: PRV_VENkNmmFKKOUgvngPA-1
Received: by mail-wr1-f69.google.com with SMTP id 88so2920665wrc.17
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NWnOL4WW0a/zTNNmDoc+8E5RK1NTv6x+0aetcVGVDMk=;
        b=bD+NliALQKHY/utVqQDwZiaNvhumteMsrUOhtrYWbaL9+SOeJMsIbndKYwDzQUGWi3
         bfGkiPLPSk0wK9IlD77BCT5eY+XxPd9IEBKmggeXnSf9ohbVKmcJWYXfjdZdiUQX2fzR
         w0HQyvcr8CIECnpjMq25lSezv87KF3xH2ZFGZiSyMMvAH0dW5tz4s1IJ/JfG5Uxt746v
         9aFfb6p23CyjgEKT6TmMQkO+dzzwIHw453ST8K3aFIiV6qFacyfe775Nu1AMswy87fA/
         VeMTq/RmBa1Aem9NZc7EtKXYmrNXXfzAwcH3AvUKKZp9ByVSv/ANNKe3zLvBV3G5f7su
         XoTQ==
X-Gm-Message-State: AOAM531A2dGE68zgW+ESPEKkudb/JdwJ5FkfFoDnw+ps4eM5uAUiL5au
        o7VCaEnpcRlOsppQYgiX/eXOgXI+DkUGLbD3Awe+j3l7TA2AhcGagQJToLpzlSTFqX+IxqM3YMc
        K0G634mNmlooKDxwPxzWp+gkg
X-Received: by 2002:adf:9e47:: with SMTP id v7mr9842382wre.185.1610040775458;
        Thu, 07 Jan 2021 09:32:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzj6ERrKiiz6nNF/uGUGOK1Po7cuE8q0EYgZ+0gIBiGZ0O8mAcqYSykk7g7I+hTptjodXSOw==
X-Received: by 2002:adf:9e47:: with SMTP id v7mr9842375wre.185.1610040775315;
        Thu, 07 Jan 2021 09:32:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t188sm8326807wmf.9.2021.01.07.09.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:32:54 -0800 (PST)
Subject: Re: [PATCH v3 2/2] KVM: x86/mmu: Clarify TDP MMU page list invariants
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Leo Hou <leohou1402@gmail.com>
References: <20210107001935.3732070-1-bgardon@google.com>
 <20210107001935.3732070-2-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12a3a6fd-557f-ae6f-4687-c4c4b2a79587@redhat.com>
Date:   Thu, 7 Jan 2021 18:32:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210107001935.3732070-2-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/21 01:19, Ben Gardon wrote:
>   
> -	/* List of struct tdp_mmu_pages being used as roots */
> +	/*
> +	 * List of struct tdp_mmu_pages being used as roots.
                           ^^^

s/tdp/kvm/

Queued with this change, thanks.

Paolo

> +	 * All struct kvm_mmu_pages in the list should have
> +	 * tdp_mmu_page set.
> +	 * All struct kvm_mmu_pages in the list should have a positive
> +	 * root_count except when a thread holds the MMU lock and is removing
> +	 * an entry from the list.
> +	 */
>   	struct list_head tdp_mmu_roots;
> -	/* List of struct tdp_mmu_pages not being used as roots */
> +
> +	/*
> +	 * List of struct tdp_mmu_pages not being used as roots.
> +	 * All struct kvm_mmu_pages in the list should have
> +	 * tdp_mmu_page set and a root_count of 0.
> +	 */


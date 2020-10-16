Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889792907D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409658AbgJPO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409649AbgJPO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602860210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxUU6wZzA0Ye/CuWQkpYe1eoVOOSpaLhnMPncnxgBso=;
        b=cOEWCyaOk7MCM87D6E/u+LYCSu+SWYfKZwfA70Q/ORXGuEHTbrDdaM/pYhmZ/a0IL+afd2
        9eK+nS6oSwFjdfn4K+vctYvSyN8WgIkM7GSVrStf/C6NUfGaWjrXxM/yugYHyvwP4loO/R
        6PbHJNfpTJw2oNYpZjz5yJpdfzn17pg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-xi5W1cfvPkGiq3wfDlPTPQ-1; Fri, 16 Oct 2020 10:56:48 -0400
X-MC-Unique: xi5W1cfvPkGiq3wfDlPTPQ-1
Received: by mail-wr1-f72.google.com with SMTP id u15so1594078wrn.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZxUU6wZzA0Ye/CuWQkpYe1eoVOOSpaLhnMPncnxgBso=;
        b=V7f9wVAXq1RGcI3BR2e5YFGBIcONqE7cuJeBCP6DgPzq84eopldOyWbXMFyhJC+6cC
         atc7dFASBCOTbROtvZaoaUeq8WQlqYtbS2tti+YbZbWgau/l9IqnoQ17jEtdvFWMKC/l
         0vDCNs4H0cMcWssXGGxAW68xxTzI9rKIYH1qYJsoDzMfepZ2VN8+rMuOyRyngdVfv3/b
         s+fTFrMhV6xInUscRN8bONDV+/UsGc6ffTP1pPrQ6y267ppW3aLT4XHtQDBGATrQN76r
         mzm2iSRs7s+pwG2QRipPpMec3u3JAU1/FPKfN0RDbuXkmXD4wSColKV6UQeHC8EXL1MV
         0AHA==
X-Gm-Message-State: AOAM530+OEiuRgNS3ZXQV1U+t3Yg74El4W2l6WIXTi8tMqwUQm3wi4AR
        UpDp4O+aWEUJdT93gtlKZKjSOIv5rsCR6a0raSP2fdEppav9+xPX1cBmhFkequXy0f6I9vQcQ5R
        Owh3nSl/UndFHaBE/CpGHif3S
X-Received: by 2002:a5d:4802:: with SMTP id l2mr4289535wrq.282.1602860207144;
        Fri, 16 Oct 2020 07:56:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoJzs7daGcDiRqBnyLKbzuDcYdyikqUk1vi7RkoMxoJsfVfgPqrSfyEJMMiKVyoBIqrkmcAg==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr4289495wrq.282.1602860206865;
        Fri, 16 Oct 2020 07:56:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3? ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
        by smtp.gmail.com with ESMTPSA id c185sm3131302wma.44.2020.10.16.07.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 07:56:46 -0700 (PDT)
Subject: Re: [PATCH v2 04/20] kvm: x86/mmu: Allocate and free TDP MMU roots
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20201014182700.2888246-1-bgardon@google.com>
 <20201014182700.2888246-5-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ee0477f-553a-d22d-a7e9-f2e9186ff27e@redhat.com>
Date:   Fri, 16 Oct 2020 16:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014182700.2888246-5-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/20 20:26, Ben Gardon wrote:
> +
> +static void put_tdp_mmu_root(struct kvm *kvm, struct kvm_mmu_page *root)
> +{
> +	if (kvm_mmu_put_root(root))
> +		kvm_tdp_mmu_free_root(kvm, root);
> +}

Unused...

> +static void get_tdp_mmu_root(struct kvm *kvm, struct kvm_mmu_page *root)
> +{
> +	lockdep_assert_held(&kvm->mmu_lock);
> +
> +	kvm_mmu_get_root(root);
> +}
> +

... and duplicate with kvm_mmu_get_root itself since we can move the
assertion there.

Paolo


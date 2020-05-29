Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3917B1E7A79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgE2KYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 06:24:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42640 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbgE2KYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590747847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pxDBHAtntdYo3/I5jF5RO1+05QKmLkITNesr/lf56qc=;
        b=DBEx4+5FN/AD28aeTa6dXDKO2fUVDo1Zp3RPGaxoClkHagydljSivvmylb7ocwM+5Qwe1h
        xQCNm6dLkdoqqxI9zjqFNOgUWiFQCe6V3qcNmFaIEZeaSqe+CDxd8aJLRhvVQzSIIKRm0G
        l/UKtQF5Y18HyBfspStKx3z1+9QmeSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-qawquSnTOy-0VwhveRywAw-1; Fri, 29 May 2020 06:24:03 -0400
X-MC-Unique: qawquSnTOy-0VwhveRywAw-1
Received: by mail-wm1-f70.google.com with SMTP id b63so2434847wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 03:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pxDBHAtntdYo3/I5jF5RO1+05QKmLkITNesr/lf56qc=;
        b=JCFU3fIi+gnswbW6/u9Aeh+Z00H38FAEMIo/W8yJ9mYer00YvpSEDgclf6JZWBBwVk
         /jGClZgPGg5976BemDzhA9w237Q7C/noiRxbgv9JZ4rJK+aCY2BCKtVezjA7G1Tp5swh
         0MEcegcDu1fr2MyMmsL6DN8ljfiOonMhWjGWCUCpY2+UpiNjxsf1B0sTOmGf2BpNNqzB
         yWxxLS7ULUMwouDxlcDXvFd2vI7vCtaRnOzLHHwIeYkjO1maIlM0hBlWDV6rxbjaxdhJ
         UD3P+fD8gEvFE/+2z7Hltt1YXquNxGh8MKLacAeCizgWJgDxW7ovC8b65ciTWpZ3/I/1
         4zfQ==
X-Gm-Message-State: AOAM530cj5ULjD5vwGS+9tASZQiirV0Hpv5C36Wp5ceaEIfP2WqUfoSM
        tYgUDGcC9RBHDjyBZRDJpgYSq4yoQETUFvpZ2DFLTxfh4Kt+3o9ux4W5WzOVWYaOMgYTCq+zvlf
        x4H7EIqFHWkaG5GpQnE1v/HMc
X-Received: by 2002:a1c:df57:: with SMTP id w84mr8387054wmg.52.1590747842077;
        Fri, 29 May 2020 03:24:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTJlbT0P7UibD2L2+OQYbTMuMmZmH8apUHkw6a/gvcox+qHPjE6vge9qVAIxlOiHSEMqBYiQ==
X-Received: by 2002:a1c:df57:: with SMTP id w84mr8387030wmg.52.1590747841776;
        Fri, 29 May 2020 03:24:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id e6sm3010301wrx.80.2020.05.29.03.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 03:24:00 -0700 (PDT)
Subject: Re: [Qemu-devel PATCH] target/i386: define a new MSR based feature
 word - FEAT_PERF_CAPABILITIES
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20200529074347.124619-1-like.xu@linux.intel.com>
 <20200529074347.124619-5-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1aa68600-e48d-fa83-b2e2-b070a486afd4@redhat.com>
Date:   Fri, 29 May 2020 12:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200529074347.124619-5-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/20 09:43, Like Xu wrote:
> +        if (!cpu->enable_pmu) {
> +            *ecx &= ~CPUID_EXT_PDCM;
> +        }
>          break;
>      case 2:
>          /* cache info: needed for Pentium Pro compatibility */
> @@ -6505,6 +6528,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    if (kvm_enabled() && cpu->enable_pmu &&
> +        (kvm_arch_get_supported_cpuid(kvm_state, 1, 0, R_ECX) &
> +         CPUID_EXT_PDCM)) {
> +        env->features[FEAT_1_ECX] |= CPUID_EXT_PDCM;
> +    }
> +

I'm dropping this hunk two hunks because it's going to break live
migration with e.g. "-cpu IvyBridge,pmu=on".  We will have to add PDCM
by default only to future CPU models, but "-cpu host,pmu=on" will pick
it up automatically.

Paolo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96842303C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405485AbhAZLv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405357AbhAZLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611661161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0wKJ8J6J+aWfXtEgN9Cfp9ba8h0RDEg6xqqW3PaoLg=;
        b=HmVIW7ygFLw3GfwaLOcnLao9OOiGeKb6MvMbPVEuwsq7fxB/LyECKoU1Kbf2BV6WCm361q
        d5bv9psoxXtqX3dw+5ejAodOckCEDMKJavCs1erzGtjlAiwAieKAt5sJ3XCQNvUKI1ktoa
        OQEW8bxXVU+wZ/JdwRCfBl/trwPuIrY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-LRvjwGz0Pu-3JUBJqWb1nQ-1; Tue, 26 Jan 2021 06:39:19 -0500
X-MC-Unique: LRvjwGz0Pu-3JUBJqWb1nQ-1
Received: by mail-ed1-f69.google.com with SMTP id q12so4418747edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E0wKJ8J6J+aWfXtEgN9Cfp9ba8h0RDEg6xqqW3PaoLg=;
        b=YOCNjXJd4Qqk2LJ5m3VZ/pdBqVew8qjpHEA0sO52glV/RpYpxPVh+87vDcTTYiP1Dc
         tnGeGGQpZFIqsG77zMnZNP9+d5ARrmJ3c9AHnl1P4bnQbBS+wszgVeII1yin4LjLFYIq
         JUk4YwJxQAzXywElobFf0GVkCHzzp9LYyvrbEJhw6H98nY1L2skyhppB8eJF9aqizokL
         auC81N9PF4/AgwI9fGmCTeEz9PozwiGExD8pUK0OXhWLvm0wrI2NYftGaEXuwD7XKLLm
         ZGT2CxMqgkBBeL7w8sR1LpFybq9U264Fsl5qh6EOLLpIkLn2QCy1Sr9PtofwAkJVoeDK
         yIrA==
X-Gm-Message-State: AOAM533rj2n9jM3ZsDRNJ0ifrXhQG1MXXYHqUF0IWgc8sMX2ohuPGI+i
        iou0AS7TVIg/CS8arbD8ihRNjLgGV3URsGtBCrNObj90suZECLvHre7LkqlJjokMAJs8wpXA1pN
        KKPj5ORmxvJCr8/PAdz6h3NQ+
X-Received: by 2002:a05:6402:1ad0:: with SMTP id ba16mr4225092edb.287.1611661158280;
        Tue, 26 Jan 2021 03:39:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyBCj/eVq38FRL7pA2HJ547nNKlItj4J7SQ/h0RNsy0VMk2AC3XJ/PTdVLNn6qHkWVJqcq0A==
X-Received: by 2002:a05:6402:1ad0:: with SMTP id ba16mr4225074edb.287.1611661158155;
        Tue, 26 Jan 2021 03:39:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id bk2sm9746794ejb.98.2021.01.26.03.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 03:39:17 -0800 (PST)
Subject: Re: [PATCH v3 4/4] KVM: SVM: Support #GP handling for the case of
 nested on nested
To:     Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        mlevitsk@redhat.com, seanjc@google.com, joro@8bytes.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, bsd@redhat.com,
        dgilbert@redhat.com, luto@amacapital.net
References: <20210126081831.570253-1-wei.huang2@amd.com>
 <20210126081831.570253-5-wei.huang2@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3611af9-dce2-b07f-e5c4-5a47c7e519a6@redhat.com>
Date:   Tue, 26 Jan 2021 12:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126081831.570253-5-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21 09:18, Wei Huang wrote:
> Under the case of nested on nested (L0->L1->L2->L3), #GP triggered by 
> SVM instructions can be hided from L1. Instead the hypervisor can inject 
> the proper #VMEXIT to inform L1 of what is happening. Thus L1 can avoid 
> invoking the #GP workaround. For this reason we turns on guest VM's 
> X86_FEATURE_SVME_ADDR_CHK bit for KVM running inside VM to receive the 
> notification and change behavior.

Slightly reworked commit message:

KVM: SVM: Fix #GP handling for doubly-nested virtualization

Under the case of nested on nested (L0, L1, L2 are all hypervisors),
#GP triggered by SVM instructions can be hidden from L1.  Because
we do not support emulation of the vVMLOAD/VMSAVE feature, the
L0 hypervisor can inject the proper #VMEXIT to inform L1 of what is
happening and L1 can avoid invoking the #GP workaround.

Thanks,

Paolo


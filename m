Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43786286E54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgJHFwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728418AbgJHFwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602136373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltGs068siZf3xtEoiji16jcQ5M11pmWZuXAiz0lIBWM=;
        b=R6VyFQoJEFe5MlGN8xQqYzPWwQxFzsMqAyrkbLHI+CoDVKY1H6YowaTYs3pbiYSi6Pjp8v
        2s/EXC7+oQWilzExOfFuj1l4Pq0fgrkDfngxLYxUFIo3/jHJW+Lr2UZjg/9VajFBLDCCuP
        bzfmdPRx46Rf5vtwNGero5DiNMYblLQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-bqlMQGinNEKRuyr_6k5bLg-1; Thu, 08 Oct 2020 01:52:51 -0400
X-MC-Unique: bqlMQGinNEKRuyr_6k5bLg-1
Received: by mail-wr1-f69.google.com with SMTP id r16so3437751wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 22:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ltGs068siZf3xtEoiji16jcQ5M11pmWZuXAiz0lIBWM=;
        b=K/BFoYMVW6Gd3JoQy6qsHhmPzHhH+a0kHWTixSYl4tkRmxz2O4lGOO1bvzwbq6sBN9
         pIVgPmBSGdP6ZGsPVZp2wWK2VGm+O0OyIjOfKYwEaEAAlcEP0CKO0uRtgjidTVWJ+Kz1
         EtUBh0DakKiYi2One2E+1E5JWWwvLxjnffhHKFiRXpgitX0IYlPSxvxpbfbArlL2OKkv
         WLiIiEkl5BeT3kBZg2E0F0H0Yhtd63DKsfUoKU4FsX66XV49nEtXSMZQeqgZkdbDx7Ec
         kgTp8NvWnuInFZx8KvLGAfZ+Nmr242hRDuE6Tx04kqD935Vdln5aT4y15xvWGWU2t7AF
         hs7A==
X-Gm-Message-State: AOAM532SMaIVW9XvJ3M5PqT7nmPePFZlTsUlTuW5/YcHCmqsMWCgPvUS
        pKjkCwbJF4T3eE5SZ7lrGt1Tq+GjwOK41s1q3ricKe5iCpNyplx+JHmBmmxEZnS1wzi48emAxs5
        Z5cGcH9ezIuP0M/rRhP9H/Ajq
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr7171580wrr.248.1602136370098;
        Wed, 07 Oct 2020 22:52:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5Bm/ZD8U7+p2VglQe5fK4bJTyhYCj95+XyM/xiKcrn7gpj+d3p19Xy0SSDHPLrmm2ZEDASw==
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr7171562wrr.248.1602136369782;
        Wed, 07 Oct 2020 22:52:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff? ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
        by smtp.gmail.com with ESMTPSA id j14sm5759851wrr.66.2020.10.07.22.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 22:52:49 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Use a separate vmcb for the nested L2 guest
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, wei.huang2@amd.com
References: <20200917192306.2080-1-cavery@redhat.com>
 <587d1da1a037dd3ab7844c5cacc50bfda5ce6021.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aaaadb29-6299-5537-47a9-072ca34ba512@redhat.com>
Date:   Thu, 8 Oct 2020 07:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <587d1da1a037dd3ab7844c5cacc50bfda5ce6021.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/20 00:14, Maxim Levitsky wrote:
>>
>> +	if (svm->vmcb01->control.asid == 0)
>> +		svm->vmcb01->control.asid = svm->nested.vmcb02->control.asid;
> 
> I think that the above should be done always. The asid field is currently host
> controlled only (that is L2 value is ignored, selective ASID tlb flush is not
> advertized to the guest and lnvlpga is emulated as invlpg). 

Yes, in fact I suggested that ASID should be in svm->asid and moved to
svm->vmcb->asid in svm_vcpu_run.  Then there's no need to special case
it in nested code.

This should be a patch coming before this one.

> 
> 1. Something wrong with memory types - like guest is using UC memory for everything.
>     I can't completely rule that out yet

You can print g_pat and see if it is all zeroes.

In general I think it's better to be explicit with vmcb01 vs. vmcb02,
like Cathy did, but I can see it's a matter of personal preference to
some extent.

Paolo


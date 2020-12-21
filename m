Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4D2DFFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgLUSZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:25:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbgLUSZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608575063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIHhDp6JjovqIb+IiGQWcQSFYCxr+8xx7FZ95bj2vtE=;
        b=fRkDKVqhD2JiUbVsZk3DNnP+jyT02/R+xqTQep1X0W+Xly4icBSovwDepLug+WvLje3Ei0
        L1eFJNCXjX6FGcq6gG/eJBHDXBH87YFlj4xrhTospLz5bMHmK+rDvcHSWHKpkioi3Q7HVN
        AjFWt6GscEmcrCsbY73LJyi+kFIf//4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-o2FkEwoxORW1wSJgW7MQ7g-1; Mon, 21 Dec 2020 13:24:20 -0500
X-MC-Unique: o2FkEwoxORW1wSJgW7MQ7g-1
Received: by mail-ej1-f71.google.com with SMTP id u15so4314337ejg.17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yIHhDp6JjovqIb+IiGQWcQSFYCxr+8xx7FZ95bj2vtE=;
        b=Gyuc/SwKmhhiJ1Qw3Y9s3SVflKVkepgN3aDBasEehi5x86ECIQDSoDEkT8JlKtkRMC
         hKz7jsCSLMwzTnRdiJ83e2mggvFZuhevDf5K9qj/Kp+rkO5Pjf2XoGdNfoBszig8Zf7d
         PDz6ZMVJEigJwPu+Lfvf7RbKE3JvG/uzEGYmbUlXGvRjkCHsO5KjotunVr4jmE25oX07
         X5TuGzU6XLTiKTMveiNSU1B+4M9uhME1xsX/+9BEewAJQmJ4/3u+eu7PDIb+fsPFArHx
         romroNhYktq7M0IEDbH5vjtjGCsVmUxN/xL5RPYMTC0dxMB5gUJdVSOw/cr9phaqGL8k
         8CiA==
X-Gm-Message-State: AOAM5339kHNlaI829cnGdJob9q2u9J65Pqp81a0+O9lD5Emmc5RX+MP0
        PMZbAthpkn9cKc71jfVc05M1AQtEeGqlOboNgmRrzYs1Xu3p4f8it5OJkNQbwoImoRdqGZ+w+XC
        knf0V8GuLimaqXw0t7dFql1zI
X-Received: by 2002:a17:907:2061:: with SMTP id qp1mr16109767ejb.222.1608575058890;
        Mon, 21 Dec 2020 10:24:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5tpvy1N5ZQZV/nQ+r7ruRnK//awichKa9+ePVpHGO6xb4OUGHuiMWNdLcjY208ZHmqJtZdw==
X-Received: by 2002:a17:907:2061:: with SMTP id qp1mr16109751ejb.222.1608575058755;
        Mon, 21 Dec 2020 10:24:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id pv24sm9186118ejb.101.2020.12.21.10.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:24:17 -0800 (PST)
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Get root level from walkers when
 retrieving MMIO SPTE
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Richard Herbert <rherbert@sympatico.ca>
References: <20201218003139.2167891-1-seanjc@google.com>
 <20201218003139.2167891-3-seanjc@google.com>
 <87r1nntr7s.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <493c0252-7aa1-b14d-0172-91bf75cf7553@redhat.com>
Date:   Mon, 21 Dec 2020 19:24:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87r1nntr7s.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/20 10:10, Vitaly Kuznetsov wrote:
>> -	int root = vcpu->arch.mmu->shadow_root_level;
>> -	int leaf;
>> -	int level;
>> +	int root, leaf, level;
>>   	bool reserved = false;
> Personal taste: I would've renamed 'root' to 'root_level' (to be
> consistent with get_walk()/kvm_tdp_mmu_get_walk()) and 'level' to
> e.g. 'l' as it's only being used as an interator ('i' would also do).

Maybe agree on the former, not really on the latter. :)

Paolo


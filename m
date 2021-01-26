Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0230409D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405874AbhAZOkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390715AbhAZOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611671894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oe0wvqDebMI0CXdGaiTIbnTKoPtRWBVqJDqyisah7eU=;
        b=C14XKy0FuE/0/s3Hz+si+fyOkbiHV5DVKUXoAn+wSNrR9joFN+A04CLtx1vo/84Yf384uU
        agwn17aOTx4BQ7eHfGwPDL/YHE8rDhYtaAH1ToL/ior0MDfjaV9qPpAzIb0rqxFVnfGgd1
        5jKPWR8ZdzE35xErQYaCpFuYvTbeOeg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-1nufdXUTOs2A8g3lxaebzg-1; Tue, 26 Jan 2021 09:38:12 -0500
X-MC-Unique: 1nufdXUTOs2A8g3lxaebzg-1
Received: by mail-ed1-f69.google.com with SMTP id j12so9430078edq.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oe0wvqDebMI0CXdGaiTIbnTKoPtRWBVqJDqyisah7eU=;
        b=Fm23NP+2knDCa4+5K8n/lx3A6yHBRUGJKDjlTzO8+LlG9gRcTewnL90347nBU3ts4d
         89MddrI4LcpEsMY46mgF50SbJ4XfkTWqw8ZzO3V/fNHX66+cdvXXHA4/oJOWvjqS98bS
         69fNdF2TYVp1fOmLss1GY09hADSRIyMYXetl1zL/+69ib83+myxO8eEcHEYtGdwg/wZl
         Z7Pi1Z83fvjUYYng1/jAXdPhsc1O/xVXuDUv+fQkwFvAprMzb+1mud5ce0ssLH8MAt6q
         XHPlyaMVkp6UulBmJqwQn7XulGccpQ7kAmDFTN0863lFtxE4fhW1Hq7nIMl6+/7LKZl3
         LRjw==
X-Gm-Message-State: AOAM531IP6gXOHb45Wiwbfp2IPD6GAaGcQkwdQDFVt18BZKKT3otuXHJ
        E5E4P+ZzIoHKBFN3+/hHxRHv65glMyrjRJ3v8Ph5zxM85K+OXW5zTcS7LYC+7IajeNS3hCXHVOm
        6kH/KZV1oHXpalWoTqUZ6LqyS
X-Received: by 2002:a17:907:2851:: with SMTP id el17mr3445310ejc.405.1611671891323;
        Tue, 26 Jan 2021 06:38:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQ4GBnxdpp/J9Y1B6D0WQXhMe0svsRoxYvq0qLC77MuBwovQsJGin47Xvchi8pU47I84DrNQ==
X-Received: by 2002:a17:907:2851:: with SMTP id el17mr3445302ejc.405.1611671891185;
        Tue, 26 Jan 2021 06:38:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h12sm9956507ejf.95.2021.01.26.06.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 06:38:10 -0800 (PST)
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-16-bgardon@google.com> <YAjIddUuw/SZ+7ut@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 15/24] kvm: mmu: Wrap mmu_lock cond_resched and needbreak
Message-ID: <460d38b9-d920-9339-1293-5900d242db37@redhat.com>
Date:   Tue, 26 Jan 2021 15:38:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAjIddUuw/SZ+7ut@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 01:19, Sean Christopherson wrote:
> What if we simply make the common mmu_lock a union? The rwlock_t is 
> probably a bit bigger, but that's a few bytes for an entire VM. And 
> maybe this would entice/inspire other architectures to move to a similar 
> MMU model.

Looking more at this, there is a problem in that MMU notifier functions 
take the MMU lock.

Yes, qrwlock the size is a bit larger than qspinlock.  However, the fast 
path of qrwlocks is small, and if the slow paths are tiny compared to 
the mmu_lock critical sections that are so big as to require 
cond_resched.  So I would consider just changing all architectures to an 
rwlock.

Paolo


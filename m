Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95A527EFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgI3Qz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI3Qz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:55:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601484925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8EZjCnkyFc1cMjpMH0gu6rS7aovGZS/4aH0BOoM7mI=;
        b=TmR1CVaGn7ozshOVYmFOBUJ8i+gDE9aWIzbHUzQLy3cgpYfnwz/hynQKlyx87Ts8j2QkpI
        HhzgaJcfeLFdWUuOmwSo1hR5xzLCEL/6RJOfg3rGipSjOpOfq5y+MzmJTfOGlxx0sD+FOz
        fXCU24GjudA/V0+E/4TAkYvJSiXRuJw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-XjuwIYULOwGdZPOKmkt3Rg-1; Wed, 30 Sep 2020 12:55:22 -0400
X-MC-Unique: XjuwIYULOwGdZPOKmkt3Rg-1
Received: by mail-wm1-f71.google.com with SMTP id y18so64101wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B8EZjCnkyFc1cMjpMH0gu6rS7aovGZS/4aH0BOoM7mI=;
        b=aYaOkJ97yQtfOJEllSmf0j9cHz7vXWyM64LLtD9rDZQLVn/RQlbKE3nwncHvtuIs/b
         EKcY7U0RZKzsz31/LKPr8EZTjN9ezxz+o8UeaOqlxOFLuY70BTPEPAnRQZFVahPETWnf
         dWT3Xsh7i2AWs2Fbg/MI/sfPqg0JlCBFd7uDQILVLT647X9z2NnZTbqs9nHZmp5pRITo
         YyJEsqxvT3RmWNm0KBba/MsM1nu5jf7R5/2Fg96Xrg3Jz8dhRtJF+ERrOl5m3q6MMIzt
         Acf3bSNY1fKOHA5hCbMQpaLmqbs3IdWtygXkH4fTD5sF2Dsag1vji7a7qWScHo+By245
         mEhQ==
X-Gm-Message-State: AOAM533zvFqOzYdM+yAoZbeHT3hWZEwoQZhUyPftycm4fALADJGr9cpd
        oKqnV0FVYZJzMpoFVoiSTGTypf6xgwZXia3ZEC2ER23WmWY3Zo4/R1Z0f8ZgJtgZVOU51Ul/P6Z
        uJ1VjvjhZt5JiAFdwhd01HhAp
X-Received: by 2002:a1c:b703:: with SMTP id h3mr3915207wmf.131.1601484920439;
        Wed, 30 Sep 2020 09:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpqMWMCf8rNOLTb8uVhzIBXgspOLuTByal+8MYiknPL2xBZbFeEcfJ4nRe0PKpiG562hHDqw==
X-Received: by 2002:a1c:b703:: with SMTP id h3mr3915176wmf.131.1601484920155;
        Wed, 30 Sep 2020 09:55:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4? ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
        by smtp.gmail.com with ESMTPSA id h4sm4746659wrm.54.2020.09.30.09.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 09:55:19 -0700 (PDT)
Subject: Re: [PATCH 10/22] kvm: mmu: Add TDP MMU PF handler
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-11-bgardon@google.com>
 <20200930163740.GD32672@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ee2a2cf-625b-3c10-a7da-75677ea37aa3@redhat.com>
Date:   Wed, 30 Sep 2020 18:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930163740.GD32672@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 18:37, Sean Christopherson wrote:
>> +
>> +	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)))
>> +		return RET_PF_RETRY;
> I feel like we should kill off these silly WARNs in the existing code instead
> of adding more.  If they actually fired, I'm pretty sure that they would
> continue firing and spamming the kernel log until the VM is killed as I don't
> see how restarting the guest will magically fix anything.

This is true, but I think it's better to be defensive.  They're
certainly all candidates for KVM_BUG_ON.

Paolo


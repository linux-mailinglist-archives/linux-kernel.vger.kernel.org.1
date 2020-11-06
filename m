Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86DF2A93EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKFKSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbgKFKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604657886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yzk7p3eTaQyL5wtsKR5oklwe+xjCN3EJ0U6A47oK3k0=;
        b=ay0gAqPfz58kmDtkHJKxDfPArR5S2iXYLOjL1opgd/CEv5becI8hVHGj2LJmbQVNVRyX86
        lynlBRfTqPE7lzybxs0VoFyBeypFcKEIP3nbUtK7pkDRTmBmXod0z6nSHdnHJ6tAwQGCnn
        Cq4y70OrnmqhjVR04DGf9Tzstx2KTY4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-AlLQUnLWNxyUlfVEi22OKw-1; Fri, 06 Nov 2020 05:18:04 -0500
X-MC-Unique: AlLQUnLWNxyUlfVEi22OKw-1
Received: by mail-wr1-f70.google.com with SMTP id x16so301372wrg.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yzk7p3eTaQyL5wtsKR5oklwe+xjCN3EJ0U6A47oK3k0=;
        b=BCL0l4PlsSjFjiYi/Bma2+sQx6LkLEZwnzbXx7VKw1B0SloD+YcIyJLsWuakHp4hqn
         8VFfeLx6TmMNOLqmXBnR1OEmuY9ICIElACgm22VP8LiGA0bvIjQv3K+Xabxa1JMBpin2
         i8viZVOk14JXiNTYKr63qCsePAtl/XbahEKH0pdtndE4aDd/hMmLH1rAIPdX4gQ8YjVr
         BhAO0dTzS7kfeSFYltao4bDYzL7Ch9dRSJMw3w3rZv9n/u+nNtp3sW5FHqdRrtlNh/kq
         6D61eeHl7ctjtrXzNOeydVfJDuy8+NADGkcIKEA5M2By56D8/gHJTgq+uICD0Xt1z4r1
         OCxg==
X-Gm-Message-State: AOAM533o8Kg0rslDP2x+hauGJ2o27kQuu9dUa93gyKvBHn3/AzsM5Dh8
        1onca6VlHNGQhVPRrjckmJn/8DD0sZ1fNUoM2u9iFk1TXai0kA5X4XPzHqi1hLENlgTisKRZpW7
        QqloeM/iF2Z6XMM1uojIQ5qWZ
X-Received: by 2002:a5d:4104:: with SMTP id l4mr76525wrp.276.1604657883307;
        Fri, 06 Nov 2020 02:18:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB2u9mosiunWtpr+aCXh7Ej3eCO/BmFfUkhzOjK2rINBlvPD+3Osb4sZK4nnIZVF5p75slog==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr76504wrp.276.1604657883127;
        Fri, 06 Nov 2020 02:18:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id e25sm1449631wra.71.2020.11.06.02.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:18:02 -0800 (PST)
Subject: Re: [PATCH] x86/kvm/hyper-v: Don't deactivate APICv unconditionally
 when Hyper-V SynIC enabled
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, junjiehua0xff@gmail.com
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        Junjie Hua <junjiehua@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1604567537-909-1-git-send-email-junjiehua@tencent.com>
 <87sg9n3ilt.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <348f8763-3842-0dda-2c01-6c5d510fe630@redhat.com>
Date:   Fri, 6 Nov 2020 11:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87sg9n3ilt.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/20 16:53, Vitaly Kuznetsov wrote:
>> The current implementation of Hyper-V SynIC[1] request to deactivate
>> APICv when SynIC is enabled, since the AutoEOI feature of SynIC is not
>> compatible with APICv[2].
>>
>> Actually, windows doesn't use AutoEOI if deprecating AutoEOI bit is set
>> (CPUID.40000004H:EAX[bit 9], HyperV-TLFS v6.0b section 2.4.5), we don't
>> need to disable APICv in this case.
>>
> Thank you for the patch, the fact that we disable APICv every time we
> enable SynIC is nothing to be proud of. I'm, however, not sure we can
> treat 'Recommend deprecating AutoEOI' as 'AutoEOI must not be
> used.'. Could you please clarify which Windows versions you've tested
> with with?
> 

Indeed---older versions of Windows that predate the deprecation will 
continue using AutoEOI.

Paolo


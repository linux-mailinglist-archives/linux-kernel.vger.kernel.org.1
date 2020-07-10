Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B849721BBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgGJRGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 13:06:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbgGJRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594400769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTZ1nOQ1nCOHsG301mu1C00Qszsv989jBZgL2Q/fhp0=;
        b=FbydY3mXxHGGkNqCE2oOnqIGPFsSwU92QiCUKNZO9RvhkW7OrPA9ZXlJLPYewUtisqn51/
        eWqhn8BxjDB7PdDZhaJuCe3rqq7mr2i2D8haZhi/xsYtpqejaBwTOL2krBZV9lVcDBLWWV
        HQTOUUmWzlRhghFhAwAEk/WZFB4N5aA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-QQQ1hRDLMfGBCs_whKgrug-1; Fri, 10 Jul 2020 13:06:08 -0400
X-MC-Unique: QQQ1hRDLMfGBCs_whKgrug-1
Received: by mail-wr1-f71.google.com with SMTP id 89so6595732wrr.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NTZ1nOQ1nCOHsG301mu1C00Qszsv989jBZgL2Q/fhp0=;
        b=B5xm54wo7/FzJsUlLuim83ozry2Thqt8wILBifSOP8nGKDBSfqiRZ/Gk+bZqGtfVZE
         se738J7jTtCiKTIP+QYrKP8sH7fd46CmzAlTnbm8ZXIlkkhn5oQPQJatmwxxknj/uyZh
         28edlprYJLiDBtYz1eG/R4OBGAKz/Rl7ETQpYQaLGWftviI42qjTp7uX2Dzy2YBVa0nQ
         NZbAFPfjMjqiezSQhLooCkk4OWqM8dZS1iCA5g1ZexiWwH3gnCizKyqTH2e7wKGE/owH
         5Q8n4PpilW1zYRc1DDUTab5BMiO3zKyeiFngguv8DdjnDbNf9/rUTifwu3AtqAJeNeNb
         91Pg==
X-Gm-Message-State: AOAM533u8xk4hE9fkJvqaBE8iETny3N6Lq5JZW0zFw8SB+2kJRYysXo/
        F4JS34jV1kmKKiHCAGYICdzVC1JcUXUP/M+PBCsmwAlyCy5ODbfqI3g+AB1IRweRVYthSjD3SfW
        DeljyM2cz958t2gEa4CRPmH7n
X-Received: by 2002:a1c:49d7:: with SMTP id w206mr6344800wma.181.1594400766850;
        Fri, 10 Jul 2020 10:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsM1AjQwejEwx6n+VewBHVbmmNXDaP6/ZzlHUjfU1w35i1uhnXyXxhWGn5e9sCA6yod3+NlQ==
X-Received: by 2002:a1c:49d7:: with SMTP id w206mr6344782wma.181.1594400766627;
        Fri, 10 Jul 2020 10:06:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id r28sm10152940wrr.20.2020.07.10.10.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:06:06 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Jim Mattson <jmattson@google.com>,
        Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200710154811.418214-1-mgamal@redhat.com>
 <CALMp9eRfZ50iyrED0-LU75VWhHu_kVoB2Qw55VzEFzZ=0QCGow@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c892b1e-6fe6-2aa7-602e-f5fadc54c257@redhat.com>
Date:   Fri, 10 Jul 2020 19:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eRfZ50iyrED0-LU75VWhHu_kVoB2Qw55VzEFzZ=0QCGow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 18:30, Jim Mattson wrote:
>>
>> This can be problem when having a mixed setup of machines with 5-level page
>> tables and machines with 4-level page tables, as live migration can change
>> MAXPHYADDR while the guest runs, which can theoretically introduce bugs.
>
> Huh? Changing MAXPHYADDR while the guest runs should be illegal. Or
> have I missed some peculiarity of LA57 that makes MAXPHYADDR a dynamic
> CPUID information field?

Changing _host_ MAXPHYADDR while the guest runs, such as if you migrate
from a host-maxphyaddr==46 to a host-maxphyaddr==52 machine (while
keeping guest-maxphyaddr==46).

Paolo


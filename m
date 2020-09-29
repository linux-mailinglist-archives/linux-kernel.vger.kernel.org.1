Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E418227C0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgI2JPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgI2JP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:15:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601370925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypt8LgdMVSyUFDx2ajf/v0PrV4X2XJYzLdUlFmhUgvY=;
        b=IErnP0ZNfhDa8KU44aPKScYFZPDEsmX6LZTrTV5RssM5gRArlCvRp3/FQTlOkrNYvfHdLf
        9VMQ6ADxzn7uswhrdvpy2aXmFXy2z31ON40gNlisrTShHlrGgBi4lb2dNasK1Y52IEu826
        W2hxsPpbaYyaBNH3V7i7yHHP2/KcKBw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-ejG1kumxNuSrQq8eWoOYNA-1; Tue, 29 Sep 2020 05:15:23 -0400
X-MC-Unique: ejG1kumxNuSrQq8eWoOYNA-1
Received: by mail-wr1-f71.google.com with SMTP id g6so1503418wrv.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ypt8LgdMVSyUFDx2ajf/v0PrV4X2XJYzLdUlFmhUgvY=;
        b=iu6X8NXHKvgvO/c101O+r1yzT+XYhSQfYdYBGKO0B4Cls+SV//rD0/UEmeyU7K5sPe
         o0P9cJxlQlvQ9t8iseUCmvgFwxlAugFDMaokZqZTsvDVbRrQqQ5triZFqSTzaW//wMjh
         4gJIUmC+XF/Is2fOiTIgXxiu9NcnthK/Fe3vAzwIpvXIvbUJ7jWgFq3VYIOEmwM6DbN4
         Zu3n9bHwnBX5m0ws2LcD5232KHTh6uGfProPPxDdur/c989JpihyIpN8bLJ1oIH4Mh+Q
         91PwyneZTZ32bsXUhKLJHjgHU4049sDtz9DOlcYG4OeaPCZTQMpmngsDGvIHNHxtIr5M
         MS1A==
X-Gm-Message-State: AOAM533U7SvW1IOhKzfEwFrcjC0IqzIC9+HiVJ/Ca87mrC7+/upaY8nP
        gA9L86RVV8fyimkGC6xkDUyGdTVMnVifr/CiKqh3AC1EqyxiOdInqv8Yhm72C9uY7gHQ0pHfZrB
        26f1sYbGz42Bc9bl0oyOqFd8b
X-Received: by 2002:a1c:7912:: with SMTP id l18mr3442452wme.124.1601370922093;
        Tue, 29 Sep 2020 02:15:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxya0bZiu1x+swKFOywBEtJWuTSDjfs6yaSqAv5yo6ryU2YWrILMOly6HzXmYqAMyK+58cTgw==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr3442435wme.124.1601370921899;
        Tue, 29 Sep 2020 02:15:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6? ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
        by smtp.gmail.com with ESMTPSA id o15sm4501936wmh.29.2020.09.29.02.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 02:15:21 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] KVM: x86: Use KVM_BUG/KVM_BUG_ON to handle bugs
 that are fatal to the VM
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Huacai Chen <chenhc@lemote.com>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20200923224530.17735-1-sean.j.christopherson@intel.com>
 <20200923224530.17735-4-sean.j.christopherson@intel.com>
 <878scze4l5.fsf@vitty.brq.redhat.com> <20200924181134.GB9649@linux.intel.com>
 <87k0wichht.fsf@vitty.brq.redhat.com>
 <20200925171233.GC31528@linux.intel.com>
 <731dd323-8c66-77ff-cf15-4bbdea34bcf9@redhat.com>
 <20200929035257.GH31514@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c195f6b4-c714-16e3-879f-0196540e1987@redhat.com>
Date:   Tue, 29 Sep 2020 11:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929035257.GH31514@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/20 05:52, Sean Christopherson wrote:
>> I think usage should be limited to dangerous cases, basically WARN_ON
>> level.  However I agree with Vitaly that KVM_GET_* should be allowed.
>
> On the topic of feedback from Vitaly, while dredging through my mailbox I
> rediscovered his suggestion of kvm->kvm_internal_bug (or maybe just
> kvm->internal_bug) instead of kvm->vm_bugged[*].

Also agrees with KVM_EXIT_INTERNAL_ERROR.

>> The other question is whether to return -EIO or KVM_EXIT_INTERNAL_ERROR.
>>  The latter is more likely to be handled already by userspace.
>
> And probably less confusing for unsuspecting users.  E.g. -EIO is most
> likely to be interpreted as "I screwed up", whereas KVM_EXIT_INTERNAL_ERROR
> will correctly be read as "KVM screwed up".

All good points, seems like you have enough review material for the
non-RFC version.

Paolo


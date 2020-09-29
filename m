Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44B027C526
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgI2Lbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729023AbgI2L3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:29:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601378941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jgd9+IvcGT8+fG9kgn+qU1iqHDwGn9/rK0K5vQ757us=;
        b=XaBXvrCBo7C+TIY1v+/9Nllr8xK4QYDutPIrQCdr8fGyYT5bLPHpXaVNNfwwf46z3J+CTt
        Y6KEjHSqQaekiYntcEujjpMwZPLu5qsdiKL+YjGVB88DCmgWXYvjvTTnkBZSj7AZjZxc3n
        BlsfiCxvW5ytPiTwOc7n1Orepwb0Onk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-RMn8nIjqMHKYAGvNNW66Zg-1; Tue, 29 Sep 2020 07:26:39 -0400
X-MC-Unique: RMn8nIjqMHKYAGvNNW66Zg-1
Received: by mail-wm1-f70.google.com with SMTP id c200so1703887wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Jgd9+IvcGT8+fG9kgn+qU1iqHDwGn9/rK0K5vQ757us=;
        b=J6TMMyzs6z9P1dIqdFMzA+ZuB4b6eHXSeEGmMMGnTlEfeosHooH42s2c5C2IJ6dj2H
         Xr1aGncr7m+hbT3lnjcMBOSQLtQGRuC9AOeVevNMkO1tl2iwleDxK0sJlAeVTptCE88x
         cv+TIW3KvJwg5oubDVdKHjUrXjYys5cYiFjOfNT1aw2dTg2WGP5/w9oynDFWhkanf/54
         L475RPXuIss3o+KXqfadQoQmbIHrgDE5ldr5gZNWnDUnAx5xJhDwTUDHbb06nrLZD6SW
         zgcUrgH43S0LLSeoWZD1GJd1qMzoBQjFpYj3f1YeAbtujwcaLu0sdNhpYFDTMZLhwKSx
         cFWw==
X-Gm-Message-State: AOAM533XdtJ7dIldaSU24XatovMMX9scsDc+Otz/IpdIDSGOBbnxKIIq
        RQMwvr+u81YzgDFY3hUiOk6Q54hemiCAan8wyabjcEa5sRTcZOd92adodS2hr7CAz8UN18QpIHE
        SdTSQXwStGL1MZqVnl26Gu0pI
X-Received: by 2002:a7b:c192:: with SMTP id y18mr3898925wmi.108.1601378798097;
        Tue, 29 Sep 2020 04:26:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyxP52XOengRaEtx3AULabzHo2vMHQxAZX3YMtDk64jHdZoOKQWBO6sgitlALK/aRFssPWCA==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr3898895wmi.108.1601378797780;
        Tue, 29 Sep 2020 04:26:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a10sm5010727wmj.38.2020.09.29.04.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 04:26:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Jon Doron <arilou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] KVM: x86: hyper-v: always advertise HV_STIMER_DIRECT_MODE_AVAILABLE
In-Reply-To: <34ea6c7c-6c10-5cdb-de75-6b4afc023dd2@redhat.com>
References: <20200924145757.1035782-1-vkuznets@redhat.com> <20200924145757.1035782-5-vkuznets@redhat.com> <ded79131-bef1-cb56-68ca-d2bc596a4425@redhat.com> <875z7wdg43.fsf@vitty.brq.redhat.com> <34ea6c7c-6c10-5cdb-de75-6b4afc023dd2@redhat.com>
Date:   Tue, 29 Sep 2020 13:26:36 +0200
Message-ID: <87lfgsbz83.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/09/20 12:36, Vitaly Kuznetsov wrote:
>>> Sorry for the late reply.  I think this is making things worse.  It's
>>> obviously okay to add a system KVM_GET_SUPPORTED_HV_CPUID, and I guess
>>> it makes sense to have bits in there that require to enable a
>>> capability.  For example, KVM_GET_SUPPORTED_CPUID has a couple bits such
>>> as X2APIC, that we return even if they require in-kernel irqchip.
>>>
>>> For the vCPU version however we should be able to copy the returned
>>> leaves to KVM_SET_CPUID2, meaning that unsupported features should be
>>> masked.
>> What I don't quite like about exposing HV_STIMER_DIRECT_MODE_AVAILABLE
>> conditionally is that we're requiring userspace to have a certain
>> control flow: first, it needs to create irqchip and only then call
>> KVM_GET_SUPPORTED_HV_CPUID or it won't know that
>> HV_STIMER_DIRECT_MODE_AVAILABLE is supported. 
>> 
>> Also, are you only concerned about HV_STIMER_DIRECT_MODE_AVAILABLE? E.g.
>> PATCH3 of this series is somewhat similar, it exposes eVMCS even when
>> the corresponding CAP wasn't enabled.
>
> All of them, but this was only about the vCPU ioctl.  I agree with you
> that the system ioctl should return everything unconditionally.
>
> But perhaps the best thing to do is to deprecate the vCPU ioctl and just
> leave it as is with all its quirks.
>

Ok, I'll do exactly that. I'm not sure if there are any
KVM_GET_SUPPORTED_HV_CPUID users out there bisedes QEMU/selftest but
let's take the 'safest' approach.

-- 
Vitaly


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8E22960A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900652AbgJVOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2900642AbgJVOGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603375609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IksS0dWGNjACWPqrKqEiMIvP6KsFkhmhvk7S1rPtye8=;
        b=auu+H5J6yk2ytG6UydYefjj+onhnNSEYwgRvfSlaZtMyKArIqdHeelO8m7mjNRhGySIDxk
        H8LgXik/G/ZfdKdoNmRvMTTdIRbQiNJmxs80Ol0rNnAonMV6aRuUICLuH80rmDsBq+29+w
        tut6nIn1gOiaZdNp63zKm47OTU3bKiM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-CBgnZqf3MO-ZeyN65TlyZA-1; Thu, 22 Oct 2020 10:06:48 -0400
X-MC-Unique: CBgnZqf3MO-ZeyN65TlyZA-1
Received: by mail-wr1-f70.google.com with SMTP id 47so663566wrc.19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IksS0dWGNjACWPqrKqEiMIvP6KsFkhmhvk7S1rPtye8=;
        b=Z7gHiMb4eMNSMjLvBfIuetqLbk/YfI7BTY+YvTsf3BOPzlKPaFLuFzkzzUl2oKCPFJ
         JdI9j+7Zp+LJWfCv4k4dLUVdblwSA3AUiglPnioQ46RCvfiXf0jW2QHoISM6dH/jgj7A
         5L7NqEoeDH+f06rLoRFxVLveZd4qXFabbIpx7vPeXE7R/7PcHeVvv2tFq/emVMRmkUJz
         xQhs3Ukk9mmPfo1LUHmerLvYmWPOzpgONgOrx6iegbS3OqHsjPThBFeIKFLT/sbf2hx3
         MU90NJCEZTinvo0XAR9X8WSCslWaCT1Ik2k1yxw+Ab+BDs4dbq2gFV7YhOr7eWLSXGvt
         aeMg==
X-Gm-Message-State: AOAM532EZwpmmun8gssosiQZ/Iu+uTkV74ZXeXjHB6JnrvRP3bXeHqGq
        FzbVLxuzLxif1Z62J7e3lOR1NVEdTH4nry7w4sNQexeWlulPCs/ihmJBhCrEg+IswhWpWGQva5Q
        2x3vfUkaWZIkG5dly4qkAcJ1U
X-Received: by 2002:a7b:c259:: with SMTP id b25mr2633247wmj.141.1603375606752;
        Thu, 22 Oct 2020 07:06:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoNQeHJNOP1tlc5K9b2forzKL95uimESQ1LxcUbal3YLzrd4t5sn+mT1MWkl0piTT/MsTq0w==
X-Received: by 2002:a7b:c259:: with SMTP id b25mr2633225wmj.141.1603375606556;
        Thu, 22 Oct 2020 07:06:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 10sm4361466wmn.9.2020.10.22.07.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 07:06:44 -0700 (PDT)
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1603330475-7063-1-git-send-email-wanpengli@tencent.com>
 <cfd9d16f-6ddf-60d5-f73d-bb49ccd4055f@redhat.com>
 <6ad94df6-9ecd-e364-296a-34ba41e938b1@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: X86: Expose KVM_HINTS_REALTIME in
 KVM_GET_SUPPORTED_CPUID
Message-ID: <31b189e0-503f-157d-7af0-329744ed5369@redhat.com>
Date:   Thu, 22 Oct 2020 16:06:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6ad94df6-9ecd-e364-296a-34ba41e938b1@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/20 15:31, Xiaoyao Li wrote:
>>
>> It's common for userspace to copy all supported CPUID bits to
>> KVM_SET_CPUID2, I don't think this is the right behavior for
>> KVM_HINTS_REALTIME.
> 
> It reminds of X86_FEATURE_WAITPKG, which is added to supported CPUID
> recently as a fix but QEMU exposes it to guest only when "-overcommit
> cpu-pm"

WAITPKG is not included in KVM_GET_SUPPORTED_CPUID either.  QEMU detects
it through the MSR_IA32_UMWAIT register.

Paolo


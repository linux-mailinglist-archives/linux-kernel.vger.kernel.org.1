Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94D2FA84E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbhARSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407469AbhARSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610993003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3fOsl24D+clK1mP7t8IC2anP5pI+fdytFfqpN21NNg=;
        b=DcKAlFDFAcdayUy71dy92a/XGJ5F4gLqDHacLVhejA4iE3+gnNfyXcvC5kHkVVhwnk7gdh
        z/3DUgQrD4pI/mVT0mQ7rD4Fs6CfKPap9cth/2bEhXCJm6+hd1aWFOGoU/LNYtV0xuFgHy
        dJpgW1vEDH2qKAKfHHyX7J0Q2UrN29A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-Nvu6KrWVMq62QqFjsuB5Vw-1; Mon, 18 Jan 2021 13:03:21 -0500
X-MC-Unique: Nvu6KrWVMq62QqFjsuB5Vw-1
Received: by mail-wm1-f72.google.com with SMTP id h21so4868362wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v3fOsl24D+clK1mP7t8IC2anP5pI+fdytFfqpN21NNg=;
        b=X4+YEcLw4RpWfIrA9dqoLqaJKasCxqfxllO7s3GLqPAR9aNE6EL0EiMVTsjuX2BB3u
         Uc+IUNm+l9FUy7f9d1mPT+/QEmypNpp53cXY3dptNbTnvcgKo5WTVJvI2R/NJnmfsg/J
         uJHupwXDvONB8+qC4FVL/vheH65xKl26GJXZyLvoN6LFvv11cr0o/qAZZBRjg9gdu6Cu
         P/MKTJ2N77Lxm3LiduPloOg54W30RSfaa1G5luivRKAT1OZ2n9pv6y0PB1Fvv7Vg30RT
         cA/xiQKRFEEgIbNZTgw9vOchLolUm89n2svw5i13ZkB5IBbseuQ4Qbq6/Y1dzjMUSzQF
         eGwQ==
X-Gm-Message-State: AOAM530R/mflvTj1eY9h/quKEFUgy0wOvl7FXa4hSbkxRZ0bBakRLm+G
        jPFYkcN5kIFZ2Tm4O9xUJRYHkuC+XDSsiv2HPwj1EsNzbIv1Hu5JCHhoLnAU1BVDWCYjRzO4k0B
        WFcXmxQ4eFNpiJU8gXz663eYd
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr494671wmq.95.1610992999979;
        Mon, 18 Jan 2021 10:03:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGH/62H+In2XTV+JBTIIODitgnHjg2s+H947E9xDwCPeLH1Tz18EkxBmDXrthGgZ8q4IzwEQ==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr494637wmq.95.1610992999778;
        Mon, 18 Jan 2021 10:03:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m21sm167198wml.13.2021.01.18.10.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:03:18 -0800 (PST)
Subject: Re: [PATCH] x86/sev: Add AMD_SEV_ES_GUEST Kconfig for including
 SEV-ES support
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20210116002517.548769-1-seanjc@google.com>
 <015821b1-9abc-caed-8af6-c44950bd04f0@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d795f19-2ac8-ea74-4365-41ea07f8eeec@redhat.com>
Date:   Mon, 18 Jan 2021 19:03:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <015821b1-9abc-caed-8af6-c44950bd04f0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/21 06:40, Tom Lendacky wrote:
> 
>> Introduce a new Kconfig, AMD_SEV_ES_GUEST, to control the inclusion of
>> support for running as an SEV-ES guest.  Pivoting on AMD_MEM_ENCRYPT for
>> guest SEV-ES support is undesirable for host-only kernel builds as
>> AMD_MEM_ENCRYPT is also required to enable KVM/host support for SEV and
>> SEV-ES.
> 
> I believe only KVM_AMD_SEV is required to enable the KVM support to run 
> SEV and SEV-ES guests. The AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT setting is 
> only used to determine whether to enable the KVM SEV/SEV-ES support by 
> default on module load.

Right:

         if (IS_ENABLED(CONFIG_KVM_AMD_SEV) && sev) {
                 sev_hardware_setup();
         } else {
                 sev = false;
                 sev_es = false;
         }

I removed the addition to "config AMD_MEM_ENCRYPT_ from Sean's patch, 
but (despite merging it not once but twice) I don't really like the 
hidden dependency on AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT and thus 
AMD_MEM_ENCRYPT.  Is there any reason to not always enable sev/sev_es by 
default?

Paolo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA82D9B73
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439370AbgLNPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:51:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439036AbgLNPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607960954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPVMdkrOLjH4YG0WvH2MD8or3IV6IeS+xhG/nPpSr6k=;
        b=JfKFymRNRR9vxcbMP7rA7pEhpdYANkd+0oSRqc67ejJz6h0pGWUIgUgklb9Kos7ooUMeUi
        DCVfOiVAl11l4FzWx9+rKzSMaBZpvpUGeJ9Vl/CiMNw9ucf0i1c3YQXwJKmoZwIsZeaAoI
        YmBwYZwo9GJ76ppl8imzkt5vZkUWIhg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-_5NvHFPcM0yIIV65NjKJWQ-1; Mon, 14 Dec 2020 10:49:12 -0500
X-MC-Unique: _5NvHFPcM0yIIV65NjKJWQ-1
Received: by mail-ed1-f69.google.com with SMTP id i15so8468241edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hPVMdkrOLjH4YG0WvH2MD8or3IV6IeS+xhG/nPpSr6k=;
        b=qHWskOgymTTOqlUkdlOhIUliRjpBJiFiYfAVPB0SWVJTDc1Bjpodsw6L45cmuNifjO
         8muvOqbS4IMvPOyUp0BIcBVgQHJiNCLdpthFp+3av7dh24gAmrHzahNwfrX+7gcMTaPL
         9EoZJTYT6Jdm7Iqip/5cLxh+MiGeW9SS1ls6+4KvydDkQTEI9PpPspNPUT3kcNuiFwXz
         2mlWSyjhmVPbEql+zHc/5pveAj88cbYeeWq2CzlV8gN1F+44vl9/rBfbeyccYyQlFePV
         UyshjOsxLVkkc99zQmg+5bMCVznbOIolRlkUifwUWVB/AH20aM+j+H7thcE7mExESig2
         GBbw==
X-Gm-Message-State: AOAM530bwU2EUecf3yQ4bGS2XA2gXG0VF4gk/MZyGTs7FKhUgzJO++Qd
        hbuhzAAp+UmnyJ1BRVnidUaL60PMLMDgI7/8E0g8a2YcCJRlPwRfsiI+5lNUCgOFdDgQcypV/1A
        BdugFDOd5tjor95XoABn1zObW
X-Received: by 2002:a17:906:d28f:: with SMTP id ay15mr22034668ejb.327.1607960951339;
        Mon, 14 Dec 2020 07:49:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyegjkkEcKatjPQPai67p6kOlbtipYi2XTi51XfOn3SGzvO1att8O9MxSTgI2mBCc3mR7Fg+A==
X-Received: by 2002:a17:906:d28f:: with SMTP id ay15mr22034648ejb.327.1607960951141;
        Mon, 14 Dec 2020 07:49:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t19sm11726057ejc.62.2020.12.14.07.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 07:49:10 -0800 (PST)
Subject: Re: [PATCH v5 16/34] KVM: SVM: Add support for SEV-ES GHCB MSR
 protocol function 0x100
To:     Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1607620209.git.thomas.lendacky@amd.com>
 <f3a1f7850c75b6ea4101e15bbb4a3af1a203f1dc.1607620209.git.thomas.lendacky@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1907a448-3fa6-70c6-e162-cb42ab79a95e@redhat.com>
Date:   Mon, 14 Dec 2020 16:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <f3a1f7850c75b6ea4101e15bbb4a3af1a203f1dc.1607620209.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 18:09, Tom Lendacky wrote:
> +		pr_info("SEV-ES guest requested termination: %#llx:%#llx\n",
> +			reason_set, reason_code);
> +		fallthrough;
> +	}

It would be nice to send these to userspace instead as a follow-up.

Paolo


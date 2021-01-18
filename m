Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291932FA7A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407148AbhARRhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436578AbhARRfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610991264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvg2z+rJE7oAboiLpvnNtZpTYMBCy/tGBkqn7W8lY0M=;
        b=E9CyQvEiaRNX79lu3BS9smfbWUs48VzfoWiXZRXXWQFsOO5KslBSFairKmprhiAPKEZrN2
        1DjGrrNWRcFzRHxYBH/l+CJW2mEI0GvsrDXHioR/Pti4WIGytveVn4wBZi9C8vbOc8Xtek
        e9pH+Z2Wp3JRbJmvVU+c9lJq572NRxs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-Vcr9oqreM9CgW1oYjSNU0Q-1; Mon, 18 Jan 2021 12:34:22 -0500
X-MC-Unique: Vcr9oqreM9CgW1oYjSNU0Q-1
Received: by mail-wr1-f72.google.com with SMTP id r11so8645505wrs.23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tvg2z+rJE7oAboiLpvnNtZpTYMBCy/tGBkqn7W8lY0M=;
        b=KK6Eexu7cUZPkObyofmfl5iftcys4fvrvDuF0zBj0W5h8+M9185f41RMK+7MDjNRVU
         3ZkdOsdqAj1syQfEeTOuHfIA6AfDZ/9evmpvxfl1Bh5gmGqKWoNymGWsucKHUPPU29nJ
         BAW5k0yGMGo0W9DuJ7oLZ6wgufge3Eaxm6GLIVzeMEACWHaJAOGNPUDBTfHBM+jISPLn
         qV8Tja/v5lji9xsYmZNbxaLcO4Ux3l0k50YqSBHECw3LETlddgjX1G8hx1sCxOOp0NFN
         /YSnhhMf/6JMy6saRIyYhnqTAwN8gHOsSZK/2uYbIFNV2kR9NhyrZ+HU3yQ4YDeWd4+b
         uWtA==
X-Gm-Message-State: AOAM531ls/RfEygYBbAMNtrIEWdlvX9WTpD+xVAhab7LuPLuHyEo+919
        YXtLW9GNEDBe+hW9MUKfKpLDzcmQ9ZchHlxPUZfEC/8d3k6O96KtZtbcnkyzrgjDXjpBv0I4+Lt
        fJ+TofKzkF2sxTGY+WX/smBkPK5M8k6/v9obiTRMj8HM2ZBdiPDGmzC8xpU0R5d9pr+bKUHpHar
        Hf
X-Received: by 2002:adf:ed49:: with SMTP id u9mr580679wro.292.1610991261266;
        Mon, 18 Jan 2021 09:34:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHdsDozji1Mbty0aRn53xFuOFArekZ/aSrjVwZRRRr7i/mb+3I5yS0zbfo3MHFnvOyhnhvZQ==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr580660wro.292.1610991261001;
        Mon, 18 Jan 2021 09:34:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v4sm31428402wrw.42.2021.01.18.09.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 09:34:20 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Add more protection against undefined behavior
 in rsvd_bits()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210113204515.3473079-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <947f0e1a-c8db-5c68-1e0c-abadd10d92fc@redhat.com>
Date:   Mon, 18 Jan 2021 18:34:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113204515.3473079-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/21 21:45, Sean Christopherson wrote:
> Add compile-time asserts in rsvd_bits() to guard against KVM passing in
> garbage hardcoded values, and cap the upper bound at '63' for dynamic
> values to prevent generating a mask that would overflow a u64.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 581925e476d6..261be1d2032b 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -44,8 +44,15 @@
>   #define PT32_ROOT_LEVEL 2
>   #define PT32E_ROOT_LEVEL 3
>   
> -static inline u64 rsvd_bits(int s, int e)
> +static __always_inline u64 rsvd_bits(int s, int e)
>   {
> +	BUILD_BUG_ON(__builtin_constant_p(e) && __builtin_constant_p(s) && e < s);
> +
> +	if (__builtin_constant_p(e))
> +		BUILD_BUG_ON(e > 63);
> +	else
> +		e &= 63;
> +
>   	if (e < s)
>   		return 0;
>   
> 

Queued for 5.11, thanks.

Paolo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD542ED66F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbhAGSKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727749AbhAGSKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610042951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tmc2SUr2EDYUvSr/Ugpsd9kuveplLIkFRP2hAGBtBmk=;
        b=hDJxfNDoVimnOxpjUGBSu4iAKwwwCa7bP3mv/zXy5IfOHfG1LiSJhv29JMM6JTELSJglz8
        KEWGxUYYWewFDwU+GVU5YneATnXpJGUYDPHuJ6pMrWXeIb4lVJY2Lzw2gltSvNzAOAQyul
        nl9NrGvjUYx2hHUNTyFfSWzZpO3NNz4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-GIMDVVXFO7aryrOk1f2AJg-1; Thu, 07 Jan 2021 13:09:09 -0500
X-MC-Unique: GIMDVVXFO7aryrOk1f2AJg-1
Received: by mail-wr1-f72.google.com with SMTP id g17so2966689wrr.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 10:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tmc2SUr2EDYUvSr/Ugpsd9kuveplLIkFRP2hAGBtBmk=;
        b=DY1LQ+m50g6yOmRiBOYlwY0MJeN/6HuT3AObx+PSSofpovUR41tBnXFa5YI1BHWWh0
         KmImzxap0dRVbjnKNADQMNvnfD+/4dZknZYvgEt6QHkGuKnpWH+4RuYQk/QExHh4DeAo
         SxLTnNu22QLnD5CpZ0tgpvSuHDQrYUJcL1FSmsgy6DEyqe8cOSIH7higQIr+amskn2hK
         OFNG3jAcrKtvSeSRWQnjoqz3PjUsLgprQ8nUIf5Qk2jm33QqYW21MpywOq3oJC+CICL4
         k5AZaLIBQz7eoqRp1t1EbPntiS6H5Goo/WOis9yg8HooZylhNT6MM7PfC84CXNXxiT+H
         EB5g==
X-Gm-Message-State: AOAM531JCHfL2DVXkgE69DNltQ+r8zt9WUFN3RUNob4cRadDDLKKq+bB
        LpAdeVQIHoldz6T+DWi4AOr8V5E6y1vl68KeCFnmTVBC6WHygypnp7ANqo4zMS6zYVxL30FDxzh
        SFhHmTiwuH7Ps4EXqnu5wKYJ4
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr9815097wrw.188.1610042948271;
        Thu, 07 Jan 2021 10:09:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXE1gHwUIxhIzO6TG3lEipQyZ/A/VhsKf7U7psi+SZvv4dijHU/+qhm67HIAUH8c/qp6kW/w==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr9815074wrw.188.1610042948050;
        Thu, 07 Jan 2021 10:09:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r16sm10445268wrx.36.2021.01.07.10.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 10:09:07 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Really update email address for Sean
 Christopherson
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20210106182916.331743-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c37441a-1588-e735-c8eb-0da80b8e1ba9@redhat.com>
Date:   Thu, 7 Jan 2021 19:09:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210106182916.331743-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/21 19:29, Sean Christopherson wrote:
> Use my @google.com address in MAINTAINERS, somehow only the .mailmap
> entry was added when the original update patch was applied.
> 
> Fixes: c2b1209d852f ("MAINTAINERS: Update email address for Sean Christopherson")
> Cc: kvm@vger.kernel.org
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c1e45c416b1..9201e6147cba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9776,7 +9776,7 @@ F:	tools/testing/selftests/kvm/s390x/
>   
>   KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
>   M:	Paolo Bonzini <pbonzini@redhat.com>
> -R:	Sean Christopherson <sean.j.christopherson@intel.com>
> +R:	Sean Christopherson <seanjc@google.com>
>   R:	Vitaly Kuznetsov <vkuznets@redhat.com>
>   R:	Wanpeng Li <wanpengli@tencent.com>
>   R:	Jim Mattson <jmattson@google.com>
> 

Applied, thanks.

Paolo


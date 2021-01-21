Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44862FECDE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbhAUO2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729554AbhAUO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611239149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilhpMvCfjFiElS7bgjbZqmd9IpUEn0B8JkfPwC0b+mk=;
        b=MThR4m43C+4Ox6T3KQ3tSGPuooIeJwt+TA9G9hYzcJDYugDAK9Dr+fUgFUwx7kv/gjGlmS
        raREN/hbzHr5Wf1mw5pAlDKx0+UyMJActNOu7UsNIuDPHr74QMOKVn7xxE4Z1cS3HKqHf0
        hgtzxZYujrZ9SIfseMnJM44k/tAjBgc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-SA_NArATNEeszKjtfTBHfg-1; Thu, 21 Jan 2021 09:25:45 -0500
X-MC-Unique: SA_NArATNEeszKjtfTBHfg-1
Received: by mail-ed1-f69.google.com with SMTP id e25so1232440edq.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ilhpMvCfjFiElS7bgjbZqmd9IpUEn0B8JkfPwC0b+mk=;
        b=t/Yd+WFbJYNPhV13f31b82qluRFzlsAiqrIZAVljWsVGznIkCmXjC6GmVzU2/rtro7
         A8CxsI5SlUezYKk6aENFgGVCFWPDMZj6b77LJxEcZ0lbrFUXAwo1lpJ+rXN8q2axCOS9
         sCSq8rmVEcO0vp9XQvNjMyWaMSvapetmJ7V4UixypsKEx4Gh9AZG3LIbWXRmC6FJQEcL
         WHhtd2YLRdCpRDhemD66b1ABwFkulVZ2fCtqwXpwOgW2C350gtl9Nl01/qaB9pWyK/vg
         MgzGHBltV84EdIV5K9TFJp97H4Qj5XdbD5SfOxTQtD3LZtwP0HEzZ0SJTbgDBuIpgj3D
         33ww==
X-Gm-Message-State: AOAM532WovqcrNA4+cYVYpTFFiTqTU3qBibP7/5JQ8SkTCHpg4XWxRRQ
        eK9V3MoCjnw8BxD6aejQ3ZN664EzG0kAD53up4FgnJzspt2rmAp1joC3g29k9GY9uBSLonpseTy
        NIv6Rq1Kr1gSDRlSuQyfs7pBL
X-Received: by 2002:a17:906:5618:: with SMTP id f24mr9395272ejq.517.1611239144786;
        Thu, 21 Jan 2021 06:25:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpASqyEPkiyX9HLBJSuLOzYLLasq+dJWlIvr4kVJBrv43P0n6PmUlJnq6LqcM4doL9ZwLq0A==
X-Received: by 2002:a17:906:5618:: with SMTP id f24mr9395260ejq.517.1611239144659;
        Thu, 21 Jan 2021 06:25:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id r10sm2870779edw.24.2021.01.21.06.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 06:25:43 -0800 (PST)
Subject: Re: [PATCH v2 4/4] KVM: SVM: Support #GP handling for the case of
 nested on nested
To:     Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        mlevitsk@redhat.com, seanjc@google.com, joro@8bytes.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, bsd@redhat.com,
        dgilbert@redhat.com, luto@amacapital.net
References: <20210121065508.1169585-1-wei.huang2@amd.com>
 <20210121065508.1169585-5-wei.huang2@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8eb44204-51c2-d3c8-3adf-f825544f3c88@redhat.com>
Date:   Thu, 21 Jan 2021 15:25:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121065508.1169585-5-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 07:55, Wei Huang wrote:
> +	if (nested && guest_cpuid_has(vcpu, X86_FEATURE_SVM)) {
> +		best = kvm_find_cpuid_entry(vcpu, 0x8000000A, 0);
> +		best->edx |= (1 << 28);
> +	}
> +

Instead of this, please use kvm_cpu_cap_set in svm_set_cpu_caps's "if 
(nested)".

Paolo


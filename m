Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6597D304EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbhA0BWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:22:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389253AbhAZSYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611685398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTz7Xoz/xvXYECYSVr5bsWFWwC4zp+4NtN2NN+NvbGo=;
        b=bsIZIhHk/f0FnX5xOUPvcRsAYxF2wV4Zsks9Wsj1ea1M2TwzQaCgrBNHwxaQ7kAnhQ4YB+
        TUGMWFlvXQoCs3fTNDViiChLuJTz0qOAHe8LuCq9KbmfkFCA0MYMcwW7pBl0/jQZ9VssEi
        ZYjMJ4aoSytZtVJ01Uvo4PAyY/saIso=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-YKksl6WhP5-zJuJiL-_Spw-1; Tue, 26 Jan 2021 13:23:15 -0500
X-MC-Unique: YKksl6WhP5-zJuJiL-_Spw-1
Received: by mail-ed1-f69.google.com with SMTP id a24so9772786eda.14
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTz7Xoz/xvXYECYSVr5bsWFWwC4zp+4NtN2NN+NvbGo=;
        b=c2Ha5B8ieyg5iyxZlUsanVrL6RtPfkDpPrgtz541vuzvrG4J+xqXPuEmWotP0cVtbQ
         jdrrmBtW31J1iSMOBVAzU2c0sSlilHKCMWr3yzOHPofpFs02WZV4tE3i2j3xHmq5t0Pd
         N5V1iQzJwbBt8kDnJQeffibJjvS1t41M3F5W17+DowKWrKPwIj5WiW0ZFU2OLpL64mT0
         4I8X7Jq4OhFhbvWLxfH3m9avALk7c84eGcNa2TUYmHgzt4ph4rCcH1l9cj//NFeZEsv5
         0cWviu+8ZgdZvdTejZD+D6egOR8eIEZHgSLnt1KSS6fdEh5ADgcRPS7wKQBbN8YqqMBB
         rSog==
X-Gm-Message-State: AOAM532+AdxH+fsvIR/OqnVW+Jmu8wnWSnR2Sqork0mCrRV9Z4CMYVA+
        Uz10V0z4GyeX4tuLgSml64Dj7egIFekG/JZXS8nCkY0vSmxPN8I0/Ezqd0hPIebJkRkXmfxlyZi
        KomZkAujhhqWnzmKaESJIeqK4gjTTTO7kgxPA5YClZzuGAkDdU9q6f+tcSQm7veV51HN+nfr5Hg
        8W
X-Received: by 2002:a05:6402:304e:: with SMTP id bu14mr5340168edb.60.1611685394138;
        Tue, 26 Jan 2021 10:23:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzr51I20o6O5R03Qzlo4pmpOKwtbS3ynzLph+LxnPczeJmRRvNM0dj1mdVqb/N74vT5qUFbNQ==
X-Received: by 2002:a05:6402:304e:: with SMTP id bu14mr5340145edb.60.1611685393882;
        Tue, 26 Jan 2021 10:23:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y2sm1522942ejd.27.2021.01.26.10.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 10:23:13 -0800 (PST)
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200807084841.7112-1-chenyi.qiang@intel.com>
 <20200807084841.7112-6-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 5/7] KVM: MMU: Add support for PKS emulation
Message-ID: <0689bda9-e91a-2b06-3dd6-f78572879296@redhat.com>
Date:   Tue, 26 Jan 2021 19:23:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20200807084841.7112-6-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/20 10:48, Chenyi Qiang wrote:
> 
>  		if (pte_access & PT_USER_MASK)
>  			pkr_bits = (vcpu->arch.pkru >> (pte_pkey * 2)) & 3;
> +		else if (!kvm_get_msr(vcpu, MSR_IA32_PKRS, &pkrs))
> +			pkr_bits = (pkrs >> (pte_pkey * 2)) & 3;

You should be able to always use vcpu->arch.pkrs here.  So

pkr = pte_access & PT_USER_MASK ? vcpu->arch.pkru : vcpu->arch.pkrs;
pkr_bits = (pkr >> pte_pkey * 2) & 3;

Paolo


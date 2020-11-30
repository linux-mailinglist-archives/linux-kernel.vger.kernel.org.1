Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D272C8CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbgK3S3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726977AbgK3S3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606760891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbtreiyDGBEVJHR6bcT5fhYEmcIXMhysj30QJYe5Mbc=;
        b=i+C1Z9t4OMYz3iu6Y8ygqvbxD45v4p3Vy5JVG3qncJ3aRYgaZvB3zQas/JLpiPZN+q8faW
        q9pdunU/gvMhjLqCSv7cY7/2tVdRIDoyZuV8lq9MKj7eGmFOU3lzRPhyKo6eSOMBlgzDtE
        LVnbBIYpeR+1j7xahcWojL79rhpl4S0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-oazmt_N0OP6eo_hIuHXidA-1; Mon, 30 Nov 2020 13:28:09 -0500
X-MC-Unique: oazmt_N0OP6eo_hIuHXidA-1
Received: by mail-ed1-f69.google.com with SMTP id s7so7211007eds.17
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TbtreiyDGBEVJHR6bcT5fhYEmcIXMhysj30QJYe5Mbc=;
        b=Y0pqTLrzoPeCzW6EXxYciaevtaR4S9cHcPY36ZkydekL88P++tkFWoT2nxK3jhsFrj
         4Oi++suH1EJYw4Dff/AeuM429/IUAdpOegpixJzQyPuQ06Djl8CwaojHuUx6nGtvtNiD
         iyNg4CcEBvfCElbcL1ZnmX3x5VW5W2wFujhugkCtS8I9MS4+3AIIWo260ktl5b3OYv1L
         GPjDUBtTJtqjQ46NT8AdMpGLpY53sMGXgq1r4BYYWRRFaiA6vHWNX5YEEeFxZm3K6GOV
         FRlwZUMc7JKD34sftu2E2jUsUBHBz0eZH4F8IEpFjoq843qZQGdNYbwVCFySecxGAP3L
         E6zg==
X-Gm-Message-State: AOAM5338P+bFoAUNpqxu7n0vGAop4y6y5glBCxYC0mDwcGT2CxEccuhL
        1OvMcqHn00/YqsWNKooidPn0I5loJWM9mnb0MtXpx+zeb4OHMUyEMD99ytFcpXRRAuCLfD3uhFZ
        XIQtzqXcdi0mEsWiHa3TtgnaS
X-Received: by 2002:a17:906:f8ce:: with SMTP id lh14mr10719379ejb.267.1606760885802;
        Mon, 30 Nov 2020 10:28:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI2tx7KbgvM1BKmi17D0Z7B1t1G7JZTOJ0/e6KdoqzSVgxvZ4sYKtg8ul1h6q4pwzHyzCJHQ==
X-Received: by 2002:a17:906:f8ce:: with SMTP id lh14mr10719164ejb.267.1606760883832;
        Mon, 30 Nov 2020 10:28:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h15sm6773411edz.95.2020.11.30.10.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:28:02 -0800 (PST)
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1600114548.git.thomas.lendacky@amd.com>
 <e08f56496a52a3a974310fbe05bb19100fd6c1d8.1600114548.git.thomas.lendacky@amd.com>
 <20200914213708.GC7192@sjchrist-ice>
 <7fa6b074-6a62-3f8e-f047-c63851ebf7c9@amd.com>
 <20200915163342.GC8420@sjchrist-ice>
 <6486b1f3-35e2-bcb0-9860-1df56017c85f@amd.com>
 <20200915224410.GI8420@sjchrist-ice>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 25/35] KVM: x86: Update __get_sregs() / __set_sregs()
 to support SEV-ES
Message-ID: <3f5bd68d-7b2f-8b1f-49b9-0e59587513c8@redhat.com>
Date:   Mon, 30 Nov 2020 19:28:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20200915224410.GI8420@sjchrist-ice>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/20 00:44, Sean Christopherson wrote:
>> KVM doesn't have control of them. They are part of the guest's encrypted
>> state and that is what the guest uses. KVM can't alter the value that the
>> guest is using for them once the VMSA is encrypted. However, KVM makes
>> some decisions based on the values it thinks it knows.  For example, early
>> on I remember the async PF support failing because the CR0 that KVM
>> thought the guest had didn't have the PE bit set, even though the guest
>> was in protected mode. So KVM didn't include the error code in the
>> exception it injected (is_protmode() was false) and things failed. Without
>> syncing these values after live migration, things also fail (probably for
>> the same reason). So the idea is to just keep KVM apprised of the values
>> that the guest has.
> 
> Ah, gotcha.  Migrating tracked state through the VMSA would probably be ideal.
> The semantics of __set_sregs() kinda setting state but not reaaaally setting
> state would be weird.

How would that work with TDX?

Paolo


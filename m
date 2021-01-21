Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B052FECD7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbhAUO0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730059AbhAUOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611238999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKetp3qvNfokfYo8zlseFMKLOIJriD8afQXzk6JdR84=;
        b=cmF75aKBDQnB5CuRrrnKIGM9usTTKEN9Z491AcpBGeafpj3QZBv09QQrvnFNY8Enmmy/zk
        vw8CJSv+O0q64VRRoxgLAJvsBuim99vJDPicY1rYNQ4LFATHi7ylTZ2vj0bUwYu8gBRAlw
        +qap/eW+kXrSTULQNYK4xpKvlZ0AteU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-vVC6pGQbNMCclP8KFwEj8A-1; Thu, 21 Jan 2021 09:23:17 -0500
X-MC-Unique: vVC6pGQbNMCclP8KFwEj8A-1
Received: by mail-ed1-f70.google.com with SMTP id m16so1210570edd.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKetp3qvNfokfYo8zlseFMKLOIJriD8afQXzk6JdR84=;
        b=J9jJZ5PI1estthcyv+jjf7zQl1O9HD+Wgs05jveakhdZ7uWzNd4+3YvfN3JB/0DkHD
         Memue3zrsm3dpJaBFBJHVmaymJgxF7Tip0D7hYLJ8A+5c6FfpUDH2KuupBNufXIyvmVl
         uufjCJhz5DogpKy9OHCdAFPb3ODYG+QSaWmxJZG8AU2kyynlJ5M2EZG0MSY+MzZ5IAeF
         bjBjnZ1Ih5dS43XXi1rQzEe6/jUzfc65u5F8XTrWZsdVG+GCVrgl1moBq9I8Jai72wpm
         c+sZMvB9zBJaj5suTf9+aE3maqMTMw0QCpBTo0i5s5RK01uAqWEMwCwwpuSLPbGBPw0T
         unUA==
X-Gm-Message-State: AOAM533diaDpBIaCpiBq2WP59Sg6NNjzOtK6OvHAhCTo/TSr+mLhDuRC
        6mIE/be1HU5HcnWm2gtVrV2aRko4UX9hp8mt0FLGSEJ8XBvQmVjQNiq5wDjwChMlmxTtBbludGX
        vJ/+lcirdkf0o5srl5JimqDu2
X-Received: by 2002:a17:906:14ce:: with SMTP id y14mr9159514ejc.366.1611238996057;
        Thu, 21 Jan 2021 06:23:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLExhiFQa62LdmbEKJnrpXnesCCKCtdV6xcBQm6dUfxJVpgY5Fl9wlWU4TsdErE+24Q9EGow==
X-Received: by 2002:a17:906:14ce:: with SMTP id y14mr9159503ejc.366.1611238995865;
        Thu, 21 Jan 2021 06:23:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id w4sm2874569eds.40.2021.01.21.06.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 06:23:15 -0800 (PST)
Subject: Re: [PATCH v2 1/4] KVM: x86: Factor out x86 instruction emulation
 with decoding
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        seanjc@google.com, joro@8bytes.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, bsd@redhat.com,
        dgilbert@redhat.com, luto@amacapital.net
References: <20210121065508.1169585-1-wei.huang2@amd.com>
 <20210121065508.1169585-2-wei.huang2@amd.com>
 <82a82abaab276fd75f0cb47f1a32d5a44fa3bec5.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3044193d-1610-fd67-e4ec-12a87fed62f2@redhat.com>
Date:   Thu, 21 Jan 2021 15:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <82a82abaab276fd75f0cb47f1a32d5a44fa3bec5.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 15:04, Maxim Levitsky wrote:
>> +int x86_emulate_decoded_instruction(struct kvm_vcpu *vcpu, int emulation_type,
>> +				    void *insn, int insn_len)
> Isn't the name of this function wrong? This function decodes the instruction.
> So I would expect something like x86_decode_instruction.
> 

Yes, that or x86_decode_emulated_instruction.

Paolo


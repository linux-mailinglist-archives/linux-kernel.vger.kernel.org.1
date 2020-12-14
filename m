Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142B52D9B55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392621AbgLNPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728558AbgLNPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607960525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MqMQKzQOSdZrk041m8eNtC5s8c67cMYU3gn9o6WzOQ=;
        b=dYKm10ZGzsZaRh42IPxmTJljk6I+e/VyxZSuSQeQD/kDP/wd2+hXiCEvqcZ9ddUpNeyLaG
        /Ra+SkC6J+QofUMq9uceghRgVUzm90Kl6hB/ox9CpYx69+nYeWFw9z3f08eXuhirxGi5A3
        z1MIq9H8VjXGg8QKV9mU9sf2nXiMzbw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-z3nZGyemNKGNr4TD8rkcBg-1; Mon, 14 Dec 2020 10:42:02 -0500
X-MC-Unique: z3nZGyemNKGNr4TD8rkcBg-1
Received: by mail-wr1-f71.google.com with SMTP id b8so6769800wrv.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MqMQKzQOSdZrk041m8eNtC5s8c67cMYU3gn9o6WzOQ=;
        b=W/n7DzGwVAADl9qap6V0Y3S2ub8hvbAPjRpNdcHAb3bhVeV8sVNiulJFY6RGjAR7fY
         G3nTlk6D0oIbdLRQmIQAQQU48BviohRIemu+YPBE7g24SkkFYkdyqXdhPb85LpPjsLMW
         nda5VjhRZgWt0mEPdeLk0a/zAHh0Kf3mMzm0j4CDVCdPNlBFuX8A20jBRvQ/5MmNdRYx
         +F3PHlejDejW2C5v+VE49G5CRh8c9C94x+jkPP5V0LxkgFATdYIsZidjEsKyh4DBZeuf
         Daa6g08Mm9jZI5AmHMci909Z85QgvBYNjYfnsg7c9hqX4BkdCGwntuwYJ1BIUs29sZ+t
         zDZA==
X-Gm-Message-State: AOAM533Yba8TsvFG32tyhVRxgz/5qxoBhKCtOVQPx+SBM60eegv4DZca
        rh3PEE92VOlo7TZrmhujrM9WAwmaAqRPgcygLHgFc8H13OD8nEDBFs0DBgxxtr2Vux72gFuP+fR
        u+7Wc/5ZmgNbEvWmfuBdrCvgW
X-Received: by 2002:a5d:504b:: with SMTP id h11mr29476552wrt.337.1607960521216;
        Mon, 14 Dec 2020 07:42:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyJIp+lTZTT9sR0NCGPoEVoSmk9zQ5BbMRL/noLXCJ1EZncZsE/or2kVQEcH2swnRjb31WKw==
X-Received: by 2002:a5d:504b:: with SMTP id h11mr29476538wrt.337.1607960521046;
        Mon, 14 Dec 2020 07:42:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c4sm34435771wrw.72.2020.12.14.07.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 07:41:59 -0800 (PST)
Subject: Re: [PATCH v5 08/34] KVM: SVM: Prevent debugging under SEV-ES
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
 <8db966fa2f9803d6454ce773863025d0e2e7f3cc.1607620209.git.thomas.lendacky@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da080e02-7921-1b67-2b3b-a480d38cfcb5@redhat.com>
Date:   Mon, 14 Dec 2020 16:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8db966fa2f9803d6454ce773863025d0e2e7f3cc.1607620209.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 18:09, Tom Lendacky wrote:
> Additionally, an SEV-ES guest must only and always intercept DR7 reads and
> writes. Update set_dr_intercepts() and clr_dr_intercepts() to account for
> this.

I cannot see it, where is this documented?

Paolo


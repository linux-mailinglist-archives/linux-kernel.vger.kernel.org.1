Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84CE30461D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394501AbhAZSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:16:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392427AbhAZR7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611683875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3aW2uM4TrU5904EoR8KVwdgCwkLOfTVHPiLkX3lXps=;
        b=dnBUsPXjBnRBZ3O7G8DlkxnjbRGrJ6QNH4YVolheopMJXhB/Y2nDcMXZfcI/xSpkS/kl7n
        LqYDq4C8iPtpieFCBCfdsPo2SdVvaYUm24PTEQWXuAbcHye9wimV50Vwa1aWLQNnd5igQN
        E1iP7hUktWnC56e+tG+UQGEqIp2xvOQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-fhj6JyVQP1WPaq6WgtfHeA-1; Tue, 26 Jan 2021 12:57:53 -0500
X-MC-Unique: fhj6JyVQP1WPaq6WgtfHeA-1
Received: by mail-ej1-f71.google.com with SMTP id h4so5284246eja.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b3aW2uM4TrU5904EoR8KVwdgCwkLOfTVHPiLkX3lXps=;
        b=n/goNdMS+ZYswq9hGm4c0jPxJmR5XVWJkc+pfnrNoIePDEn/Q4tMTTtA0b5egDid04
         48oCDYtBz7K1LEqKHiUK8KSjaey54Dx+PZa7hyduXAfrhAi4g6Ltwueyo1vFRt2Z788g
         F7INMaYGN1i2ByYp7Dcd9JE0eiFbQCFlN8EVU5nRq5VTBS6awyx9KsA/PZIVMQrCejLp
         LqSl8dIwtrlAxEx2OYHEePYRbUM2gxX+VJhE+x+PSRsQdwGswMRhsZvQ/DF4s9HW519Y
         S7W3C3TiSmVYt/Op8d51lqeuV0Iqagc5KXSlU4ZhWvW3znPgIvmri8Htfk0W82gq52Wj
         bBqA==
X-Gm-Message-State: AOAM5301cTzseJIqH3V50TauDwY/hty+PdPswFORPWu9D4RlUFYGVU3P
        sFPVfSRiPu5bTKQdJBfxc3U8XP8iykOgcQbTIKjZzSB0iEx/hRrmAd9t3w3W7oMBmIO+4GlZskN
        LQ85wK0q2ThH8lRCI0XDPb4mFKFE0F8rhITlPxjFd4atE9TK1J+j9ePCD9luO8RdZENcjW7czh/
        Ql
X-Received: by 2002:aa7:de10:: with SMTP id h16mr5524573edv.385.1611683871721;
        Tue, 26 Jan 2021 09:57:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUFsbmfmVp39QdotlAJTr2gMqoH+TFk7PzB7WRoMWJ7arY46vzgiPVS2hY9IN8XKfHlpV3Kg==
X-Received: by 2002:aa7:de10:: with SMTP id h16mr5524552edv.385.1611683871515;
        Tue, 26 Jan 2021 09:57:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ar1sm9969586ejc.30.2021.01.26.09.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:57:50 -0800 (PST)
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Cun Li <cun.jia.li@gmail.com>
Cc:     seanjc@google.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210111152435.50275-1-cun.jia.li@gmail.com>
 <87h7nn8ke8.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: update depracated jump label API
Message-ID: <24e29c32-f6cb-cf7b-9376-1281b9545e69@redhat.com>
Date:   Tue, 26 Jan 2021 18:57:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87h7nn8ke8.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/21 18:15, Vitaly Kuznetsov wrote:
> kvm_no_apic_vcpu is different, we actually need to increase it with
> every vCPU which doesn't have LAPIC but maybe we can at least switch to
> static_branch_inc()/static_branch_dec(). It is still weird we initialize
> it to 'false'

"kvm_no_apic_vcpu" is badly named.  It reads as "true if no vCPU has 
APIC" but it means "true if some vCPU has no APIC".  The latter is 
obviously false in the beginning, because there is no vCPUs at all.

Perhaps a better name would be "kvm_has_noapic_vcpu" (for once, 
smashingwordstogether is more readable than the alternative).

Paolo

  but it seems to be a documented behavior. From
> include/linux/jump_label.h:
> 
> "... Thus, static_branch_inc() can be thought of as a 'make more true'
>   and static_branch_dec() as a 'make more false'"


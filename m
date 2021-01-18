Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ED42FA909
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436809AbhARSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407563AbhARS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610994423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SR1znhrtBE/8TBlcbJN+jUcCvjG/B/RC2d1W3pykhC8=;
        b=ilYS6IlTQID5zULyPJRs3KFfU8VqrcuIfVT+vXZFcScBJRetl71MxVwRz2pJDdUtCuUaty
        73+jAzX6QJkpE7/kszkB0paZaJyK1bNKUdCib3k+S3R8yA052LihLjxjrqDmGm0C0ja+sX
        db7xycqyupGxDzW61a2Xj5ZSIvWTRww=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-J1SnNH_JMTqye4wfHA8wQQ-1; Mon, 18 Jan 2021 13:27:01 -0500
X-MC-Unique: J1SnNH_JMTqye4wfHA8wQQ-1
Received: by mail-wm1-f69.google.com with SMTP id r1so4887597wmn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SR1znhrtBE/8TBlcbJN+jUcCvjG/B/RC2d1W3pykhC8=;
        b=Jo8/I6vww6fujlDBL96QizFH0Hbiz1uF3gUmob3iPIFkRtQGVKYP67AFrWSiRigrV4
         rzz3z4PZ8GjoBmnAKqAelfm5ZejhTbHOCTNlYFf3TdnHX+RjE48aLVqRyB3Hx3AHMSHZ
         8Rrrymi/GnpFjxIaD0d6gPBrGCto40m5Azg4cjAaTMNU/+kxSmCcYGpd5S+GFXRVBnff
         Rv3B2EXFliFsP1UbcCuwq4t+CIX+UcnRt2O2UBG0hCpaU+mYMqSHYBZVVe1JyxhZY2v2
         6xvAsG6j55OTyqTMfD+sBYfhMo1mk11tWvcSBPRFKrUV/HHycIyU27y1h+PgolUnYM/L
         odEw==
X-Gm-Message-State: AOAM533wug524oFCMbrSwwtK/lEeuhV8IEnKFl6iXAQe0zV8Wv4pN7l4
        fGb/3z8cAnqLD0F1BU2Vxaier14WBNZ1nUuTDZHTzzQJXV7fWDZsvp8Sdi3dKEVU4dG0ekFPNrg
        DlsJ2iPv2bZfwBJ3/Z0NAN0/u
X-Received: by 2002:adf:e590:: with SMTP id l16mr766932wrm.294.1610994419993;
        Mon, 18 Jan 2021 10:26:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhmYapYaKFujvmiwwxElIFxlvpL42SB4ZxG2fojeadfOVzKP7/K7YRdhDUUElrQNd1cKeS4g==
X-Received: by 2002:adf:e590:: with SMTP id l16mr766918wrm.294.1610994419853;
        Mon, 18 Jan 2021 10:26:59 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c18sm1234571wmk.0.2021.01.18.10.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:26:59 -0800 (PST)
Subject: Re: [PATCH] KVM: kvmclock: Fix vCPUs > 64 can't be online/hotpluged
To:     Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
References: <1610623624-18697-1-git-send-email-wanpengli@tencent.com>
 <87pn277huh.fsf@vitty.brq.redhat.com>
 <CANRm+Cz01Xva0_OjTpq3Wbyppa=FZzxBwZJCWJNicV3eCrzpdQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67171a65-f87d-8b60-22c6-449ed727f6e0@redhat.com>
Date:   Mon, 18 Jan 2021 19:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+Cz01Xva0_OjTpq3Wbyppa=FZzxBwZJCWJNicV3eCrzpdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/21 02:15, Wanpeng Li wrote:
>> The comment above should probably be updated as it is not clear why we
>> check kvm_clock.vdso_clock_mode here. Actually, I would even suggest we
>> introduce a 'kvmclock_tsc_stable' global instead to avoid this indirect
>> check.
> I prefer to update the comment above, assign vsyscall pvclock data
> pointer iff kvmclock vsyscall is enabled.

Are you going to send v2?

Paolo


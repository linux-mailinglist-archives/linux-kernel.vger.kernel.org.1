Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF52D0315
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 12:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgLFK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:59:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbgLFK7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607252285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJk0kDKu4RhzpZW3focLf1jdoJOBzAL7ny/bjvEAH1I=;
        b=OhbYth8kZJz0QFGXhCUCxlQAml8sywQyKoskpm3w0SK9G5WH7pvjIvzzb8Pz9b/ucWEs1Q
        B+EVmTUWorgkTT0ySya/cTZ9DhbtWxV9c5uVMCeu4N/FOVJXUZTKTWZ/ygiqZLIkPRw+fp
        DMbtpl5u0DX8pori68VEnE5Kw3WTwvk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-prMrh_U5M1awb5eCoH_Qvw-1; Sun, 06 Dec 2020 05:58:03 -0500
X-MC-Unique: prMrh_U5M1awb5eCoH_Qvw-1
Received: by mail-wr1-f71.google.com with SMTP id p16so4186633wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJk0kDKu4RhzpZW3focLf1jdoJOBzAL7ny/bjvEAH1I=;
        b=R5JamAmoao1Aw9yougR3Gi8Tl7ecqWpOHhOM5zvMNElVDTzOSQPfDqwwJ3rzPyXW6G
         YotS/3x2awZfDDYzWGt3q1uZl7Oa2lRSfNJ0g325PIXv8QPZpAzzWKtq6ZwFs4872m1S
         BbGLcPPoj3ze28H/cu5Y0Ym4kb0DBf+EBqODKjUuVmWQmFqSxHPgso8qxmKznsL1+7m5
         DqcRqozrHgw83HbnJbCiWRMn/Oofsa6SnjQffP9k31HtQcb+e8UEGzmOgplMmHX77tc3
         ci66HaFXNja4ZZALN3Qofy7EUlLqSb/2n9oHleRKsd3fZC42m7IF1vu+kuJU7Yp4EGW4
         asjg==
X-Gm-Message-State: AOAM532OV5nw6PbjnalWawcJ+cXXKrk3y31cmVgCGqB8cFsFjZBIDvwb
        MbUCRoBpqyx/koJknsne7iu1YKcz4W/H/DM4TvVZhOvCuL7ojAJ4kk124OnbtkOi6cVg1RoW1LT
        ZuBgCFzPrl7ykyPpxVzjBdVzq
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr13412257wmg.189.1607252282520;
        Sun, 06 Dec 2020 02:58:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi0Fz7eh+LZJvrBYAtet3/qWQmz90+4O4xbQdqRFpHWcmB8NOdgMAiXg8z2VVrrx+YeyR4+w==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr13412241wmg.189.1607252282348;
        Sun, 06 Dec 2020 02:58:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id z22sm9435920wml.1.2020.12.06.02.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:58:01 -0800 (PST)
Subject: Re: [PATCH v8 13/18] KVM: x86: Introduce new
 KVM_FEATURE_SEV_LIVE_MIGRATION feature & Custom MSR.
To:     Sean Christopherson <seanjc@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Thomas.Lendacky@amd.com, bp@suse.de, brijesh.singh@amd.com,
        hpa@zytor.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rientjes@google.com, srutherford@google.com, tglx@linutronix.de,
        venu.busireddy@oracle.com, x86@kernel.org
References: <X8pocPZzn6C5rtSC@google.com>
 <20201204170855.1131-1-Ashish.Kalra@amd.com> <X8pwmoQW6VSA2SZy@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fa0f11e-2737-5ecb-f2e6-4e5c21e68b9c@redhat.com>
Date:   Sun, 6 Dec 2020 11:57:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8pwmoQW6VSA2SZy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/20 18:23, Sean Christopherson wrote:
> On Fri, Dec 04, 2020, Ashish Kalra wrote:
>> An immediate response, actually the SEV live migration patches are preferred
>> over the Page encryption bitmap patches, in other words, if SEV live
>> migration patches are applied then we don't need the Page encryption bitmap
>> patches and we prefer the live migration series to be applied.
>>
>> It is not that page encryption bitmap series supersede the live migration
>> patches, they are just cut of the live migration patches.
> In that case, can you post a fresh version of the live migration series?  Paolo
> is obviously willing to take a big chunk of that series, and it will likely be
> easier to review with the full context, e.g. one of my comments on the standalone
> encryption bitmap series was going to be that it's hard to review without seeing
> the live migration aspect.

It still applies without change.  For now I'll only keep the series 
queued in my (n)SVM branch, but will hold on applying it to kvm.git's 
queue and next branches.

Thanks,

Paolo


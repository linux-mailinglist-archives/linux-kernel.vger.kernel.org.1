Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A393F2DCDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgLQIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:31:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgLQIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608193774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RBZhUqV1mKyo1+nFeSEltDnCdPl4nfZF/4Jw9aI3W4=;
        b=QJJ22DUsiffuadFIx+/H44kcA89L6ES2DnX0yq/GzFNX2GOHw0QVQ+kX809nY1Hiv0Jz6Y
        ADtK47HYl7WKPI+HtGIRhMqdfFgHecPJQ2NpKQk7ZdZWVsryAqcjFSHagBH+q8ZxCsEgqV
        0W+F+gZYNxPbigLO5dZ6l9cOYTkFnx4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-PWQ8jxYSOkiIswqg-pn94Q-1; Thu, 17 Dec 2020 03:29:31 -0500
X-MC-Unique: PWQ8jxYSOkiIswqg-pn94Q-1
Received: by mail-ed1-f72.google.com with SMTP id i15so13096079edx.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6RBZhUqV1mKyo1+nFeSEltDnCdPl4nfZF/4Jw9aI3W4=;
        b=PBvj/iuk7ICvA/bCj+edaAWWbqiMR7/o83Pj89R4yvIiNIWZBIJBZ/9+Z9LvLam38A
         xs3usTqhYP/jhjjhr1ZZddAOZZSkL8fHcm+ZA6M600CQoRFSu59960DmWO7sXxwGiQH0
         Awn0nZxJOuVLVR4lLyJ9r2/COma3Uv5tqgqj9B8rxGQeKmk4aVivxGqZAZTVkpezciUe
         IJbUtg6Lik2yoroixklzKfgJzO+Pa49UQ9ObpdSadbWMd7DNzDA9yR1eQ+ZMPB0/ZEQe
         1vcGb3vQoiL2ZNf9F1ECIDptb3pzVkVVFQUPGk7HgB4EVxTmPj1aDcfe62lM1kHkwBfa
         AK+g==
X-Gm-Message-State: AOAM533ETBffhF9tQwYDHRLc6nsSqy9IVZz+UX6KHX9JtwPB59Wrh+Yj
        fI0Wapz/lNdu5f7DBV6unR3sW5akdK6XQvh7YqVBkhAH/WnrqmdxRjdkWpJ4USExgql3uGgltbo
        FhLBBfGBdNJn99b5oH9E2gnXD
X-Received: by 2002:a17:906:971a:: with SMTP id k26mr34940846ejx.279.1608193770173;
        Thu, 17 Dec 2020 00:29:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJnoCNNqZ2kGS4IJ5qWLl+U9l+SxoWfsHOi+kNAHvyTGeevk6Xi7EcLOIsiTHa4dz7/SrTNQ==
X-Received: by 2002:a17:906:971a:: with SMTP id k26mr34940831ejx.279.1608193770001;
        Thu, 17 Dec 2020 00:29:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e10sm3212558ejl.70.2020.12.17.00.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 00:29:29 -0800 (PST)
Subject: Re: [PATCH v2] KVM: SVM: use vmsave/vmload for saving/restoring
 additional host state
To:     Sean Christopherson <seanjc@google.com>,
        Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20201214174127.1398114-1-michael.roth@amd.com>
 <X9e/L3YTAT/N+ljh@google.com> <20201215185541.nxm2upy76u7z2ko6@amd.com>
 <X9qcsq2kW1kkoVWI@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93168eba-6139-2d01-f8a5-182ecd723a8e@redhat.com>
Date:   Thu, 17 Dec 2020 09:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X9qcsq2kW1kkoVWI@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/20 00:48, Sean Christopherson wrote:
>> c) refactor SEV-ES handling as part of this series. it's only a small change
>>     to the SEV-ES code but it re-orders enough things around that I'm
>>     concerned it might invalidate some of the internal testing we've done.
>>     whereas a follow-up refactoring such as the above options can be rolled
>>     into our internal testing so we can let our test teams re-verify
>>
>> Obviously I prefer b) but I'm biased on the matter and fine with whatever
>> you and others think is best. I just wanted to point out my concerns with
>> the various options.
> Definitely (c).  This has already missed 5.11 (unless Paolo plans on shooting
> from the hip),

No, 5.11 is more or less done as far as x86 is concerned.  I'm sending 
the PR to Linus right now.

Paolo

> which means SEV-ES will get to enjoy a full (LTS) kernel release
> before these optimizations take effect.


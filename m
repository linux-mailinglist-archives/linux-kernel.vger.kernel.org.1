Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB14293939
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393234AbgJTKey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392120AbgJTKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603190092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q96jnE0zL/+3eV1zXo6SJcOjLpLSsjofFz0lkEdY9WI=;
        b=fOzj4D5z7YBxhlyNDi/Y6ONpjdIv9jDaJ4ynA+JTWmkFa08kbi+/iKWZb6n4QxmbGXekpJ
        i694eWgV3/jW9xRTXIvGKbu9H25cQWRikL+ieOS2eQYg67IQZQ/Lr1AJLNiH1tU2qbiSKL
        56KjDtua4nP/jgexk+MXggCal1zEByU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-sXH1ULZoMuOw_ewUlA1O6w-1; Tue, 20 Oct 2020 06:34:50 -0400
X-MC-Unique: sXH1ULZoMuOw_ewUlA1O6w-1
Received: by mail-wm1-f69.google.com with SMTP id c204so300124wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 03:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q96jnE0zL/+3eV1zXo6SJcOjLpLSsjofFz0lkEdY9WI=;
        b=HaGpaTjVVuBUZEiUQxLJqsg84XzsZuWWtFSKjPeQBP8n94azQJVDVUZe4EdCL1F/03
         SA9EqylryVrlahTzeAYqzxak5UiPdj2Wg6teaPJZlizVkbnHk+IOzJBS3GJNJmeLayne
         S62BUHw+sSgJ7UWdu9MtbVf61CocMTBjjVRer97cX5AM/nh1cLEDNLQkzbBryt6TtrXN
         nGIKJkuwNtUoAfpqOD69Dw/AU14VJ3wHIHEr7wMZ0sfH9J+vfIzkck7uBrIh3cisr095
         AliBOpdHEpvPP/dC+6RBkBfdGNl5zuobyE8oskbRpRqLM/6p/psSfbSRP/QSx0Ee6LjE
         5lsQ==
X-Gm-Message-State: AOAM531oPvEIkhCliNzxvXDGT50I+Qlw0cUv139apGnsd6LPTmExSqOL
        rwRKFDqKqNCjZLeqO5E4usxJYgGm9ioXfz47X4z/OHB8IRXMjI1P2olPYx2TMc4ocfvZrNB+WLK
        3U7eShldyYBHQC/eOkL2NeQdM
X-Received: by 2002:a1c:87:: with SMTP id 129mr2170664wma.103.1603190089055;
        Tue, 20 Oct 2020 03:34:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK0vtophc5uwVNCm9j+6rJW4gkhbpN0w4IRqerxSf208yGjd3VCwoUYBlm7xrrgEKKeeDtfQ==
X-Received: by 2002:a1c:87:: with SMTP id 129mr2170619wma.103.1603190088421;
        Tue, 20 Oct 2020 03:34:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x81sm2016034wmb.11.2020.10.20.03.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 03:34:47 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Forbid userspace MSR filters for x2APIC
To:     Alexander Graf <graf@amazon.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20201019170519.1855564-1-pbonzini@redhat.com>
 <618E2129-7AB5-4F0D-A6C9-E782937FE935@amazon.de>
 <c9dd6726-2783-2dfd-14d1-5cec6f69f051@redhat.com>
 <bce2aee1-bfac-0640-066b-068fa5f12cf8@amazon.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6edd5e08-92c2-40ff-57be-37b92d1ca2bc@redhat.com>
Date:   Tue, 20 Oct 2020 12:34:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <bce2aee1-bfac-0640-066b-068fa5f12cf8@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/20 11:48, Alexander Graf wrote:
> 
>     count: 1,
>     default_allow: false,
>     ranges: [
>         {
>             flags: KVM_MSR_FILTER_READ,
>             nmsrs: 1,
>             base: MSR_EFER,
>             bitmap: { 1 },
>         },
>     ],
> }
> 
> That filter would set all x2apic registers to "deny", but would not be
> caught by the code above. Conversely, a range that explicitly allows
> x2apic ranges with default_allow=0 would be rejected by this patch.

Yes, but the idea is that x2apic registers are always allowed, even
overriding default_allow, and therefore it makes no sense to have them
in a range.  The patch is only making things fail early for userspace,
the policy is defined by Sean's patch.

Paolo


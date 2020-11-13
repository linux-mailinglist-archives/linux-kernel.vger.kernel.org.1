Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4066D2B1A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgKMLc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:32:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbgKMLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605267062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZX7ay2VwMvfSJ5+6tIQGuldDMeDU11P6MjKLtsymonc=;
        b=giRorWjZTr3VB2N1ZP7108Ml+0WlID6Afx2+O/J63jA0zg6taEDuKBfxXyXUC1WcfiBD0S
        PfKMfSZW/kJsg9WPdMEpakZpr/60GNHlEOZxUYeBPJgF0UI5vFSGP/E5vTf0iVB5+CR1++
        wpGPk2VjLB8qvZvjHHVTxNmnSktVZ5o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-eFEwmlB2MzeRpzZ88WjQIQ-1; Fri, 13 Nov 2020 06:31:01 -0500
X-MC-Unique: eFEwmlB2MzeRpzZ88WjQIQ-1
Received: by mail-wm1-f69.google.com with SMTP id 14so3777084wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZX7ay2VwMvfSJ5+6tIQGuldDMeDU11P6MjKLtsymonc=;
        b=HnU1Br9FbxudPwVzh71p+EnNKtp2gwMPRsZbdlGzYb3Zz7gw4gTzIRWOEYUZKSy5ah
         ZKrxjQFcVdWziCk/58DEVMyrVSmzEtVoEwx0gPZE49Jvql+HFbnjb7SjWHV/rk/ZOUnn
         vuZnUoMWVNZINbykXIG7go40ITl9N3oH8uuIM5QesMBMFYPqK1gBFoIcUeNzmJVMIGVL
         QLh6UfPbeWYJLI9CRC0F5rAhyHx7gL9riFg2JOu3NhodJ38qz5/iIQlpVEmI70crtWUC
         +38s7Hi0BK1ivtiga2VJ5jV+PiJ3wrRbKfbDTpq2dM0c3Fw+S47Nmu5p1dNEYZ2OpJtE
         k9Lw==
X-Gm-Message-State: AOAM5331HQDjlztt/5wAwnOUpmsaFyRVkT5B9Ep0BKagqI05GvQIAiK1
        n3oiT/uSAzoamu+2HdqF+GX6OdsCyk82k/eVJZYGenez9m5VeR9AI5I7ch/ByffjOIDLbF9DhbK
        RMOIGoCi5VXRk5O/U7favKr77
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr2776325wrx.137.1605267059747;
        Fri, 13 Nov 2020 03:30:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqNr4OI1Ne3dhDwut6kst5dnN1YE8myWel2KXy4k6OjbSjLC01gPLn9+blQIrtYrf27gQJmw==
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr2776309wrx.137.1605267059583;
        Fri, 13 Nov 2020 03:30:59 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a15sm10842492wrn.75.2020.11.13.03.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:30:58 -0800 (PST)
Subject: Re: [PATCH v2 2/2] KVM:SVM: Update cr3_lm_rsvd_bits for AMD SEV
 guests
To:     Babu Moger <babu.moger@amd.com>
Cc:     junaids@google.com, wanpengli@tencent.com, kvm@vger.kernel.org,
        joro@8bytes.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, tglx@linutronix.de, vkuznets@redhat.com,
        jmattson@google.com
References: <160521930597.32054.4906933314022910996.stgit@bmoger-ubuntu>
 <160521948301.32054.5783800787423231162.stgit@bmoger-ubuntu>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9910665-8330-6db6-ee0a-2db9a69d6c95@redhat.com>
Date:   Fri, 13 Nov 2020 12:30:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <160521948301.32054.5783800787423231162.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 23:18, Babu Moger wrote:
> +	/*
> +	 * For sev guests, update the cr3_lm_rsvd_bits to mask the memory
> +	 * encryption bit from reserved bits
> +	 */

Say why in the comment, don't repeat what the code already says (ok, 
technically the code didn't say that CPUID[0x8000001F].ebx hosts the 
memory encryption bit).  I changed this to:

/* For sev guests, the memory encryption bit is not reserved in CR3.  */

and queued the patches,

Paolo

> +	if (sev_guest(vcpu->kvm)) {
> +		best = kvm_find_cpuid_entry(vcpu, 0x8000001F, 0);
> +		if (best)
> +			vcpu->arch.cr3_lm_rsvd_bits &= ~(1UL << (best->ebx & 0x3f));
> +	}
> +


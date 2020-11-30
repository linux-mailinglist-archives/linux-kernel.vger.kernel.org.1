Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED752C8F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbgK3U0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388402AbgK3U0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606767880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMj2PaNetiusUJ1P54tSAn6Nz2qIosd6leD0c3q65l0=;
        b=InG3Uk7qnehRSVLzbgduuGm7+AHbgwvOaL4cdyJMO7e3yHKjkCsVrbSwaaSi0r/SCY+Hto
        6RYyZI8gcxI5f+8KAPR2DBi0gywUK2bUu+z+nJ0+BuXt/B/BWPTnJXNu5Bzn95gibxBDhP
        nUu6/TFsER/ManPlR+4LfJrKx2/CWA8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-QOutz7TmNzS9Q9cMPJS9rA-1; Mon, 30 Nov 2020 15:24:37 -0500
X-MC-Unique: QOutz7TmNzS9Q9cMPJS9rA-1
Received: by mail-ed1-f72.google.com with SMTP id bt2so7422885edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMj2PaNetiusUJ1P54tSAn6Nz2qIosd6leD0c3q65l0=;
        b=amLM2jPZBs/rS6it4j7OGseCJoR37azA8eGvPcVksKFe1CWYKbUOpTdDEEv/lAZAnt
         uv6tWrs0BOmEqGcqpfTK9673YapIuJeR4dRuZtsH+5dU1UlJCMKT4+2H2+2JGVI2PKcj
         w/sH2ccv4Ju8cTUSigxSvlehg+OjQZUHojnU+fJR5NTerkmYEszL7zEgo0ec9NoT9N/S
         T+1vkVQp9xMdjUyVj+DBDrEommWbbPOeIUrSMiO6sF5qbHmFW/MakKhvIRVdOVsnfXts
         WwsGphHfbsoGm63XhtIyMuj8Ds9t46cU+Ro8/vBK5HZaLA+Q2mZL1gDv9lREXOkSOoeJ
         Lxig==
X-Gm-Message-State: AOAM5322SKL8+HVhHnAVQikYNq6pFSYsBoBZYh4ERAM63UIoTN1/zuD2
        O8Zt0MoBCC1OWJIY/9kUmfADiIHciXDZKJODoqtXn5uyP5gCMDG8UhWZgJzgbVU3qgP4KPRRCNf
        jcYftsI3ZkxixOGlQAXT3QlLr
X-Received: by 2002:a05:6402:1508:: with SMTP id f8mr24584455edw.350.1606767875965;
        Mon, 30 Nov 2020 12:24:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcaweS7N9Z2p838MkPfnWxC0zGsgoIar9qD5b2KHOmOuPY1gh8wXFsvvvU96QcQwwD96dezQ==
X-Received: by 2002:a05:6402:1508:: with SMTP id f8mr24584431edw.350.1606767875803;
        Mon, 30 Nov 2020 12:24:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q19sm8970227ejz.90.2020.11.30.12.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 12:24:34 -0800 (PST)
Subject: Re: [RFC PATCH 00/35] SEV-ES hypervisor support
To:     Sean Christopherson <seanjc@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <cover.1600114548.git.thomas.lendacky@amd.com>
 <20200914225951.GM7192@sjchrist-ice>
 <bee6fdda-d548-8af5-f029-25c22165bf84@amd.com>
 <20200916001925.GL8420@sjchrist-ice>
 <60cbddaf-50f3-72ca-f673-ff0b421db3ad@redhat.com>
 <X8U2gyj7F2wFU3JI@google.com>
 <8759948d-aa0b-3929-bda6-488b6788489a@redhat.com>
 <X8VJdxTKKkC7uEMh@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fce53908-4b7b-5ef1-eb60-360a505b21d3@redhat.com>
Date:   Mon, 30 Nov 2020 21:24:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8VJdxTKKkC7uEMh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 20:35, Sean Christopherson wrote:
>> Delayed interrupts are fine, since they are injected according to RVI and
>> the posted interrupt descriptor.  I'm thinking more of events (exceptions
>> and interrupts) that caused an EPT violation exit and were recorded in the
>> IDT-vectored info field.
> Ah.  As is, I don't believe KVM has access to this information.  TDX-Module
> handles the actual EPT violation, as well as event reinjection.  The EPT
> violation reported by SEAMRET is synthesized, and IIRC the IDT-vectoring field
> is not readable.
> 
> Regardless, is there an actual a problem with having a "pending" exception that
> isn't reported to userspace?  Obviously the info needs to be migrated, but that
> will be taken care of by virtue of migrating the VMCS.

No problem, I suppose we would just have to get used to not being able 
to look into the state of migrated VMs.

Paolo


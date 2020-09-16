Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4AB26CCED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgIPUvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbgIPQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJSG6Y7e0CSGgIOTKaNO0us2V640Rco/KiC8fWFZ2Ig=;
        b=XPAEMrzLsglGGZB0RxdFnqRSqm5y7PA4+2uHJtkWDdiAKS19gRu29PH0paLuQ21LkCkiOm
        ZKhX4Cw0ypOg7B7ju1Uh8mcJHbtzNKi/lwYfeAkpmmgCIcto2HIx08hqRJqwhFwh+0Z3jP
        UaI2YgBJrrZU1Otal5M+/Xdfkm8cuOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-wJ6McDJHMxaLJUI93ZNnBw-1; Wed, 16 Sep 2020 12:55:00 -0400
X-MC-Unique: wJ6McDJHMxaLJUI93ZNnBw-1
Received: by mail-wm1-f69.google.com with SMTP id c200so1262412wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 09:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJSG6Y7e0CSGgIOTKaNO0us2V640Rco/KiC8fWFZ2Ig=;
        b=p2pIkDnFAC37EbId9tJrgNkLWvwvB1Pf5R/yrmfg+a1HZ+eWKjHnWuo1foa5ndnctY
         nJRrI9B9oIBGUtOJp5edHCOkqHFFGEIur94NC43nRDtGuoYfpK3ir7EYKBl0yq6x+yXO
         fsJgNI+aOkD25eSNWHpy1QBuSguTpxQoFLAp+8xFstWLSmDUlDN8osXsKXovi+SXyxR1
         cOuVaAzMI0ubu/wvdscbdWfORprHSSrXRHd+IiOyUd2Ur6zgO5xI3ZsIvIPcL0YR2c4L
         bEnwoNz6TcRc3rU3ohm5+cI8cw0ZjI98fl1d6Kuu3JQYcseflfaS3cfZNwxqlygJ5rjr
         L3Yw==
X-Gm-Message-State: AOAM532CIDVL7sGY2pOyc5wQbfzTQ/d0ZiwZLd7205QwEK+Bp8ImAk/F
        YWF/r1POvQ3XrTN8inEraD9dzCEnCAdP3g+KC0rM1NIQxiC55kVwABAHIKF2eVp3S/1XtY3xF+H
        lDmI9BUaycpEPIM6gam+c7HzB
X-Received: by 2002:a1c:e256:: with SMTP id z83mr5822662wmg.33.1600275299577;
        Wed, 16 Sep 2020 09:54:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbg4hnvHl1gD37lQ9DJwvCPZ0OWw1FCup/YOVHBNjkxFt/p8dARzNgXlXHpU2uAPuf4jaidw==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr5822645wmg.33.1600275299310;
        Wed, 16 Sep 2020 09:54:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cf8e:a9a0:1aed:9a37? ([2001:b07:6468:f312:cf8e:a9a0:1aed:9a37])
        by smtp.gmail.com with ESMTPSA id c4sm33624149wrp.85.2020.09.16.09.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 09:54:58 -0700 (PDT)
Subject: Re: [PATCH] x86/entry/64: Disallow RDPID in paranoid entry if KVM is
 enabled
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200821025050.32573-1-sean.j.christopherson@intel.com>
 <20200821074743.GB12181@zn.tnic>
 <3eb94913-662d-5423-21b1-eaf75635142a@redhat.com>
 <20200821081633.GD12181@zn.tnic>
 <3b4ba9e9-dbf6-a094-0684-e68248050758@redhat.com>
 <20200821092237.GF12181@zn.tnic>
 <1442e559-dde4-70f6-85ac-58109cf81c16@redhat.com>
 <20200821094802.GG12181@zn.tnic>
 <81985f69-190d-eea6-f1ff-206a43b06851@redhat.com>
 <CALCETrXn5DHzySo3JGfAn=Ckhn4UG48L-UjauG8_L0D9Sd=WXg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de679a1f-8a6d-6db2-d891-6069ed4cb33e@redhat.com>
Date:   Wed, 16 Sep 2020 18:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXn5DHzySo3JGfAn=Ckhn4UG48L-UjauG8_L0D9Sd=WXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/20 18:42, Andy Lutomirski wrote:
> On VMX, when a VM exits, the VM's
> value of MSR_TSC_AUX is live, and we can take an NMI, MCE, or
> abominable new #SX, #VE, #VC, etc on the next instruction boundary.
> And unless we use the atomic MSR switch mechanism, the result is that
> we're going through the entry path with guest-controlled MSRs.

If anything of that is a problem, we can and will use the atomic MSR
switching; it's not worth doing complicated stuff if you're going to pay
the price of rdmsr/wrmsr anyway.

The remaining cases are MSRs that are really meant for usermode (such as
the syscall MSRs) and especially the edge cases of these two MSRs that
the kernel doesn't mind too much about.  But they are really really
rare, I don't expect any new one coming soon and if they are ever needed
(by SGX perhaps?!?) I'll certainly loop you guys in.

Paolo


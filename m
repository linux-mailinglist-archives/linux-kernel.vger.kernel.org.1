Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164362DAABB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgLOKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbgLOKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608027423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9swSmIYZppW8rMNs03vDQOdnpTVA0ev+LyV+E4X+xyA=;
        b=Q0csQJcTnwEZ4h6ATN1ySvZbbX+7qd31ZcMkHxpPeLQhIleWBQorDfK9eCd7tMTCUafsMi
        HTnsu+8T+sf5Y4z0FXX8bl9FDEtBB4Hqem8vp3d+oFG4SXXDNlP+KW/PeEY0Pv0DJkE7nX
        tVrhmtJYwU9U3nBnt68e6cwU//P5x4Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-hFETQa5aOES702Iwp2HMjA-1; Tue, 15 Dec 2020 05:17:00 -0500
X-MC-Unique: hFETQa5aOES702Iwp2HMjA-1
Received: by mail-ed1-f70.google.com with SMTP id g8so9784805edm.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9swSmIYZppW8rMNs03vDQOdnpTVA0ev+LyV+E4X+xyA=;
        b=spoVcG0CrP40Ri30FA8EMCicPqUdnDQk+Abjlvg2gnxow68jeCabxHJdECN7MAjVka
         xGJ1JE1m1TH6oFhs4RSBvFhP7Ryndmki/mIN6EJ++UoY8CClytey2tAfYHNvPFYK41WU
         EvZooPDM3sf41InnElkJaN2tqKQt63PQQ0zC66+rOScahk3ArflLxHUGhkzKAwe91J3C
         zxYuQ2v/U/qdjJq2IRt3duNZ7oJKWJoYEIjMK2OXhqUkph5QLr4ZRBw/WeuHa9+NtwHr
         FM982b2ErPr1eM/3KK1ScreRwjNu0ApjdqkjBX3wtRW/GVSwfAczYRP4pTIYzFKFkYN7
         M7Bg==
X-Gm-Message-State: AOAM533T/Smtr0UaTq9AZep8JGI73v1uItJTwB0xCLXoE+73JjMLjYGa
        vIosfyzrgY05AXrAGLm0awx3IP5jIk1K7g7FoOoMYSN+YA0WB+os5IJA5APswYqaNLZMB6up0SV
        hdCWex3m0fPtgHzI9+7XMUEAZ
X-Received: by 2002:a50:a684:: with SMTP id e4mr11879104edc.148.1608027418925;
        Tue, 15 Dec 2020 02:16:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzabBZlSxgcEsAJ4vJm1Qr35IJrd95+WrjSMPfVpsEhNYyrrr35lQpOGUZSrKUTLe+2GnaXag==
X-Received: by 2002:a50:a684:: with SMTP id e4mr11879085edc.148.1608027418772;
        Tue, 15 Dec 2020 02:16:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k16sm1010768ejd.78.2020.12.15.02.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 02:16:57 -0800 (PST)
Subject: Re: [PATCH v5 12/34] KVM: SVM: Add initial support for a VMGEXIT
 VMEXIT
To:     Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1607620209.git.thomas.lendacky@amd.com>
 <c6a4ed4294a369bd75c44d03bd7ce0f0c3840e50.1607620209.git.thomas.lendacky@amd.com>
 <7bac31c8-a008-8223-0ed5-9c25012e380a@redhat.com>
 <33e98d2d-93b5-acd6-4608-f30c709019ad@amd.com> <X9fAAhF2LzOmZAtv@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35efe04e-a3df-d151-8192-b09473f81cc1@redhat.com>
Date:   Tue, 15 Dec 2020 11:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X9fAAhF2LzOmZAtv@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/20 20:41, Sean Christopherson wrote:
> I agree VMGEXIT should be added to the hot path, it could very well be the most
> common exit reason due to all instruction-based emulation getting funneled
> through VMGEXIT.

Yeah, I was thinking that not many guests will be SEV-ES.  On the other 
hand, it's quite likely to have an SEV-ES guest in your hands once the 
really common non-VMGEXITs have been eliminated.

Paolo


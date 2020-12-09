Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2612D3E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgLIJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:10:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgLIJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607504935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8HlquEoW4X2q/+qcVSM6H75qDDj8W+Dq9wZut/Sz5s=;
        b=OsZ0bIonnXTORI237wlYn5X4VKEJwgHmORSbvBSSG174d1mT+/9EWRvl5E08A/Z0O5ZBJb
        FhjqNVTgj84j3IN+WwCdF3GGKIy3UE2v2taWRflUX5753C4Z1Gz/w9fNzjiANvTGqWL5Oi
        OUiyVIc+q7rS4+ToXEJl1BMelfPUP84=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-TGvgQEK_NFeHOwNgjZGB0A-1; Wed, 09 Dec 2020 04:08:53 -0500
X-MC-Unique: TGvgQEK_NFeHOwNgjZGB0A-1
Received: by mail-ej1-f72.google.com with SMTP id 2so351688ejv.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z8HlquEoW4X2q/+qcVSM6H75qDDj8W+Dq9wZut/Sz5s=;
        b=n1NqJyezInYgvenO3dQy7dgqdP/d1SZMDKCUo+gmaKOLCK36Z9LD+JsguMpfnctm9U
         PQa0F+4d8d1ihrsA1n7vEoY25LbKJnGLlmk62m9jNHqxtZXdO/gKS2+fCzVXwJ74QWqB
         sKohJQHeHzaCXnmM4DGKU80qdFCwjOgJYx5zD8BPcC1pcGNOkPWOw//5USRcSIf6VRR3
         vdVa+rA4OuqQ9LTkhYLDZn8ZVRW2xKygemOvSZwXgso5tNDDjjnaqH5WWcoRood3wzT7
         ht5Vzyxk3gTecEdsyIqxaWLUx7qlomOyK+8oD0e6yKbeUGNMFJS0XKf3AVsjKu3GXF7W
         62nQ==
X-Gm-Message-State: AOAM531y3h1+YEmh4MLkq0CqChWGDr16F3JmAwixKVwhMXGEQ/GgtVPU
        7VwHTVMH3274w46f2ejsvjaZpDmF+6m8XAoJkzS/s9yMvoryZRoABz3gt/3h+veR7iud7/RXimh
        u4y5h2CGX96CcSy+3yQ7CeNu8nQIwUeYoyyiqrKQpDzIWs3mn1lZFD9hAKEEcSzEonKyM+L+Zy8
        Ym
X-Received: by 2002:a17:906:c193:: with SMTP id g19mr1169804ejz.393.1607504932129;
        Wed, 09 Dec 2020 01:08:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyCALCpD/nDA8Lmv55gbFxBTmrGaC6FbUiJ6kN1W5/lZm38nY8tddFPlonjiINu/+QS9+lYQ==
X-Received: by 2002:a17:906:c193:: with SMTP id g19mr1169784ejz.393.1607504931925;
        Wed, 09 Dec 2020 01:08:51 -0800 (PST)
Received: from [192.168.1.124] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id m24sm868412ejo.52.2020.12.09.01.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 01:08:51 -0800 (PST)
Subject: Re: [PATCH] KVM: mmu: Fix SPTE encoding of MMIO generation upper half
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <156700708db2a5296c5ed7a8b9ac71f1e9765c85.1607129096.git.maciej.szmigiero@oracle.com>
 <370db207-7216-ae26-0c33-dab61e0fdaab@redhat.com>
 <X8/sWzYUjuEYwCuf@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5e1dc1cd-b175-86be-b33e-0456ecbd50e8@redhat.com>
Date:   Wed, 9 Dec 2020 10:08:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8/sWzYUjuEYwCuf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/20 22:12, Sean Christopherson wrote:
>> #define MMIO_SPTE_GEN_MASK               GENMASK_ULL(MMIO_SPTE_GEN_LOW_BITS + MMIO_SPTE_GEN_HIGH_BITS - 1, 0)
> What if we leave MMIO_SPTE_GEN_MASK as is, GENMASK_ULL(17, 0), and instead add a
> BUILD_BUG_ON() to assert that it matches the above logic?  It's really easy to
> get lost when reading through the chain of defines, I find the explicit mask
> helps provide an anchor/reference for understand what's going on.  It'll require
> an update if/when PT64_SECOND_AVAIL_BITS_SHIFT, but that's not necessarily a bad
> thing, e.g. the comment above this block will also be stale.

Sounds good.

Paolo


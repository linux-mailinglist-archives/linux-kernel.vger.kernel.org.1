Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86908296BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461127AbgJWJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461114AbgJWJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603444044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDSn1aAjNMgpc4B1YOGiuNHspmgqNuHO0dXhh/lQRnk=;
        b=AI6oS8eeeoW1kFVXcD0lcpckls16fgrwOfG2XrvF9utDX95PTiZmXdjCd9T9XqH3BRwLCo
        4wovB/nyk01BVvNTWOqBoaM3V9H6SkxFM3u5YPUS2Yks6xjF5jQhGKabPt57p1cNsOb9nW
        eXwVB1ucKI9oAu1J/cd2xkEuzDMhK7o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-1tGkt_0fOpGRmMUJaQqZdg-1; Fri, 23 Oct 2020 05:07:23 -0400
X-MC-Unique: 1tGkt_0fOpGRmMUJaQqZdg-1
Received: by mail-wm1-f70.google.com with SMTP id y83so116461wmc.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDSn1aAjNMgpc4B1YOGiuNHspmgqNuHO0dXhh/lQRnk=;
        b=Cnb0v+a7I5GcDikAr2uP3NqG/8Av4NIDwPJSNoC7u90UM4XQQL6ugyfEozPg/6hz71
         bAhAo4Aax7x2j4A+ANLRPQa1/Ks02Gq8+zfV2SgfFXcdWQG9IvzixcOo/w2SVo82tEai
         fvKytcCaH9uw/26eP0Rhx+8k7Csc6loKgCAF4KVsvSKqPg0e9FAIhZzeOzZy3padG7b2
         oXi6B7g2jzwjTPhw4EQgwZcG/I5Src6EE/2/092Q0izkex6dZJL/J5Sdn9L21OxSmBDr
         RgENFyQK9hn1iawYv/0FNuE3JlcHcRRAs84svvkG3+uajYCdy7EKYvlJP6eXX/Cv2DaN
         aTWA==
X-Gm-Message-State: AOAM530uWiU/Yrl1AE+c1Kk5Ww2bo2MRBBe7yvpoS91wG/IDmXujvUgi
        pbKUTMduxa0iptbOTId8hN5FMH0AnNDjXfYo/vYmhLPB0xMIkiknVVnmwbVFfy9YGDPDiT/ojg7
        pKWdGLJNW/gqnobi+XK2nBJ/k
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr1254482wmc.55.1603444038825;
        Fri, 23 Oct 2020 02:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymkAQVzRC+NdRJu3Qpt8v16P0bBR5YMQh/1cANaSLmKSByCA2TahG776pO8+Ion6vfQ8liog==
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr1254464wmc.55.1603444038582;
        Fri, 23 Oct 2020 02:07:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b63sm2041759wme.9.2020.10.23.02.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 02:07:17 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Expose KVM_HINTS_REALTIME in
 KVM_GET_SUPPORTED_CPUID
To:     Jim Mattson <jmattson@google.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1603330475-7063-1-git-send-email-wanpengli@tencent.com>
 <cfd9d16f-6ddf-60d5-f73d-bb49ccd4055f@redhat.com>
 <CALMp9eR3Ng-WBrumXaJAecLWZECf-1NfzW+eTA0VxWuAcKAjAA@mail.gmail.com>
 <281bca2d-d534-1032-eed3-7ee7705cb12c@redhat.com>
 <CALMp9eQyJXko_CKPgg4xRDCsvOmA8zJvrg_kmU6weu=MwKBv0w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <823d5027-a1e5-4b91-2d35-693f3c2b9642@redhat.com>
Date:   Fri, 23 Oct 2020 11:07:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eQyJXko_CKPgg4xRDCsvOmA8zJvrg_kmU6weu=MwKBv0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/20 19:13, Jim Mattson wrote:
> We don't actually use KVM_GET_SUPPORTED_CPUID at all today. If it's
> commonly being misinterpreted as you say, perhaps we should add a
> KVM_GET_TRUE_SUPPORTED_CPUID ioctl. Or, perhaps we can just fix this
> in the documentation?

Yes, I think we should fix the documentation and document the best
practices around MSRs and CPUID bits.  Mostly documenting what QEMU
does, perhaps without all the quirks it has to support old kernels that
messed things up even more.

Paolo


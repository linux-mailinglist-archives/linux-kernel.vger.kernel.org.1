Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3E2D0F09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLGLbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbgLGLbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607340579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUUmIf9d5raiFEfOQ0JhRAqjErNztrP6nIp2TZr3s30=;
        b=eU3m7kIvJhK46uxGyHubhE3+mFaSiGHItQ6P9/U8eNyxnggoBOSJEA90oi8mtQySgW7sxc
        7lHQLX/mhWLpxbOpNXL6FuMr3tf1Bor1oyMjMYRfV80rbzmN83MqNHK2K/MPC7kkw5+Fbl
        Xc700R9wEVxyk6KpjmgdHpf08GzsIYI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-BgnXkdjWMDmsMAGzXg9o3A-1; Mon, 07 Dec 2020 06:29:38 -0500
X-MC-Unique: BgnXkdjWMDmsMAGzXg9o3A-1
Received: by mail-ed1-f69.google.com with SMTP id g8so5678428edm.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 03:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUUmIf9d5raiFEfOQ0JhRAqjErNztrP6nIp2TZr3s30=;
        b=n3YPoH+lwR0D1Egek0eMDlwhk8sd26o4xZtfzI260HEOoKdVphINi2sFIua7LMhLPh
         znRdb6cOkedmIsTApbtk+9sAyxbx9xbQwg9tJh9zbHDoDRWh/Kr65azorS/4yDq7n+gW
         ejXTRTm3i5Z8d3E0OzAHWWaUkvbu1GmW1G9iAavfYLrsDxehch5P1iUFYk1zN+5Wyybm
         93hQU7qGvvVyVNCIf4wEmG44zxa2KoacdQ1SdOionUWJsgJVwh9rN6QKfI9Dtkr9BI2K
         RVMxLtsQEQkVJyz0rNA6zFnYLCosO7HByv9oDjVJfbFd9ifaYobzEbWpB9oQO6xdF3d9
         kolQ==
X-Gm-Message-State: AOAM530ZlHnTlkl0WGO/F2aRKx5AsCWJ56jbhLpxh6Lfy2rN7m0nr2a5
        8OcDu1yYXwzxVgLQue/q0z5+aJX7yWqYUqobj8L2WLuFAFVNyauF3Z0LHC4d4YYQ10pNrc1NZWx
        N0UtGl5Z8Qlc9U1Y+O8MTQTV+f+BiwON3HkDzpfs3bRBL9rVvuRJRLYLzv5i8C28hltmI+xkwgw
        vy
X-Received: by 2002:aa7:da01:: with SMTP id r1mr19631541eds.45.1607340576501;
        Mon, 07 Dec 2020 03:29:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy22YgC9+zXV2Fz3O6j80uNXHmIZwmHhehotkxzZQgiiFto+9+iy0k3k5rRSPr8xd3nqwaetA==
X-Received: by 2002:aa7:da01:: with SMTP id r1mr19631524eds.45.1607340576324;
        Mon, 07 Dec 2020 03:29:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id u17sm11835476eje.11.2020.12.07.03.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:29:35 -0800 (PST)
Subject: Re: KVM_SET_CPUID doesn't check supported bits (was Re: [PATCH 0/6]
 KVM: x86: KVM_SET_SREGS.CR4 bug fixes and cleanup)
To:     stsp <stsp2@yandex.ru>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201007014417.29276-1-sean.j.christopherson@intel.com>
 <99334de1-ba3d-dfac-0730-e637d39b948f@yandex.ru>
 <20201008175951.GA9267@linux.intel.com>
 <7efe1398-24c0-139f-29fa-3d89b6013f34@yandex.ru>
 <20201009040453.GA10744@linux.intel.com>
 <5dfa55f3-ecdf-9f8d-2d45-d2e6e54f2daa@yandex.ru>
 <20201009153053.GA16234@linux.intel.com>
 <b38dff0b-7e6d-3f3e-9724-8e280938628a@yandex.ru>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c206865e-b2da-b996-3d48-2c71d7783fbc@redhat.com>
Date:   Mon, 7 Dec 2020 12:29:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b38dff0b-7e6d-3f3e-9724-8e280938628a@yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/20 12:24, stsp wrote:
> It tries to enable VME among other things.
> qemu appears to disable VME by default,
> unless you do "-cpu host". So we have a situation where
> the host (which is qemu) doesn't have VME,
> and guest (dosemu) is trying to enable it.
> Now obviously KVM_SET_CPUID doesn't check anyting
> at all and returns success. That later turns
> into an invalid guest state.
> 
> 
> Question: should KVM_SET_CPUID check for
> supported bits, end return error if not everything
> is supported?

No, it is intentional.  Most bits of CPUID are not ever checked by KVM, 
so userspace is supposed to set values that makes sense or just copy the 
value of KVM_GET_SUPPORTED_CPUID more or less blindly.

Paolo


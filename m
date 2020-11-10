Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44862ADB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgKJQIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730182AbgKJQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605024516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2Sf12kgoaoMwSO7zVui+rmBiPrlupwBdcBqb7pEUrA=;
        b=CBYvAhNPhmxne0KvUleygGt0iFEn9tmgZB9rOfWctx2V6RzvCc1nnErQRvuIUByviV24It
        yITxTIjq/DlC8sveeP3WDOOWX1rDEZ/eSb2rxT7PowvhQuSntr9jOUj4O/x3hptcDCSdYO
        77m2TfcRsTbYUnFHiaeKwdH3s/FDE9s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-4Uci3FkhOcm_IsOUxPjHcQ-1; Tue, 10 Nov 2020 11:08:35 -0500
X-MC-Unique: 4Uci3FkhOcm_IsOUxPjHcQ-1
Received: by mail-wm1-f72.google.com with SMTP id 14so982225wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2Sf12kgoaoMwSO7zVui+rmBiPrlupwBdcBqb7pEUrA=;
        b=lLZay74pGXrkENT56ze3bhJLjoX5J7LbqDH4YbmB33J/Hi+/5HafpC+MZMh9grwuwa
         NORaRQMLSEJ5UdfhZVmPNaMEF8W3rkptXlrtFEJr0+Co5N/NOtXM+0+6xYi7qxkj6Fsw
         s40AjiwGRD2o7znCepe9zV5v8CwHNM+wPfYamWHdag+GZTJlX/iPHZzXhgWRPefVJruD
         HL9wZQ5ef0N+FFHGrf3T6ziw0dD77W+VZ1sboGmssKP9F9gsOpajCPR7FxsN6RoGJoHJ
         GF5CvCiXxEzU+Im8R3HfFrouMRDay91+BA9sUgDhoOIClb5KU9Gbi8Sr378e1ecnMVre
         9HMg==
X-Gm-Message-State: AOAM5317qlRs7nQJ9TOLMufvnFfDv6CEZQzNqa94SDrepl1Vv5lPwjdb
        /vmI1XenbNwpeg6cRa0GWLE4WV+K5LIyi18ygGjGdQxWSB1z+Xn6yRpnqOS6xonFfSmWM9E6wNG
        fB9n71ek2qUhMJA6HcnB5lyaY
X-Received: by 2002:a1c:7418:: with SMTP id p24mr459764wmc.36.1605024513691;
        Tue, 10 Nov 2020 08:08:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwX2bp8EAQvFHBwQTJhwBcQNIfAJv7DP1ceAp2mu/MJcNBhBYQdzSeyQiIFxUbOK4ZpE66t/Q==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr459735wmc.36.1605024513477;
        Tue, 10 Nov 2020 08:08:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h128sm3524684wme.38.2020.11.10.08.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 08:08:32 -0800 (PST)
Subject: Re: [PATCH] x86/mce: Check for hypervisor before enabling additional
 error logging
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Jim Mattson <jmattson@google.com>, Qian Cai <cai@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>, x86 <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <160431588828.397.16468104725047768957.tip-bot2@tip-bot2>
 <3f863634cd75824907e8ccf8164548c2ef036f20.camel@redhat.com>
 <bfc274fc27724ea39ecac1e7ac834ed8@intel.com>
 <CALMp9eTFaiYkTnVe8xKzg40E4nZ3rAOii0O06bTy0+oLNjyKhA@mail.gmail.com>
 <a22b5468e1c94906b72c4d8bc83c0f64@intel.com>
 <20201109232402.GA25492@agluck-desk2.amr.corp.intel.com>
 <20201110063151.GB7290@nazgul.tnic>
 <094c2395-b1b3-d908-657c-9bd4144e40ac@redhat.com>
 <20201110095615.GB9450@nazgul.tnic>
 <b8de7f7b-7aa1-d98b-74be-62d7c055542b@redhat.com>
 <20201110155013.GE9857@nazgul.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b587b45-a5a8-2147-ae53-06d1b284ea11@redhat.com>
Date:   Tue, 10 Nov 2020 17:08:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201110155013.GE9857@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/20 16:50, Borislav Petkov wrote:
> I was thinking of
> having a mapping between f/m/s and a list of MSRs which those models
> have - even non-architectural ones - but that's a waste of energy. Why?
> Because using the *msr_safe() variants will give you the same thing

Yes, pretty much.

>> If it makes sense to emulate certain non-architectural MSRs we can add them.
> See above - probably not worth the effort.

When we do, certain Microsoft OSes are usually involved. :)

> I'll take a look at how ugly it would become to make the majority of MSR
> accesses safe.

I think most of them already are, especially the non-architectural ones, 
because I remember going through a similar discussion a few years ago 
and Andy said basically "screw it, let's just use *_safe anywhere" as 
well.  I don't see any need to do anything but add it to your review 
checklist if you have it (and do it now for MSR_ERROR_CONTROL).

Paolo


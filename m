Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D512D76BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436821AbgLKNjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732957AbgLKNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607693852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gV4c090IqWI5tEA2buwHKvS0/NqK9RSA3GoSyg8aYNs=;
        b=iTCa6FGrc6qZ+CZCtxQ9Xc66Nef0EeItlW4FqcPpMw5F2epXHNgfbDd3f56G1kL1CTnlyz
        3CswlN0mZMejTAWkTcxacBvWxXlNqdz6MoPluDy9oQ09GSDt8oyMuTUJLILTzj5z1ee37g
        M0fLNCc8Z1mHinZGjxfWUF6ZCs12uWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-wO9qoWP0Mgm2NY22oC7hyg-1; Fri, 11 Dec 2020 08:37:31 -0500
X-MC-Unique: wO9qoWP0Mgm2NY22oC7hyg-1
Received: by mail-wm1-f72.google.com with SMTP id r5so3295003wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gV4c090IqWI5tEA2buwHKvS0/NqK9RSA3GoSyg8aYNs=;
        b=COplQI58tuKc51XMPvLHRaZvoVDVnB+mhI2/5Jg4cTWzl56w52I1iT9K7PFWudN63o
         BZGwy0CG6ElMW+FVc30qgsuGsW3fRufaUmHLnD7Mg5iIyBU5KEevZMZAPpcizZlo+sBK
         NbuojPqhpu6vt43/pxterS54PXB2EubS6tWlV+o77e6ZQOghubPF1HGArnl67CyKqWhP
         z3sCGmAvP8uBKHoyQrsaUmDFS2EywfrHbbsFkhGzdHxzYUGGeCpOnIE2UHR7wr9P8H8F
         eXO3NNlfCfiXAscqAvT/jMSjhLDZTr7T7b4Js/W4XOI7ZtFyEoyC8z5MssyxMR6cJuDf
         WFVQ==
X-Gm-Message-State: AOAM532pvSQr+N4ussfk7MGNpsvzQtQkJrv1PkPunjYs/Lgvn3fWTZLA
        pVA1e99MN7dJqvihsb5qRT3CbfEXSSs/UiXWCx1AKP9oH29JrINa6H3gTs4PcvhGtgOQjkPcY3L
        +8FlIiioj21WTSZ8xKwsscMtf
X-Received: by 2002:adf:dd90:: with SMTP id x16mr13783245wrl.85.1607693850198;
        Fri, 11 Dec 2020 05:37:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ6/HzWkhgIrtQKABfYostveB3IDy4vSX+reQk78mBEui3U7TXREPtLi7Hnr4bOSkxry96bA==
X-Received: by 2002:adf:dd90:: with SMTP id x16mr13783217wrl.85.1607693850018;
        Fri, 11 Dec 2020 05:37:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z64sm13966730wme.10.2020.12.11.05.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 05:37:28 -0800 (PST)
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20201203171118.372391-2-mlevitsk@redhat.com>
 <20201207232920.GD27492@fuller.cnet>
 <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
 <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <20201208181107.GA31442@fuller.cnet>
 <875z5c2db8.fsf@nanos.tec.linutronix.de> <20201209163434.GA22851@fuller.cnet>
 <87r1nyzogg.fsf@nanos.tec.linutronix.de> <20201210152618.GB23951@fuller.cnet>
 <87zh2lib8l.fsf@nanos.tec.linutronix.de> <20201211002703.GA47016@fuller.cnet>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec926c2c-985a-2e3d-1ba0-b35ce55a19c4@redhat.com>
Date:   Fri, 11 Dec 2020 14:37:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201211002703.GA47016@fuller.cnet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 01:27, Marcelo Tosatti wrote:
> This features first, correctness later frenzy is insane and it better
> stops now before you pile even more crap on the existing steaming pile
> of insanities.

FWIW I agree, in fact I wish I knew exactly where to start simplifying 
it; the timekeeping code in KVM is perhaps the last remaining bastion 
where I'm afraid just to look at it.

At least I know there's a couple of features that IMHO are completely 
useless, and that's even before you reach the ones that might "only" be 
obsolete.  So perhaps that's where to start, together with the messiest 
userspace interfaces.

Paolo


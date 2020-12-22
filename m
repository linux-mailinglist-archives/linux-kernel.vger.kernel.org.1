Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA32E1063
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgLVWut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:50:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgLVWus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608677362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+qbneJ2jh3fYPKfa/u50B7CIQ8X0Uo7bpQgn3QfrgA=;
        b=h6PiD3kzTM0XpWojxgCNY15cNefn7ZuMPa1j1EgOcEIpJhzPBR0POaMSc8T07fg7+PKHbf
        4Fezi4/lfz5JKwX8zCDSvkS4AkdXcjwLaoVou1wiBhwTAxS3dTblxnE2MgSgjOWotS7Ce+
        ZUUW54yiHA7UUvrEPUXj8iZKnnmG8BU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-h5dnPpw1PCaG00N1lGjH_g-1; Tue, 22 Dec 2020 17:49:18 -0500
X-MC-Unique: h5dnPpw1PCaG00N1lGjH_g-1
Received: by mail-wr1-f69.google.com with SMTP id j5so11902654wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n+qbneJ2jh3fYPKfa/u50B7CIQ8X0Uo7bpQgn3QfrgA=;
        b=Eh1CpBZaf/KC9NxCR6T3KSbh4Irp8uxeJqAuNEbNwhKjPkOvKTG/ImY+U7CN51hPf1
         acERdWQoSFV0p9jIP9lTiYtjCJZi60KPySiW8EJlhqoa40d8pzwD0t2Y5FEV4fcJ3JiI
         naBft/9qAYoWpuU9AmuhsefpjZuPRE8hO9UguP2MhDyG4c1vUf7geHjigkr4r1uzXk5B
         GoJxMOx5hG8Zh4qVvuvncTMu88hwXRN7pz+tCGW6jg/UCGGT1w0vON1yyCQyyUMgxvo1
         df7pLB7WB+bLkaQKuddsLnyUTzKTX0QOQGVHFmgxGX2dFcmRiSxVDB0JCpscKzhzWhOS
         I3Yw==
X-Gm-Message-State: AOAM5302DLUFzgWUR20GFC56YwiJTWs3VWHgl6WxJLDsFuxaJas81DE3
        +XtI+WMKplmMfoawIB1Vz5nhQehBg26BONrXWwUGcRNhnSqRiXZbIiH8FC0NrLaS790q9f0uERT
        fXw9AKP/G7cXYPTbNy80oJk6S
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr24010965wmc.105.1608677357436;
        Tue, 22 Dec 2020 14:49:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwS2fZRfRZ1tqO6mhPhZptW872NTdNoTC5rXieW8+2cgXm7VZ25VmkNgChwkfEp+tpsEJX+BQ==
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr24010957wmc.105.1608677357295;
        Tue, 22 Dec 2020 14:49:17 -0800 (PST)
Received: from [192.168.1.124] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id z6sm27359812wmi.15.2020.12.22.14.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 14:49:16 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: fix shift out of bounds reported by UBSAN
To:     David Laight <David.Laight@ACULAB.COM>,
        'Sean Christopherson' <seanjc@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "syzbot+e87846c48bf72bc85311@syzkaller.appspotmail.com" 
        <syzbot+e87846c48bf72bc85311@syzkaller.appspotmail.com>
References: <20201222102132.1920018-1-pbonzini@redhat.com>
 <X+I3SFzLGhEZIzEa@google.com>
 <01b7c21e3a864c0cb89fd036ebe03ccf@AcuMS.aculab.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64932096-22a8-27dd-a8d6-1e40f3119db4@redhat.com>
Date:   Tue, 22 Dec 2020 23:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <01b7c21e3a864c0cb89fd036ebe03ccf@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/20 19:31, David Laight wrote:
>> 	/*
>> 	 * Use 2ULL to incorporate the necessary +1 in the shift; adding +1 in
>> 	 * the shift count will overflow SHL's max shift of 63 if s=0 and e=63.
>> 	 */
> A comment of the desired output value would be more use.
> I think it is:
> 	return 'e-s' ones followed by 's' zeros without shifting by 64.
> 

What about a mix of the two:

	/*
	 * Return 'e-s' ones followed by 's' zeros.  Note that the
	 * apparently obvious 1ULL << (e - s + 1) can shift by 64 if
	 * s=0 and e=63, which is undefined behavior.
	 */

Paolo


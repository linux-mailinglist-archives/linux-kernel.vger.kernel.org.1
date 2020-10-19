Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA6292B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgJSQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730404AbgJSQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603125131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C7GwC2vuW9nIIIjv9Ux8aNhEET+El5KATGOMKXjdxY=;
        b=a83DZX7UHSU6l+NWrmGo1wN8btKRhjaQKFwzmKP+y4ZMPQeexabr2CQCKp0OprnZQ8diwF
        WtlDxP+Al/e/LJ0Cwhg8PNV9NZSa72IDxAUFdtoAM3pEG3l1s1YXrV60V2Ir/oMUwtO0hG
        je9hKG8IYO8Ag/xWWe7zAVOYOU5UvHk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-vKPtc9m4PC23wBY-ez77BA-1; Mon, 19 Oct 2020 12:32:09 -0400
X-MC-Unique: vKPtc9m4PC23wBY-ez77BA-1
Received: by mail-wm1-f70.google.com with SMTP id s12so105118wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4C7GwC2vuW9nIIIjv9Ux8aNhEET+El5KATGOMKXjdxY=;
        b=a0irHOuWd/0dXkqDTBNHWZU7wLVToVF1gHPLnUt4gTYgmwyw+4WPg4JsfuWMD4wb3e
         bYx/UI1ugksICD3RFFNvx8zGWZbiMfigXC/KaSpalU3Ua2lNfs5jhbaMLOEd49W9GOm7
         HvaXo5kqqbh98cLs0kHFMwCI5RmrAgdeyNKm9xykIflD/NmgusNZucp2wMCWXMZ/Xwze
         r39buJ+bdkj2Wd+gLwpD9V703gKR5CMW827hhRvqhbyNUmeYR/C0agXUtA/8CgQjAlpM
         qNAkwTPTyFhKauJ5B0fjseuliWnmn5GS8b7Mldsap2xOkR4LEAcUiVGfzdc3rrDtl6sl
         i64Q==
X-Gm-Message-State: AOAM530mvCTMyx0F05tQuneL+Ege12751ywHbgozbAbR7Kovq2wQggwk
        XegaRzu+pJSXjBpkDfAqgSUDIPR/xBRYM7X1tCFlC4iWmICfxK0NugFbJfZTlRg0BArlggKgPmj
        IcE3HhM50h6MpSXXTXn/UzaMT
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr40447wmi.29.1603125127938;
        Mon, 19 Oct 2020 09:32:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmmzI6Xy18s7Y4Z04FTmBQZ1vbpn96nBmr0M7V6FxutTh3mnkiTw1okMvWReJLtqtswYU0Iw==
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr40427wmi.29.1603125127752;
        Mon, 19 Oct 2020 09:32:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j17sm270116wrw.68.2020.10.19.09.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 09:32:07 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>, Alexander Graf <graf@amazon.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aaron Lewis <aaronlewis@google.com>
References: <20201005195532.8674-1-sean.j.christopherson@intel.com>
 <20201005195532.8674-3-sean.j.christopherson@intel.com>
 <bcb15eb1-8d3e-ff6d-d11f-667884584f1f@amazon.com>
 <20201007164431.GE6026@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Ignore userspace MSR filters for x2APIC
 when APICV is enabled
Message-ID: <5258c516-dc01-9377-1cf6-6a9ccd51d41d@redhat.com>
Date:   Mon, 19 Oct 2020 18:32:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007164431.GE6026@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/20 18:44, Peter Xu wrote:
> If we want to forbid apicv msrs, should we even fail KVM_X86_SET_MSR_FILTER
> directly then?

Yes, probably it should.  I'll send a patch shortly.

Paolo


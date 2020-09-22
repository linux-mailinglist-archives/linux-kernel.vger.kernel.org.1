Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54518274319
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgIVNcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbgIVNcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600781539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KOUboBhuauCRUBcQ6dQyRqiY0Af0JRbBDZbe0s5vHo=;
        b=iC8zIniEp5Q4feR2tP3QHezhN5nYKNWace4svKXmeYR2Pl+XmMMcuiHLeWPZ1pBVOEvLBR
        cbc/+D80c3lMKZnGVkf+ZKGJGF7Pch89mPyACAxdopASdoHYbkjhaex98/Yk/p+mQXNOUY
        qeGCT3kqFkc74isJtvr31GyKyz8G2L4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-wenvLfynN_O6MLKab5Mgew-1; Tue, 22 Sep 2020 09:32:17 -0400
X-MC-Unique: wenvLfynN_O6MLKab5Mgew-1
Received: by mail-wm1-f72.google.com with SMTP id r10so1119614wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9KOUboBhuauCRUBcQ6dQyRqiY0Af0JRbBDZbe0s5vHo=;
        b=YcvrBKi+JK4CeheSSdBeQ2vobEbXaRF1YrK0sQJs9rIp/sD2Y2ILnwnprIlVifzIYR
         v+F70T3p6YHw73IBNC7lXngek5MfNfz3HHApWGPjRTk9vqLkW/f3EJufxToQz5PAUFkM
         8sHRi9VdvIxraCDsWs9g8DmWfQla5rqXpsm6PwX2eXhWMRUzOqUQUjZqtd1XRp5LiiHQ
         yY8ZDIlelr3Ww1NoVhhae8yqEfdTkkBEKss4oRZln6MJ2d2o7cjVD5SxHjTMOAw1CBFY
         A54DJg1EZrgAZadEbZViDqAuzq/PbhXVJdGIb0mE+c/5NDqB+wZsg7QtXKE5iqxKrz+1
         X86A==
X-Gm-Message-State: AOAM532bDioK/RGq+L98PjFTSq6ex2msJTVxfYtX0H9GFa3PU4LQhGBb
        geuUqInWoEOII73gDNHrldW/RhctaudDngZn+YwhHDn3g9YpVJE70PWvpS+oz71MaLJkoOn5kf0
        cYOV9OXM4ERDReGc6lpQfg05B
X-Received: by 2002:adf:ec92:: with SMTP id z18mr5763127wrn.53.1600781535755;
        Tue, 22 Sep 2020 06:32:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxS6S+odf+HnI1PTGOP+NH8DPAXdJWGHQkG7uXGUMcWXEDVQMGMKrusLYnD3TH4JbKLX4KtA==
X-Received: by 2002:adf:ec92:: with SMTP id z18mr5763105wrn.53.1600781535530;
        Tue, 22 Sep 2020 06:32:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6? ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
        by smtp.gmail.com with ESMTPSA id a15sm28371867wrn.3.2020.09.22.06.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:32:14 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Add kvm_x86_ops hook to short circuit emulation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200915232702.15945-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0fe8dc75-4aa3-cd84-5fff-1d2f23c01c6a@redhat.com>
Date:   Tue, 22 Sep 2020 15:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915232702.15945-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/20 01:27, Sean Christopherson wrote:
> Replace the existing kvm_x86_ops.need_emulation_on_page_fault() with a
> more generic is_emulatable(), and unconditionally call the new function
> in x86_emulate_instruction().
> 
> KVM will use the generic hook to support multiple security related
> technologies that prevent emulation in one way or another.  Similar to
> the existing AMD #NPF case where emulation of the current instruction is
> not possible due to lack of information, AMD's SEV-ES and Intel's SGX
> and TDX will introduce scenarios where emulation is impossible due to
> the guest's register state being inaccessible.  And again similar to the
> existing #NPF case, emulation can be initiated by kvm_mmu_page_fault(),
> i.e. outside of the control of vendor-specific code.
> 
> While the cause and architecturally visible behavior of the various
> cases are different, e.g. SGX will inject a #UD, AMD #NPF is a clean
> resume or complete shutdown, and SEV-ES and TDX "return" an error, the
> impact on the common emulation code is identical: KVM must stop
> emulation immediately and resume the guest.
> 
> Query is_emulatable() in handle_ud() as well so that the
> force_emulation_prefix code doesn't incorrectly modify RIP before
> calling emulate_instruction() in the absurdly unlikely scenario that
> KVM encounters forced emulation in conjunction with "do not emulate".

Ahah, I love those adverb + adjective pairs (my favorite is
https://patchwork.kernel.org/cover/10710751/ which unfortunately was in
the cover letter and thus was not immortalized in linux.git).

"is_emulatable" is not very grammatical, so I'd rather call it
"can_emulate_instruction" instead.  Either way, it's an improvement over
"need".  Queued, thanks.

Paolo


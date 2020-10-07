Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0FC286526
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgJGQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbgJGQoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602089075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqaEw5icSFdPDojtd3NVaf6pvOb3q0DRVRJSpbduobU=;
        b=Rz3JzNAUHn2tzOKQruLg3bVXuzOaF1RwjC44uAkR+Jsr+oq2dWkHXsBGB03L5QBf8BhRi9
        Fc/yESoXq9/1sHEnKPEUlre+lcj1eyjEh5Vt67UQAwrMZDFXs7wi2NJImg7NjhI5XFF2+Q
        sGfZiwj/6AV38EfDuJlCf1telBrzsU4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-G89gfKYAND6-xJMfGFjgEQ-1; Wed, 07 Oct 2020 12:44:34 -0400
X-MC-Unique: G89gfKYAND6-xJMfGFjgEQ-1
Received: by mail-qt1-f199.google.com with SMTP id e19so1715702qtq.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 09:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uqaEw5icSFdPDojtd3NVaf6pvOb3q0DRVRJSpbduobU=;
        b=pfvh83fl4Cm0XaRcdHoB6Xea0RHQp2SfAkKPCIJiblaNdj7FNJNdxDH2qgFWcKCfIz
         fnmOxiCDcc5w1mUJ/dhGEptyJ8vS6C7UebWf/jF4wcYj45btyr804kTRxpHW6EKpeAMj
         HrMMgZcebMMLLRnQDC7vHPyonh3y+S/0K9h6dvAtHru+FgjWJ+vdr7EhBep/ew2yIzKk
         aEk/PKsPtwoChY7NRaSYKBWtG9ObuQhaBBMunfRRsUzfSodmz7IRpbk9eVIzzXrf4eAZ
         31AmKd2lBDEl1YxSm9nWOAVvAeHeqhpqevfeG5amGpMl1Zr1vw2PhkONYkzuM4aKVdjW
         NijA==
X-Gm-Message-State: AOAM532ghckiamHFN3ZItlIeOkGxYviS15+QDOnXjRPeovHlqwWloQ5W
        QxLMdFqCZn8peT9xY5ScNqHgya0DWQcxVISuLqRXbLP/kMBPixsCMu7sDbas5Sgh/d55pfxtuGH
        elvyrUKPm9UHE1uIGGsTxHk6b
X-Received: by 2002:a37:7c3:: with SMTP id 186mr3673393qkh.417.1602089073609;
        Wed, 07 Oct 2020 09:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx26wMk2ONL7Bqk1khWS1xBde3IYp73x2D7hRvH7JN+dhfsPVuudkRiYhJQo4g04aEYuSjKew==
X-Received: by 2002:a37:7c3:: with SMTP id 186mr3673359qkh.417.1602089073195;
        Wed, 07 Oct 2020 09:44:33 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id f64sm1836783qkj.124.2020.10.07.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 09:44:32 -0700 (PDT)
Date:   Wed, 7 Oct 2020 12:44:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alexander Graf <graf@amazon.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Ignore userspace MSR filters for x2APIC
 when APICV is enabled
Message-ID: <20201007164431.GE6026@xz-x1>
References: <20201005195532.8674-1-sean.j.christopherson@intel.com>
 <20201005195532.8674-3-sean.j.christopherson@intel.com>
 <bcb15eb1-8d3e-ff6d-d11f-667884584f1f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcb15eb1-8d3e-ff6d-d11f-667884584f1f@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 04:01:59PM +0200, Alexander Graf wrote:
> 
> 
> On 05.10.20 21:55, Sean Christopherson wrote:
> > 
> > Rework the resetting of the MSR bitmap for x2APIC MSRs to ignore
> > userspace filtering when APICV is enabled.  Allowing userspace to
> > intercept reads to x2APIC MSRs when APICV is fully enabled for the guest
> > simply can't work.   The LAPIC and thus virtual APIC is in-kernel and
> > cannot be directly accessed by userspace.  If userspace wants to
> > intercept x2APIC MSRs, then it should first disable APICV.
> > 
> > Opportunistically change the behavior to reset the full range of MSRs if
> > and only if APICV is enabled for KVM.  The MSR bitmaps are initialized
> > to intercept all reads and writes by default, and enable_apicv cannot be
> > toggled after KVM is loaded.  I.e. if APICV is disabled, simply toggle
> > the TPR MSR accordingly.
> > 
> > Note, this still allows userspace to intercept reads and writes to TPR,
> > and writes to EOI and SELF_IPI.  It is at least plausible userspace
> > interception could work for those registers, though it is still silly.
> > 
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Aaron Lewis <aaronlewis@google.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> I'm not opposed in general to leaving APICV handled registers out of the
> filtering logic. However, this really needs a note in the documentation
> then, no?

If we want to forbid apicv msrs, should we even fail KVM_X86_SET_MSR_FILTER
directly then?

I've no strong opinion on whether these msrs should be restricted. I'm not sure
whether my understanding is correct here - to me, kvm should always depend on
the userspace to do the right thing to make the vm work.  To me, as long as the
error is self-contained and it does not affect kvm as a whole or the host, then
it seems still fine.

However I do agree that I also worried about vmx_update_msr_bitmap_x2apic()
being slower.  Majorly I see calls from vmx_refresh_apicv_exec_ctrl() or
nested, so I'm not sure whether that could make sense for some workload.  Btw,
that seems to be another change corresponds to the idea to restrict msr
filitering on apicv regs.

Thanks,

-- 
Peter Xu


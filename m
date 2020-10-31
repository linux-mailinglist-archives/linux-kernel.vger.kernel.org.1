Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311122A1896
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgJaPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727984AbgJaPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604158450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GPtRky/4dhnp2uurQVRkXKC6EfMKsv9ZysUWkjiVSAw=;
        b=FJ8q5Aw+96JvN2Hj6NuuzihVDtmnSliWaI8g0X1rIojs3c79rxgtGB2u/0ddcCDJtZrBQX
        w5Mmi+QSLKX8oEYqY0U/7e0oYg10wZc8eMPUn0t5jupUNkt/souxFt6JC93knk/Ciekq24
        ZxaZlH1imPwPBEep0FDZ9Zd5WqAS1Z4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-e_4CntWFPPGokAhhypwVSQ-1; Sat, 31 Oct 2020 11:34:06 -0400
X-MC-Unique: e_4CntWFPPGokAhhypwVSQ-1
Received: by mail-qv1-f72.google.com with SMTP id s8so5620910qvv.18
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GPtRky/4dhnp2uurQVRkXKC6EfMKsv9ZysUWkjiVSAw=;
        b=EGwWk0UxPZ0nfSowyviWhstEO53c1Y3prQlzZbBpk6btGLu6gugBb+O0xA1TsGpu79
         NiKBtJGbehxvMqnPT+SN8V4oRWePvln15Iw93guGSS+UPSz9K6FTRS7MaPYjGVSikie7
         6rA/C+bl7gTLitId3gLfi4hE5bCS3txGnisDRMuo239pbfLTVgxoJplHz4DnPF3kJdNG
         rv5gfehBTyHBksJS6iZkIa9z58yRKx2Q9SK9aXz7ZSCDyGNXrLzZofZerK8MhystiYT+
         VsaSSY0LKpI1JN7CCIcj2xLjZsSx3GiUH/HXd4gHYOPjEEvS25WkDffM5cOOCbWG8gI2
         DvbQ==
X-Gm-Message-State: AOAM532PDlgn4Sz2juVQSsswGh6Jqpiih57lyj+Llvj8E9IXBFmrnnGk
        o+2guW1NxN085m+63ruUlUGptTABjdDu4cIWUW6hCDEp0l2lpKdXrrcRJmYkGaw82JQaGK5GbrN
        c7ScQI531KWWGjXPU32+fwDlR
X-Received: by 2002:a05:6214:a0f:: with SMTP id dw15mr13992313qvb.44.1604158446258;
        Sat, 31 Oct 2020 08:34:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKaXsMQ0TLZpWWYvPhZCkc4+m2u6T8RValElCHgJmDII7TxS2VUmQxhbdrW97JpomevJL5Tg==
X-Received: by 2002:a05:6214:a0f:: with SMTP id dw15mr13992304qvb.44.1604158446037;
        Sat, 31 Oct 2020 08:34:06 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id o2sm4444255qkk.121.2020.10.31.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 08:34:05 -0700 (PDT)
Date:   Sat, 31 Oct 2020 11:34:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: selftests: Add get featured msrs test case
Message-ID: <20201031153403.GF6357@xz-x1>
References: <20201025185334.389061-1-peterx@redhat.com>
 <20201025185334.389061-2-peterx@redhat.com>
 <874kmh2wj5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874kmh2wj5.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 09:58:54AM +0100, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Try to fetch any supported featured msr.  Currently it won't fail, so at least
> > we can check against valid ones (which should be >0).
> >
> > This reproduces [1] too by trying to fetch one invalid msr there.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=209845
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  .../testing/selftests/kvm/include/kvm_util.h  |  3 +
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 14 +++++
> >  .../testing/selftests/kvm/x86_64/state_test.c | 58 +++++++++++++++++++
> >  3 files changed, 75 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index 919e161dd289..e34cf263b20a 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -66,6 +66,9 @@ int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
> >  
> >  struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> >  struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> > +void kvm_vm_get_msr_feature_index_list(struct kvm_vm *vm,
> > +				       struct kvm_msr_list *list);
> > +int kvm_vm_get_feature_msrs(struct kvm_vm *vm, struct kvm_msrs *msrs);
> >  void kvm_vm_free(struct kvm_vm *vmp);
> >  void kvm_vm_restart(struct kvm_vm *vmp, int perm);
> >  void kvm_vm_release(struct kvm_vm *vmp);
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 74776ee228f2..3c16fa044335 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -132,6 +132,20 @@ static const struct vm_guest_mode_params vm_guest_mode_params[] = {
> >  _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
> >  	       "Missing new mode params?");
> >  
> > +void kvm_vm_get_msr_feature_index_list(struct kvm_vm *vm,
> > +				       struct kvm_msr_list *list)
> > +{
> > +	int r = ioctl(vm->kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
> > +
> > +	TEST_ASSERT(r == 0, "KVM_GET_MSR_FEATURE_INDEX_LIST failed: %d\n",
> > +		    -errno);
> > +}
> > +
> > +int kvm_vm_get_feature_msrs(struct kvm_vm *vm, struct kvm_msrs *msrs)
> > +{
> > +	return ioctl(vm->kvm_fd, KVM_GET_MSRS, msrs);
> > +}
> 
> I *think* that the non-written rule for kvm selftests is that functions
> without '_' prefix check ioctl return value with TEST_ASSERT() and
> functions with it don't (e.g. _vcpu_run()/vcpu_run()) but maybe it's
> just me.

Sure, will fix it up.

> 
> > +
> >  /*
> >   * VM Create
> >   *
> > diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
> > index f6c8b9042f8a..7ce9920e526a 100644
> > --- a/tools/testing/selftests/kvm/x86_64/state_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/state_test.c
> 
> I would not overload state_test with this new check and create a new
> one. The benefit is that when one of these tests fail we still get the
> result of the other one so it's not 'everything works' vs 'everything is
> broken' type of log.

IMHO it's not extremely important on knowingg which binary failed - afaiu,
kernel selftests are really for an "all pass", so if anything fails, we dig.

Another thing, state_test.c has a comment (at the top):

/*
 * KVM_GET/SET_* tests
 *
 * Copyright (C) 2018, Red Hat, Inc.
 ...

Shouldn't KVM_GET_MSRS suites here? :)

Thanks,

-- 
Peter Xu


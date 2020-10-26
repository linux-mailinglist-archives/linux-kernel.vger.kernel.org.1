Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B29298921
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772607AbgJZJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1422271AbgJZJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603703317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pOBGZ5+A7L2rnaWgcxvogJM7iw4FNPt7uW+XKHPm+GM=;
        b=Q+ySPu9zNOD0pPlV27pMUS8tQw/V9nYFO2i6WOBFTS/xj2Kl4stgvYBl3leASqP8PMUnum
        1O6ClqlWopVjd8JsCLFHjPjP99MZfp4+f4i0difVW20BOtsAB8QQbNydrlGKwTm2QfjW9d
        /PCbZaW6HhI0+jcGgrNXRjPMIlXJNoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-NhFTAwbvNemABcpc2XymHA-1; Mon, 26 Oct 2020 05:08:35 -0400
X-MC-Unique: NhFTAwbvNemABcpc2XymHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9918564ACA;
        Mon, 26 Oct 2020 09:08:34 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1755B5D9E4;
        Mon, 26 Oct 2020 09:08:29 +0000 (UTC)
Date:   Mon, 26 Oct 2020 10:08:27 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: selftests: Add get featured msrs test case
Message-ID: <20201026090827.muchi7h5dcvh5c2r@kamzik.brq.redhat.com>
References: <20201025185334.389061-1-peterx@redhat.com>
 <20201025185334.389061-2-peterx@redhat.com>
 <874kmh2wj5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kmh2wj5.fsf@vitty.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 09:58:54AM +0100, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
> > +int kvm_vm_get_feature_msrs(struct kvm_vm *vm, struct kvm_msrs *msrs)
> > +{
> > +	return ioctl(vm->kvm_fd, KVM_GET_MSRS, msrs);
> > +}
> 
> I *think* that the non-written rule for kvm selftests is that functions
> without '_' prefix check ioctl return value with TEST_ASSERT() and
> functions with it don't (e.g. _vcpu_run()/vcpu_run()) but maybe it's
> just me.
>

Yes, that's the pattern I've been trying to implement. If we want to be
strict about it, then we should do a quick scan of the code to ensure
its currently consistent. I have it feeling it isn't.

Thanks,
drew


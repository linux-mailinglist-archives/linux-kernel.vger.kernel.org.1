Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12A02A188F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgJaP1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727355AbgJaP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604158071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CeMu0Q01glqXmwQt4+Bz8jKavcgfaMX1Jr1NHqeLsAQ=;
        b=NONAWzppjNLdwAyymQLF4tu6bAEMqKA8Fge4+9YYI2S+V0xNgbdI5hyKcqtKs92WYNrvt0
        duvM+62S8zwUZVFmNUQMlTaIYJbdx2sFnJfL8V62Ei11GmGWgGZ1vsWV2PF841CQuHcaem
        gvIkwdNMcsqT1ZU2JxiHb/xHVCdoFUM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-BACxchW1PxyRqYgEnSP2vQ-1; Sat, 31 Oct 2020 11:27:49 -0400
X-MC-Unique: BACxchW1PxyRqYgEnSP2vQ-1
Received: by mail-qk1-f197.google.com with SMTP id f126so5862764qke.17
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CeMu0Q01glqXmwQt4+Bz8jKavcgfaMX1Jr1NHqeLsAQ=;
        b=jFq9/JGJ1o7L8ZS4XuFiXIlk9eexpap1ajAt/k/efTgKcAcAWnIPZNMgb6y7gf/kJe
         ygyNxLXI9qLxm99K+qo875Rsj2UQYXVbfjGJkKwelRPF9OEL3EgwlZL1CNGDsmwoKI0i
         q2A3ghoIzsVUR8O3R5+88l6oupEmWiBPIp82XLq0I3O4BzpGzS4MIKmvIxAameq2q0ku
         b36RhyDVhcBz8GPyD+4ycvbiAA3Wxhk0ZUDQnUqWjm4DN1d3SWeEIYX226pKWsve2dr2
         JbfsCTKAS3OM13f+8qgQX+cZcKK6daSJE2EKiyNDCMoI86TbEY3SryZDDOT34YPRAfys
         0wtQ==
X-Gm-Message-State: AOAM530mnAm8859Klz3+88LW5kLGa9a9xq5Pu3ErDyhsp+DA+SYB2K7P
        VVHKeNTlKzfHdQUJgga45yxL2i6qzsRIAKPbCZtCKYq1+HOl+BfXChKbhTJHfJ6RxlMdpKi8ASJ
        csy9ZfLwlaf/78btf/j7hJn3F
X-Received: by 2002:a37:5904:: with SMTP id n4mr7238274qkb.364.1604158068836;
        Sat, 31 Oct 2020 08:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDh0Hlgox2NxrXVtI9hV5MphLGsUtUUJ1oY7eXHwn7qxgz6UGiFk4EsUQC501eZpz9ZjrkKQ==
X-Received: by 2002:a37:5904:: with SMTP id n4mr7238259qkb.364.1604158068650;
        Sat, 31 Oct 2020 08:27:48 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id j50sm1851112qtc.5.2020.10.31.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 08:27:47 -0700 (PDT)
Date:   Sat, 31 Oct 2020 11:27:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Steffen Dirkwinkel <kernel-bugs@steffen.cc>
Subject: Re: [PATCH 2/2] KVM: X86: Fix null pointer reference for KVM_GET_MSRS
Message-ID: <20201031152746.GE6357@xz-x1>
References: <20201025185334.389061-1-peterx@redhat.com>
 <20201025185334.389061-3-peterx@redhat.com>
 <c20d7c85-b2f3-608a-833f-093363fac5f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c20d7c85-b2f3-608a-833f-093363fac5f5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 03:06:59PM +0100, Paolo Bonzini wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index ce856e0ece84..5993fbd6d2c5 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -259,8 +259,8 @@ static int kvm_msr_ignored_check(struct kvm_vcpu *vcpu, u32 msr,
> >  
> >  	if (ignore_msrs) {
> >  		if (report_ignored_msrs)
> > -			vcpu_unimpl(vcpu, "ignored %s: 0x%x data 0x%llx\n",
> > -				    op, msr, data);
> > +			kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n",
> > +				      op, msr, data);
> >  		/* Mask the error */
> >  		return 0;
> >  	} else {
> > 
> 
> I committed Takashi Iwai's very similar patch.  Please resend 1/2 with
> reviewer comments addressed, thanks!

Sorry for a late reply (to reviewers).

Oh, how did I miss the other vcpu reference... that one is definitely better. :)

Will respin shortly on the test.

Thanks,

-- 
Peter Xu


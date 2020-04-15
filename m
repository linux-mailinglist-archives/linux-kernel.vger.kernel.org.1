Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD861A99A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408452AbgDOJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 05:54:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22309 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2895873AbgDOJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586944176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qaGXYPrjx6asVnwUlRwgPZ9xv0d8gA5/xd4DP6F32Eg=;
        b=f+XE5fH3w+CTeU7C/7DW0Rh5upeav7Dq8MYzb5UOOVQChq7gj+eSinhy0HBhwUHmYR2EVJ
        L7jsnziyvb2oXbp/SQJ5zjM7NGYnYBzt9thN0HW8U9LbH8o2veIbnC0Ss6pLvg3BX8XgwN
        pVTaoNQPlHdOoLU2/Jx57q4ZepS00Qo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-0xTk02FKNDeyrW7ccboN8Q-1; Wed, 15 Apr 2020 05:49:28 -0400
X-MC-Unique: 0xTk02FKNDeyrW7ccboN8Q-1
Received: by mail-wr1-f70.google.com with SMTP id v14so10313602wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qaGXYPrjx6asVnwUlRwgPZ9xv0d8gA5/xd4DP6F32Eg=;
        b=WZd5IlVnljuLQucde2jmHh7Kt6remj6Ii//a5Ozy+UYwG7hoaePFGDdJDNJswWvgdp
         ZPuCVFagEHDDXex3pm7jXaBqd5Ty2zE7GBLaa6LUFgzmQbYdp4BvnDAYyTvKrUW4glcI
         vd9edfwRuGEIaOTC43T9TeWxCJ9+GiBDFM20XC976nOYDG8AzOLzIkDr6RAzY/CEmnxn
         b2HvNXdoeBf6F40JeA1m/borhTYgIycWwwd+8q1VgijzPv5xnmO7tAJStd+ZCMYiVR0Z
         Cz1nJN8fsEdFUPiFq97KMMsJgi88FEsMaCmMiEs5OVjVHRR5TL0IBoyDIbJVEkHWIeVO
         kJtg==
X-Gm-Message-State: AGi0PubxShLOo9UIWw73I7HTkX96RlFZt9SctY8hronyNWxkPobLoTyx
        V49hoV+RBoozjXvFwetWWjCCqn26EQPwFklA7mgNfoEA+2uLE41d80AHtlsw1BQGqFLbkU1SYfL
        Yq5BN94zhnKrUWk+w2bbfASxc
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr22513579wrx.189.1586944166843;
        Wed, 15 Apr 2020 02:49:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypK6iom3TxtitcFG3fEyEhV0IQri7rGaW4po1K8ddZ+k0gAwKo+5fXC8PqAQAruae6CWSJ1r4g==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr22513570wrx.189.1586944166653;
        Wed, 15 Apr 2020 02:49:26 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l15sm21578535wmi.48.2020.04.15.02.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:49:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Cathy Avery <cavery@redhat.com>, pbonzini@redhat.com
Cc:     wei.huang2@amd.com, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: SVM: Implement check_nested_events for NMI
In-Reply-To: <20200414201107.22952-1-cavery@redhat.com>
References: <20200414201107.22952-1-cavery@redhat.com>
Date:   Wed, 15 Apr 2020 11:49:25 +0200
Message-ID: <87zhbdw02i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cathy Avery <cavery@redhat.com> writes:

> Moved nested NMI exit to new check_nested_events.
> The second patch fixes the NMI pending race condition that now occurs.
>
> Cathy Avery (2):
>   KVM: SVM: Implement check_nested_events for NMI
>   KVM: x86: check_nested_events if there is an injectable NMI
>

Not directly related to this series but I just noticed that we have the
following comment in inject_pending_event():

	/* try to inject new event if pending */
	if (vcpu->arch.exception.pending) {
                ...
		if (vcpu->arch.exception.nr == DB_VECTOR) {
			/*
			 * This code assumes that nSVM doesn't use
			 * check_nested_events(). If it does, the
			 * DR6/DR7 changes should happen before L1
			 * gets a #VMEXIT for an intercepted #DB in
			 * L2.  (Under VMX, on the other hand, the
			 * DR6/DR7 changes should not happen in the
			 * event of a VM-exit to L1 for an intercepted
			 * #DB in L2.)
			 */
			kvm_deliver_exception_payload(vcpu);
			if (vcpu->arch.dr7 & DR7_GD) {
				vcpu->arch.dr7 &= ~DR7_GD;
				kvm_update_dr7(vcpu);
			}
		}

		kvm_x86_ops.queue_exception(vcpu);
	}

As we already implement check_nested_events() on SVM, do we need to do
anything here? CC: Jim who added the guardian (f10c729ff9652).

>  arch/x86/kvm/svm/nested.c | 21 +++++++++++++++++++++
>  arch/x86/kvm/svm/svm.c    |  2 +-
>  arch/x86/kvm/svm/svm.h    | 15 ---------------
>  arch/x86/kvm/x86.c        | 15 +++++++++++----
>  4 files changed, 33 insertions(+), 20 deletions(-)

-- 
Vitaly


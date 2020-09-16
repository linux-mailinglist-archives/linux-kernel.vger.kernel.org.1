Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D327C26C51A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIPQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgIPQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600273153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZI8lYi1OnkVKApFKCxg3mkSWXhff04EIiDJ1538o1/E=;
        b=A7ICzLdSbNdFff2Ai0+V6rYbZugNXJxwfYBCAxvoOLctwhXY0R4A5ogopaLgxKNZbfjhEU
        /X1ozZ9IeSZofUmCa9/45dTVsumWKUQvGTMZih5L7rGkHBhwB55x2rM/dVvKlSxVQoCfXb
        oLcQPktJ4flLBwcvu7kESt7DFN366gY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-0goMPl7JN7CZKPGN7_KAgw-1; Wed, 16 Sep 2020 12:10:30 -0400
X-MC-Unique: 0goMPl7JN7CZKPGN7_KAgw-1
Received: by mail-wr1-f72.google.com with SMTP id l17so2717780wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 09:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZI8lYi1OnkVKApFKCxg3mkSWXhff04EIiDJ1538o1/E=;
        b=UGMU8mSTQPZ848oUULmdXtQjnOFktVQ4F+1EkB3YufbIT54b2nErCU/zz8jVbWOy+M
         x6xIyhN4+5U7AiK/KDXPlnVqpU0wcHf6tMOuPACzOd83Wdz8rJ6JqjAhV/4zdFejerK8
         3UoCWnKG8Y509bZWItgIr658IvCYBZOw+9Ebx5OXHZcVtcgm2CARE3QjqmUgZNyoyOnn
         mCmFRzWbgAj5+KhD3mIXQ3wwfHHZOxSbc3lk0Xu0YC+quGk8KIly72mdwgo8G68YdYIV
         hJQSH4c30G1QhA57dXWsh6OwGf5gkbeRJ5PYNe9Vfx+IUhVjExiU8MBF9KskFi3dsMn+
         D+mg==
X-Gm-Message-State: AOAM532n2ZlI4btzdr+U+DX0ky4nrUbOCTc6zZXQBRVsUTcpBv+wZLsT
        PIthmE8jWDLjzMugj/Nat9shMvN5H9HOywqaM80BM8tV6wKDdOycQpGwIwQ/T3Vx3rUvk8XcOIv
        IVk/6ByEU3LDJ/vhb2D+TcI1q
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr26503607wrn.238.1600272629073;
        Wed, 16 Sep 2020 09:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4gkeEWQ6yHkbBOZuacUwDzTM6N52gpGFRvDHDpxtVhNLQe2bjA37+/5JF9PlTOObWYT9BrQ==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr26503567wrn.238.1600272628809;
        Wed, 16 Sep 2020 09:10:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f126sm6261892wmf.13.2020.09.16.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 09:10:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 06/18] x86/hyperv: allocate output arg pages if required
In-Reply-To: <20200916154200.7nf74vjmqu3f6sfq@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-7-wei.liu@kernel.org> <871rj3l4yt.fsf@vitty.brq.redhat.com> <20200915124318.z6tisek5y4d7e254@liuwe-devbox-debian-v2> <20200916154200.7nf74vjmqu3f6sfq@liuwe-devbox-debian-v2>
Date:   Wed, 16 Sep 2020 18:10:26 +0200
Message-ID: <87zh5phfd9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Tue, Sep 15, 2020 at 12:43:18PM +0000, Wei Liu wrote:
>> On Tue, Sep 15, 2020 at 12:16:58PM +0200, Vitaly Kuznetsov wrote:
>> > Wei Liu <wei.liu@kernel.org> writes:
>> > 
>> > > When Linux runs as the root partition, it will need to make hypercalls
>> > > which return data from the hypervisor.
>> > >
>> > > Allocate pages for storing results when Linux runs as the root
>> > > partition.
>> > >
>> > > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> > > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> > > ---
>> > >  arch/x86/hyperv/hv_init.c       | 45 +++++++++++++++++++++++++++++----
>> > >  arch/x86/include/asm/mshyperv.h |  1 +
>> > >  2 files changed, 41 insertions(+), 5 deletions(-)
>> > >
>> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> > > index cac8e4c56261..ebba4be4185d 100644
>> > > --- a/arch/x86/hyperv/hv_init.c
>> > > +++ b/arch/x86/hyperv/hv_init.c
>> > > @@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>> > >  void  __percpu **hyperv_pcpu_input_arg;
>> > >  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>> > >  
>> > > +void  __percpu **hyperv_pcpu_output_arg;
>> > > +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>> > > +
>> > >  u32 hv_max_vp_index;
>> > >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>> > >  
>> > > @@ -75,14 +78,29 @@ static int hv_cpu_init(unsigned int cpu)
>> > >  	u64 msr_vp_index;
>> > >  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>> > >  	void **input_arg;
>> > > -	struct page *pg;
>> > > +	struct page *input_pg;
>> > >  
>> > >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>> > >  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>> > > -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
>> > > -	if (unlikely(!pg))
>> > > +	input_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
>> > > +	if (unlikely(!input_pg))
>> > >  		return -ENOMEM;
>> > > -	*input_arg = page_address(pg);
>> > > +	*input_arg = page_address(input_pg);
>> > > +
>> > > +	if (hv_root_partition) {
>> > > +		struct page *output_pg;
>> > > +		void **output_arg;
>> > > +
>> > > +		output_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC :
>> > >  	GFP_KERNEL);
>> > 
>> > To simplify the code, can we just rename 'input_arg' to 'hypercall_args'
>> > and do alloc_pages(rqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, 1) to
>> > allocate two pages above?
>> 
>> It should be doable, but I need to code it up and test it to be 100%
>> sure.
>> 
>
> I switch to alloc_pages to allocate an order of 2 page if necessary, but
> I keep input_arg and output_arg separate because I want to avoid code
> churn in other places.
>

My idea was that we're free to choose how to use these pages, e.g. with
two pages allocated we can now do a hypercall which takes two pages of
input and produces no output other than the return value. This doesn't
contradict your suggestion to keep input_arg/output_arg as these are
just pointers to the continuous space, we can still do the trick.

I don't feel strong about this and you probably have more patches in
your stash, no need for massive re-work I believe. 

-- 
Vitaly


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36222A3664
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgKBWVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgKBWVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604355669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6pKs70k0LTWEUZx/agbV0FZqBJNjhpxBo6XcxlUy3Cg=;
        b=MTjUvtfxReBqaCPqh7XlwhJ9P+Kvp34cgpPezjOQWu4YcKyqwuX80mlJCQJopJS01nWdGk
        PAgEspoqNA89GYWoHY/t/A+Nu39lcw5ZnRQGgeAj16Pq8LTjaFSYBphnE6oaDyQp70asWd
        qMKHcgJ5XrcrNH4BpgSe8bE8biPbvFI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-P_j0rS-DMn6cJt0xIdkm3Q-1; Mon, 02 Nov 2020 17:21:05 -0500
X-MC-Unique: P_j0rS-DMn6cJt0xIdkm3Q-1
Received: by mail-qv1-f70.google.com with SMTP id o12so2015478qvw.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 14:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6pKs70k0LTWEUZx/agbV0FZqBJNjhpxBo6XcxlUy3Cg=;
        b=UoXIbua+0FDmhGW833EsxyIdfTeUMsOHrqculDBJfqiJXKua5KBbuCKJ1Izkd54Fvh
         /qNragExNIhK62cD+UQDa1QJ33BD7qP8iPhcDmJOQo1G/iaDjt9tKln1UAjxELl79tsx
         p4iw+a4tzPjlhlaaNwpdgd2Q51heE8/TEb6KloiTXT8BIcLWq+KtJPo4/KSHaH6mFftJ
         GRJg7SrWwwmjCFPueJF1fH+/ur7ZMa0+Vpn7ZtOElgD8rHr2PtGVIYhU2wvrp/wYxOfA
         qSqMCFsIlAO127Wo9zRKxXOv2RZE1e8cX5H88rCAL7AwghoOUVOq+FOjGoE6DKlGiAFA
         M/VQ==
X-Gm-Message-State: AOAM5322JcA3FeTnyfHCXHZs9Blrgt1HRrdsKESPIcHKkoPlhXQkxpKC
        zaFuA7mFW5EQHlYH2K1UNGleaTnc6b3nyKSkGJxUtMmKR/xSiupx2ZX+SbhAPoS4WiPycwpsLmZ
        ryNESaDRh3oqPWFmenzGV320D
X-Received: by 2002:a37:6311:: with SMTP id x17mr16848458qkb.323.1604355665145;
        Mon, 02 Nov 2020 14:21:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjl9A/td6lT7MKwdVzrv1Waaf1gt+ws8gz0KJFGXQE7ykpl45WfI/aQQXC4f/dmiMfuhqTig==
X-Received: by 2002:a37:6311:: with SMTP id x17mr16848439qkb.323.1604355664876;
        Mon, 02 Nov 2020 14:21:04 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id 8sm7268919qkk.90.2020.11.02.14.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 14:21:04 -0800 (PST)
Date:   Mon, 2 Nov 2020 17:21:02 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH 5/5] KVM: selftests: Introduce the dirty log perf test
Message-ID: <20201102222102.GE20600@xz-x1>
References: <20201027233733.1484855-1-bgardon@google.com>
 <20201027233733.1484855-6-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027233733.1484855-6-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:37:33PM -0700, Ben Gardon wrote:
> The dirty log perf test will time verious dirty logging operations
> (enabling dirty logging, dirtying memory, getting the dirty log,
> clearing the dirty log, and disabling dirty logging) in order to
> quantify dirty logging performance. This test can be used to inform
> future performance improvements to KVM's dirty logging infrastructure.

One thing to mention is that there're a few patches in the kvm dirty ring
series that reworked the dirty log test quite a bit (to add similar test for
dirty ring).  For example:

  https://lore.kernel.org/kvm/20201023183358.50607-11-peterx@redhat.com/

Just a FYI if we're going to use separate test programs.  Merging this tests
should benefit in many ways, of course (e.g., dirty ring may directly runnable
with the perf tests too; so we can manually enable this "perf mode" as a new
parameter in dirty_log_test, if possible?), however I don't know how hard -
maybe there's some good reason to keep them separate...

[...]

> +static void run_test(enum vm_guest_mode mode, unsigned long iterations,
> +		     uint64_t phys_offset, int vcpus,
> +		     uint64_t vcpu_memory_bytes, int wr_fract)
> +{

[...]

> +	/* Start the iterations */
> +	iteration = 0;
> +	host_quit = false;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
> +		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
> +			       &perf_test_args.vcpu_args[vcpu_id]);
> +	}
> +
> +	/* Allow the vCPU to populate memory */
> +	pr_debug("Starting iteration %lu - Populating\n", iteration);
> +	while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
> +		pr_debug("Waiting for vcpu_last_completed_iteration == %lu\n",
> +			iteration);

Isn't array vcpu_last_completed_iteration[] initialized to all zeros?  If so, I
feel like this "while" won't run as expected to wait for populating mem.

The flooding pr_debug() seems a bit scary too if the mem size is huge..  How
about a pr_debug() after the loop (so if we don't see that it means it hanged)?

(There's another similar pr_debug() after this point too within a loop)

Thanks,

-- 
Peter Xu


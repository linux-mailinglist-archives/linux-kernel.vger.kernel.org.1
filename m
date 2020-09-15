Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1226A3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIOK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgIOK5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:57:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 03:57:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m15so1141963pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jwkMsDqbHDpkmL1DX5NgTbbCQ3AjMnA4hImq/0BH+g8=;
        b=Z1en/MsuS0FkLwP9QiKP4RDKQ4lDQrtoQcNhaQbkkWLL0C7dop77EY6E35zFR3KEPv
         tHy4ymOajbSYRNFipuUxO/ue+Ey0xOrnD0w+KURVDA8S9vTK9qYklTQFqXpb12xuHvmJ
         +sZj50iAni6pL8qSngd1dy/Wfa9or7UJIURMLST69b/CWmTFoNeAHdC7npkdyK/qLhs5
         tKLUukQJlbpxfnW+5tksh44wwjw8nOtwhDxh1qVUHDQw2XdjjF0Mb35LJGYGqo9hkvMa
         cb3KTdqAxVTD6vI4qGGWAWVq0ld7iPOHwXP9XTjoo5PzX1x5PFL57t9yku8TRVsyqTrX
         XreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwkMsDqbHDpkmL1DX5NgTbbCQ3AjMnA4hImq/0BH+g8=;
        b=o1Y4JeIt4ighq1iiqrr5/CJGryNn6rgYf6xJGnjPkMMdh6WzZ0nKNq8l2qCztH8FSe
         8ehMaZeNWPQ4L/r2c6tWJrXj8y5sAOQ3SJKYeWjv1pGOMpyfWf8XJb6cZQb9Enko1bmZ
         01ImTnjs/vK+ivelCP6IneUAh1KEFezK4A7UCq2iJS2SCO2E+B/gv5jXPtuuL3/LWrH3
         MOIGX0eTAJ0es0M6TNfXJL6PodZmDdNC3h41WeygT5Q/uUYgsZesiKNszfqHVibVSWLT
         k6Vd1QPIVBVivj2RS6K34dNuY/BlSYTzPYM6NqeOocAJkhzihB2+n96oa6Nh118t294I
         v3iA==
X-Gm-Message-State: AOAM533EisDgUwsFsDJmCR5pBiGA8Sza3UfaEQ3FLBGvwaisAppYXEWa
        8JBM8kdQZFopZBNYLhzadSY=
X-Google-Smtp-Source: ABdhPJzRoeYwWAVjm+161ifDeODD584x26HaSlSK2Ee2HVdWhaSe/P++BaS7m2BhbnFG3MOgK3KsjA==
X-Received: by 2002:a17:90b:d89:: with SMTP id bg9mr3429765pjb.26.1600167425864;
        Tue, 15 Sep 2020 03:57:05 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id s28sm13471235pfd.111.2020.09.15.03.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:57:04 -0700 (PDT)
Date:   Tue, 15 Sep 2020 19:57:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2] perf kvm: add kvm-stat for arm64
Message-ID: <20200915105702.GA604@jagdpanzerIV.localdomain>
References: <20200915091140.152775-1-sergey.senozhatsky@gmail.com>
 <20200915103644.GA32758@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915103644.GA32758@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (20/09/15 18:36), Leo Yan wrote:
> > +#define HVC_STUB_ERR		  0xbadca11
> > +
> > +/* Per asm/kvm_asm.h */
> > +#define ARM_EXCEPTION_IRQ		0
> > +#define ARM_EXCEPTION_EL1_SERROR	1
> > +#define ARM_EXCEPTION_TRAP		2
> > +#define ARM_EXCEPTION_IL		3
>
> Nitpick: from completeness, we also can give out KVM exiting reason
> for 'ARM_EXCEPTION_IL'.

OK, let me take a look.

> > +define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
> > +define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
> > +
> > +const char *kvm_trap_exit_reason = "esr_ec";
> > +const char *vcpu_id_str = "id";
> > +const int decode_str_len = 20;
> > +const char *kvm_exit_reason = "ret";
> > +const char *kvm_entry_trace = "kvm:kvm_entry";
> > +const char *kvm_exit_trace = "kvm:kvm_exit";
> > +
> > +const char *kvm_events_tp[] = {
> > +	"kvm:kvm_entry",
> > +	"kvm:kvm_exit",
>
> I think Arm64 needs to support event 'kvm_mmio'.  It's good to use a
> new patch for support this event?

Yes, I guess a follow up kvm_mmio patch would be a better option.

> > +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
> > +{
> > +	kvm->exit_reasons = arm64_exit_reasons;
>
> Since the "kvm->exit_reasons" will be always set in the function
> event_get_key(), seems to me here can remove this assignment.

Yes, this assignment is a leftover.

	-ss

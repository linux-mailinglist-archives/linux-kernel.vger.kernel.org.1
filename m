Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7998C26FAB2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRKfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:35:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170DCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:35:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k14so3218264pgi.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RqoAg1y2XJE1pFIbTt3E45OwWJcrNJ7ET1lzszenztA=;
        b=pLoy5C3SRHQvO5NIp9UEoCT2SMIgggujADGmgj9gYlGv8cEVq3TP3o0+Mss1DMwieg
         Mi6ngkCS3PhqQOHAMfdiZ+7EjwZVFL4XGUisiGUeJn63+wWvWVaeFEiXuroAWCoCq+Y3
         rhy8QrMfp610bpsB0ENJCT90q9MyUDPCbgjkfR2BxmOORujEOKWoUnjln2Fx88CfVJpE
         KGhmxNMtjxJeUtHvg5TsHT6e9oqYN0V9D8GbHM2UxMjm/eCa0yrS/p0tjTn+6pFPK8vH
         4b3Da4HNwV5ErsGKR/J3C8pznSAZPYj+qGKCe46eDbqSsA0xSx6yDn1CP01efj2gU3zZ
         Y1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqoAg1y2XJE1pFIbTt3E45OwWJcrNJ7ET1lzszenztA=;
        b=VRfnSD6vBg/roPR08i9I6KhtDRzwgr6pNW1tmcyIEBDNjDdLU5nHWYXXs9sev1ZNYe
         h9AKxnlxFQhIbM3//eQErG+KZfPBDSZBuDidG3as3NSJ2zAOmaMsFU43I7xO7MKy4nQc
         1wbbk6nYfr4z02xWY5+GOQBj2egXK3R03rx0ArgNj9zhpQBrPHN+0g77jxw4RaVs4eDV
         aR2ijhsyh84T3JiGMxoVWw+/owX2VlstkkH+TNX2KEKalf76t2zNVLxO+XHJfVuv4V0G
         HNL7dWDuR61C08tUCkbd0ldWA9rnXxcrgMnviAzq9Qq7BB9YQVgc8NN9PtXjYCMtEJqd
         bsLA==
X-Gm-Message-State: AOAM5315BR0728f6vIh7Rwr5EKvcfqP06rf50bpqiNQ1wAH+AO9JiDrQ
        bMt8J4hkbM7xFCJ1mk0yZm0=
X-Google-Smtp-Source: ABdhPJwZ1SuDZiux9y0FN9/TViASeCp9ftZFPp+ILwCxrKkVnoUT2VtcGCDOOJ4NYMgUZbXIDGF8PA==
X-Received: by 2002:a63:f104:: with SMTP id f4mr27363203pgi.365.1600425323501;
        Fri, 18 Sep 2020 03:35:23 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id r5sm2513402pgk.34.2020.09.18.03.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:35:22 -0700 (PDT)
Date:   Fri, 18 Sep 2020 19:35:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] perf kvm: add kvm-stat for arm64
Message-ID: <20200918103521.GE3049@jagdpanzerIV.localdomain>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
 <652f10660f09bd608b825233713f775a@kernel.org>
 <20200917114231.GE12548@leoy-ThinkPad-X240s>
 <ca309fcda71944455a8c6c1b308886ba@kernel.org>
 <20200918003219.GC3049@jagdpanzerIV.localdomain>
 <f60758eeacb4e94db698d98d6d447939@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60758eeacb4e94db698d98d6d447939@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/18 09:20), Marc Zyngier wrote:
> On 2020-09-18 01:32, Sergey Senozhatsky wrote:
> > On (20/09/17 12:53), Marc Zyngier wrote:
> > > Feel free to add a *new* tracepoint instead.
> > 
> > Wouldn't we want a whole bunch of new tracepoints in this case?
> 
> Yes. I don't have a better solution as long as tracepoints are ABI.

Well, no one does.

> Get someone to sign-off on it, and I'll happily change them.

Sorry, I'm not sure I understand this sentence.

> > (almost all of the existing ones with the extra vcpu_id field).
> > Right now we have 3 types of events:
> > - events with no vcpu at all        // nil
> > - events with vcpu_pc               // "0x%016lx", __entry->vcpu_pc
> > - events with (void *)vcpu          // "vcpu: %p", __entry->vcpu
> > 
> > It might be helpful if we could filter out events by vcpu_id.
> > But this, basically, doubles the number of events in the ringbuffer.
> 
> Only if you enable them both, right?
[..]
> How would that double the number of events in the buffer?

Yes. I assume that many scripts do something like "capture kvm:* events",
so new and old events are enabled. Unless we want to keep new events in
something like kvm2:* namespace (which is unlikely to happen, I guess).

And `sudo ./perf stat -e 'kvm:*'` is not unseen. In fact, this is
literally the first thing mentioned at https://www.linux-kvm.org/page/Perf_events

So if we'll have something like

	trace_kvm_foo(vcpu);
+	trace_kvm_foo2(vcpu->id, vcpu);

for all arm64 kvm events, then we double the number of arm64 kvm:* events
in the ringbuffer, don't we? Maybe this is not a gigantic issue, but who
knows.

	-ss

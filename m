Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67272C404F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgKYMgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgKYMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:36:38 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EF5C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:36:38 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y18so4006375qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KACiLRDVxG3h/sLMQ5dOaIvM1T2lG1rMqMZCn55vO8Y=;
        b=AnWJWjKEUWg8YC83KOrcI1Z9ba7gj4AFoRn0qBjTEuxTcE1WiNCvsdHZmFilzcFHMz
         JyUDUHvXthXTJmdu8ZVPPblOtntilq9CZfbysnjvoq7utw8AqeZaU58fIpSd/mtFe54d
         k1pf9FM1j3XMIRbEJsp8unCNMH+7AVs37sh0ylcErtChJhHo1ZlrTWyIXt0u6hEwwARX
         srgcDWeYbPR3P6yJyT2bQ5AAtC9ZedxfF5LP8q64nfsHkHMDcwQWW+yOW4CU61/SnP1/
         mkAQ9uGXdJHWX48oYC4e5MX0lt0RV87HkMvZ1uA2w3wJVdOZJ3gRObO/y0cs7d34gZv8
         2D5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KACiLRDVxG3h/sLMQ5dOaIvM1T2lG1rMqMZCn55vO8Y=;
        b=FFZY6WtZeitY01WZ2q4yGuXh+OsCrRfNUFEMzpMUXbycY/y249GLptcvJtdQOo258g
         /oOXFuoB9xVmHmU5yy1j2cXYQIiCgR8OG4zfPFkwN3HAXbOKbNyKwQLHwENjfte9sQzf
         PBEbpYvjJELe7nPbePs2WDtPYe6+1uI3kw6OtdixMnnsvq2clfeAvrMOBO6mPI0p6bDs
         ooBdT5ip5Fxfns7MnDApdX2ioo/wyO6Jpc8CBBKYTiLGHAK6AqNXxjUL9rd4JQk7SuEd
         pf46q0leooTV7SskSOBZttmMg5JAXFKL7Kth7YWrR4mF0VLrpenmMa7mauOSgO4kAkls
         qJgg==
X-Gm-Message-State: AOAM5336n99L/MOX8AznlBdyGFHSo47OCrw25T2C/2k2phd5efAzjCaW
        wrWa9Lcnfa87mqC+4+cYRqc=
X-Google-Smtp-Source: ABdhPJwMgTyXQyATF3eAmY8VpHYCXLVrVBqKKGvRYkFlPMKpvFpqPa3xZqaguD3zAvjjud+9PXgKMg==
X-Received: by 2002:a37:a654:: with SMTP id p81mr2978588qke.404.1606307797779;
        Wed, 25 Nov 2020 04:36:37 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id b197sm2337308qkg.65.2020.11.25.04.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:36:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:36:14 -0500
From:   "tj@kernel.org" <tj@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Message-ID: <X75Pvp9q3XTckdwd@mtj.duckdns.org>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109140141.GE7496@mtj.duckdns.org>
 <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
 <20201109161007.GF7496@mtj.duckdns.org>
 <87ft55nd6n.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft55nd6n.fsf@notabene.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 20, 2020 at 10:23:44AM +1100, NeilBrown wrote:
> On Mon, Nov 09 2020, tj@kernel.org wrote:
> 
> >                                                    Given that nothing on
> > these types of workqueues can be latency sensitive
> 
> This caught my eye and it seems worth drilling in to.  There is no
> mention of "latency" in workqueue.rst or workqueue.h.  But you seem to
> be saying there is an undocumented assumption that latency-sensitive
> work items much not be scheduled on CM-workqueues.
> Is that correct?

Yeah, correct. Because they're all sharing execution concurrency, the
latency consistency is likely a lot worse.

> NFS writes are latency sensitive to a degree as increased latency per
> request will hurt overall throughput.  Does this mean that handling
> write-completion in a CM-wq is a poor choice?
> Would it be better to us WQ_HIGHPRI??  Is there any rule-of-thumb that
> can be used to determine when WQ_HIGHPRI is appropriate?

I don't think it'd need HIGHPRI but UNBOUND or CPU_INTENSIVE would make
sense. I think the rule of the thumb is along the line of if you're worried
about cpu consumption or latency, let the scheduler take care of it (ie. use
unbound workqueues).

Thanks.

-- 
tejun

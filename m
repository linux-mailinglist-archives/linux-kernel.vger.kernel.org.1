Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BD1277787
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIXRNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727136AbgIXRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600967629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12L9VeJpf7N5GiUvawNcQLZPZYtJc7Q5WG3UX7MsT7M=;
        b=Piprq4iMeCw8lXRzPa53y2uk3V804qOiT4LMCqhecIVUjfHn3OHUWS8bI2i3Of4DHF5VbZ
        rOVNoB72xxaumjvwDCH6nvt3ay6R6IplVXOFcegzRL68o0EKjAvsNcoxgujpVJjZKZrrxE
        aWO+tFy8sBtmyGvUibQDykgJ0smhrow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Lt4dIp6PPcSxxn3JMnPMuA-1; Thu, 24 Sep 2020 13:13:48 -0400
X-MC-Unique: Lt4dIp6PPcSxxn3JMnPMuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C798618C89C4;
        Thu, 24 Sep 2020 17:13:45 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-112-166.phx2.redhat.com [10.3.112.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42A7978828;
        Thu, 24 Sep 2020 17:13:41 +0000 (UTC)
Date:   Thu, 24 Sep 2020 13:13:39 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
Message-ID: <20200924171339.GD29958@lorien.usersys.redhat.com>
References: <20200916043103.606132-1-aubrey.li@linux.intel.com>
 <20200916110039.GG3117@suse.de>
 <78d608f2-b974-e940-da32-b37777bc405a@linux.intel.com>
 <CAKfTPtAVkg081VEGp3Hx3i7D+jxRJcyBi2=NJypvHH6HVJ8Nwg@mail.gmail.com>
 <CAKfTPtA2yE_sFfP5MFN=K+ph7rqpYUhapUdDBJ5hFLxnQPktJw@mail.gmail.com>
 <af0237e0-1451-9d11-2ee2-1468a8bb6180@linux.intel.com>
 <CAKfTPtD71z-n2dVTpZk5tLwy5OZjkju9v5vJ-3QNHhw8Grhc_Q@mail.gmail.com>
 <40ee756f-1f27-b17e-6292-d8069a56e3c8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ee756f-1f27-b17e-6292-d8069a56e3c8@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:37:33AM -0700 Tim Chen wrote:
> 
> 
> On 9/22/20 12:14 AM, Vincent Guittot wrote:
> 
> >>
> >>>>
> >>>> And a quick test with hackbench on my octo cores arm64 gives for 12
> 
> Vincent,
> 
> Is it octo (=10) or octa (=8) cores on a single socket for your system?

In what Romance language does octo mean 10?  :)


> The L2 is per core or there are multiple L2s shared among groups of cores?
> 
> Wonder if placing the threads within a L2 or not within
> an L2 could cause differences seen with Aubrey's test.
> 
> Tim
> 

-- 


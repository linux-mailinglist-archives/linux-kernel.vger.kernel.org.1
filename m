Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0924A2D1210
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgLGNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbgLGNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607347731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HmPG+N5jTzzRdIL5s1TNf9yxVHZKpWeydP8k3ZEKz4U=;
        b=cRkh5x94hpySf7qp4sQp9P5qw4WwYFmWCOi/W8lVSsdjDRQ77U0AIj/w2p+upOlBnFycoC
        1cGKqJVW86Ml4Yv3pHezaNyXajnvZxJd32gcDb6bKCZMwSXx+eCoZXc1OR+RMQg7bqUGiB
        Shhhrv/roL8U4ss/cRwmwmECPDXUflI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-QPyZHp8YPHuq4piMgHAKvg-1; Mon, 07 Dec 2020 08:28:47 -0500
X-MC-Unique: QPyZHp8YPHuq4piMgHAKvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 929421934100;
        Mon,  7 Dec 2020 13:28:45 +0000 (UTC)
Received: from krava (unknown [10.40.195.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D23D10016FB;
        Mon,  7 Dec 2020 13:28:41 +0000 (UTC)
Date:   Mon, 7 Dec 2020 14:28:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        Will Deacon <will@kernel.org>,
        Chanho Park <parkch98@gmail.com>, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] perf arm pmu: fix build error on MUSL libc
Message-ID: <20201207132840.GA4070632@krava>
References: <20201206144527.1670483-1-chanho61.park@samsung.com>
 <CGME20201207105410epcas2p3f9210689886172422d27870f25a79df3@epcas2p3.samsung.com>
 <20201207105359.GA4198@willie-the-truck>
 <001101d6cc90$3b491310$b1db3930$@samsung.com>
 <CAM9d7chU0SP79cjuZOBg1Rhe2NYaxAOnKzdQ+XQ65fenTzak0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chU0SP79cjuZOBg1Rhe2NYaxAOnKzdQ+XQ65fenTzak0A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:31:06PM +0900, Namhyung Kim wrote:
> Hi Chanho,
> 
> On Mon, Dec 7, 2020 at 8:58 PM Chanho Park <chanho61.park@samsung.com> wrote:
> >
> > Hi Will,
> >
> > > Looks like other files just include this unconditionally, but have a
> > > comment explaining why. See util/branch.h and util/event.h. Maybe we
> > > should do the same for util/pmu.h, which is already included here?
> >
> > I found below files which perf includes <linux/perf_event.h>. Instead of
> > doing same for all, we'd better put this only for
> > tools/include/uapi/linux/perf_event.h.
> 
> It's a copy of the kernel header, I'm not sure we want to add something there.

right, we want to copy that directly from kernel uapi
so let's not do any changes in here

jirka


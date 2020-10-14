Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E13A28DFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbgJNLQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729372AbgJNLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602674212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/KujEL9OO4RQnyINjYD02F7cN+kUA8e37LwN9pBzAAk=;
        b=Gb4QN4dWPCN9j6VTCzyqrfYisYNgrzhDJIvuqoZCkSswxL3gDAJ/FZitDjvZm0fDjBMx3W
        JwoqcKIxWaWIb7Q7VvKYXtHY43qKryPErSeTMH5fKahBi4WNmZ3cMZW24fzCm/S16nCLls
        VO7SjFZKnVXL8rkCeBFlIPzWzwUsYIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-rXS71b4FPcCjUMvl-WhNTA-1; Wed, 14 Oct 2020 07:16:48 -0400
X-MC-Unique: rXS71b4FPcCjUMvl-WhNTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F0908014D9;
        Wed, 14 Oct 2020 11:16:46 +0000 (UTC)
Received: from krava (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id A0B025D9D3;
        Wed, 14 Oct 2020 11:16:40 +0000 (UTC)
Date:   Wed, 14 Oct 2020 13:16:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     kajoljain <kjain@linux.ibm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "irogers@google.com" <irogers@google.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH RFC v4 00/13] perf pmu-events: Support event aliasing for
 system PMUs
Message-ID: <20201014111639.GA1375972@krava>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
 <1f1c4537-2224-cd83-a10a-947ef8cd2864@linux.ibm.com>
 <2ca3d31e-478f-5e0a-dd36-37e84e4abf7c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca3d31e-478f-5e0a-dd36-37e84e4abf7c@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 12:49:15PM +0100, John Garry wrote:
> On 08/10/2020 12:27, kajoljain wrote:
> > Hi John,
> >    I am looking into these patches, it seems they are not re-based on top of
> > latest Arnaldo's perf/core branch. Can you rebase these changes. I think we are missing
> > multiple updates.
> > 
> > 
> > Thanks,
> > Kajol Jain
> > 
> 
> Hi Kajol Jain,
> 
> My thought was that since the kernel part needs acceptance first [0], which
> is based on v5.9-rc7, I would just use the same baseline here.
> 
> However I suppose I should still use Arnaldo's perf/core from now on as
> baseline, so I'll look at that now.

yes please, I can't already apply 2nd patch..

	patching file pmu-events/jevents.c
	Hunk #1 succeeded at 82 with fuzz 2 (offset 29 lines).
	Hunk #2 FAILED at 335.
	Hunk #3 FAILED at 354.
	Hunk #4 succeeded at 406 (offset 22 lines).
	Hunk #5 FAILED at 439.
	Hunk #6 FAILED at 531.
	Hunk #7 FAILED at 555.
	Hunk #8 FAILED at 602.
	Hunk #9 FAILED at 698.
	Hunk #10 succeeded at 770 (offset 2 lines).
	Hunk #11 succeeded at 813 (offset 2 lines).
	Hunk #12 succeeded at 1075 (offset 2 lines).
	Hunk #13 succeeded at 1242 (offset 2 lines).
	Hunk #14 succeeded at 1273 (offset 2 lines).
	7 out of 14 hunks FAILED -- saving rejects to file pmu-events/jevents.c.rej
	can't find file to patch at input line 439
thanks,
jirka


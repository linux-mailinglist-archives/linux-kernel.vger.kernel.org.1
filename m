Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF611270356
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIRR3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgIRR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600450141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/9npi5Fcll908WPlmB0OPngkHkpNIVEY0DiOg3OylY=;
        b=H5iHbS6RPpdJ1A8UY/Zo8mEbnvBoscUSS3+VO8W8djN8eCc7NDqqrKs33x+OvnRpdwEwbB
        JELNNM1iooSw5j8+uheCh3Oqk8nBPkk0bCT8jw2ssKgUc0UGZvrCPIKmZhghEnOfCdU1+T
        VnoVNVV4h5M+zgYrcpj41U32MvtpqDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-YkdcG9ISNDKUa8I7lMjTmw-1; Fri, 18 Sep 2020 13:27:54 -0400
X-MC-Unique: YkdcG9ISNDKUa8I7lMjTmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C118064BA;
        Fri, 18 Sep 2020 17:27:51 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73C321C4;
        Fri, 18 Sep 2020 17:27:47 +0000 (UTC)
Date:   Fri, 18 Sep 2020 13:27:45 -0400
From:   Phil Auld <pauld@redhat.com>
To:     peterz@infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH 0/4] sched/fair: Improve fairness between cfs tasks
Message-ID: <20200918172745.GI55398@lorien.usersys.redhat.com>
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914114202.GQ1362448@hirez.programming.kicks-ass.net>
 <20200918163928.GG55398@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918163928.GG55398@lorien.usersys.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:39:28PM -0400 Phil Auld wrote:
> Hi Peter,
> 
> On Mon, Sep 14, 2020 at 01:42:02PM +0200 peterz@infradead.org wrote:
> > On Mon, Sep 14, 2020 at 12:03:36PM +0200, Vincent Guittot wrote:
> > > Vincent Guittot (4):
> > >   sched/fair: relax constraint on task's load during load balance
> > >   sched/fair: reduce minimal imbalance threshold
> > >   sched/fair: minimize concurrent LBs between domain level
> > >   sched/fair: reduce busy load balance interval
> > 
> > I see nothing objectionable there, a little more testing can't hurt, but
> > I'm tempted to apply them.
> > 
> > Phil, Mel, any chance you can run them through your respective setups?
> > 
> 
> Sorry for the delay. Things have been backing up...
> 
> We tested with tis series and found there was no performance change in
> our test suites. (We don't have a good way to share the actual numbers
> outside right now, but since they aren't really different it probably
> doesn't matter much here.)
> 
> The difference we did see was a slight decrease in the number of tasks
> moved around at higher loads.  That seems to be a good thing even though
> it didn't directly show time-based performance benefits (and was pretty
> minor).
> 
> So if this helps other use cases we've got no problems with it.
>

Feel free to add a

Reviewed-by: Phil Auld <pauld@redhat.com>

Jirka did the actual testing so he can speak up with a Tested-by if he
wants to.


> Thanks,
> Phil
> 
> -- 
> 

-- 


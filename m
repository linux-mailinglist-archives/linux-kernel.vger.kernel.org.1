Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D301D2C82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgENKWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 06:22:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53303 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbgENKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589451739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdmT6ANXa6NhFjFuIFGimW7zROVm3IZ6tXffgmcMrRw=;
        b=SL8beS89VTXY/2Xo7ZWoHcFNI73lURdiwbE3U76+SNedpqT4dMSCJjSPlJh+pB7rpJ8Dem
        OBaDNlqK/uTAmFUinCMSuBnPJJQFXvfYkTBAsXGhdYw1jZ97ZQsbRjVTr7Rdfv0Hk2GY3f
        Quk1fBn7l24j9PpXjpA2ALRNNnXEpWs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-M-I0_sIFPf20W1D5ymTfcw-1; Thu, 14 May 2020 06:22:17 -0400
X-MC-Unique: M-I0_sIFPf20W1D5ymTfcw-1
Received: by mail-ed1-f70.google.com with SMTP id b7so959209edf.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 03:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdmT6ANXa6NhFjFuIFGimW7zROVm3IZ6tXffgmcMrRw=;
        b=qHZ9L/tyfneXaFWC+pCeMCY92uk3bOSenw8fQN4Rik1YQHDSV2ZjnvnPKZu6RMn2g1
         YUDwxBP8DHUiG+JfawxKQA1ApKehCVnr191OJXD46RUWg6ga3IIVzeo32cKvTinHxWu8
         N4OMLXT5GIFs0K3Inl80dhthpQBwov0ke91a/YggaKeGSgAZP2hbZQHiDbfq1bv01zuq
         Cuc4Z76NY6peg3fsndPgfrA7UmyU1NuXByjrzlZACFrK6nM1egNeuW6+Vs2OqrofCE4X
         jvTQ5QVH9hzVv+rXv5Uqy9CgRdjn4FsITuLZUnCV4wK2DHTx+rMi2p3cI9eLb/L+5H16
         COoQ==
X-Gm-Message-State: AOAM532HrstG7TGleI7PWZMwjWF/8KE+nrBnxXJVClYYLOF6CEZ3TcnU
        zPXNCyV86s7IFOX5xoo99WbL8nOgOMn0g1lcorWSoB14xILbgafd8bREj4fQMfqMA7C+lRFA1UQ
        t0vaTmpnhBDyDf8hlwZi4H3eNn9TR/oZxtqLHlnFq
X-Received: by 2002:a17:906:cd08:: with SMTP id oz8mr951006ejb.90.1589451736312;
        Thu, 14 May 2020 03:22:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLm16DHWkAOyXk9ppPSD0F3lVHAw8cm/ZP5ATce5P9UjOR7zkbX73wgtYMc/2xXQCeE71RiQJSDs0cLAvzLaM=
X-Received: by 2002:a17:906:cd08:: with SMTP id oz8mr950983ejb.90.1589451736069;
 Thu, 14 May 2020 03:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net> <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net> <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net> <CAE4VaGBq5+ucS4p+0AzFsNP7YDsg7dLZ73dzuhBerHiM4EYP_Q@mail.gmail.com>
 <20200514095055.GG3758@techsingularity.net> <CAE4VaGCGUFOAZ+YHDnmeJ95o4W0j04Yb7EWnf8a43caUQs_WuQ@mail.gmail.com>
 <20200514100814.GH3758@techsingularity.net>
In-Reply-To: <20200514100814.GH3758@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 14 May 2020 12:22:05 +0200
Message-ID: <CAE4VaGBwFvduqOyn8pQnN3U4ozuB=4DVx6i1vheAg-2PegvE9Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Do you have a link? I cannot find it on github
(https://github.com/gormanm/mmtests, searched for
config-network-netperf-cstate-small-cross-socket)


On Thu, May 14, 2020 at 12:08 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, May 14, 2020 at 11:58:36AM +0200, Jirka Hladky wrote:
> > Thank you, Mel!
> >
> > We are using netperf as well, but AFAIK it's running on two different
> > hosts. I will check with colleagues, if they can
> > add network-netperf-unbound run on the localhost.
> >
> > Is this the right config?
> > https://github.com/gormanm/mmtests/blob/345f82bee77cbf09ba57f470a1cfc1ae413c97df/bin/generate-generic-configs
> > sed -e 's/NETPERF_BUFFER_SIZES=.*/NETPERF_BUFFER_SIZES=64/'
> > config-network-netperf-unbound > config-network-netperf-unbound-small
> >
>
> That's one I was using at the moment to have a quick test after
> the reconciliation series was completed. It has since changed to
> config-network-netperf-cstate-small-cross-socket to limit cstates, bind
> the client and server to two local CPUs and using one buffer size. It
> was necessary to get an ftrace function graph of the wakeup path that
> was readable and not too noisy due to migrations, cpuidle exit costs etc.
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka


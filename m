Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB522843CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgJFB0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:26:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56161 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgJFB0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:26:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id d4so1231989wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 18:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEn/BbqJAigLNYaVm32cPXAksF2y350jGRnAefzYvYw=;
        b=ixx4aFNZ/u+W1ubTDKWb+XPA3JmwhOw7uXhn4FTAJQf4i12pSXnZQ2q2VU3BQBh4xK
         Ghm3u81DEPpkuVAGI6dlbDlsICDUUdM4T78i+T6oOt2jNJDTLPNgeC2wfg3tkTXrTfSv
         GI5ul94epHfaumNeIeNuNg/OoqsLcXdCG8oeYTULfPa0xZTTx0Dkdx8vPaLXYKDjHg69
         KOh7zhn8jG6wcHrvcudbdmqgrIxKl+DKp1TaNNawpaUz1+W/uQTuWMEce2R1Nhc3P24L
         gQ/lCK/I7DMhhbmr/DtLpw4lz56XJIPDdqAkP4UPDCPI0/kHtrCuVdiQaGQvn+ojOWSr
         rycg==
X-Gm-Message-State: AOAM53369V2BQITooI8GAQK631ZIIZ2k8WmfJpenW3eBpYA3kqoqCwUv
        lybxENQNMmdX1JRHTiAhzn18EnzAE3nM+cKNYVY=
X-Google-Smtp-Source: ABdhPJys8HtHkRd8V9HZanOZHi9HGd+Q2qX3W2YHI2RwrqhPevQfc79aKyKjqKFJNKMJJcNZfVJ8eL2W7S7i8rtlnkI=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr1997325wmb.70.1601947568715;
 Mon, 05 Oct 2020 18:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201001115729.27116-1-song.bao.hua@hisilicon.com>
 <20201001230653.GM50079@tassilo.jf.intel.com> <dc9c24dcc58d477fa7e9c1a2ea246791@hisilicon.com>
In-Reply-To: <dc9c24dcc58d477fa7e9c1a2ea246791@hisilicon.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Oct 2020 10:25:57 +0900
Message-ID: <CAM9d7cjM262j4ixjayz+M1BqYDuiqRmrd9ifx++XBxT830ymRQ@mail.gmail.com>
Subject: Re: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 2, 2020 at 12:02 PM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Andi Kleen [mailto:ak@linux.intel.com]
> > Sent: Friday, October 2, 2020 12:07 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Peter
> > Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Arnaldo
> > Carvalho de Melo <acme@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@redhat.com>;
> > Namhyung Kim <namhyung@kernel.org>; Adrian Hunter
> > <adrian.hunter@intel.com>; Alexey Budankov
> > <alexey.budankov@linux.intel.com>
> > Subject: Re: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
> >
> > On Fri, Oct 02, 2020 at 12:57:29AM +1300, Barry Song wrote:
> > > Commit 7736627b865d ("perf stat: Use affinity for closing file
> > > descriptors") will use FD(evsel, cpu, thread) to read and write file
> > > descriptors xyarray. For a kernel PMU event, this leads to serious
> > > memory corruption and perf crash.
> > > I have seen evlist->core.cpus->nr is 1 while evsel has cpus->nr with
> > > the total number of CPUs. so xyarray which is allocated by
> > > evlist->core.cpus->nr will get overflow. This leads to various
> > > segmentation faults in perf tool for kernel PMU events, eg:
> > > ./perf stat -e bus_cycles  sleep 1
> > > *** Error in `./perf': free(): invalid next size (fast):
> > > 0x00000000401e6370 *** Aborted (core dumped)
> >
> > Thanks.
> >
> > I believe there is already a patch queued for this.
>
> Andi, thanks! Could you share the link or the commit ID? I'd like to take a look at the fix.
> I could still reproduce this issue in the latest linus' tree and I didn't find any commit
> related to this issue in linux-next and tip/perf/core.

I think Andi was referring to this discussion which is not merged yet:

https://lore.kernel.org/lkml/20200922031346.15051-2-liwei391@huawei.com/

I suggested a patch at the end.  Can you please try it?

Thanks
Namhyung

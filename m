Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E962F84C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbhAOSxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732973AbhAOSxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:53:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 463E22336F;
        Fri, 15 Jan 2021 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610736759;
        bh=bNmv8opxj2w/GfQ5B9uYIonThSq0yWk3kvyk1ZXkNco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQQy0mlwz+oaHkciQTio675hNV5pGBIfm6re8J0ESlzhcbAmg4GMw8wCrV+fsEfPW
         8+srQf9pyVjqrJuerimMWLwRt5dA/igrtifyb3cBs7w1WrAsi75tWGDnXENRUuBXsx
         73/AfyAnWmNfwAjGYag8HiZfHnw0TapDpM2P45MD9kTLVK0lEOihdhMhm4Z6UBWtOX
         n6xDIdx+WiZOOZrrgACI4HwkTcM4Vpu4mZzB0d14IxZeOOz11W/lGvbt0NOubhpcl8
         JI2v4+zy+viF2KEW9SQx/R4C0hqi4fsmtX3fE2kThgplChsZLAwKdc2HJHeBIU6l50
         6mk/kpmJ+UBTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6388E40522; Fri, 15 Jan 2021 15:53:11 -0300 (-03)
Date:   Fri, 15 Jan 2021 15:53:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF programs
Message-ID: <20210115185311.GB457607@kernel.org>
References: <20201229214214.3413833-1-songliubraving@fb.com>
 <20201229214214.3413833-4-songliubraving@fb.com>
 <CAM9d7chV0UEPaWFcPJppy++2dO6t16p+S7ah01+0r7r57dyTvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chV0UEPaWFcPJppy++2dO6t16p+S7ah01+0r7r57dyTvQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 12, 2021 at 04:35:14PM +0900, Namhyung Kim escreveu:
> Hi,
> 
> On Wed, Dec 30, 2020 at 6:42 AM Song Liu <songliubraving@fb.com> wrote:
> >
> > Introduce perf-stat -b option, which counts events for BPF programs, like:
> >
> > [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
> >      1.487903822            115,200      ref-cycles
> >      1.487903822             86,012      cycles
> >      2.489147029             80,560      ref-cycles
> >      2.489147029             73,784      cycles
> >      3.490341825             60,720      ref-cycles
> >      3.490341825             37,797      cycles
> >      4.491540887             37,120      ref-cycles
> >      4.491540887             31,963      cycles
> >
> > The example above counts cycles and ref-cycles of BPF program of id 254.
> > This is similar to bpftool-prog-profile command, but more flexible.
> >
> > perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> > programs (monitor-progs) to the target BPF program (target-prog). The
> > monitor-progs read perf_event before and after the target-prog, and
> > aggregate the difference in a BPF map. Then the user space reads data
> > from these maps.
> >
> > A new struct bpf_counter is introduced to provide common interface that
> > uses BPF programs/maps to count perf events.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied locally, testing now.

- Arnaldo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DF2D28CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgLHK03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728469AbgLHK03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607423102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QSUgtdQ8lYRnilvpEn/TCJNcxm35wEax0rs6wowzfsQ=;
        b=LjJ9PGInUGNbxPrjePNdfL6RODchigccowN3m3ugUFm07/iIHMIrVWblnt9GKC8bFM9LRn
        2/7igR6iQUPcjc+YfuZC4FoDHqpq49frxeZt3euiY2HyIIp83YdnBnKJC4K2zG55hnTSPf
        pXYhrBSFAxPuStqMOVdjMJJGi/IHXls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-VsnSABsiPH-Mfvx5zLxH2w-1; Tue, 08 Dec 2020 05:24:58 -0500
X-MC-Unique: VsnSABsiPH-Mfvx5zLxH2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54AA2809DC9;
        Tue,  8 Dec 2020 10:24:57 +0000 (UTC)
Received: from krava (unknown [10.40.193.58])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE7FE5D6AB;
        Tue,  8 Dec 2020 10:24:54 +0000 (UTC)
Date:   Tue, 8 Dec 2020 11:24:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201208102453.GA4135722@krava>
References: <20201204061310.3196812-1-songliubraving@fb.com>
 <20201204061310.3196812-3-songliubraving@fb.com>
 <20201207220703.GA4116109@krava>
 <C94864E9-CE05-4AEA-A986-731BFC0C95FF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C94864E9-CE05-4AEA-A986-731BFC0C95FF@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 01:36:57AM +0000, Song Liu wrote:

SNIP

> > 
> > I'm still getting
> > 
> > [root@dell-r440-01 perf]# ./perf stat -b 38
> > libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > libbpf: XXX is not found in vmlinux BTF
> > libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > ...
> > 
> > with id 38 being:
> > 
> > 38: tracepoint  name sys_enter  tag 03418b72a610af75  gpl
> >        loaded_at 2020-12-07T22:54:05+0100  uid 0
> >        xlated 272B  jited 153B  memlock 4096B  map_ids 1
> > 
> > how is this supposed to work when there's XXX in the
> > program's section? libbpf is trying to find XXX in
> > kernel BTF and fails of course
> 
> I think this is because this program doesn't have BTF. The actual failed
> function was bpf_program__set_attach_target(). So the error message above
> should be "Failed to _open_ bpf skeleton". I will fix the error messages. 

ah right, it's bpftrace program, so there's no BTF loaded for the program
I'll check if there's a way to add it, it'd be shame not to have this
feature for bpftrace programs

there's no way around it, right? we need btf id of the program to attach
fentry/fexit to it

I think we need to fail the function if there's error detected,
and also check on the prog_name and fail if it's not found

plus change all those pr_debug to pr_err in bpf_program_profiler_load_one

jirka


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F162C457F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgKYQmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730519AbgKYQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606322565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sBN448M4om5RZkVXUtIgjbFquI9hquo/OzA8jpagZyk=;
        b=FSm47KVQxiNSA/fGoEvf+kTSu/4riTz+lvS2w3jKIko2wLVqhfarVNwNYjzXpskR/x1JHA
        DKEVA9zeh1tcPOD55E4M2xUW2TCVIdezabW+2+YodWKIKrLqhe+/zR+2RXKeUjXb41t1hP
        XWN4cPP40RAXzhk/8bKmV/VWxXWmioI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-rgalVuLNOEaxZOMTFUTCRA-1; Wed, 25 Nov 2020 11:42:40 -0500
X-MC-Unique: rgalVuLNOEaxZOMTFUTCRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EB3880F050;
        Wed, 25 Nov 2020 16:42:39 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1A1FF5D6AC;
        Wed, 25 Nov 2020 16:42:36 +0000 (UTC)
Date:   Wed, 25 Nov 2020 17:42:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201125164236.GM2164284@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-3-songliubraving@fb.com>
 <20201123234735.GB2088148@krava>
 <86F842B0-BF89-4418-BA2E-F93E50726A81@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86F842B0-BF89-4418-BA2E-F93E50726A81@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:31:49PM +0000, Song Liu wrote:
> 
> 
> > On Nov 23, 2020, at 3:47 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> 
> [...]
> 
> > 
> > I still need to review this deeply, but so far I'm getting this error:
> > 
> > 	# ./perf stat -b 40
> > 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 	libbpf: XXX is not found in vmlinux BTF
> > 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 	libbpf: XXX is not found in vmlinux BTF
> > 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 	libbpf: XXX is not found in vmlinux BTF
> > 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 	libbpf: XXX is not found in vmlinux BTF
> > 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 	libbpf: XXX is not found in vmlinux BTF
> > 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 	libbpf: XXX is not found in vmlinux BTF
> > 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 	libbpf: XXX is not found in vmlinux BTF
> > 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 	libbpf: XXX is not found in vmlinux BTF
> > 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> > 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> > 	libbpf: Can't get the 0th fd from program fentry_XXX: only -1 instances
> > 	libbpf: prog 'fentry_XXX': can't attach before loaded
> > 	libbpf: failed to auto-attach program 'fentry_XXX': -22
> 
> I cannot reproduce this. Is 40 a valid BPF program ID? Could you please share 
> more information about it with "bpftool prog show id 40"?

it was bpftrace kfunc program, I'll try again and get back with
more details if there's still the problem

jirka


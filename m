Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AD52C1996
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKWXrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:47:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbgKWXrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606175265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UL5eePgWVWq4aCLVQSZWw5OD+CaLYkQd6w8ndcxaoBQ=;
        b=OQfhMqckqD+OpdMggaWPLWw3Xtc03eSt9yemPFSRPNZiHpeKG2gLx1ubqlLZLlOdHFZ1BE
        KNEnFDyv7TqdhrxEQ4mEp0P7WUE9YokR+P7goJWdYnVCk50s1ZrOilhIUCDRggYOb6Ih44
        jBO5EkRihNjXOEpUN+oG+xZ54tpBHGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-uckOrNoQODCd5unIHOqKGA-1; Mon, 23 Nov 2020 18:47:40 -0500
X-MC-Unique: uckOrNoQODCd5unIHOqKGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0BFB1005E43;
        Mon, 23 Nov 2020 23:47:38 +0000 (UTC)
Received: from krava (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with SMTP id DCA385D719;
        Mon, 23 Nov 2020 23:47:36 +0000 (UTC)
Date:   Tue, 24 Nov 2020 00:47:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201123234735.GB2088148@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119045046.1491106-3-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:50:46PM -0800, Song Liu wrote:
> Introduce perf-stat -b option, which counts events for BPF programs, like:
> 
> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>      1.487903822            115,200      ref-cycles
>      1.487903822             86,012      cycles
>      2.489147029             80,560      ref-cycles
>      2.489147029             73,784      cycles
>      3.490341825             60,720      ref-cycles
>      3.490341825             37,797      cycles
>      4.491540887             37,120      ref-cycles
>      4.491540887             31,963      cycles
> 
> The example above counts cycles and ref-cycles of BPF program of id 254.
> This is similar to bpftool-prog-profile command, but more flexible.
> 
> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> programs (monitor-progs) to the target BPF program (target-prog). The
> monitor-progs read perf_event before and after the target-prog, and
> aggregate the difference in a BPF map. Then the user space reads data
> from these maps.
> 
> A new struct bpf_counter is introduced to provide common interface that
> uses BPF programs/maps to count perf events.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

I still need to review this deeply, but so far I'm getting this error:

	# ./perf stat -b 40
	libbpf: elf: skipping unrecognized data section(9) .eh_frame
	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
	libbpf: XXX is not found in vmlinux BTF
	libbpf: failed to load object 'bpf_prog_profiler_bpf'
	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
	libbpf: elf: skipping unrecognized data section(9) .eh_frame
	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
	libbpf: XXX is not found in vmlinux BTF
	libbpf: failed to load object 'bpf_prog_profiler_bpf'
	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
	libbpf: elf: skipping unrecognized data section(9) .eh_frame
	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
	libbpf: XXX is not found in vmlinux BTF
	libbpf: failed to load object 'bpf_prog_profiler_bpf'
	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
	libbpf: elf: skipping unrecognized data section(9) .eh_frame
	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
	libbpf: XXX is not found in vmlinux BTF
	libbpf: failed to load object 'bpf_prog_profiler_bpf'
	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
	libbpf: elf: skipping unrecognized data section(9) .eh_frame
	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
	libbpf: XXX is not found in vmlinux BTF
	libbpf: failed to load object 'bpf_prog_profiler_bpf'
	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
	libbpf: elf: skipping unrecognized data section(9) .eh_frame
	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
	libbpf: XXX is not found in vmlinux BTF
	libbpf: failed to load object 'bpf_prog_profiler_bpf'
	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
	libbpf: elf: skipping unrecognized data section(9) .eh_frame
	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
	libbpf: XXX is not found in vmlinux BTF
	libbpf: failed to load object 'bpf_prog_profiler_bpf'
	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
	libbpf: elf: skipping unrecognized data section(9) .eh_frame
	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
	libbpf: XXX is not found in vmlinux BTF
	libbpf: failed to load object 'bpf_prog_profiler_bpf'
	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
	libbpf: Can't get the 0th fd from program fentry_XXX: only -1 instances
	libbpf: prog 'fentry_XXX': can't attach before loaded
	libbpf: failed to auto-attach program 'fentry_XXX': -22

jirka


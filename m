Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E12E733B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 20:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL2TdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 14:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2TdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 14:33:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7679420825;
        Tue, 29 Dec 2020 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609270345;
        bh=c010P99dKRRu2/LZOkPB/Zqjd8wESc8MwaBhu/GkKBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhEdIL8OtoTJqv9rHKUtx3aAUS/5uDU+6My4WfY8WQyBfRpRwVgdVKbj6RNfMpwmb
         X67bm/alWL1QUOb6R67BtNLkn2ef/wiwnF+syleKchI7bxckW7PcA/d3jMung47BPT
         BX1P+reHeHgh7HE6XUsU82+93lIjakG3gysT9DqH6u8LsturT7TODZELKuqkjftTDx
         OmKoyba7PoUpxLliAa6vAvJVulImRIXvoSXLv3kljPeMTzzGIHKscbMb3A1iQIwhp9
         dtqxM9XFBvBTmqRTq6OBsJxSo4L/GjnO4KaYFC6BY38+f9UKfKReLL8fgWjLrHTth3
         zzGPpE2CJlvKw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44B17411E9; Tue, 29 Dec 2020 16:32:43 -0300 (-03)
Date:   Tue, 29 Dec 2020 16:32:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Message-ID: <20201229193243.GN521329@kernel.org>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <20201228201159.GF521329@kernel.org>
 <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
 <20201229151504.GI521329@kernel.org>
 <3E293E73-ECB7-48E0-8A6E-337988218299@fb.com>
 <20201229184829.GK521329@kernel.org>
 <9BDC4556-E802-4152-91E1-1A4696F62AAE@fb.com>
 <20201229191848.GL521329@kernel.org>
 <20201229192347.GM521329@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201229192347.GM521329@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 29, 2020 at 04:23:47PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 29, 2020 at 04:18:48PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Tue, Dec 29, 2020 at 07:11:12PM +0000, Song Liu escreveu:
> > > > On Dec 29, 2020, at 10:48 AM, Arnaldo Carvalho de Melo <acme@kernel=
=2Eorg> wrote:
> > > > I'll check this one to get a patch that at least moves the needle h=
ere,
> > > > i.e. probably we can leave supporting bpf counters in the python bi=
nding
> > > > for a later step.
>=20
> > > Thanks Arnaldo!
>=20
> > > Currently, I have:
> > > 1. Fixed issues highlighted by Namhyung;
> > > 2. Merged 3/4 and 4/4;
> > > 3. NOT found segfault;
> > > 4. NOT fixed python import perf.=20

For 3, now with a kprobe:

[root@five ~]# bpftool prog | grep hrtimer -A10
99: kprobe  name hrtimer_nanosle  tag 0e77bacaf4555f83  gpl
	loaded_at 2020-12-29T16:25:34-0300  uid 0
	xlated 80B  jited 49B  memlock 4096B
	btf_id 253
[root@five ~]# perf stat -I 1000 -b 99
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
Segmentation fault (core dumped)
[root@five ~]#

(gdb) run stat -I 1000 -b 99
Starting program: /root/bin/perf stat -I 1000 -b 99
Missing separate debuginfos, use: dnf debuginfo-install glibc-2.32-2.fc33.x=
86_64
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me

Program received signal SIGSEGV, Segmentation fault.
0x000000000056559b in bpf_program_profiler__read (evsel=3D0xc39770) at util=
/bpf_counter.c:217
217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-4.=
fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod-client-=
0.182-1.fc33.x86_64 elfutils-libelf-0.182-1.fc33.x86_64 elfutils-libs-0.182=
-1.fc33.x86_64 keyutils-libs-1.6-5.fc33.x86_64 krb5-libs-1.18.2-29.fc33.x86=
_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_64 libcap-=
2.26-8.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libcurl-7.71.1-8.fc33.x8=
6_64 libgcc-10.2.1-9.fc33.x86_64 libidn2-2.3.0-4.fc33.x86_64 libnghttp2-1.4=
1.0-3.fc33.x86_64 libpsl-0.21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86_64 =
libssh-0.9.5-1.fc33.x86_64 libunistring-0.9.10-9.fc33.x86_64 libunwind-1.4.=
0-4.fc33.x86_64 libuuid-2.36-3.fc33.x86_64 libxcrypt-4.4.17-1.fc33.x86_64 l=
ibzstd-1.4.5-5.fc33.x86_64 numactl-libs-2.0.14-1.fc33.x86_64 openldap-2.4.5=
0-5.fc33.x86_64 openssl-libs-1.1.1i-1.fc33.x86_64 pcre-8.44-2.fc33.x86_64 p=
cre2-10.36-1.fc33.x86_64 perl-libs-5.32.0-464.fc33.x86_64 popt-1.18-2.fc33.=
x86_64 python3-libs-3.9.1-1.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 xz-libs-5=
=2E2.5-3.fc33.x86_64
(gdb) bt
#0  0x000000000056559b in bpf_program_profiler__read (evsel=3D0xc39770) at =
util/bpf_counter.c:217
#1  0x0000000000000000 in ?? ()
(gdb) p skel->maps.accum_readings
Cannot access memory at address 0x20
(gdb) p skel
$1 =3D (struct bpf_prog_profiler_bpf *) 0x0
(gdb) list -10
202		int reading_map_fd;
203		__u32 key =3D 0;
204		int err, cpu;
205
206		if (list_empty(&evsel->bpf_counter_list))
207			return -EAGAIN;
208
209		for (cpu =3D 0; cpu < num_cpu; cpu++) {
210			perf_counts(evsel->counts, cpu, 0)->val =3D 0;
211			perf_counts(evsel->counts, cpu, 0)->ena =3D 0;
(gdb)
212			perf_counts(evsel->counts, cpu, 0)->run =3D 0;
213		}
214		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
215			struct bpf_prog_profiler_bpf *skel =3D counter->skel;
216
217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
218
219			err =3D bpf_map_lookup_elem(reading_map_fd, &key, values);
220			if (err) {
221				fprintf(stderr, "failed to read value\n");
(gdb) p counter->skel
$2 =3D (void *) 0x0
(gdb) p perf_evsel__name(counter)
No symbol "perf_evsel__name" in current context.
(gdb) p evsel__name(counter)
$3 =3D 0xc77420 "unknown attr type: 13078424"
(gdb) p evsel->type
There is no member named type.
(gdb) p evsel->core.
attr         cpus         fd           id           ids          node      =
   nr_members   own_cpus     sample_id    system_wide  threads
(gdb) p evsel->core.attr.type
$4 =3D 1
(gdb) p evsel->core.attr.config
$5 =3D 0
(gdb) p evsel->evlist
$6 =3D (struct evlist *) 0xc3cfd0
(gdb) p evsel->evlist->core.nr_entries
$7 =3D 10
(gdb)


10 entries, the default for 'perf stat'


With just one event:

(gdb) run stat -e cycles -I 1000 -b 99
Starting program: /root/bin/perf stat -e cycles -I 1000 -b 99
Missing separate debuginfos, use: dnf debuginfo-install glibc-2.32-2.fc33.x=
86_64
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me

Program received signal SIGSEGV, Segmentation fault.
0x000000000056559b in bpf_program_profiler__read (evsel=3D0xc392c0) at util=
/bpf_counter.c:217
217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-4.=
fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod-client-=
0.182-1.fc33.x86_64 elfutils-libelf-0.182-1.fc33.x86_64 elfutils-libs-0.182=
-1.fc33.x86_64 keyutils-libs-1.6-5.fc33.x86_64 krb5-libs-1.18.2-29.fc33.x86=
_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_64 libcap-=
2.26-8.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libcurl-7.71.1-8.fc33.x8=
6_64 libgcc-10.2.1-9.fc33.x86_64 libidn2-2.3.0-4.fc33.x86_64 libnghttp2-1.4=
1.0-3.fc33.x86_64 libpsl-0.21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86_64 =
libssh-0.9.5-1.fc33.x86_64 libunistring-0.9.10-9.fc33.x86_64 libunwind-1.4.=
0-4.fc33.x86_64 libuuid-2.36-3.fc33.x86_64 libxcrypt-4.4.17-1.fc33.x86_64 l=
ibzstd-1.4.5-5.fc33.x86_64 numactl-libs-2.0.14-1.fc33.x86_64 openldap-2.4.5=
0-5.fc33.x86_64 openssl-libs-1.1.1i-1.fc33.x86_64 pcre-8.44-2.fc33.x86_64 p=
cre2-10.36-1.fc33.x86_64 perl-libs-5.32.0-464.fc33.x86_64 popt-1.18-2.fc33.=
x86_64 python3-libs-3.9.1-1.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 xz-libs-5=
=2E2.5-3.fc33.x86_64
(gdb) bt
#0  0x000000000056559b in bpf_program_profiler__read (evsel=3D0xc392c0) at =
util/bpf_counter.c:217
#1  0x0000000000000000 in ?? ()
(gdb) p evsel->name
$1 =3D 0xc37960 "cycles"
(gdb) p evsel->bpf_counter_
bpf_counter_list  bpf_counter_ops
(gdb) p evsel->bpf_counter_ops
$2 =3D (struct bpf_counter_ops *) 0xa08ec0 <bpf_program_profiler_ops>
(gdb) p evsel->bpf_counter_
bpf_counter_list  bpf_counter_ops
(gdb) p evsel->bpf_counter_list
$3 =3D {next =3D 0xc36e18, prev =3D 0xc36e18}
(gdb) p evsel->s
sample_size        side_band          stats              supported         =
 synth_sample_type
(gdb) list -5
207			return -EAGAIN;
208
209		for (cpu =3D 0; cpu < num_cpu; cpu++) {
210			perf_counts(evsel->counts, cpu, 0)->val =3D 0;
211			perf_counts(evsel->counts, cpu, 0)->ena =3D 0;
212			perf_counts(evsel->counts, cpu, 0)->run =3D 0;
213		}
214		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
215			struct bpf_prog_profiler_bpf *skel =3D counter->skel;
216
(gdb)
217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
218
219			err =3D bpf_map_lookup_elem(reading_map_fd, &key, values);
220			if (err) {
221				fprintf(stderr, "failed to read value\n");
222				return err;
223			}
224
225			for (cpu =3D 0; cpu < num_cpu; cpu++) {
226				perf_counts(evsel->counts, cpu, 0)->val +=3D values[cpu].counter;
(gdb) p counter->skel
$4 =3D (void *) 0x0
(gdb)

skel is NULL?!

I ran out of time, have to go errands now. will bbl.

- Arnaldo
=20
> > > I don't have good ideas with 3 and 4... Shall I send current code as =
v7?
>=20
> > For 4, please fold the patch below into the relevant patch, we don't
> > need bpf_counter.h included in util/evsel.h, you even added a forward
> > declaration for that 'struct bpf_counter_ops'.
> =20
> > And in general we should refrain from adding extra includes to header
> > files, .h-ell is not good.
> >=20
> > Then we provide a stub for that bpf_counter__destroy() so that
> > util/evsel.o when linked into the perf python biding find it there,
> > links ok.
>=20
> Ok, one more stub is needed, I wasn't building all the time with=20
>=20
>   $ make BUILD_BPF_SKEL=3D1
>=20
> Ditch the previous patch please, use the one below instead:
>=20
> - Arnaldo
>=20
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 40e3946cd7518113..8226b1fefa8cf2a3 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -10,7 +10,6 @@
>  #include <internal/evsel.h>
>  #include <perf/evsel.h>
>  #include "symbol_conf.h"
> -#include "bpf_counter.h"
>  #include <internal/cpumap.h>
> =20
>  struct bpf_object;
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cc5ade85a33fc999..278abecb5bdfc0d2 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -79,6 +79,27 @@ int metricgroup__copy_metric_events(struct evlist *evl=
ist, struct cgroup *cgrp,
>  	return 0;
>  }
> =20
> +/*
> + * XXX: All these evsel destructors need some better mechanism, like a l=
inked
> + * list of destructors registered when the relevant code indeed is used =
instead
> + * of having more and more calls in perf_evsel__delete(). -- acme
> + *
> + * For now, add some more:
> + *
> + * Not to drag the BPF bandwagon...
> + */
> +void bpf_counter__destroy(struct evsel *evsel);
> +int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
> +
> +void bpf_counter__destroy(struct evsel *evsel __maybe_unused)
> +{
> +}
> +
> +int bpf_counter__install_pe(struct evsel *evsel __maybe_unused, int cpu =
__maybe_unused, int fd __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  /*
>   * Support debug printing even though util/debug.c is not linked.  That =
means
>   * implementing 'verbose' and 'eprintf'.

--=20

- Arnaldo

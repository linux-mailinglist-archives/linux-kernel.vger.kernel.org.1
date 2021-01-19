Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294332FBAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390586AbhASPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404703AbhASOnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:43:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4DE6208E4;
        Tue, 19 Jan 2021 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611067374;
        bh=srkjutQOp0Nz78YjpuXe5nSxBl9hz3J3Sb3YlG3GWIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmqfQT+QnqRYGUcZ8Q9ZyuytCCGC6ajd1FktORK1pg0SOnsCRx8NtAv4wAn84d9pu
         v/0Wllndhwwwr4N7PQEXt9kfSfpy3/n2bG5o0j1Gp5OaHU6LWQFpMOVJ44oldOaQTh
         jb35xe1nZdNTSJjjNEYRrO9BFybuLPMR5p+ziVknzrXIX6lvwV6aCA/IXUS+L7m9Vq
         cnypTTPBDb49kyccS+UoT2A0WZmLURuW3NiI826GKoBAU5ozIu7JnPv6SmvLGjo6Ti
         /5KGgNH4tZpkxBUmzkV14HFmqFV2xVSgQgAQV6edGmjfviN6sOamYeBUo4tSvwJcXu
         VYWLMq5jT6vCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B31BE40CE2; Tue, 19 Jan 2021 11:42:49 -0300 (-03)
Date:   Tue, 19 Jan 2021 11:42:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF programs
Message-ID: <20210119144249.GK12699@kernel.org>
References: <20201229214214.3413833-1-songliubraving@fb.com>
 <20201229214214.3413833-4-songliubraving@fb.com>
 <20210118193817.GG12699@kernel.org>
 <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
 <20210119143143.GJ12699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210119143143.GJ12699@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 19, 2021 at 11:31:44AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 19, 2021 at 12:48:19AM +0000, Song Liu escreveu:
> > > On Jan 18, 2021, at 11:38 AM, Arnaldo Carvalho de Melo <acme@kernel.o=
rg> wrote:
> > We are looking at two issues:
> > 1. Cannot recursively attach;
> > 2. prog FD 3 doesn't have valid btf.=20
 =20
> > #1 was caused by the verifier disallowing attaching fentry/fexit progra=
m=20
> > to program with type BPF_PROG_TYPE_TRACING (in bpf_check_attach_target)=
=2E=20
> > This constraint was added when we only had fentry/fexit in the TRACING
> > type. We have extended the TRACING type to many other use cases, like=
=20
> > "tp_btf/", "fmod_ret" and "iter/". Therefore, it is good time to revisi=
t=20
> > this constraint. I will work on this.=20
 =20
> > For #2, we require the target program to have BTF. I guess we won't rem=
ove
> > this requirement.
 =20
> > While I work on improving #1, could you please test with some kprobe=20
> > programs? For example, we can use fileslower.py from bcc.=20
=20
> Sure, and please consider improving the error messages to state what you
> described above.

Terminal 1:

[root@five perf]# perf trace -e 5sec.c
^C
[root@five perf]# cat 5sec.c
#include <bpf.h>

#define NSEC_PER_SEC	1000000000L

int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
{
	return sec / NSEC_PER_SEC =3D=3D 5;
}

license(GPL);
[root@five perf]# perf trace -e 5sec.c/max-stack=3D16/
     0.000 sleep/3739435 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1743=
337312, rqtp: 5000000000)
                                       hrtimer_nanosleep ([kernel.kallsyms])
                                       common_nsleep ([kernel.kallsyms])
                                       __x64_sys_clock_nanosleep ([kernel.k=
allsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64_after_hwframe ([ker=
nel.kallsyms])
                                       __clock_nanosleep_2 (/usr/lib64/libc=
-2.32.so)


Terminal 2:

[root@five ~]# perf stat -e cycles -b 180 -I 1000
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
perf: util/bpf_counter.c:227: bpf_program_profiler__read: Assertion `skel !=
=3D NULL' failed.
Aborted (core dumped)
[root@five ~]# gdb perf
GNU gdb (GDB) Fedora 10.1-2.fc33
<SNIP>
Reading symbols from perf...
(gdb) run stat -e cycles -b 180 -I 1000
Starting program: /root/bin/perf stat -e cycles -b 180 -I 1000
Missing separate debuginfos, use: dnf debuginfo-install glibc-2.32-2.fc33.x=
86_64
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
perf: util/bpf_counter.c:227: bpf_program_profiler__read: Assertion `skel !=
=3D NULL' failed.

Program received signal SIGABRT, Aborted.
0x00007ffff75149d5 in raise () from /lib64/libc.so.6
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-4.=
fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod-client-=
0.182-1.fc33.x86_64 elfutils-libelf-0.182-1.fc33.x86_64 elfutils-libs-0.182=
-1.fc33.x86_64 keyutils-libs-1.6.1-1.fc33.x86_64 krb5-libs-1.18.2-29.fc33.x=
86_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_64 libca=
p-2.26-8.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libcurl-7.71.1-8.fc33.=
x86_64 libgcc-10.2.1-9.fc33.x86_64 libidn2-2.3.0-4.fc33.x86_64 libnghttp2-1=
=2E41.0-3.fc33.x86_64 libpsl-0.21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86=
_64 libssh-0.9.5-1.fc33.x86_64 libunistring-0.9.10-9.fc33.x86_64 libunwind-=
1.4.0-4.fc33.x86_64 libuuid-2.36.1-1.fc33.x86_64 libxcrypt-4.4.17-1.fc33.x8=
6_64 libzstd-1.4.7-1.fc33.x86_64 numactl-libs-2.0.14-1.fc33.x86_64 openldap=
-2.4.50-5.fc33.x86_64 openssl-libs-1.1.1i-1.fc33.x86_64 pcre-8.44-2.fc33.x8=
6_64 pcre2-10.36-1.fc33.x86_64 perl-libs-5.32.0-465.fc33.x86_64 popt-1.18-2=
=2Efc33.x86_64 python3-libs-3.9.1-1.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 x=
z-libs-5.2.5-4.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
(gdb) bt
#0  0x00007ffff75149d5 in raise () from /lib64/libc.so.6
#1  0x00007ffff74fd8a4 in abort () from /lib64/libc.so.6
#2  0x00007ffff74fd789 in __assert_fail_base.cold () from /lib64/libc.so.6
#3  0x00007ffff750d026 in __assert_fail () from /lib64/libc.so.6
#4  0x00000000005661c3 in bpf_program_profiler__read (evsel=3D0xc3a2c0) at =
util/bpf_counter.c:227
#5  0x0000000000000000 in ?? ()
(gdb)

207 static int bpf_program_profiler__read(struct evsel *evsel)
208 {
209         int num_cpu =3D evsel__nr_cpus(evsel);
210         struct bpf_perf_event_value values[num_cpu];
211         struct bpf_counter *counter;
212         int reading_map_fd;
213         __u32 key =3D 0;
214         int err, cpu;
215=20
216         if (list_empty(&evsel->bpf_counter_list))
217                 return -EAGAIN;
218=20
219         for (cpu =3D 0; cpu < num_cpu; cpu++) {
220                 perf_counts(evsel->counts, cpu, 0)->val =3D 0;
221                 perf_counts(evsel->counts, cpu, 0)->ena =3D 0;
222                 perf_counts(evsel->counts, cpu, 0)->run =3D 0;
223         }
224         list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
225                 struct bpf_prog_profiler_bpf *skel =3D counter->skel;
226=20
227                 assert(skel !=3D NULL);
228                 reading_map_fd =3D bpf_map__fd(skel->maps.accum_reading=
s);
229=20
230                 err =3D bpf_map_lookup_elem(reading_map_fd, &key, value=
s);
231                 if (err) {
232                         pr_err("failed to read value\n");
233                         return err;
234                 }
235=20
236                 for (cpu =3D 0; cpu < num_cpu; cpu++) {
237                         perf_counts(evsel->counts, cpu, 0)->val +=3D va=
lues[cpu].counter;
238                         perf_counts(evsel->counts, cpu, 0)->ena +=3D va=
lues[cpu].enabled;
239                         perf_counts(evsel->counts, cpu, 0)->run +=3D va=
lues[cpu].running;
240                 }
241         }
242         return 0;
243 }

- Arnaldo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5177B2DE20A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 12:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLRLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 06:32:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgLRLcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 06:32:35 -0500
Date:   Fri, 18 Dec 2020 08:32:09 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608291114;
        bh=vgj+lu9Xy21UHCvYQuyDBumcV+RLtxLTw1h5/m6Sl+g=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2Yw+uI8dV/gAqX0yuW7eOeaexFlXMPPN0gDrC5tAfyT8DRdVjd89/sPEr9sabCAQ
         LmXmiPaaOJGt5pSdNBqLX+XyEvX7pGqFEX9oRdww0xOIbvXK04qnNkFVz66rDgk9dW
         /ayASQEP3GSu+zDwPaxSCmHtqVqEUIAid/1je/Mj4GbhvSAwioAro/PBF1UcTAgFda
         uiEqeOCA+t4ApY3Xyuj7oFhg4DIF62MeyD5VGRkElw/Fr5Ip8f6lhEmoEiSbUrmF2O
         iny5k4WNQNt7FhvpW8nAluOsbIQJTSP6drnJpjnG4TX/dp51s9OoKHMAvgC4a2MLeo
         1tlxr+bFpN7HA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 3/4] perf tools: Update powerpc's syscall.tbl
Message-ID: <20201218113209.GD325926@kernel.org>
References: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
 <1608278364-6733-4-git-send-email-yangtiezhu@loongson.cn>
 <20201218112659.GB325926@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218112659.GB325926@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 18, 2020 at 08:26:59AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Dec 18, 2020 at 03:59:23PM +0800, Tiezhu Yang escreveu:
> > This silences the following tools/perf/ build warning:
> > Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
> 
> Hi Ravi, Naveen,
> 
> 	Can I get your Reviewed-by or Acked-by for this change and the
> other that adds s390's syscall.tbl to check_headers.sh so that we get

oops s/s390/powerpc/g :-)

> notified when the copy drifts, so that we can see if it still continues
> working and we can get new syscalls to be supported in things like 'perf
> trace'?
> 
> Thanks,
> 
> - Arnaldo
>  
> > Just make them same:
> > cp arch/powerpc/kernel/syscalls/syscall.tbl tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > 
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 25 ++++++++++++++++------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > index b168364..1275dae 100644
> > --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > @@ -9,7 +9,9 @@
> >  #
> >  0	nospu	restart_syscall			sys_restart_syscall
> >  1	nospu	exit				sys_exit
> > -2	nospu	fork				ppc_fork
> > +2	32	fork				ppc_fork			sys_fork
> > +2	64	fork				sys_fork
> > +2	spu	fork				sys_ni_syscall
> >  3	common	read				sys_read
> >  4	common	write				sys_write
> >  5	common	open				sys_open			compat_sys_open
> > @@ -158,7 +160,9 @@
> >  119	32	sigreturn			sys_sigreturn			compat_sys_sigreturn
> >  119	64	sigreturn			sys_ni_syscall
> >  119	spu	sigreturn			sys_ni_syscall
> > -120	nospu	clone				ppc_clone
> > +120	32	clone				ppc_clone			sys_clone
> > +120	64	clone				sys_clone
> > +120	spu	clone				sys_ni_syscall
> >  121	common	setdomainname			sys_setdomainname
> >  122	common	uname				sys_newuname
> >  123	common	modify_ldt			sys_ni_syscall
> > @@ -240,7 +244,9 @@
> >  186	spu	sendfile			sys_sendfile64
> >  187	common	getpmsg				sys_ni_syscall
> >  188	common 	putpmsg				sys_ni_syscall
> > -189	nospu	vfork				ppc_vfork
> > +189	32	vfork				ppc_vfork			sys_vfork
> > +189	64	vfork				sys_vfork
> > +189	spu	vfork				sys_ni_syscall
> >  190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
> >  191	common	readahead			sys_readahead			compat_sys_readahead
> >  192	32	mmap2				sys_mmap2			compat_sys_mmap2
> > @@ -316,8 +322,8 @@
> >  248	32	clock_nanosleep			sys_clock_nanosleep_time32
> >  248	64	clock_nanosleep			sys_clock_nanosleep
> >  248	spu	clock_nanosleep			sys_clock_nanosleep
> > -249	32	swapcontext			ppc_swapcontext			ppc32_swapcontext
> > -249	64	swapcontext			ppc64_swapcontext
> > +249	32	swapcontext			ppc_swapcontext			compat_sys_swapcontext
> > +249	64	swapcontext			sys_swapcontext
> >  249	spu	swapcontext			sys_ni_syscall
> >  250	common	tgkill				sys_tgkill
> >  251	32	utimes				sys_utimes_time32
> > @@ -456,7 +462,7 @@
> >  361	common	bpf				sys_bpf
> >  362	nospu	execveat			sys_execveat			compat_sys_execveat
> >  363	32	switch_endian			sys_ni_syscall
> > -363	64	switch_endian			ppc_switch_endian
> > +363	64	switch_endian			sys_switch_endian
> >  363	spu	switch_endian			sys_ni_syscall
> >  364	common	userfaultfd			sys_userfaultfd
> >  365	common	membarrier			sys_membarrier
> > @@ -516,6 +522,11 @@
> >  432	common	fsmount				sys_fsmount
> >  433	common	fspick				sys_fspick
> >  434	common	pidfd_open			sys_pidfd_open
> > -435	nospu	clone3				ppc_clone3
> > +435	32	clone3				ppc_clone3			sys_clone3
> > +435	64	clone3				sys_clone3
> > +435	spu	clone3				sys_ni_syscall
> > +436	common	close_range			sys_close_range
> >  437	common	openat2				sys_openat2
> >  438	common	pidfd_getfd			sys_pidfd_getfd
> > +439	common	faccessat2			sys_faccessat2
> > +440	common	process_madvise			sys_process_madvise
> > -- 
> > 2.1.0
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo

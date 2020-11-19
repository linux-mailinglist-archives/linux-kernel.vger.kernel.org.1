Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701792B8D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKSIZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgKSIZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:25:42 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B55C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:25:42 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r9so6973155lfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gRfv+qjvOJHgKLMXqbndpgdOXkisOpjAjb6GIzL6lo4=;
        b=oM175cHfr9p1m2fmAlfzI7fprHvK0RgT8sTorMhvpCeA9j2ZMjQtCSi/V2wTUc/GcJ
         D2wC/BYYM2DywE308neJdYve3E0926vVFusj5IFxW//1gDl5aOy/JdSMTtkdgJnen+Du
         ilKVSLELAj5etwO5rKD+BzFeWKiVUWimiwIWjQRHlNl3XWbQthEbldIBrGr/RqMYgbJ5
         gaAug9bDiCPXIRN5U4Y9/Tk6aVnYoLck2IYFSRX7PTIgOwaBGAIlToq1mrzY7F0g4L5o
         ukl8Btg4zxiXBvD8BkAgmjnpQwOLSMfF7A5+5hhS29Fu8HrNnjCeRnlSxU2gtBtIYZGy
         Eu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gRfv+qjvOJHgKLMXqbndpgdOXkisOpjAjb6GIzL6lo4=;
        b=X1Lqg3DzA1ZaMN3x/wDqQ24CqG3ZDyWlkEV/1wFUyRC5iopAiSWl7v0pDKhiccOaui
         Wqov8UcfGc5ybHFEu7Fi4cfY8g57BKQ4R4d/Lp1+Y2ElXMJx1O1nUsLvhSYF3zVokBil
         dnxEaHXRgxrba6xL1Ra6JoRKY1rLnAVPJclSZVSq9y4J3sVaw79GGFNJnJ237eXpDOC2
         Kx9Pns7/u4FNypid4n3DPcVPgMk/FRjsRRgOYOu2mhX/Mx6PX/ilWVFMC4IJMXoj62Ue
         vYGEPUIaKCbuox0yQh7L2hviYfn92Dc6ZLBOD8KFRkj4GGuzqvgQJ47LQsfbNF7Wtw5E
         6rDA==
X-Gm-Message-State: AOAM533ewW1ENbEFf7uAkxiDkw4grLuMoL2a0uICC4SOhk1aaR2EtEta
        C0XMD74KzOD7IygpjiYTccWYooPhMaumSW+SqKY=
X-Google-Smtp-Source: ABdhPJyg75M+nm4TXWWQqk6K6Wbou5tG96C1LYatdjBhE20d91+DwChjV2zryF59eu63fnaX9je12SkjZkqs+WI5+90=
X-Received: by 2002:a19:913:: with SMTP id 19mr5674922lfj.147.1605774340350;
 Thu, 19 Nov 2020 00:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
 <20201003085345.GA114893@kroah.com> <20201006005736.GD6041@ranerica-svr.sc.intel.com>
 <20201006073744.GA6753@kroah.com> <20201007031447.GB27938@ranerica-svr.sc.intel.com>
 <20201007051546.GA47583@kroah.com> <7233394d-982b-72cd-ceb9-d81161bd826f@gmail.com>
 <X6zZaKt57Xl9NnuN@kroah.com> <d7ac96f2-10e8-209d-2903-1bbe8fc552f4@gmail.com>
 <X60TJ2u47WK3yY/y@kroah.com> <38f290d2-4c3a-d1b0-f3cc-a0897ea10abd@gmail.com>
In-Reply-To: <38f290d2-4c3a-d1b0-f3cc-a0897ea10abd@gmail.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 19 Nov 2020 16:25:27 +0800
Message-ID: <CAC2o3DLWwag6FCrVVppKF=_VRqiCcabrbXycdfsE_c9mfVQ_Vw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
To:     Brice Goglin <brice.goglin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 2:15 PM Brice Goglin <brice.goglin@gmail.com> wrote=
:
>
>
> Le 12/11/2020 =C3=A0 11:49, Greg Kroah-Hartman a =C3=A9crit :
>
> On Thu, Nov 12, 2020 at 10:10:57AM +0100, Brice Goglin wrote:
>
> Le 12/11/2020 =C3=A0 07:42, Greg Kroah-Hartman a =C3=A9crit :
>
> On Thu, Nov 12, 2020 at 07:19:48AM +0100, Brice Goglin wrote:
>
> Le 07/10/2020 =C3=A0 07:15, Greg Kroah-Hartman a =C3=A9crit :
>
> On Tue, Oct 06, 2020 at 08:14:47PM -0700, Ricardo Neri wrote:
>
> On Tue, Oct 06, 2020 at 09:37:44AM +0200, Greg Kroah-Hartman wrote:
>
> On Mon, Oct 05, 2020 at 05:57:36PM -0700, Ricardo Neri wrote:
>
> On Sat, Oct 03, 2020 at 10:53:45AM +0200, Greg Kroah-Hartman wrote:
>
> On Fri, Oct 02, 2020 at 06:17:42PM -0700, Ricardo Neri wrote:
>
> Hybrid CPU topologies combine CPUs of different microarchitectures in the
> same die. Thus, even though the instruction set is compatible among all
> CPUs, there may still be differences in features (e.g., some CPUs may
> have counters that others CPU do not). There may be applications
> interested in knowing the type of micro-architecture topology of the
> system to make decisions about process affinity.
>
> While the existing sysfs for capacity (/sys/devices/system/cpu/cpuX/
> cpu_capacity) may be used to infer the types of micro-architecture of the
> CPUs in the platform, it may not be entirely accurate. For instance, two
> subsets of CPUs with different types of micro-architecture may have the
> same capacity due to power or thermal constraints.
>
> Create the new directory /sys/devices/system/cpu/types. Under such
> directory, create individual subdirectories for each type of CPU micro-
> architecture. Each subdirectory will have cpulist and cpumap files. This
> makes it convenient for user space to read all the CPUs of the same type
> at once without having to inspect each CPU individually.
>
> Implement a generic interface using weak functions that architectures can
> override to indicate a) support for CPU types, b) the CPU type number, an=
d
> c) a string to identify the CPU vendor and type.
>
> For example, an x86 system with one Intel Core and four Intel Atom CPUs
> would look like this (other architectures have the hooks to use whatever
> directory naming convention below "types" that meets their needs):
>
> user@host:~$: ls /sys/devices/system/cpu/types
> intel_atom_0  intel_core_0
>
> user@host:~$ ls /sys/devices/system/cpu/types/intel_atom_0
> cpulist cpumap
>
> user@host:~$ ls /sys/devices/system/cpu/types/intel_core_0
> cpulist cpumap
>
> user@host:~$ cat /sys/devices/system/cpu/types/intel_atom_0/cpumap
> 0f
>
> user@host:~$ cat /sys/devices/system/cpu/types/intel_atom_0/cpulist
> 0-3
>
> user@ihost:~$ cat /sys/devices/system/cpu/types/intel_core_0/cpumap
> 10
>
> user@host:~$ cat /sys/devices/system/cpu/types/intel_core_0/cpulist
> 4
>
> Thank you for the quick and detailed Greg!
>
> The output of 'tree' sometimes makes it easier to see here, or:
> grep -R . *
> also works well.
>
> Indeed, this would definitely make it more readable.
>
> On non-hybrid systems, the /sys/devices/system/cpu/types directory is not
> created. Add a hook for this purpose.
>
> Why should these not show up if the system is not "hybrid"?
>
> My thinking was that on a non-hybrid system, it does not make sense to
> create this interface, as all the CPUs will be of the same type.
>
> Why not just have this an attribute type in the existing cpuX directory?
> Why do this have to be a totally separate directory and userspace has to
> figure out to look in two different spots for the same cpu to determine
> what it is?
>
> But if the type is located under cpuX, usespace would need to traverse
> all the CPUs and create its own cpu masks. Under the types directory it
> would only need to look once for each type of CPU, IMHO.
>
> What does a "mask" do?  What does userspace care about this?  You would
> have to create it by traversing the directories you are creating anyway,
> so it's not much different, right?
>
> Hello
>
> Sorry for the late reply. As the first userspace consumer of this
> interface [1], I can confirm that reading a single file to get the mask
> would be better, at least for performance reason. On large platforms, we
> already have to read thousands of sysfs files to get CPU topology and
> cache information, I'd be happy not to read one more file per cpu.
>
> Reading these sysfs files is slow, and it does not scale well when
> multiple processes read them in parallel.
>
> Really?  Where is the slowdown?  Would something like readfile() work
> better for you for that?
> https://lore.kernel.org/linux-api/20200704140250.423345-1-gregkh@linuxfou=
ndation.org/
>
> I guess readfile would improve the sequential case by avoiding syscalls
> but it would not improve the parallel case since syscalls shouldn't have
> any parallel issue?
>
> syscalls should not have parallel issues at all.
>
> We've been watching the status of readfile() since it was posted on LKML
> 6 months ago, but we were actually wondering if it would end up being
> included at some point.
>
> It needs a solid reason to be merged.  My "test" benchmarks are fun to
> run, but I have yet to find a real need for it anywhere as the
> open/read/close syscall overhead seems to be lost in the noise on any
> real application workload that I can find.
>
> If you have a real need, and it reduces overhead and cpu usage, I'm more
> than willing to update the patchset and resubmit it.
>
>
> Good, I'll give it at try.
>
>
> How does multiple processes slow anything down, there shouldn't be any
> shared locks here.
>
> When I benchmarked this in 2016, reading a single (small) sysfs file was
> 41x slower when running 64 processes simultaneously on a 64-core Knights
> Landing than reading from a single process. On a SGI Altix UV with 12x
> 8-core CPUs, reading from one process per CPU (12 total) was 60x slower
> (which could mean NUMA affinity matters), and reading from one process
> per core (96 total) was 491x slower.
>
> I will try to find some time to dig further on recent kernels with perf
> and readfile (both machines were running RHEL7).
>
> 2016 was a long time ago in kernel-land, please retest on a kernel.org
> release, not a RHEL monstrosity.
>
>
> Quick test on 5.8.14 from Debian (fairly close to mainline) on a server w=
ith 2x20 cores.
>
> I am measuring the time to do open+read+close of /sys/devices/system/cpu/=
cpu15/topology/die_id 1000 times
>
> With a single process, it takes 2ms (2us per open+read+close, looks OK).
>
> With one process per core (with careful binding, etc), it jumps from 2ms =
to 190ms (without much variation).
>
> It looks like locks in kernfs_iop_permission and kernfs_dop_revalidate ar=
e causing the issue.
>
> I am attaching the perf report callgraph output below.
>
>
>
> There are ways to avoid this
> multiple discoveries by sharing hwloc info through XML or shmem, but it
> will take years before all developers of different runtimes all
> implement this :)
>
> I don't understand, what exactly are you suggesting we do here instead?
>
> I was just saying userspace has ways to mitigate the issue but it will
> take time because many different projects are involved.
>
> I still don't understand, what issue are you referring to?
>
>
> Reading many sysfs files causing the application startup to takes many se=
conds when launching multiple process at the same time.
>
> Brice
>
>
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 7K of event 'cycles'
> # Event count (approx.): 5291578622
> #
> # Children      Self  Command        Shared Object      Symbol
> # ........  ........  .............  .................  .................=
......................
> #
>     99.91%     0.00%  fops_overhead  [kernel.kallsyms]  [k] entry_SYSCALL=
_64_after_hwframe
>             |
>             ---entry_SYSCALL_64_after_hwframe
>                do_syscall_64
>                |
>                |--98.69%--__x64_sys_openat
>                |          |
>                |           --98.67%--do_sys_openat2
>                |                     |
>                |                      --98.57%--do_filp_open
>                |                                path_openat
>                |                                |
>                |                                |--81.83%--link_path_walk=
.part.0
>                |                                |          |
>                |                                |          |--52.19%--ino=
de_permission.part.0
>                |                                |          |          |
>                |                                |          |           --=
51.86%--kernfs_iop_permission
>                |                                |          |             =
        |
>                |                                |          |             =
        |--50.92%--__mutex_lock.constprop.0
>                |                                |          |             =
        |          |
>                |                                |          |             =
        |           --49.58%--osq_lock
>                |                                |          |             =
        |
>                |                                |          |             =
         --0.59%--mutex_unlock
>                |                                |          |
>                |                                |           --29.47%--wal=
k_component
>                |                                |                     |
>                |                                |                      --=
29.10%--lookup_fast
>                |                                |                        =
        |
>                |                                |                        =
         --28.76%--kernfs_dop_revalidate
>                |                                |                        =
                   |
>                |                                |                        =
                    --28.29%--__mutex_lock.constprop.0
>                |                                |                        =
                              |
>                |                                |                        =
                               --27.65%--osq_lock
>                |                                |
>                |                                |--9.60%--lookup_fast
>                |                                |          |
>                |                                |           --9.50%--kern=
fs_dop_revalidate
>                |                                |                     |
>                |                                |                      --=
9.35%--__mutex_lock.constprop.0
>                |                                |                        =
        |
>                |                                |                        =
         --9.18%--osq_lock
>                |                                |
>                |                                |--6.17%--may_open
>                |                                |          |
>                |                                |           --6.13%--inod=
e_permission.part.0
>                |                                |                     |
>                |                                |                      --=
6.10%--kernfs_iop_permission
>                |                                |                        =
        |
>                |                                |                        =
         --5.90%--__mutex_lock.constprop.0
>                |                                |                        =
                   |
>                |                                |                        =
                    --5.80%--osq_lock
>                |                                |
>                |                                 --0.52%--do_dentry_open
>                |
>                 --0.63%--__prepare_exit_to_usermode
>                           |
>                            --0.58%--task_work_run
>
>     99.91%     0.01%  fops_overhead  [kernel.kallsyms]  [k] do_syscall_64
>             |
>              --99.89%--do_syscall_64
>                        |
>                        |--98.69%--__x64_sys_openat
>                        |          |
>                        |           --98.67%--do_sys_openat2
>                        |                     |
>                        |                      --98.57%--do_filp_open
>                        |                                path_openat
>                        |                                |
>                        |                                |--81.83%--link_p=
ath_walk.part.0
>                        |                                |          |
>                        |                                |          |--52.=
19%--inode_permission.part.0
>                        |                                |          |     =
     |
>                        |                                |          |     =
      --51.86%--kernfs_iop_permission
>                        |                                |          |     =
                |
>                        |                                |          |     =
                |--50.92%--__mutex_lock.constprop.0
>                        |                                |          |     =
                |          |
>                        |                                |          |     =
                |           --49.58%--osq_lock
>                        |                                |          |     =
                |
>                        |                                |          |     =
                 --0.59%--mutex_unlock
>                        |                                |          |
>                        |                                |           --29.=
47%--walk_component
>                        |                                |                =
     |
>                        |                                |                =
      --29.10%--lookup_fast
>                        |                                |                =
                |
>                        |                                |                =
                 --28.76%--kernfs_dop_revalidate
>                        |                                |                =
                           |
>                        |                                |                =
                            --28.29%--__mutex_lock.constprop.0
>                        |                                |                =
                                      |
>                        |                                |                =
                                       --27.65%--osq_lock
>                        |                                |
>                        |                                |--9.60%--lookup_=
fast
>                        |                                |          |
>                        |                                |           --9.5=
0%--kernfs_dop_revalidate
>                        |                                |                =
     |
>                        |                                |                =
      --9.35%--__mutex_lock.constprop.0
>                        |                                |                =
                |
>                        |                                |                =
                 --9.18%--osq_lock
>                        |                                |
>                        |                                |--6.17%--may_ope=
n
>                        |                                |          |
>                        |                                |           --6.1=
3%--inode_permission.part.0
>                        |                                |                =
     |
>                        |                                |                =
      --6.10%--kernfs_iop_permission
>                        |                                |                =
                |
>                        |                                |                =
                 --5.90%--__mutex_lock.constprop.0
>                        |                                |                =
                           |
>                        |                                |                =
                            --5.80%--osq_lock
>                        |                                |
>                        |                                 --0.52%--do_dent=
ry_open
>                        |
>                         --0.63%--__prepare_exit_to_usermode
>                                   |
>                                    --0.58%--task_work_run
>
>     98.72%     0.00%  fops_overhead  [unknown]          [k] 0x7379732f736=
56369
>             |
>             ---0x7379732f73656369
>                __GI___libc_open
>                |
>                 --98.70%--entry_SYSCALL_64_after_hwframe
>                           do_syscall_64
>                           |
>                            --98.66%--__x64_sys_openat
>                                      |
>                                       --98.65%--do_sys_openat2
>                                                 |
>                                                  --98.55%--do_filp_open
>                                                            path_openat
>                                                            |
>                                                            |--81.80%--lin=
k_path_walk.part.0
>                                                            |          |
>                                                            |          |--=
52.16%--inode_permission.part.0
>                                                            |          |  =
        |
>                                                            |          |  =
         --51.86%--kernfs_iop_permission
>                                                            |          |  =
                   |
>                                                            |          |  =
                   |--50.92%--__mutex_lock.constprop.0
>                                                            |          |  =
                   |          |
>                                                            |          |  =
                   |           --49.58%--osq_lock
>                                                            |          |  =
                   |
>                                                            |          |  =
                    --0.59%--mutex_unlock
>                                                            |          |
>                                                            |           --=
29.47%--walk_component
>                                                            |             =
        |
>                                                            |             =
         --29.10%--lookup_fast
>                                                            |             =
                   |
>                                                            |             =
                    --28.76%--kernfs_dop_revalidate
>                                                            |             =
                              |
>                                                            |             =
                               --28.29%--__mutex_lock.constprop.0
>                                                            |             =
                                         |
>                                                            |             =
                                          --27.65%--osq_lock
>                                                            |
>                                                            |--9.60%--look=
up_fast
>                                                            |          |
>                                                            |           --=
9.50%--kernfs_dop_revalidate
>                                                            |             =
        |
>                                                            |             =
         --9.35%--__mutex_lock.constprop.0
>                                                            |             =
                   |
>                                                            |             =
                    --9.18%--osq_lock
>                                                            |
>                                                            |--6.17%--may_=
open
>                                                            |          |
>                                                            |           --=
6.13%--inode_permission.part.0
>                                                            |             =
        |
>                                                            |             =
         --6.10%--kernfs_iop_permission
>                                                            |             =
                   |
>                                                            |             =
                    --5.90%--__mutex_lock.constprop.0
>                                                            |             =
                              |
>                                                            |             =
                               --5.80%--osq_lock
>                                                            |
>                                                             --0.52%--do_d=
entry_open
>
>     98.72%     0.00%  fops_overhead  libc-2.31.so       [.] __GI___libc_o=
pen
>             |
>             ---__GI___libc_open
>                |
>                 --98.70%--entry_SYSCALL_64_after_hwframe
>                           do_syscall_64
>                           |
>                            --98.66%--__x64_sys_openat
>                                      |
>                                       --98.65%--do_sys_openat2
>                                                 |
>                                                  --98.55%--do_filp_open
>                                                            path_openat
>                                                            |
>                                                            |--81.80%--lin=
k_path_walk.part.0
>                                                            |          |
>                                                            |          |--=
52.16%--inode_permission.part.0
>                                                            |          |  =
        |
>                                                            |          |  =
         --51.86%--kernfs_iop_permission
>                                                            |          |  =
                   |
>                                                            |          |  =
                   |--50.92%--__mutex_lock.constprop.0
>                                                            |          |  =
                   |          |
>                                                            |          |  =
                   |           --49.58%--osq_lock
>                                                            |          |  =
                   |
>                                                            |          |  =
                    --0.59%--mutex_unlock
>                                                            |          |
>                                                            |           --=
29.47%--walk_component
>                                                            |             =
        |
>                                                            |             =
         --29.10%--lookup_fast
>                                                            |             =
                   |
>                                                            |             =
                    --28.76%--kernfs_dop_revalidate
>                                                            |             =
                              |
>                                                            |             =
                               --28.29%--__mutex_lock.constprop.0
>                                                            |             =
                                         |
>                                                            |             =
                                          --27.65%--osq_lock
>                                                            |
>                                                            |--9.60%--look=
up_fast
>                                                            |          |
>                                                            |           --=
9.50%--kernfs_dop_revalidate
>                                                            |             =
        |
>                                                            |             =
         --9.35%--__mutex_lock.constprop.0
>                                                            |             =
                   |
>                                                            |             =
                    --9.18%--osq_lock
>                                                            |
>                                                            |--6.17%--may_=
open
>                                                            |          |
>                                                            |           --=
6.13%--inode_permission.part.0
>                                                            |             =
        |
>                                                            |             =
         --6.10%--kernfs_iop_permission
>                                                            |             =
                   |
>                                                            |             =
                    --5.90%--__mutex_lock.constprop.0
>                                                            |             =
                              |
>                                                            |             =
                               --5.80%--osq_lock
>                                                            |
>                                                             --0.52%--do_d=
entry_open
>
>     98.69%     0.01%  fops_overhead  [kernel.kallsyms]  [k] __x64_sys_ope=
nat
>             |
>              --98.67%--__x64_sys_openat
>                        do_sys_openat2
>                        |
>                         --98.57%--do_filp_open
>                                   path_openat
>                                   |
>                                   |--81.83%--link_path_walk.part.0
>                                   |          |
>                                   |          |--52.19%--inode_permission.=
part.0
>                                   |          |          |
>                                   |          |           --51.86%--kernfs=
_iop_permission
>                                   |          |                     |
>                                   |          |                     |--50.=
92%--__mutex_lock.constprop.0
>                                   |          |                     |     =
     |
>                                   |          |                     |     =
      --49.58%--osq_lock
>                                   |          |                     |
>                                   |          |                      --0.5=
9%--mutex_unlock
>                                   |          |
>                                   |           --29.47%--walk_component
>                                   |                     |
>                                   |                      --29.10%--lookup=
_fast
>                                   |                                |
>                                   |                                 --28.=
76%--kernfs_dop_revalidate
>                                   |                                      =
     |
>                                   |                                      =
      --28.29%--__mutex_lock.constprop.0
>                                   |                                      =
                |
>                                   |                                      =
                 --27.65%--osq_lock
>                                   |
>                                   |--9.60%--lookup_fast
>                                   |          |
>                                   |           --9.50%--kernfs_dop_revalid=
ate
>                                   |                     |
>                                   |                      --9.35%--__mutex=
_lock.constprop.0
>                                   |                                |
>                                   |                                 --9.1=
8%--osq_lock
>                                   |
>                                   |--6.17%--may_open
>                                   |          |
>                                   |           --6.13%--inode_permission.p=
art.0
>                                   |                     |
>                                   |                      --6.10%--kernfs_=
iop_permission
>                                   |                                |
>                                   |                                 --5.9=
0%--__mutex_lock.constprop.0
>                                   |                                      =
     |
>                                   |                                      =
      --5.80%--osq_lock
>                                   |
>                                    --0.52%--do_dentry_open
>
>     98.67%     0.03%  fops_overhead  [kernel.kallsyms]  [k] do_sys_openat=
2
>             |
>              --98.65%--do_sys_openat2
>                        |
>                         --98.57%--do_filp_open
>                                   path_openat
>                                   |
>                                   |--81.83%--link_path_walk.part.0
>                                   |          |
>                                   |          |--52.19%--inode_permission.=
part.0
>                                   |          |          |
>                                   |          |           --51.86%--kernfs=
_iop_permission
>                                   |          |                     |
>                                   |          |                     |--50.=
92%--__mutex_lock.constprop.0
>                                   |          |                     |     =
     |
>                                   |          |                     |     =
      --49.58%--osq_lock
>                                   |          |                     |
>                                   |          |                      --0.5=
9%--mutex_unlock
>                                   |          |
>                                   |           --29.47%--walk_component
>                                   |                     |
>                                   |                      --29.10%--lookup=
_fast
>                                   |                                |
>                                   |                                 --28.=
76%--kernfs_dop_revalidate
>                                   |                                      =
     |
>                                   |                                      =
      --28.29%--__mutex_lock.constprop.0
>                                   |                                      =
                |
>                                   |                                      =
                 --27.65%--osq_lock
>                                   |
>                                   |--9.60%--lookup_fast
>                                   |          |
>                                   |           --9.50%--kernfs_dop_revalid=
ate
>                                   |                     |
>                                   |                      --9.35%--__mutex=
_lock.constprop.0
>                                   |                                |
>                                   |                                 --9.1=
8%--osq_lock
>                                   |
>                                   |--6.17%--may_open
>                                   |          |
>                                   |           --6.13%--inode_permission.p=
art.0
>                                   |                     |
>                                   |                      --6.10%--kernfs_=
iop_permission
>                                   |                                |
>                                   |                                 --5.9=
0%--__mutex_lock.constprop.0
>                                   |                                      =
     |
>                                   |                                      =
      --5.80%--osq_lock
>                                   |
>                                    --0.52%--do_dentry_open
>
>     98.57%     0.00%  fops_overhead  [kernel.kallsyms]  [k] do_filp_open
>             |
>             ---do_filp_open
>                path_openat
>                |
>                |--81.83%--link_path_walk.part.0
>                |          |
>                |          |--52.19%--inode_permission.part.0
>                |          |          |
>                |          |           --51.86%--kernfs_iop_permission
>                |          |                     |
>                |          |                     |--50.92%--__mutex_lock.c=
onstprop.0
>                |          |                     |          |
>                |          |                     |           --49.58%--osq=
_lock
>                |          |                     |
>                |          |                      --0.59%--mutex_unlock
>                |          |
>                |           --29.47%--walk_component
>                |                     |
>                |                      --29.10%--lookup_fast
>                |                                |
>                |                                 --28.76%--kernfs_dop_rev=
alidate
>                |                                           |
>                |                                            --28.29%--__m=
utex_lock.constprop.0
>                |                                                      |
>                |                                                       --=
27.65%--osq_lock
>                |
>                |--9.60%--lookup_fast
>                |          |
>                |           --9.50%--kernfs_dop_revalidate
>                |                     |
>                |                      --9.35%--__mutex_lock.constprop.0
>                |                                |
>                |                                 --9.18%--osq_lock
>                |
>                |--6.17%--may_open
>                |          |
>                |           --6.13%--inode_permission.part.0
>                |                     |
>                |                      --6.10%--kernfs_iop_permission
>                |                                |
>                |                                 --5.90%--__mutex_lock.co=
nstprop.0
>                |                                           |
>                |                                            --5.80%--osq_=
lock
>                |
>                 --0.52%--do_dentry_open
>
>     98.57%     0.01%  fops_overhead  [kernel.kallsyms]  [k] path_openat
>             |
>              --98.56%--path_openat
>                        |
>                        |--81.83%--link_path_walk.part.0
>                        |          |
>                        |          |--52.19%--inode_permission.part.0
>                        |          |          |
>                        |          |           --51.86%--kernfs_iop_permis=
sion
>                        |          |                     |
>                        |          |                     |--50.92%--__mute=
x_lock.constprop.0
>                        |          |                     |          |
>                        |          |                     |           --49.=
58%--osq_lock
>                        |          |                     |
>                        |          |                      --0.59%--mutex_u=
nlock
>                        |          |
>                        |           --29.47%--walk_component
>                        |                     |
>                        |                      --29.10%--lookup_fast
>                        |                                |
>                        |                                 --28.76%--kernfs=
_dop_revalidate
>                        |                                           |
>                        |                                            --28.=
29%--__mutex_lock.constprop.0
>                        |                                                 =
     |
>                        |                                                 =
      --27.65%--osq_lock
>                        |
>                        |--9.60%--lookup_fast
>                        |          |
>                        |           --9.50%--kernfs_dop_revalidate
>                        |                     |
>                        |                      --9.35%--__mutex_lock.const=
prop.0
>                        |                                |
>                        |                                 --9.18%--osq_loc=
k
>                        |
>                        |--6.17%--may_open
>                        |          |
>                        |           --6.13%--inode_permission.part.0
>                        |                     |
>                        |                      --6.10%--kernfs_iop_permiss=
ion
>                        |                                |
>                        |                                 --5.90%--__mutex=
_lock.constprop.0
>                        |                                           |
>                        |                                            --5.8=
0%--osq_lock
>                        |
>                         --0.52%--do_dentry_open
>
>     94.52%     1.30%  fops_overhead  [kernel.kallsyms]  [k] __mutex_lock.=
constprop.0
>             |
>             |--93.23%--__mutex_lock.constprop.0
>             |          |
>             |          |--92.23%--osq_lock
>             |          |
>             |           --0.55%--mutex_spin_on_owner
>             |
>              --1.30%--0x7379732f73656369
>                        __GI___libc_open
>                        entry_SYSCALL_64_after_hwframe
>                        do_syscall_64
>                        __x64_sys_openat
>                        do_sys_openat2
>                        do_filp_open
>                        path_openat
>                        |
>                         --1.09%--link_path_walk.part.0
>                                   |
>                                    --0.75%--inode_permission.part.0
>                                              kernfs_iop_permission
>                                              __mutex_lock.constprop.0
>
>     92.24%    92.22%  fops_overhead  [kernel.kallsyms]  [k] osq_lock
>             |
>              --92.22%--0x7379732f73656369
>                        __GI___libc_open
>                        entry_SYSCALL_64_after_hwframe
>                        do_syscall_64
>                        __x64_sys_openat
>                        do_sys_openat2
>                        do_filp_open
>                        path_openat
>                        |
>                        |--77.21%--link_path_walk.part.0
>                        |          |
>                        |          |--49.57%--inode_permission.part.0
>                        |          |          kernfs_iop_permission
>                        |          |          __mutex_lock.constprop.0
>                        |          |          osq_lock
>                        |          |
>                        |           --27.64%--walk_component
>                        |                     lookup_fast
>                        |                     kernfs_dop_revalidate
>                        |                     __mutex_lock.constprop.0
>                        |                     osq_lock
>                        |
>                        |--9.18%--lookup_fast
>                        |          kernfs_dop_revalidate
>                        |          __mutex_lock.constprop.0
>                        |          osq_lock
>                        |
>                         --5.80%--may_open
>                                   inode_permission.part.0
>                                   kernfs_iop_permission
>                                   __mutex_lock.constprop.0
>                                   osq_lock
>
>     81.83%     0.03%  fops_overhead  [kernel.kallsyms]  [k] link_path_wal=
k.part.0
>             |
>              --81.80%--link_path_walk.part.0
>                        |
>                        |--52.19%--inode_permission.part.0
>                        |          |
>                        |           --51.86%--kernfs_iop_permission
>                        |                     |
>                        |                     |--50.92%--__mutex_lock.cons=
tprop.0
>                        |                     |          |
>                        |                     |           --49.58%--osq_lo=
ck
>                        |                     |
>                        |                      --0.59%--mutex_unlock
>                        |
>                         --29.47%--walk_component
>                                   |
>                                    --29.10%--lookup_fast
>                                              |
>                                               --28.76%--kernfs_dop_revali=
date
>                                                         |
>                                                          --28.29%--__mute=
x_lock.constprop.0
>                                                                    |
>                                                                     --27.=
65%--osq_lock
>
>     58.32%     0.24%  fops_overhead  [kernel.kallsyms]  [k] inode_permiss=
ion.part.0
>             |
>              --58.08%--inode_permission.part.0
>                        |
>                         --57.97%--kernfs_iop_permission
>                                   |
>                                   |--56.81%--__mutex_lock.constprop.0
>                                   |          |
>                                   |           --55.39%--osq_lock
>                                   |
>                                    --0.73%--mutex_unlock
>
>     57.97%     0.00%  fops_overhead  [kernel.kallsyms]  [k] kernfs_iop_pe=
rmission
>             |
>             ---kernfs_iop_permission
>                |
>                |--56.81%--__mutex_lock.constprop.0
>                |          |
>                |           --55.39%--osq_lock
>                |
>                 --0.73%--mutex_unlock
>
>     38.71%     0.03%  fops_overhead  [kernel.kallsyms]  [k] lookup_fast
>             |
>              --38.68%--lookup_fast
>                        |
>                         --38.26%--kernfs_dop_revalidate
>                                   |
>                                    --37.64%--__mutex_lock.constprop.0
>                                              |
>                                               --36.83%--osq_lock
>
>     38.26%     0.04%  fops_overhead  [kernel.kallsyms]  [k] kernfs_dop_re=
validate
>             |
>              --38.22%--kernfs_dop_revalidate
>                        |
>                         --37.64%--__mutex_lock.constprop.0
>                                   |
>                                    --36.83%--osq_lock
>
>     29.47%     0.03%  fops_overhead  [kernel.kallsyms]  [k] walk_componen=
t
>             |
>              --29.44%--walk_component
>                        |
>                         --29.10%--lookup_fast
>                                   |
>                                    --28.76%--kernfs_dop_revalidate
>                                              |
>                                               --28.29%--__mutex_lock.cons=
tprop.0
>                                                         |
>                                                          --27.65%--osq_lo=
ck
>
>      6.17%     0.03%  fops_overhead  [kernel.kallsyms]  [k] may_open
>             |
>              --6.14%--may_open
>                        |
>                         --6.13%--inode_permission.part.0
>                                   |
>                                    --6.10%--kernfs_iop_permission
>                                              |
>                                               --5.90%--__mutex_lock.const=
prop.0
>                                                         |
>                                                          --5.80%--osq_loc=
k
>
>      1.22%     0.00%  fops_overhead  [unknown]          [k] 0x5541d689495=
64100
>             |
>             ---0x5541d68949564100
>                __libc_start_main
>                |
>                |--0.68%--__close
>                |          |
>                |           --0.66%--entry_SYSCALL_64_after_hwframe
>                |                     do_syscall_64
>                |                     |
>                |                      --0.61%--__prepare_exit_to_usermode
>                |                                |
>                |                                 --0.58%--task_work_run
>                |
>                 --0.54%--read
>
>      1.22%     0.00%  fops_overhead  libc-2.31.so       [.] __libc_start_=
main
>             |
>             ---__libc_start_main
>                |
>                |--0.68%--__close
>                |          |
>                |           --0.66%--entry_SYSCALL_64_after_hwframe
>                |                     do_syscall_64
>                |                     |
>                |                      --0.61%--__prepare_exit_to_usermode
>                |                                |
>                |                                 --0.58%--task_work_run
>                |
>                 --0.54%--read
>
>      1.06%     1.05%  fops_overhead  [kernel.kallsyms]  [k] mutex_unlock
>             |
>              --1.02%--0x7379732f73656369
>                        __GI___libc_open
>                        entry_SYSCALL_64_after_hwframe
>                        do_syscall_64
>                        __x64_sys_openat
>                        do_sys_openat2
>                        do_filp_open
>                        path_openat
>                        |
>                         --0.80%--link_path_walk.part.0
>                                   |
>                                    --0.60%--inode_permission.part.0
>                                              kernfs_iop_permission
>                                              |
>                                               --0.59%--mutex_unlock
>
>      0.88%     0.79%  fops_overhead  [kernel.kallsyms]  [k] mutex_lock
>             |
>              --0.68%--0x7379732f73656369
>                        __GI___libc_open
>                        entry_SYSCALL_64_after_hwframe
>                        do_syscall_64
>                        __x64_sys_openat
>                        do_sys_openat2
>                        do_filp_open
>                        path_openat
>
>      0.68%     0.01%  fops_overhead  libc-2.31.so       [.] __close
>             |
>              --0.67%--__close
>                        |
>                         --0.66%--entry_SYSCALL_64_after_hwframe
>                                   do_syscall_64
>                                   |
>                                    --0.61%--__prepare_exit_to_usermode
>                                              |
>                                               --0.58%--task_work_run
>
>      0.63%     0.05%  fops_overhead  [kernel.kallsyms]  [k] __prepare_exi=
t_to_usermode
>             |
>              --0.58%--__prepare_exit_to_usermode
>                        task_work_run
>
>      0.58%     0.00%  fops_overhead  [kernel.kallsyms]  [k] task_work_run
>             |
>             ---task_work_run
>
>      0.58%     0.10%  fops_overhead  [kernel.kallsyms]  [k] dput
>      0.56%     0.55%  fops_overhead  [kernel.kallsyms]  [k] mutex_spin_on=
_owner
>             |
>              --0.55%--0x7379732f73656369
>                        __GI___libc_open
>                        entry_SYSCALL_64_after_hwframe
>                        do_syscall_64
>                        __x64_sys_openat
>                        do_sys_openat2
>                        do_filp_open
>                        path_openat
>
>      0.54%     0.00%  fops_overhead  libc-2.31.so       [.] read
>             |
>             ---read
>
>      0.52%     0.12%  fops_overhead  [kernel.kallsyms]  [k] do_dentry_ope=
n
>      0.50%     0.00%  fops_overhead  [kernel.kallsyms]  [k] ksys_read
>      0.50%     0.03%  fops_overhead  [kernel.kallsyms]  [k] vfs_read
>      0.46%     0.05%  fops_overhead  [kernel.kallsyms]  [k] __fput
>      0.45%     0.45%  fops_overhead  [kernel.kallsyms]  [k] lockref_put_r=
eturn
>      0.43%     0.43%  fops_overhead  [kernel.kallsyms]  [k] osq_unlock
>      0.41%     0.08%  fops_overhead  [kernel.kallsyms]  [k] step_into
>      0.41%     0.08%  fops_overhead  [kernel.kallsyms]  [k] __d_lookup
>      0.37%     0.35%  fops_overhead  [kernel.kallsyms]  [k] _raw_spin_loc=
k
>      0.35%     0.03%  fops_overhead  [kernel.kallsyms]  [k] seq_read
>      0.28%     0.01%  fops_overhead  [kernel.kallsyms]  [k] kernfs_fop_op=
en
>      0.27%     0.03%  fops_overhead  [kernel.kallsyms]  [k] kernfs_fop_re=
lease
>      0.16%     0.01%  fops_overhead  [kernel.kallsyms]  [k] kernfs_put_op=
en_node
>      0.16%     0.00%  fops_overhead  [kernel.kallsyms]  [k] terminate_wal=
k
>      0.12%     0.01%  fops_overhead  [kernel.kallsyms]  [k] __alloc_file
>      0.12%     0.00%  fops_overhead  [kernel.kallsyms]  [k] alloc_empty_f=
ile
>      0.12%     0.01%  fops_overhead  [kernel.kallsyms]  [k] unlazy_walk
>      0.12%     0.05%  fops_overhead  [kernel.kallsyms]  [k] _cond_resched
>      0.12%     0.07%  fops_overhead  [kernel.kallsyms]  [k] call_rcu
>      0.10%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __legitimize_=
path
>      0.09%     0.05%  fops_overhead  [kernel.kallsyms]  [k] sysfs_kf_seq_=
show
>      0.09%     0.09%  fops_overhead  [kernel.kallsyms]  [k] generic_permi=
ssion
>      0.09%     0.07%  fops_overhead  [kernel.kallsyms]  [k] rcu_all_qs
>      0.09%     0.01%  fops_overhead  [kernel.kallsyms]  [k] security_file=
_open
>      0.08%     0.00%  fops_overhead  [kernel.kallsyms]  [k] security_file=
_alloc
>      0.08%     0.08%  fops_overhead  [kernel.kallsyms]  [k] lockref_get_n=
ot_dead
>      0.08%     0.03%  fops_overhead  [kernel.kallsyms]  [k] kmem_cache_al=
loc
>      0.08%     0.08%  fops_overhead  [kernel.kallsyms]  [k] apparmor_file=
_open
>      0.07%     0.05%  fops_overhead  [kernel.kallsyms]  [k] kfree
>      0.05%     0.05%  fops_overhead  [kernel.kallsyms]  [k] kernfs_fop_re=
ad
>      0.05%     0.05%  fops_overhead  [kernel.kallsyms]  [k] set_nlink
>      0.05%     0.01%  fops_overhead  [kernel.kallsyms]  [k] kernfs_seq_st=
art
>      0.05%     0.03%  fops_overhead  [kernel.kallsyms]  [k] path_init
>      0.05%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __x64_sys_clo=
se
>      0.05%     0.00%  fops_overhead  [kernel.kallsyms]  [k] filp_close
>      0.05%     0.05%  fops_overhead  [kernel.kallsyms]  [k] syscall_retur=
n_via_sysret
>      0.05%     0.03%  fops_overhead  [kernel.kallsyms]  [k] __kmalloc_nod=
e
>      0.05%     0.05%  fops_overhead  [kernel.kallsyms]  [k] rcu_segcblist=
_enqueue
>      0.04%     0.04%  fops_overhead  [kernel.kallsyms]  [k] vfs_open
>      0.04%     0.04%  fops_overhead  [kernel.kallsyms]  [k] _raw_spin_loc=
k_irqsave
>      0.04%     0.03%  fops_overhead  [kernel.kallsyms]  [k] sprintf
>      0.04%     0.00%  fops_overhead  [kernel.kallsyms]  [k] dev_attr_show
>      0.04%     0.00%  fops_overhead  [kernel.kallsyms]  [k] die_id_show
>      0.04%     0.04%  fops_overhead  [kernel.kallsyms]  [k] kmem_cache_fr=
ee
>      0.04%     0.04%  fops_overhead  [kernel.kallsyms]  [k] fsnotify_pare=
nt
>      0.04%     0.04%  fops_overhead  [kernel.kallsyms]  [k] security_inod=
e_permission
>      0.04%     0.01%  fops_overhead  [kernel.kallsyms]  [k] __check_objec=
t_size
>      0.04%     0.04%  fops_overhead  [kernel.kallsyms]  [k] apparmor_file=
_alloc_security
>      0.04%     0.00%  fops_overhead  [kernel.kallsyms]  [k] seq_release
>      0.04%     0.04%  fops_overhead  [kernel.kallsyms]  [k] memset_erms
>      0.04%     0.04%  fops_overhead  [kernel.kallsyms]  [k] kernfs_get_ac=
tive
>      0.03%     0.00%  fops_overhead  [kernel.kallsyms]  [k] try_to_wake_u=
p
>      0.03%     0.00%  fops_overhead  [kernel.kallsyms]  [k] vsnprintf
>      0.03%     0.01%  fops_overhead  [kernel.kallsyms]  [k] mntput_no_exp=
ire
>      0.03%     0.03%  fops_overhead  [kernel.kallsyms]  [k] lockref_get
>      0.03%     0.03%  fops_overhead  [kernel.kallsyms]  [k] kernfs_put_ac=
tive
>      0.03%     0.03%  fops_overhead  [kernel.kallsyms]  [k] fsnotify
>      0.03%     0.03%  fops_overhead  [kernel.kallsyms]  [k] locks_remove_=
posix
>      0.03%     0.00%  fops_overhead  [kernel.kallsyms]  [k] security_file=
_permission
>      0.03%     0.03%  fops_overhead  [kernel.kallsyms]  [k] rw_verify_are=
a
>      0.03%     0.03%  fops_overhead  [kernel.kallsyms]  [k] set_root
>      0.03%     0.00%  fops_overhead  [kernel.kallsyms]  [k] nd_jump_root
>      0.03%     0.01%  fops_overhead  [kernel.kallsyms]  [k] wake_up_q
>      0.03%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __mutex_unloc=
k_slowpath.constprop.0
>      0.03%     0.00%  fops_overhead  [kernel.kallsyms]  [k] getname_flags=
.part.0
>      0.03%     0.03%  fops_overhead  [kernel.kallsyms]  [k] task_work_add
>      0.03%     0.00%  fops_overhead  [kernel.kallsyms]  [k] fput_many
>      0.03%     0.03%  fops_overhead  [kernel.kallsyms]  [k] __legitimize_=
mnt
>      0.03%     0.01%  fops_overhead  [kernel.kallsyms]  [k] kernfs_seq_st=
op
>      0.02%     0.02%  fops_overhead  [nfs]              [k] nfs_do_access
>      0.02%     0.00%  fops_overhead  ld-2.31.so         [.] _dl_map_objec=
t
>      0.02%     0.00%  fops_overhead  ld-2.31.so         [.] open_path
>      0.02%     0.00%  fops_overhead  ld-2.31.so         [.] __GI___open64=
_nocancel
>      0.02%     0.00%  fops_overhead  [nfs]              [k] nfs_permissio=
n
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] kernfs_seq_ne=
xt
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] available_idl=
e_cpu
>      0.01%     0.00%  fops_overhead  [unknown]          [k] 0x3931206e692=
07364
>      0.01%     0.00%  fops_overhead  libc-2.31.so       [.] __GI___libc_w=
rite
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] ksys_write
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] vfs_write
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] tty_write
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] n_tty_write
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] pty_write
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] queue_work_on
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __queue_work
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] select_task_r=
q_fair
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] _raw_spin_unl=
ock_irqrestore
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] native_queued=
_spin_lock_slowpath
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] slab_free_fre=
elist_hook
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] __list_del_en=
try_valid
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] memcg_kmem_pu=
t_cache
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __syscall_ret=
urn_slowpath
>      0.01%     0.01%  fops_overhead  libc-2.31.so       [.] _dl_addr
>      0.01%     0.00%  fops_overhead  [unknown]          [.] 0x756e696c2d3=
4365f
>      0.01%     0.00%  fops_overhead  [unknown]          [.] 0x00007f4b1ca=
1e000
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __x86_indirec=
t_thunk_rax
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] __virt_addr_v=
alid
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] locks_remove_=
file
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] memcpy_erms
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] update_rq_clo=
ck
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] entry_SYSCALL=
_64
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] __check_heap_=
object
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] apparmor_file=
_free_security
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] security_file=
_free
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] __d_lookup_rc=
u
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] mntput
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] get_unused_fd=
_flags
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] alloc_slab_pa=
ge
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __slab_alloc
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] ___slab_alloc
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] allocate_slab
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __alloc_fd
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] legitimize_ro=
ot
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] strncpy_from_=
user
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] kernfs_refres=
h_inode
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] build_open_fl=
ags
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] strcmp
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] memcg_kmem_ge=
t_cache
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] asm_sysvec_ap=
ic_timer_interrupt
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] sysvec_apic_t=
imer_interrupt
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] asm_call_sysv=
ec_on_stack
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __sysvec_apic=
_timer_interrupt
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] hrtimer_inter=
rupt
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __hrtimer_run=
_queues
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] tick_sched_ti=
mer
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] tick_sched_ha=
ndle
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] update_proces=
s_times
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] scheduler_tic=
k
>      0.01%     0.01%  fops_overhead  [kernel.kallsyms]  [k] perf_iterate_=
ctx
>      0.01%     0.00%  fops_overhead  [unknown]          [k] 0x00007fd34e3=
a0627
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __x64_sys_exe=
cve
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] do_execve
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] __do_execve_f=
ile
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] load_elf_bina=
ry
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] elf_map
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] vm_mmap_pgoff
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] do_mmap
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] mmap_region
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] perf_event_mm=
ap
>      0.01%     0.00%  fops_overhead  [kernel.kallsyms]  [k] perf_iterate_=
sb
>      0.00%     0.00%  perf_5.8       [unknown]          [k] 0x00007fd34e3=
a0627
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] entry_SYSCALL=
_64_after_hwframe
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] perf_event_ex=
ec
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] do_syscall_64
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] __x64_sys_exe=
cve
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] do_execve
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] __do_execve_f=
ile
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] load_elf_bina=
ry
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] begin_new_exe=
c
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] native_write_=
msr
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] __intel_pmu_e=
nable_all.constprop.0
>      0.00%     0.00%  perf_5.8       [kernel.kallsyms]  [k] acpi_os_read_=
memory
>
>
> #
> # (Tip: To count events in every 1000 msec: perf stat -I 1000)
> #
>

Hi Brice,

I wrote a benchmark to do open+read+close on
/sys/devices/system/cpu/cpu0/topology/die_id
https://github.com/foxhlchen/sysfs_benchmark/blob/main/main.c


+    3.39%     3.37%  a.out  [kernel.kallsyms]  [k] mutex_unlock
                                 =E2=97=86
+    2.76%     2.74%  a.out  [kernel.kallsyms]  [k] mutex_lock
                                 =E2=96=92
+    0.92%     0.42%  a.out  [kernel.kallsyms]  [k]
__mutex_lock.constprop.0                            =E2=96=92
     0.38%     0.37%  a.out  [kernel.kallsyms]  [k]
mutex_spin_on_owner                                 =E2=96=92
     0.05%     0.05%  a.out  [kernel.kallsyms]  [k] __mutex_init
                                 =E2=96=92
     0.01%     0.01%  a.out  [kernel.kallsyms]  [k]
__mutex_lock_slowpath                               =E2=96=92
     0.01%     0.00%  a.out  [kernel.kallsyms]  [k]
__mutex_unlock_slowpath.constprop.0

But I failed to reproduce your result.

If it is possible, would you mind providing your benchmark code? :)


thanks,
fox

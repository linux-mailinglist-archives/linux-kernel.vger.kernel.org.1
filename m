Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA8269E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIOFt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:49:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:9618 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgIOFtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:49:13 -0400
IronPort-SDR: Q5FmER5qeQPVf4dvQSK922PT1Vee2JUKk1uE7x8COYLgNlDWgcwKJWh5xYc4qq9ykbhXIQ3FGE
 Vcuwy38sGVBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146892712"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="146892712"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 22:42:34 -0700
IronPort-SDR: 4U+nf6SDSvJ+gR3ujRzxnplZ5wtzVf4WJwV97oGxIuoAIB0j6fjsG+5v/+e4lf+MIxkgOHvm0d
 sGBVpTMaW0ew==
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="482626395"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 22:42:30 -0700
Date:   Tue, 15 Sep 2020 13:54:11 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [btrfs] 3b54a0a703:
 WARNING:at_fs/btrfs/inode.c:#btrfs_finish_ordered_io[btrfs]
Message-ID: <20200915055411.GC17463@xsang-OptiPlex-9020>
References: <20200909070857.GA25950@xsang-OptiPlex-9020>
 <29350c54-fb8e-433e-404c-d72c83f3989a@suse.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29350c54-fb8e-433e-404c-d72c83f3989a@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 09, 2020 at 03:49:30PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/9/9 下午3:08, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 3b54a0a703f17d2b1317d24beefcdcca587a7667 ("[PATCH v3 3/5] btrfs: Detect unbalanced tree with empty leaf before crashing btree operations")
> > url: https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-Enhanced-runtime-defence-against-fuzzed-images/20200809-201720
> > base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
> > 
> > in testcase: fio-basic
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	disk: 1SSD
> > 	fs: btrfs
> > 	nr_task: 100%
> > 	test_size: 128G
> > 	rw: write
> > 	bs: 4k
> > 	ioengine: sync
> > 	cpufreq_governor: performance
> > 	ucode: 0x400002c
> > 	fs2: nfsv4
> > 
> > test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
> > test-url: https://github.com/axboe/fio
> > 
> > 
> > on test machine: 96 threads Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz with 128G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +----------------------------------------------------------------------------+------------+------------+
> > |                                                                            | 2703206ff5 | 3b54a0a703 |
> > +----------------------------------------------------------------------------+------------+------------+
> > | boot_successes                                                             | 9          | 0          |
> > | boot_failures                                                              | 4          |            |
> > | Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-block(#,#) | 4          |            |
> > +----------------------------------------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> 
> According to the full dmesg, it's invalid nritems causing transaction abort.
> 
> I'm not sure if it's caused by corrupts fs or something else.
> 
> If intel guys can reproduce it reliably, would you please add such debug
> diff to output extra info?

Hi Qu, sorry for late. we double confirmed the issue can be reproduced reliably.
The error will only occur on fbc but not parent commit.

below from applying your path for extra info
[   42.539443] [task_0]$
[   42.539445]~$
[   42.546125] rw=write$
[   42.546126]~$
[   42.551637] directory=/fs/nvme1n1p1$
[   42.551638]~$
[   42.559135] numjobs=96' | fio --output-format=json -$
[   42.559136]~$
[   42.574513] perf version 5.9.rc4.g34d4ddd359db$
[   42.574518]~$
[   56.152662] BTRFS error (device nvme1n1p1): invalid tree nritems, bytenr=13238272 owner=7 level=0 first_key=(18446744073709551606 128 96941895680) nritems=0
 expect >0$
[   56.152664] BTRFS error (device nvme1n1p1): invalid tree nritems, bytenr=13238272 owner=7 level=0 first_key=(18446744073709551606 128 96941895680) nritems=0
 expect >0$
[   56.152666] ------------[ cut here ]------------$
[   56.168263] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered_io:2687: errno=-117 Filesystem corrupted$
[   56.168264] BTRFS info (device nvme1n1p1): forced readonly$
[   56.205009] BTRFS: Transaction aborted (error -117)$
[   56.210368] WARNING: CPU: 71 PID: 537 at fs/btrfs/inode.c:2687 btrfs_finish_ordered_io+0x70a/0x820 [btrfs]$
[   56.220466] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core btrfs blak
e2b_generic sr_mod xor cdrom sd_mod zstd_decompress sg zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg_temp_thermal intel_po
werclamp coretemp kvm_intel ipmi_ssif kvm irqbypass ast drm_vram_helper crct10dif_pclmul drm_ttm_helper crc32_pclmul ttm crc32c_intel ghash_clmulni_intel rapl
drm_kms_helper acpi_ipmi syscopyarea intel_cstate sysfillrect ahci sysimgblt nvme libahci fb_sys_fops intel_uncore mei_me nvme_core ioatdma t10_pi drm mei liba
ta joydev ipmi_si dca wmi ipmi_devintf ipmi_msghandler nfit libnvdimm ip_tables$
[   56.285795] CPU: 71 PID: 537 Comm: kworker/u193:28 Not tainted 5.8.0-rc7-00166-g6e85ab8532a52 #1$
[   56.295218] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]$
[   56.302044] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]$
[   56.308762] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 00 41 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 a0 9c 2c c1 e8 58 2e ec bf <0f> 0b 44 8
9 f9 ba 7f 0a 00 00 48 c7 c6 50 c7 2b c1 48 89 df e8 15$
[   56.328846] RSP: 0018:ffffc90007babd58 EFLAGS: 00010282$
[   56.334755] RAX: 0000000000000000 RBX: ffff888fb85984e0 RCX: 0000000000000000$
[   56.342577] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff8890401d7f60$
[   56.350415] RBP: ffff889007e2e4c0 R08: 0000000001200000 R09: 0000000000000000$
[   56.358255] R10: 0000000000000001 R11: ffffffffc00bd060 R12: 0000000010e7e000$
[   56.366121] R13: 0000000010e7efff R14: ffff888fb86622a8 R15: 00000000ffffff8b$
[   56.373983] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) knlGS:0000000000000000$
[   56.382806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033$
[   56.389291] CR2: 00007fa44c4cc448 CR3: 0000005eac7c0006 CR4: 00000000007606e0$
[   56.397176] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000$
[   56.405065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400$
[   56.412952] PKRU: 55555554$
[   56.416419] Call Trace:$
[   56.419631]  ? update_curr+0xc0/0x200$
[   56.424060]  ? newidle_balance+0x232/0x3e0$
[   56.428958]  btrfs_work_helper+0xc9/0x400 [btrfs]$
[   56.434441]  ? __schedule+0x378/0x860$
[   56.438895]  process_one_work+0x1b5/0x3a0$
[   56.443690]  worker_thread+0x50/0x3c0$
[   56.446698] /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/
lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-sync-100%25-300s-write-128G-ucode=0x400002c-monitor=a122c70f-debian-10.4-x86_64-20200603-20200915-84129-
1i8kzyy-0.yaml&job_state=post_run -O /dev/null$
[   56.446700]~$
[   56.448144]  ? process_one_work+0x3a0/0x3a0$
[   56.491886]  kthread+0x114/0x160$
[   56.495986]  ? kthread_park+0xa0/0xa0$
[   56.500522]  ret_from_fork+0x1f/0x30$
[   56.504966] ---[ end trace fbe43e164e851f97 ]---$
[   56.510432] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered_io:2687: errno=-117 Filesystem corrupted$


I also attached full dmesg 'dmesg-with-debug' for your reference.

> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b1a148058773..b050d6fcb90a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -406,8 +406,9 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
> int level,
>         /* We have @first_key, so this @eb must have at least one item */
>         if (btrfs_header_nritems(eb) == 0) {
>                 btrfs_err(fs_info,
> -               "invalid tree nritems, bytenr=%llu nritems=0 expect >0",
> -                         eb->start);
> +               "invalid tree nritems, bytenr=%llu owner=%llu level=%d
> first_key=(%llu %u %llu) nritems=0 expect >0",
> +                         eb->start, btrfs_header_owner(eb),
> btrfs_header_level(eb),
> +                         first_key->objectid, first_key->type,
> first_key->offset);
>                 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>                 return -EUCLEAN;
>         }
> 
> Thanks,
> Qu
> 
> > [   50.226906] WARNING: CPU: 71 PID: 500 at fs/btrfs/inode.c:2687 btrfs_finish_ordered_io+0x70a/0x820 [btrfs]
> > [   50.236913] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core btrfs sr_mod blake2b_generic xor cdrom sd_mod zstd_decompress sg zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg_temp_thermal ipmi_ssif intel_powerclamp coretemp kvm_intel kvm irqbypass ast crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel acpi_ipmi drm_ttm_helper ghash_clmulni_intel ttm rapl drm_kms_helper intel_cstate syscopyarea sysfillrect nvme sysimgblt intel_uncore fb_sys_fops nvme_core ahci libahci t10_pi drm mei_me ioatdma libata mei ipmi_si joydev dca wmi ipmi_devintf ipmi_msghandler nfit libnvdimm ip_tables
> > [   50.301669] CPU: 71 PID: 500 Comm: kworker/u193:5 Not tainted 5.8.0-rc7-00165-g3b54a0a703f17 #1
> > [   50.310904] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> > [   50.317626] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]
> > [   50.324255] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 00 41 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 70 1c 2b c1 e8 58 ae ed bf <0f> 0b 44 89 f9 ba 7f 0a 00 00 48 c7 c6 50 47 2a c1 48 89 df e8 15
> > [   50.344116] RSP: 0018:ffffc90007a83d58 EFLAGS: 00010282
> > [   50.349923] RAX: 0000000000000000 RBX: ffff888a93ca5ea0 RCX: 0000000000000000
> > [   50.357656] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff8890401d7f60
> > [   50.365385] RBP: ffff8890300ab8a8 R08: 0000000000000bd4 R09: 0000000000000000
> > [   50.373133] R10: 0000000000000001 R11: ffffffffc0714060 R12: 000000000f83e000
> > [   50.381060] R13: 000000000f83ffff R14: ffff888fb6c39968 R15: 00000000ffffff8b
> > [   50.388824] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) knlGS:0000000000000000
> > [   50.397545] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   50.404300] CR2: 00007feacc500f98 CR3: 0000000f74422006 CR4: 00000000007606e0
> > [   50.412477] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   50.420281] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   50.428082] PKRU: 55555554
> > [   50.431451] Call Trace:
> > [   50.434570]  ? update_curr+0xc0/0x200
> > [   50.438919]  ? newidle_balance+0x232/0x3e0
> > [   50.443700]  ? __wake_up_common+0x80/0x180
> > [   50.448491]  btrfs_work_helper+0xc9/0x400 [btrfs]
> > [   50.453880]  ? __schedule+0x378/0x860
> > [   50.458218]  process_one_work+0x1b5/0x3a0
> > [   50.462917]  worker_thread+0x50/0x3c0
> > [   50.467262]  ? process_one_work+0x3a0/0x3a0
> > [   50.472148]  kthread+0x114/0x160
> > [   50.476084]  ? kthread_park+0xa0/0xa0
> > [   50.480445]  ret_from_fork+0x1f/0x30
> > [   50.484731] ---[ end trace cc096c1a2068030e ]---
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> > 
> > 
> > 
> > Thanks,
> > Oliver Sang
> > 
> 

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-with-debug
Content-Transfer-Encoding: quoted-printable

Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel.
[    0.000000] Linux version 5.8.0-rc7-00166-g6e85ab8532a52 (kbuild@c2e36c1=
1e9d5) (gcc-9 (Debian 9.3.0-15) 9.3.0, GNU ld (GNU Binutils for Debian) 2.3=
5) #1 SMP Tue Sep 15 06:58:00 CST 2020
[    0.000000] Command line: ip=3D::::lkp-csl-2sp3::dhcp root=3D/dev/ram0 u=
ser=3Dlkp job=3D/lkp/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-performance-1=
SSD-btrfs-nfsv4-sync-100%-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c=
70f-debian-10.4-x86_64-20200603-20200915-84129-1i8kzyy-0.yaml ARCH=3Dx86_64=
 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-devel/fixup-3b54a0a703f17d2b1317d=
24beefcdcca587a7667 commit=3D6e85ab8532a52e24a614dfc017c5e8a699c53cc6 BOOT_=
IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/6e85ab8532a52e24a614dfc017c5e8a699=
c53cc6/vmlinuz-5.8.0-rc7-00166-g6e85ab8532a52 acpi_rsdp=3D0x68b85014 max_up=
time=3D1500 RESULT_ROOT=3D/result/fio-basic/4k-performance-1SSD-btrfs-nfsv4=
-sync-100%-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f/lkp-csl-2sp=
3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/6e85ab8532a52e24a61=
4dfc017c5e8a699c53cc6/2 LKP_SERVER=3Dinn nokaslr selinux=3D0 debug apic=3Dd=
ebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=
=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpan=
ic oo
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2ff, context size is 2568=
 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005a817fff] usable
[    0.000000] BIOS-e820: [mem 0x000000005a818000-0x000000005a8b4fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000005a8b5000-0x000000005c713fff] usable
[    0.000000] BIOS-e820: [mem 0x000000005c714000-0x000000005c9a5fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000005c9a6000-0x000000005ca10fff] usable
[    0.000000] BIOS-e820: [mem 0x000000005ca11000-0x000000005cc37fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000005cc38000-0x0000000060775fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000060776000-0x00000000607d0fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000607d1000-0x0000000060838fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000060839000-0x0000000060866fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x0000000060867000-0x0000000064649fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006464a000-0x00000000646f8fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000646f9000-0x00000000648a6fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000648a7000-0x0000000064923fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000064924000-0x0000000064bedfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000064bee000-0x00000000651effff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000651f0000-0x00000000652d3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000652d4000-0x00000000662d3fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000662d4000-0x0000000067d55fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000067d56000-0x0000000068055fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000068056000-0x0000000068a85fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000068a86000-0x0000000068b85fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x0000000068b86000-0x000000006fafffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006fb00000-0x000000008fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000107fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000001080000000-0x0000004f7fffffff] persi=
stent (type 7)
[    0.000000] BIOS-e820: [mem 0x0000004f80000000-0x0000005f7fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000005f80000000-0x0000009e7fffffff] persi=
stent (type 7)
[    0.000000] BIOS-e820: [mem 0x0000009e80000000-0x0000009e9fffffff] reser=
ved
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI not present or invalid.
[    0.000000] tsc: Detected 2400.000 MHz processor
[    0.000014] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.006655] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.012196] last_pfn =3D 0x5f80000 max_arch_pfn =3D 0x400000000
[    0.017726] MTRR default type: uncachable
[    0.021700] MTRR fixed ranges enabled:
[    0.025418]   00000-9FFFF write-back
[    0.028964]   A0000-FFFFF uncachable
[    0.032508] MTRR variable ranges enabled:
[    0.036486]   0 base 000000000000 mask 3F8000000000 write-back
[    0.042279]   1 base 008000000000 mask 3FE000000000 write-back
[    0.048071]   2 base 009E80000000 mask 3FFF80000000 uncachable
[    0.053863]   3 base 009F00000000 mask 3FFF00000000 uncachable
[    0.059655]   4 base 000080000000 mask 3FFF80000000 uncachable
[    0.065450]   5 base 00007F000000 mask 3FFFFF000000 uncachable
[    0.071242]   6 disabled
[    0.073748]   7 disabled
[    0.076257]   8 disabled
[    0.078763]   9 disabled
[    0.081758] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.089052] total RAM covered: 647152M
[    0.092709]  gran_size: 64K 	chunk_size: 64K 	num_reg: 10  	lose cover R=
AM: 602G
[    0.099972]  gran_size: 64K 	chunk_size: 128K 	num_reg: 10  	lose cover =
RAM: 602G
[    0.107410]  gran_size: 64K 	chunk_size: 256K 	num_reg: 10  	lose cover =
RAM: 602G
[    0.114843]  gran_size: 64K 	chunk_size: 512K 	num_reg: 10  	lose cover =
RAM: 602G
[    0.122280]  gran_size: 64K 	chunk_size: 1M 	num_reg: 10  	lose cover RA=
M: 602G
[    0.129542]  gran_size: 64K 	chunk_size: 2M 	num_reg: 10  	lose cover RA=
M: 602G
[    0.136806]  gran_size: 64K 	chunk_size: 4M 	num_reg: 10  	lose cover RA=
M: 602G
[    0.144067]  gran_size: 64K 	chunk_size: 8M 	num_reg: 10  	lose cover RA=
M: 602G
[    0.151330]  gran_size: 64K 	chunk_size: 16M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.158679]  gran_size: 64K 	chunk_size: 32M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.165943]  gran_size: 64K 	chunk_size: 64M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.173206]  gran_size: 64K 	chunk_size: 128M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.180554]  gran_size: 64K 	chunk_size: 256M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.187903]  gran_size: 64K 	chunk_size: 512M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.195253]  gran_size: 64K 	chunk_size: 1G 	num_reg: 10  	lose cover RA=
M: 58G
[    0.202429]  gran_size: 64K 	chunk_size: 2G 	num_reg: 10  	lose cover RA=
M: 58G
[    0.209605]  gran_size: 128K 	chunk_size: 128K 	num_reg: 10  	lose cover=
 RAM: 602G
[    0.217126]  gran_size: 128K 	chunk_size: 256K 	num_reg: 10  	lose cover=
 RAM: 602G
[    0.224649]  gran_size: 128K 	chunk_size: 512K 	num_reg: 10  	lose cover=
 RAM: 602G
[    0.232173]  gran_size: 128K 	chunk_size: 1M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.239519]  gran_size: 128K 	chunk_size: 2M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.246868]  gran_size: 128K 	chunk_size: 4M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.254218]  gran_size: 128K 	chunk_size: 8M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.261568]  gran_size: 128K 	chunk_size: 16M 	num_reg: 10  	lose cover =
RAM: 602G
[    0.269005]  gran_size: 128K 	chunk_size: 32M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.276352]  gran_size: 128K 	chunk_size: 64M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.283703]  gran_size: 128K 	chunk_size: 128M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.291136]  gran_size: 128K 	chunk_size: 256M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.298573]  gran_size: 128K 	chunk_size: 512M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.306010]  gran_size: 128K 	chunk_size: 1G 	num_reg: 10  	lose cover R=
AM: 58G
[    0.313270]  gran_size: 128K 	chunk_size: 2G 	num_reg: 10  	lose cover R=
AM: 58G
[    0.320533]  gran_size: 256K 	chunk_size: 256K 	num_reg: 10  	lose cover=
 RAM: 602G
[    0.328057]  gran_size: 256K 	chunk_size: 512K 	num_reg: 10  	lose cover=
 RAM: 602G
[    0.335577]  gran_size: 256K 	chunk_size: 1M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.342927]  gran_size: 256K 	chunk_size: 2M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.350276]  gran_size: 256K 	chunk_size: 4M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.357626]  gran_size: 256K 	chunk_size: 8M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.364975]  gran_size: 256K 	chunk_size: 16M 	num_reg: 10  	lose cover =
RAM: 602G
[    0.372410]  gran_size: 256K 	chunk_size: 32M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.379760]  gran_size: 256K 	chunk_size: 64M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.387109]  gran_size: 256K 	chunk_size: 128M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.394546]  gran_size: 256K 	chunk_size: 256M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.401979]  gran_size: 256K 	chunk_size: 512M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.409415]  gran_size: 256K 	chunk_size: 1G 	num_reg: 10  	lose cover R=
AM: 58G
[    0.416678]  gran_size: 256K 	chunk_size: 2G 	num_reg: 10  	lose cover R=
AM: 58G
[    0.423942]  gran_size: 512K 	chunk_size: 512K 	num_reg: 10  	lose cover=
 RAM: 602G
[    0.431462]  gran_size: 512K 	chunk_size: 1M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.438812]  gran_size: 512K 	chunk_size: 2M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.446161]  gran_size: 512K 	chunk_size: 4M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.453512]  gran_size: 512K 	chunk_size: 8M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.460858]  gran_size: 512K 	chunk_size: 16M 	num_reg: 10  	lose cover =
RAM: 602G
[    0.468295]  gran_size: 512K 	chunk_size: 32M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.475646]  gran_size: 512K 	chunk_size: 64M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.482992]  gran_size: 512K 	chunk_size: 128M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.490429]  gran_size: 512K 	chunk_size: 256M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.497865]  gran_size: 512K 	chunk_size: 512M 	num_reg: 10  	lose cover=
 RAM: 58G
[    0.505302]  gran_size: 512K 	chunk_size: 1G 	num_reg: 10  	lose cover R=
AM: 58G
[    0.512562]  gran_size: 512K 	chunk_size: 2G 	num_reg: 10  	lose cover R=
AM: 58G
[    0.519826]  gran_size: 1M 	chunk_size: 1M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.527001]  gran_size: 1M 	chunk_size: 2M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.534177]  gran_size: 1M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.541354]  gran_size: 1M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.548530]  gran_size: 1M 	chunk_size: 16M 	num_reg: 10  	lose cover RA=
M: 602G
[    0.555793]  gran_size: 1M 	chunk_size: 32M 	num_reg: 10  	lose cover RA=
M: 58G
[    0.562969]  gran_size: 1M 	chunk_size: 64M 	num_reg: 10  	lose cover RA=
M: 58G
[    0.570146]  gran_size: 1M 	chunk_size: 128M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.577409]  gran_size: 1M 	chunk_size: 256M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.584673]  gran_size: 1M 	chunk_size: 512M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.591936]  gran_size: 1M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM=
: 58G
[    0.599025]  gran_size: 1M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM=
: 58G
[    0.606113]  gran_size: 2M 	chunk_size: 2M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.613290]  gran_size: 2M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.620466]  gran_size: 2M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.627642]  gran_size: 2M 	chunk_size: 16M 	num_reg: 10  	lose cover RA=
M: 602G
[    0.634905]  gran_size: 2M 	chunk_size: 32M 	num_reg: 10  	lose cover RA=
M: 58G
[    0.642081]  gran_size: 2M 	chunk_size: 64M 	num_reg: 10  	lose cover RA=
M: 58G
[    0.649258]  gran_size: 2M 	chunk_size: 128M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.656521]  gran_size: 2M 	chunk_size: 256M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.663784]  gran_size: 2M 	chunk_size: 512M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.671047]  gran_size: 2M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM=
: 58G
[    0.678134]  gran_size: 2M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM=
: 58G
[    0.685224]  gran_size: 4M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.692400]  gran_size: 4M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.699576]  gran_size: 4M 	chunk_size: 16M 	num_reg: 10  	lose cover RA=
M: 602G
[    0.706839]  gran_size: 4M 	chunk_size: 32M 	num_reg: 10  	lose cover RA=
M: 58G
[    0.714016]  gran_size: 4M 	chunk_size: 64M 	num_reg: 10  	lose cover RA=
M: 58G
[    0.721192]  gran_size: 4M 	chunk_size: 128M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.728455]  gran_size: 4M 	chunk_size: 256M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.735718]  gran_size: 4M 	chunk_size: 512M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.742982]  gran_size: 4M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM=
: 58G
[    0.750071]  gran_size: 4M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM=
: 58G
[    0.757162]  gran_size: 8M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM=
: 602G
[    0.764336]  gran_size: 8M 	chunk_size: 16M 	num_reg: 10  	lose cover RA=
M: 602G
[    0.771598]  gran_size: 8M 	chunk_size: 32M 	num_reg: 10  	lose cover RA=
M: 58G
[    0.778775]  gran_size: 8M 	chunk_size: 64M 	num_reg: 10  	lose cover RA=
M: 58G
[    0.785951]  gran_size: 8M 	chunk_size: 128M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.793214]  gran_size: 8M 	chunk_size: 256M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.800477]  gran_size: 8M 	chunk_size: 512M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.807741]  gran_size: 8M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM=
: 58G
[    0.814831]  gran_size: 8M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM=
: 58G
[    0.821920]  gran_size: 16M 	chunk_size: 16M 	num_reg: 10  	lose cover R=
AM: 602G
[    0.829270]  gran_size: 16M 	chunk_size: 32M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.836530]  gran_size: 16M 	chunk_size: 64M 	num_reg: 10  	lose cover R=
AM: 58G
[    0.843793]  gran_size: 16M 	chunk_size: 128M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.851143]  gran_size: 16M 	chunk_size: 256M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.858493]  gran_size: 16M 	chunk_size: 512M 	num_reg: 10  	lose cover =
RAM: 58G
[    0.865840]  gran_size: 16M 	chunk_size: 1G 	num_reg: 10  	lose cover RA=
M: 58G
[    0.873017]  gran_size: 16M 	chunk_size: 2G 	num_reg: 10  	lose cover RA=
M: 58G
[    0.880193]  gran_size: 32M 	chunk_size: 32M 	num_reg: 10  	lose cover R=
AM: 583696M
[    0.887803]  gran_size: 32M 	chunk_size: 64M 	num_reg: 10  	lose cover R=
AM: 59408M
[    0.895324]  gran_size: 32M 	chunk_size: 128M 	num_reg: 10  	lose cover =
RAM: 59408M
[    0.902934]  gran_size: 32M 	chunk_size: 256M 	num_reg: 10  	lose cover =
RAM: 59408M
[    0.910540]  gran_size: 32M 	chunk_size: 512M 	num_reg: 10  	lose cover =
RAM: 59408M
[    0.918150]  gran_size: 32M 	chunk_size: 1G 	num_reg: 10  	lose cover RA=
M: 59408M
[    0.925587]  gran_size: 32M 	chunk_size: 2G 	num_reg: 10  	lose cover RA=
M: 59408M
[    0.933023]  gran_size: 64M 	chunk_size: 64M 	num_reg: 10  	lose cover R=
AM: 518192M
[    0.940630]  gran_size: 64M 	chunk_size: 128M 	num_reg: 10  	lose cover =
RAM: 59440M
[    0.948238]  gran_size: 64M 	chunk_size: 256M 	num_reg: 10  	lose cover =
RAM: 59440M
[    0.955849]  gran_size: 64M 	chunk_size: 512M 	num_reg: 10  	lose cover =
RAM: 59440M
[    0.963455]  gran_size: 64M 	chunk_size: 1G 	num_reg: 10  	lose cover RA=
M: 59440M
[    0.970892]  gran_size: 64M 	chunk_size: 2G 	num_reg: 10  	lose cover RA=
M: 59440M
[    0.978326]  gran_size: 128M 	chunk_size: 128M 	num_reg: 10  	lose cover=
 RAM: 387184M
[    0.986109]  gran_size: 128M 	chunk_size: 256M 	num_reg: 10  	lose cover=
 RAM: 59504M
[    0.993803]  gran_size: 128M 	chunk_size: 512M 	num_reg: 10  	lose cover=
 RAM: 59504M
[    1.001500]  gran_size: 128M 	chunk_size: 1G 	num_reg: 10  	lose cover R=
AM: 59504M
[    1.009020]  gran_size: 128M 	chunk_size: 2G 	num_reg: 10  	lose cover R=
AM: 59504M
[    1.016542]  gran_size: 256M 	chunk_size: 256M 	num_reg: 10  	lose cover=
 RAM: 125168M
[    1.024323]  gran_size: 256M 	chunk_size: 512M 	num_reg: 10  	lose cover=
 RAM: 59632M
[    1.032021]  gran_size: 256M 	chunk_size: 1G 	num_reg: 10  	lose cover R=
AM: 59632M
[    1.039541]  gran_size: 256M 	chunk_size: 2G 	num_reg: 10  	lose cover R=
AM: 59632M
[    1.047065]  gran_size: 512M 	chunk_size: 512M 	num_reg: 10  	lose cover=
 RAM: 59888M
[    1.054759]  gran_size: 512M 	chunk_size: 1G 	num_reg: 10  	lose cover R=
AM: 59888M
[    1.062279]  gran_size: 512M 	chunk_size: 2G 	num_reg: 10  	lose cover R=
AM: 59888M
[    1.069803]  gran_size: 1G 	chunk_size: 1G 	num_reg: 10  	lose cover RAM=
: 27632M
[    1.077153]  gran_size: 1G 	chunk_size: 2G 	num_reg: 10  	lose cover RAM=
: 27632M
[    1.084500]  gran_size: 2G 	chunk_size: 2G 	num_reg: 10  	lose cover RAM=
: 12272M
[    1.091850] mtrr_cleanup: can not find optimal value
[    1.096778] please specify mtrr_gran_size/mtrr_chunk_size
[    1.102142] e820: update [mem 0x7f000000-0xffffffff] usable =3D=3D> rese=
rved
[    1.108797] last_pfn =3D 0x6fb00 max_arch_pfn =3D 0x400000000
[    1.114156] Scan for SMP in [mem 0x00000000-0x000003ff]
[    1.119360] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    1.124546] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    1.136389] Scan for SMP in [mem 0x0009c000-0x0009c3ff]
[    1.141366] Using GB pages for direct mapping
[    1.147264] RAMDISK: [mem 0x5f6c2ed000-0x5f7cffffff]
[    1.151951] ACPI: Early table checksum verification disabled
[    1.157572] ACPI: RSDP 0x0000000068B85014 000024 (v02 INTEL )
[    1.163276] ACPI: XSDT 0x0000000068AA3188 000114 (v01 INTEL  S2600WF  00=
000000 INTL 20091013)
[    1.171753] ACPI: FACP 0x0000000068B82000 00010C (v05 INTEL  S2600WF  00=
000000 INTL 20091013)
[    1.180225] ACPI: DSDT 0x000000005C714000 291A31 (v02 INTEL  S2600WF  00=
000003 INTL 20091013)
[    1.188694] ACPI: FACS 0x00000000689C8000 000040
[    1.193278] ACPI: SSDT 0x0000000068B83000 0004B0 (v02 INTEL  S2600WF  00=
000000 MSFT 0100000D)
[    1.201750] ACPI: UEFI 0x0000000068A2C000 000042 (v01 INTEL  S2600WF  00=
000002 INTL 20091013)
[    1.210225] ACPI: UEFI 0x00000000689CA000 00005C (v01 INTEL  RstUefiV 00=
000000      00000000)
[    1.218699] ACPI: HPET 0x0000000068B81000 000038 (v01 INTEL  S2600WF  00=
000001 INTL 20091013)
[    1.227171] ACPI: APIC 0x0000000068B7F000 0016DE (v03 INTEL  S2600WF  00=
000000 INTL 20091013)
[    1.235644] ACPI: MCFG 0x0000000068B7E000 00003C (v01 INTEL  S2600WF  00=
000001 INTL 20091013)
[    1.244116] ACPI: MSCT 0x0000000068B7D000 000090 (v01 INTEL  S2600WF  00=
000001 INTL 20091013)
[    1.252589] ACPI: PCAT 0x0000000068B7C000 000088 (v02 INTEL  S2600WF  00=
000002 INTL 20091013)
[    1.261064] ACPI: PCCT 0x0000000068B7B000 00006E (v01 INTEL  S2600WF  00=
000002 INTL 20091013)
[    1.269536] ACPI: PMTT 0x0000000068B7A000 000538 (v01 INTEL  S2600WF  00=
000001 INTL 20091013)
[    1.278009] ACPI: RASF 0x0000000068B79000 000030 (v01 INTEL  S2600WF  00=
000001 INTL 20091013)
[    1.286481] ACPI: SLIT 0x0000000068B78000 00042C (v01 INTEL  S2600WF  00=
000001 INTL 20091013)
[    1.294957] ACPI: SRAT 0x0000000068B75000 002D30 (v03 INTEL  S2600WF  00=
000002 INTL 20091013)
[    1.303429] ACPI: SPMI 0x0000000068B74000 000041 (v05 INTEL  S2600WF  00=
000001 INTL 20091013)
[    1.311901] ACPI: WDDT 0x0000000068B73000 000040 (v01 INTEL  S2600WF  00=
000000 INTL 20091013)
[    1.320376] ACPI: WSMT 0x0000000068B72000 000028 (v01 INTEL  S2600WF  00=
000000 INTL 20091013)
[    1.328849] ACPI: OEM4 0x0000000068ACF000 0A27C4 (v02 INTEL  CPU  CST 00=
003000 INTL 20140828)
[    1.337321] ACPI: OEM1 0x0000000068AA4000 02A2C4 (v02 INTEL  CPU EIST 00=
003000 INTL 20140828)
[    1.345794] ACPI: OEM2 0x0000000060839000 02DC84 (v02 INTEL  CPU  HWP 00=
003000 INTL 20140828)
[    1.354266] ACPI: SSDT 0x000000006079D000 033990 (v02 INTEL  S2600WF  00=
004000 INTL 20091013)
[    1.362742] ACPI: OEM3 0x0000000060776000 026664 (v02 INTEL  CPU  TST 00=
003000 INTL 20140828)
[    1.371214] ACPI: NFIT 0x0000000068B84000 0004D0 (v01 INTEL  S2600WF  00=
000002 INTL 20091013)
[    1.379686] ACPI: SSDT 0x0000000068AA0000 002B10 (v02 INTEL  S2600WF  00=
000002 INTL 20091013)
[    1.388159] ACPI: SPCR 0x0000000068A9F000 000050 (v02 INTEL  S2600WF  00=
000000 INTL 20091013)
[    1.396635] ACPI: HEST 0x0000000068A9E000 0000A8 (v01 INTEL  S2600WF  00=
000001 INTL 00000001)
[    1.405106] ACPI: BERT 0x0000000068A9D000 000030 (v01 INTEL  S2600WF  00=
000001 INTL 00000001)
[    1.413579] ACPI: ERST 0x0000000068A9C000 000230 (v01 INTEL  S2600WF  00=
000001 INTL 00000001)
[    1.422051] ACPI: EINJ 0x0000000068A9B000 000150 (v01 INTEL  S2600WF  00=
000001 INTL 00000001)
[    1.430527] ACPI: FPDT 0x0000000068A9A000 000044 (v01 INTEL  S2600WF  00=
000002 INTL 20091013)
[    1.439002] ACPI: Local APIC address 0xfee00000
[    1.443501] mapped APIC to ffffffffff5fc000 (        fee00000)
[    1.449345] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    1.453698] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    1.458106] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    1.462517] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    1.466924] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    1.471335] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    1.475743] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    1.480153] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    1.484564] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    1.488971] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    1.493382] SRAT: PXM 0 -> APIC 0x18 -> Node 0
[    1.497793] SRAT: PXM 0 -> APIC 0x1a -> Node 0
[    1.502200] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    1.506611] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    1.511019] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    1.515430] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    1.519838] SRAT: PXM 0 -> APIC 0x28 -> Node 0
[    1.524249] SRAT: PXM 0 -> APIC 0x2a -> Node 0
[    1.528660] SRAT: PXM 0 -> APIC 0x30 -> Node 0
[    1.533067] SRAT: PXM 0 -> APIC 0x32 -> Node 0
[    1.537478] SRAT: PXM 0 -> APIC 0x34 -> Node 0
[    1.541886] SRAT: PXM 0 -> APIC 0x36 -> Node 0
[    1.546296] SRAT: PXM 0 -> APIC 0x38 -> Node 0
[    1.550704] SRAT: PXM 0 -> APIC 0x3a -> Node 0
[    1.555115] SRAT: PXM 1 -> APIC 0x40 -> Node 1
[    1.559526] SRAT: PXM 1 -> APIC 0x42 -> Node 1
[    1.563934] SRAT: PXM 1 -> APIC 0x44 -> Node 1
[    1.568344] SRAT: PXM 1 -> APIC 0x46 -> Node 1
[    1.572752] SRAT: PXM 1 -> APIC 0x48 -> Node 1
[    1.577163] SRAT: PXM 1 -> APIC 0x4a -> Node 1
[    1.581573] SRAT: PXM 1 -> APIC 0x4c -> Node 1
[    1.585981] SRAT: PXM 1 -> APIC 0x52 -> Node 1
[    1.590391] SRAT: PXM 1 -> APIC 0x54 -> Node 1
[    1.594799] SRAT: PXM 1 -> APIC 0x56 -> Node 1
[    1.599210] SRAT: PXM 1 -> APIC 0x58 -> Node 1
[    1.603621] SRAT: PXM 1 -> APIC 0x5a -> Node 1
[    1.608028] SRAT: PXM 1 -> APIC 0x60 -> Node 1
[    1.612439] SRAT: PXM 1 -> APIC 0x62 -> Node 1
[    1.616847] SRAT: PXM 1 -> APIC 0x64 -> Node 1
[    1.621258] SRAT: PXM 1 -> APIC 0x66 -> Node 1
[    1.625668] SRAT: PXM 1 -> APIC 0x68 -> Node 1
[    1.630076] SRAT: PXM 1 -> APIC 0x6a -> Node 1
[    1.634487] SRAT: PXM 1 -> APIC 0x70 -> Node 1
[    1.638895] SRAT: PXM 1 -> APIC 0x72 -> Node 1
[    1.643305] SRAT: PXM 1 -> APIC 0x74 -> Node 1
[    1.647713] SRAT: PXM 1 -> APIC 0x76 -> Node 1
[    1.652123] SRAT: PXM 1 -> APIC 0x78 -> Node 1
[    1.656534] SRAT: PXM 1 -> APIC 0x7a -> Node 1
[    1.660942] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    1.665353] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    1.669763] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    1.674171] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    1.678582] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    1.682989] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    1.687400] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    1.691808] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    1.696219] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    1.700627] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    1.705038] SRAT: PXM 0 -> APIC 0x19 -> Node 0
[    1.709449] SRAT: PXM 0 -> APIC 0x1b -> Node 0
[    1.713856] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    1.718267] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    1.722674] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    1.727085] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    1.731496] SRAT: PXM 0 -> APIC 0x29 -> Node 0
[    1.735904] SRAT: PXM 0 -> APIC 0x2b -> Node 0
[    1.740314] SRAT: PXM 0 -> APIC 0x31 -> Node 0
[    1.744722] SRAT: PXM 0 -> APIC 0x33 -> Node 0
[    1.749133] SRAT: PXM 0 -> APIC 0x35 -> Node 0
[    1.753544] SRAT: PXM 0 -> APIC 0x37 -> Node 0
[    1.757952] SRAT: PXM 0 -> APIC 0x39 -> Node 0
[    1.762362] SRAT: PXM 0 -> APIC 0x3b -> Node 0
[    1.766770] SRAT: PXM 1 -> APIC 0x41 -> Node 1
[    1.771181] SRAT: PXM 1 -> APIC 0x43 -> Node 1
[    1.775588] SRAT: PXM 1 -> APIC 0x45 -> Node 1
[    1.779999] SRAT: PXM 1 -> APIC 0x47 -> Node 1
[    1.784410] SRAT: PXM 1 -> APIC 0x49 -> Node 1
[    1.788818] SRAT: PXM 1 -> APIC 0x4b -> Node 1
[    1.793229] SRAT: PXM 1 -> APIC 0x4d -> Node 1
[    1.797637] SRAT: PXM 1 -> APIC 0x53 -> Node 1
[    1.802048] SRAT: PXM 1 -> APIC 0x55 -> Node 1
[    1.806455] SRAT: PXM 1 -> APIC 0x57 -> Node 1
[    1.810866] SRAT: PXM 1 -> APIC 0x59 -> Node 1
[    1.815277] SRAT: PXM 1 -> APIC 0x5b -> Node 1
[    1.819685] SRAT: PXM 1 -> APIC 0x61 -> Node 1
[    1.824096] SRAT: PXM 1 -> APIC 0x63 -> Node 1
[    1.828503] SRAT: PXM 1 -> APIC 0x65 -> Node 1
[    1.832914] SRAT: PXM 1 -> APIC 0x67 -> Node 1
[    1.837323] SRAT: PXM 1 -> APIC 0x69 -> Node 1
[    1.841733] SRAT: PXM 1 -> APIC 0x6b -> Node 1
[    1.846141] SRAT: PXM 1 -> APIC 0x71 -> Node 1
[    1.850552] SRAT: PXM 1 -> APIC 0x73 -> Node 1
[    1.854960] SRAT: PXM 1 -> APIC 0x75 -> Node 1
[    1.859371] SRAT: PXM 1 -> APIC 0x77 -> Node 1
[    1.863781] SRAT: PXM 1 -> APIC 0x79 -> Node 1
[    1.868189] SRAT: PXM 1 -> APIC 0x7b -> Node 1
[    1.872610] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    1.878566] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x107fffffff]
[    1.884792] ACPI: SRAT: Node 2 PXM 2 [mem 0x1080000000-0x4f7fffffff] non=
-volatile
[    1.892225] ACPI: SRAT: Node 1 PXM 1 [mem 0x4f80000000-0x5f7fffffff]
[    1.898537] ACPI: SRAT: Node 3 PXM 3 [mem 0x5f80000000-0x9e7fffffff] non=
-volatile
[    1.905979] NUMA: Initialized distance table, cnt=3D4
[    1.910815] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-=
0x107fffffff] -> [mem 0x00000000-0x107fffffff]
[    1.921456] NODE_DATA(0) allocated [mem 0x107ffd5000-0x107fffffff]
[    1.927613] NODE_DATA(1) allocated [mem 0x5f7ffcc000-0x5f7fff6fff]
[    1.933930] cma: Reserved 200 MiB at 0x0000005f5f800000
[    1.939057] Zone ranges:
[    1.941422]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    1.947561]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    1.953700]   Normal   [mem 0x0000000100000000-0x0000005f7fffffff]
[    1.959836]   Device   empty
[    1.962689] Movable zone start for each node
[    1.966929] Early memory node ranges
[    1.970473]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    1.976699]   node   0: [mem 0x0000000000100000-0x000000005a817fff]
[    1.982922]   node   0: [mem 0x000000005a8b5000-0x000000005c713fff]
[    1.989148]   node   0: [mem 0x000000005c9a6000-0x000000005ca10fff]
[    1.995373]   node   0: [mem 0x000000005cc38000-0x0000000060775fff]
[    2.001598]   node   0: [mem 0x00000000607d1000-0x0000000060838fff]
[    2.007824]   node   0: [mem 0x0000000060867000-0x0000000064649fff]
[    2.014049]   node   0: [mem 0x00000000646f9000-0x00000000648a6fff]
[    2.020275]   node   0: [mem 0x0000000064924000-0x0000000064bedfff]
[    2.026498]   node   0: [mem 0x00000000651f0000-0x00000000652d3fff]
[    2.032723]   node   0: [mem 0x00000000662d4000-0x0000000067d55fff]
[    2.038949]   node   0: [mem 0x0000000068b86000-0x000000006fafffff]
[    2.045174]   node   0: [mem 0x0000000100000000-0x000000107fffffff]
[    2.051405]   node   1: [mem 0x0000004f80000000-0x0000005f7fffffff]
[    2.058427] Zeroed struct page in unavailable ranges: 12446 pages
[    2.058428] Initmem setup node 0 [mem 0x0000000000001000-0x000000107ffff=
fff]
[    2.071243] On node 0 totalpages: 16699234
[    2.075308]   DMA zone: 64 pages used for memmap
[    2.079890]   DMA zone: 25 pages reserved
[    2.083864]   DMA zone: 3999 pages, LIFO batch:0
[    2.088492]   DMA32 zone: 6912 pages used for memmap
[    2.093376]   DMA32 zone: 442307 pages, LIFO batch:63
[    2.102300]   Normal zone: 253952 pages used for memmap
[    2.107244]   Normal zone: 16252928 pages, LIFO batch:63
[    2.112850] Initmem setup node 1 [mem 0x0000004f80000000-0x0000005f7ffff=
fff]
[    2.119619] On node 1 totalpages: 16777216
[    2.123682]   Normal zone: 262144 pages used for memmap
[    2.128867]   Normal zone: 16777216 pages, LIFO batch:63
[    2.134702] ACPI: PM-Timer IO Port: 0x508
[    2.138439] ACPI: Local APIC address 0xfee00000
[    2.142958] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    2.149164] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    2.155144] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
23
[    2.161961] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24=
-31
[    2.168877] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 3=
2-39
[    2.175880] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 4=
0-47
[    2.182884] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 4=
8-55
[    2.189887] IOAPIC[5]: apic_id 15, version 32, address 0xfec20000, GSI 7=
2-79
[    2.196891] IOAPIC[6]: apic_id 16, version 32, address 0xfec28000, GSI 8=
0-87
[    2.203894] IOAPIC[7]: apic_id 17, version 32, address 0xfec30000, GSI 8=
8-95
[    2.210898] IOAPIC[8]: apic_id 18, version 32, address 0xfec38000, GSI 9=
6-103
[    2.217988] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    2.224295] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 8, APIC =
INT 02
[    2.231472] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    2.238042] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 8, APIC =
INT 09
[    2.245220] ACPI: IRQ0 used by override.
[    2.249108] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 8, APIC =
INT 01
[    2.256284] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 8, APIC =
INT 03
[    2.263461] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 8, APIC =
INT 04
[    2.270638] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 8, APIC =
INT 05
[    2.277815] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 8, APIC =
INT 06
[    2.284991] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 8, APIC =
INT 07
[    2.292168] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 8, APIC =
INT 08
[    2.299341] ACPI: IRQ9 used by override.
[    2.303235] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 8, APIC =
INT 0a
[    2.310411] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 8, APIC =
INT 0b
[    2.317587] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 8, APIC =
INT 0c
[    2.324763] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 8, APIC =
INT 0d
[    2.331940] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 8, APIC =
INT 0e
[    2.339116] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 8, APIC =
INT 0f
[    2.346296] Using ACPI (MADT) for SMP configuration information
[    2.352169] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    2.357273] ACPI: SPCR: console: uart,io,0x3f8,115200
[    2.362288] TSC deadline timer available
[    2.366176] smpboot: Allowing 96 CPUs, 0 hotplug CPUs
[    2.371194] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    2.376466] mapped IOAPIC to ffffffffff5fa000 (fec01000)
[    2.381741] mapped IOAPIC to ffffffffff5f9000 (fec08000)
[    2.387013] mapped IOAPIC to ffffffffff5f8000 (fec10000)
[    2.392288] mapped IOAPIC to ffffffffff5f7000 (fec18000)
[    2.397563] mapped IOAPIC to ffffffffff5f6000 (fec20000)
[    2.402837] mapped IOAPIC to ffffffffff5f5000 (fec28000)
[    2.408109] mapped IOAPIC to ffffffffff5f4000 (fec30000)
[    2.413384] mapped IOAPIC to ffffffffff5f3000 (fec38000)
[    2.418684] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    2.426182] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    2.433704] PM: hibernation: Registered nosave memory: [mem 0x5a818000-0=
x5a8b4fff]
[    2.441225] PM: hibernation: Registered nosave memory: [mem 0x5c714000-0=
x5c9a5fff]
[    2.448749] PM: hibernation: Registered nosave memory: [mem 0x5ca11000-0=
x5cc37fff]
[    2.456270] PM: hibernation: Registered nosave memory: [mem 0x60776000-0=
x607d0fff]
[    2.463791] PM: hibernation: Registered nosave memory: [mem 0x60839000-0=
x60866fff]
[    2.471315] PM: hibernation: Registered nosave memory: [mem 0x6464a000-0=
x646f8fff]
[    2.478836] PM: hibernation: Registered nosave memory: [mem 0x648a7000-0=
x64923fff]
[    2.486360] PM: hibernation: Registered nosave memory: [mem 0x64bee000-0=
x651effff]
[    2.493881] PM: hibernation: Registered nosave memory: [mem 0x652d4000-0=
x662d3fff]
[    2.501402] PM: hibernation: Registered nosave memory: [mem 0x67d56000-0=
x68055fff]
[    2.508925] PM: hibernation: Registered nosave memory: [mem 0x68056000-0=
x68a85fff]
[    2.516444] PM: hibernation: Registered nosave memory: [mem 0x68a86000-0=
x68b85fff]
[    2.523970] PM: hibernation: Registered nosave memory: [mem 0x6fb00000-0=
x8fffffff]
[    2.531490] PM: hibernation: Registered nosave memory: [mem 0x90000000-0=
xfdffffff]
[    2.539010] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    2.546534] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xffffffff]
[    2.554059] PM: hibernation: Registered nosave memory: [mem 0x1080000000=
-0x4f7fffffff]
[    2.561924] [mem 0x90000000-0xfdffffff] available for PCI devices
[    2.567976] Booting paravirtualized kernel on bare hardware
[    2.573513] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    2.588498] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:96 nr_cpu_ids:96 =
nr_node_ids:4
[    2.602539] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u262144
[    2.608795] pcpu-alloc: s188416 r8192 d28672 u262144 alloc=3D1*2097152
[    2.615099] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 1=
3 14 15=20
[    2.622445] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 48 49 50 51 52 5=
3 54 55=20
[    2.629794] pcpu-alloc: [0] 56 57 58 59 60 61 62 63 [0] 64 65 66 67 68 6=
9 70 71=20
[    2.637146] pcpu-alloc: [1] 24 25 26 27 28 29 30 31 [1] 32 33 34 35 36 3=
7 38 39=20
[    2.644495] pcpu-alloc: [1] 40 41 42 43 44 45 46 47 [1] 72 73 74 75 76 7=
7 78 79=20
[    2.651844] pcpu-alloc: [1] 80 81 82 83 84 85 86 87 [1] 88 89 90 91 92 9=
3 94 95=20
[    2.659248] Built 2 zonelists, mobility grouping on.  Total pages: 32953=
353
[    2.666110] Policy zone: Normal
[    2.669223] Kernel command line: ip=3D::::lkp-csl-2sp3::dhcp root=3D/dev=
/ram0 user=3Dlkp job=3D/lkp/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-perfor=
mance-1SSD-btrfs-nfsv4-sync-100%-300s-write-128G-ucode=3D0x400002c-monitor=
=3Da122c70f-debian-10.4-x86_64-20200603-20200915-84129-1i8kzyy-0.yaml ARCH=
=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-devel/fixup-3b54a0a703f1=
7d2b1317d24beefcdcca587a7667 commit=3D6e85ab8532a52e24a614dfc017c5e8a699c53=
cc6 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/6e85ab8532a52e24a614dfc01=
7c5e8a699c53cc6/vmlinuz-5.8.0-rc7-00166-g6e85ab8532a52 acpi_rsdp=3D0x68b850=
14 max_uptime=3D1500 RESULT_ROOT=3D/result/fio-basic/4k-performance-1SSD-bt=
rfs-nfsv4-sync-100%-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f/lk=
p-csl-2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/6e85ab8532=
a52e24a614dfc017c5e8a699c53cc6/2 LKP_SERVER=3Dinn nokaslr selinux=3D0 debug=
 apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net=
=2Eifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watc=
hdog=3Dp
[    2.669542] sysrq: sysrq always enabled.
[    2.761274] mem auto-init: stack:off, heap alloc:off, heap free:off
[    2.815518] Memory: 1981732K/133905800K available (14340K kernel code, 2=
529K rwdata, 4892K rodata, 2412K init, 4892K bss, 2493192K reserved, 204800=
K cma-reserved)
[    2.830190] random: get_random_u64 called from cache_random_seq_create+0=
x7c/0x140 with crng_init=3D0
[    2.830663] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D96, =
Nodes=3D4
[    2.845952] ftrace: allocating 44744 entries in 175 pages
[    2.869319] ftrace: allocated 175 pages with 6 groups
[    2.874698] rcu: Hierarchical RCU implementation.
[    2.879132] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D96.
[    2.885962] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    2.893225] 	Trampoline variant of Tasks RCU enabled.
[    2.898239] 	Rude variant of Tasks RCU enabled.
[    2.902733] 	Tracing variant of Tasks RCU enabled.
[    2.907491] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    2.915099] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D96
[    2.924848] NR_IRQS: 524544, nr_irqs: 2552, preallocated irqs: 16
[    2.931217] Console: colour dummy device 80x25
[    2.936021] printk: console [tty0] enabled
[    2.939874] printk: console [ttyS0] enabled
[    2.939874] printk: console [ttyS0] enabled
[    2.948163] printk: bootconsole [earlyser0] disabled
[    2.948163] printk: bootconsole [earlyser0] disabled
[    2.958174] mempolicy: Enabling automatic NUMA balancing. Configure with=
 numa_balancing=3D or the kernel.numa_balancing sysctl
[    2.969454] ACPI: Core revision 20200528
[    2.976319] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    2.985389] APIC: Switch to symmetric I/O mode setup
[    2.990575] x2apic: IRQ remapping doesn't support X2APIC mode
[    2.996421] Switched APIC routing to physical flat.
[    3.001307] masked ExtINT on CPU#0
[    3.005446] ENABLING IO-APIC IRQs
[    3.008760] init IO_APIC IRQs
[    3.011730]  apic 8 pin 0 not connected
[    3.015568] IOAPIC[0]: Set routing entry (8-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:0)
[    3.023468] IOAPIC[0]: Set routing entry (8-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:0)
[    3.031370] IOAPIC[0]: Set routing entry (8-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:0)
[    3.039271] IOAPIC[0]: Set routing entry (8-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:0)
[    3.047172] IOAPIC[0]: Set routing entry (8-5 -> 0xef -> IRQ 5 Mode:0 Ac=
tive:0 Dest:0)
[    3.055066] IOAPIC[0]: Set routing entry (8-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:0)
[    3.062960] IOAPIC[0]: Set routing entry (8-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:0)
[    3.070853] IOAPIC[0]: Set routing entry (8-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:0)
[    3.078748] IOAPIC[0]: Set routing entry (8-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:0)
[    3.086642] IOAPIC[0]: Set routing entry (8-10 -> 0xef -> IRQ 10 Mode:0 =
Active:0 Dest:0)
[    3.094708] IOAPIC[0]: Set routing entry (8-11 -> 0xef -> IRQ 11 Mode:0 =
Active:0 Dest:0)
[    3.102775] IOAPIC[0]: Set routing entry (8-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:0)
[    3.110844] IOAPIC[0]: Set routing entry (8-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:0)
[    3.118919] IOAPIC[0]: Set routing entry (8-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:0)
[    3.126993] IOAPIC[0]: Set routing entry (8-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:0)
[    3.135056]  apic 8 pin 16 not connected
[    3.138975]  apic 8 pin 17 not connected
[    3.142889]  apic 8 pin 18 not connected
[    3.146808]  apic 8 pin 19 not connected
[    3.150723]  apic 8 pin 20 not connected
[    3.154638]  apic 8 pin 21 not connected
[    3.158557]  apic 8 pin 22 not connected
[    3.162472]  apic 8 pin 23 not connected
[    3.166391]  apic 9 pin 0 not connected
[    3.170220]  apic 9 pin 1 not connected
[    3.174049]  apic 9 pin 2 not connected
[    3.177881]  apic 9 pin 3 not connected
[    3.181709]  apic 9 pin 4 not connected
[    3.185541]  apic 9 pin 5 not connected
[    3.189370]  apic 9 pin 6 not connected
[    3.193203]  apic 9 pin 7 not connected
[    3.197031]  apic 10 pin 0 not connected
[    3.200947]  apic 10 pin 1 not connected
[    3.204866]  apic 10 pin 2 not connected
[    3.208782]  apic 10 pin 3 not connected
[    3.212696]  apic 10 pin 4 not connected
[    3.216615]  apic 10 pin 5 not connected
[    3.220530]  apic 10 pin 6 not connected
[    3.224448]  apic 10 pin 7 not connected
[    3.228363]  apic 11 pin 0 not connected
[    3.232282]  apic 11 pin 1 not connected
[    3.236197]  apic 11 pin 2 not connected
[    3.240115]  apic 11 pin 3 not connected
[    3.244030]  apic 11 pin 4 not connected
[    3.247948]  apic 11 pin 5 not connected
[    3.251863]  apic 11 pin 6 not connected
[    3.255782]  apic 11 pin 7 not connected
[    3.259697]  apic 12 pin 0 not connected
[    3.263616]  apic 12 pin 1 not connected
[    3.267531]  apic 12 pin 2 not connected
[    3.271449]  apic 12 pin 3 not connected
[    3.275364]  apic 12 pin 4 not connected
[    3.279282]  apic 12 pin 5 not connected
[    3.283197]  apic 12 pin 6 not connected
[    3.287116]  apic 12 pin 7 not connected
[    3.291031]  apic 15 pin 0 not connected
[    3.294950]  apic 15 pin 1 not connected
[    3.298865]  apic 15 pin 2 not connected
[    3.302783]  apic 15 pin 3 not connected
[    3.306697]  apic 15 pin 4 not connected
[    3.310616]  apic 15 pin 5 not connected
[    3.314531]  apic 15 pin 6 not connected
[    3.318450]  apic 15 pin 7 not connected
[    3.322365]  apic 16 pin 0 not connected
[    3.326283]  apic 16 pin 1 not connected
[    3.330198]  apic 16 pin 2 not connected
[    3.334113]  apic 16 pin 3 not connected
[    3.338032]  apic 16 pin 4 not connected
[    3.341946]  apic 16 pin 5 not connected
[    3.345865]  apic 16 pin 6 not connected
[    3.349783]  apic 16 pin 7 not connected
[    3.353698]  apic 17 pin 0 not connected
[    3.357616]  apic 17 pin 1 not connected
[    3.361531]  apic 17 pin 2 not connected
[    3.365450]  apic 17 pin 3 not connected
[    3.369365]  apic 17 pin 4 not connected
[    3.373280]  apic 17 pin 5 not connected
[    3.377198]  apic 17 pin 6 not connected
[    3.381113]  apic 17 pin 7 not connected
[    3.385032]  apic 18 pin 0 not connected
[    3.388947]  apic 18 pin 1 not connected
[    3.392866]  apic 18 pin 2 not connected
[    3.396782]  apic 18 pin 3 not connected
[    3.400697]  apic 18 pin 4 not connected
[    3.404616]  apic 18 pin 5 not connected
[    3.408531]  apic 18 pin 6 not connected
[    3.412449]  apic 18 pin 7 not connected
[    3.416482] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    3.427322] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x22983777dd9, max_idle_ns: 440795300422 ns
[    3.437814] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4800.00 BogoMIPS (lpj=3D2400000)
[    3.438814] pid_max: default: 98304 minimum: 768
[    3.439982] LSM: Security Framework initializing
[    3.440828] Yama: becoming mindful.
[    3.441852] AppArmor: AppArmor initialized
[    3.454253] Dentry cache hash table entries: 8388608 (order: 14, 6710886=
4 bytes, vmalloc)
[    3.460947] Inode-cache hash table entries: 4194304 (order: 13, 33554432=
 bytes, vmalloc)
[    3.462038] Mount-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, vmalloc)
[    3.462986] Mountpoint-cache hash table entries: 131072 (order: 8, 10485=
76 bytes, vmalloc)
Poking KASLR using RDRAND RDTSC...
[    3.468388] mce: CPU0: Thermal monitoring enabled (TM1)
[    3.468846] process: using mwait in idle threads
[    3.469815] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    3.470813] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    3.471818] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    3.472816] Spectre V2 : Mitigation: Enhanced IBRS
[    3.473813] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    3.474815] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    3.475816] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    3.476813] TAA: Mitigation: TSX disabled
[    3.478135] Freeing SMP alternatives memory: 44K
[    3.481031] smpboot: CPU0: Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz=
 (family: 0x6, model: 0x55, stepping: 0x6)
[    3.482014] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    3.482814] ... version:                4
[    3.483813] ... bit width:              48
[    3.484813] ... generic registers:      4
[    3.485813] ... value mask:             0000ffffffffffff
[    3.486813] ... max period:             00007fffffffffff
[    3.487813] ... fixed-purpose events:   3
[    3.488813] ... event mask:             000000070000000f
[    3.489937] rcu: Hierarchical SRCU implementation.
[    3.498454] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    3.499976] smp: Bringing up secondary CPUs ...
[    3.500906] x86: Booting SMP configuration:
[    3.501814] .... node  #0, CPUs:        #1
[    0.497775] masked ExtINT on CPU#1
[    3.516126]   #2
[    0.497775] masked ExtINT on CPU#2
[    3.524164]   #3
[    0.497775] masked ExtINT on CPU#3
[    3.532298]   #4
[    0.497775] masked ExtINT on CPU#4
[    3.540294]   #5
[    0.497775] masked ExtINT on CPU#5
[    3.548458]   #6
[    0.497775] masked ExtINT on CPU#6
[    3.556936]   #7
[    0.497775] masked ExtINT on CPU#7
[    3.564949]   #8
[    0.497775] masked ExtINT on CPU#8
[    3.572957]   #9
[    0.497775] masked ExtINT on CPU#9
[    3.580948]  #10
[    0.497775] masked ExtINT on CPU#10
[    3.588992]  #11
[    0.497775] masked ExtINT on CPU#11
[    3.597424]  #12
[    0.497775] masked ExtINT on CPU#12
[    3.605924]  #13
[    0.497775] masked ExtINT on CPU#13
[    3.613947]  #14
[    0.497775] masked ExtINT on CPU#14
[    3.622037]  #15
[    0.497775] masked ExtINT on CPU#15
[    3.630155]  #16
[    0.497775] masked ExtINT on CPU#16
[    3.638295]  #17
[    0.497775] masked ExtINT on CPU#17
[    3.646841]  #18
[    0.497775] masked ExtINT on CPU#18
[    3.654955]  #19
[    0.497775] masked ExtINT on CPU#19
[    3.663062]  #20
[    0.497775] masked ExtINT on CPU#20
[    3.671161]  #21
[    0.497775] masked ExtINT on CPU#21
[    3.679223]  #22
[    0.497775] masked ExtINT on CPU#22
[    3.687433]  #23
[    0.497775] masked ExtINT on CPU#23
[    3.696003] .... node  #1, CPUs:   #24
[    0.497775] masked ExtINT on CPU#24
[    0.497775] smpboot: CPU 24 Converting physical 0 to logical die 1
[    3.776940]  #25
[    0.497775] masked ExtINT on CPU#25
[    3.785116]  #26
[    0.497775] masked ExtINT on CPU#26
[    3.793288]  #27
[    0.497775] masked ExtINT on CPU#27
[    3.801478]  #28
[    0.497775] masked ExtINT on CPU#28
[    3.809887]  #29
[    0.497775] masked ExtINT on CPU#29
[    3.817982]  #30
[    0.497775] masked ExtINT on CPU#30
[    3.826373]  #31
[    0.497775] masked ExtINT on CPU#31
[    3.834876]  #32
[    0.497775] masked ExtINT on CPU#32
[    3.842931]  #33
[    0.497775] masked ExtINT on CPU#33
[    3.850942]  #34
[    0.497775] masked ExtINT on CPU#34
[    3.859208]  #35
[    0.497775] masked ExtINT on CPU#35
[    3.867873]  #36
[    0.497775] masked ExtINT on CPU#36
[    3.875967]  #37
[    0.497775] masked ExtINT on CPU#37
[    3.884204]  #38
[    0.497775] masked ExtINT on CPU#38
[    3.892366]  #39
[    0.497775] masked ExtINT on CPU#39
[    3.900561]  #40
[    0.497775] masked ExtINT on CPU#40
[    3.908937]  #41
[    0.497775] masked ExtINT on CPU#41
[    3.917190]  #42
[    0.497775] masked ExtINT on CPU#42
[    3.925484]  #43
[    0.497775] masked ExtINT on CPU#43
[    3.933943]  #44
[    0.497775] masked ExtINT on CPU#44
[    3.941999]  #45
[    0.497775] masked ExtINT on CPU#45
[    3.950139]  #46
[    0.497775] masked ExtINT on CPU#46
[    3.958444]  #47
[    0.497775] masked ExtINT on CPU#47
[    3.966945] .... node  #0, CPUs:   #48
[    0.497775] masked ExtINT on CPU#48
[    3.975170]  #49
[    0.497775] masked ExtINT on CPU#49
[    3.983453]  #50
[    0.497775] masked ExtINT on CPU#50
[    3.991885]  #51
[    0.497775] masked ExtINT on CPU#51
[    3.999961]  #52
[    0.497775] masked ExtINT on CPU#52
[    4.007962]  #53
[    0.497775] masked ExtINT on CPU#53
[    4.016160]  #54
[    0.497775] masked ExtINT on CPU#54
[    4.024522]  #55
[    0.497775] masked ExtINT on CPU#55
[    4.032969]  #56
[    0.497775] masked ExtINT on CPU#56
[    4.040981]  #57
[    0.497775] masked ExtINT on CPU#57
[    4.048963]  #58
[    0.497775] masked ExtINT on CPU#58
[    4.057227]  #59
[    0.497775] masked ExtINT on CPU#59
[    4.065886]  #60
[    0.497775] masked ExtINT on CPU#60
[    4.074012]  #61
[    0.497775] masked ExtINT on CPU#61
[    4.082211]  #62
[    0.497775] masked ExtINT on CPU#62
[    4.090344]  #63
[    0.497775] masked ExtINT on CPU#63
[    4.098494]  #64
[    0.497775] masked ExtINT on CPU#64
[    4.106949]  #65
[    0.497775] masked ExtINT on CPU#65
[    4.115017]  #66
[    0.497775] masked ExtINT on CPU#66
[    4.123277]  #67
[    0.497775] masked ExtINT on CPU#67
[    4.131845]  #68
[    0.497775] masked ExtINT on CPU#68
[    4.139969]  #69
[    0.497775] masked ExtINT on CPU#69
[    4.147971]  #70
[    0.497775] masked ExtINT on CPU#70
[    4.156066]  #71
[    0.497775] masked ExtINT on CPU#71
[    4.164427] .... node  #1, CPUs:   #72
[    0.497775] masked ExtINT on CPU#72
[    4.174948]  #73
[    0.497775] masked ExtINT on CPU#73
[    4.183073]  #74
[    0.497775] masked ExtINT on CPU#74
[    4.191295]  #75
[    0.497775] masked ExtINT on CPU#75
[    4.199542]  #76
[    0.497775] masked ExtINT on CPU#76
[    4.207949]  #77
[    0.497775] masked ExtINT on CPU#77
[    4.216137]  #78
[    0.497775] masked ExtINT on CPU#78
[    4.224869]  #79
[    0.497775] masked ExtINT on CPU#79
[    4.232958]  #80
[    0.497775] masked ExtINT on CPU#80
[    4.241061]  #81
[    0.497775] masked ExtINT on CPU#81
[    4.249285]  #82
[    0.497775] masked ExtINT on CPU#82
[    4.257912]  #83
[    0.497775] masked ExtINT on CPU#83
[    4.266088]  #84
[    0.497775] masked ExtINT on CPU#84
[    4.274480]  #85
[    0.497775] masked ExtINT on CPU#85
[    4.282937]  #86
[    0.497775] masked ExtINT on CPU#86
[    4.290963]  #87
[    0.497775] masked ExtINT on CPU#87
[    4.299209]  #88
[    0.497775] masked ExtINT on CPU#88
[    4.307463]  #89
[    0.497775] masked ExtINT on CPU#89
[    4.315965]  #90
[    0.497775] masked ExtINT on CPU#90
[    4.324278]  #91
[    0.497775] masked ExtINT on CPU#91
[    4.332934]  #92
[    0.497775] masked ExtINT on CPU#92
[    4.340969]  #93
[    0.497775] masked ExtINT on CPU#93
[    4.349078]  #94
[    0.497775] masked ExtINT on CPU#94
[    4.357437]  #95
[    0.497775] masked ExtINT on CPU#95
[    4.365964] smp: Brought up 2 nodes, 96 CPUs
[    4.366815] smpboot: Max logical packages: 2
[    4.367817] smpboot: Total of 96 processors activated (461070.14 BogoMIP=
S)
[    4.401972] node 1 deferred pages initialised in 30ms
[    4.402877] node 0 deferred pages initialised in 30ms
[    4.418356] devtmpfs: initialized
[    4.418860] x86/mm: Memory block size: 2048MB
[    4.420504] PM: Registering ACPI NVS region [mem 0x68056000-0x68a85fff] =
(10682368 bytes)
[    4.421225] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    4.421889] futex hash table entries: 32768 (order: 9, 2097152 bytes, vm=
alloc)
[    4.424395] pinctrl core: initialized pinctrl subsystem
[    4.424852] thermal_sys: Registered thermal governor 'fair_share'
[    4.424853] thermal_sys: Registered thermal governor 'bang_bang'
[    4.425813] thermal_sys: Registered thermal governor 'step_wise'
[    4.426813] thermal_sys: Registered thermal governor 'user_space'
[    4.428138] NET: Registered protocol family 16
[    4.430027] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    4.430821] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    4.431822] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    4.432819] audit: initializing netlink subsys (disabled)
[    4.433834] audit: type=3D2000 audit(1421187173.006:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    4.441816] cpuidle: using governor menu
[    4.442818] Detected 1 PCC Subspaces
[    4.443832] Registering PCC driver as Mailbox controller
[    4.444910] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    4.452815] ACPI: bus type PCI registered
[    4.456814] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    4.463112] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000=
-0x8fffffff] (base 0x80000000)
[    4.472859] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    4.479831] pmd_set_huge: Cannot satisfy [mem 0x80000000-0x80200000] wit=
h a huge-page mapping due to MTRR override.
[    4.490072] PCI: Using configuration type 1 for base access
[    4.501838] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    4.507816] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    4.515943] cryptd: max_cpu_qlen set to 1000
[    4.522110] ACPI: Added _OSI(Module Device)
[    4.525814] ACPI: Added _OSI(Processor Device)
[    4.530813] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.535813] ACPI: Added _OSI(Processor Aggregator Device)
[    4.540814] ACPI: Added _OSI(Linux-Dell-Video)
[    4.544813] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    4.550813] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    4.612008] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    4.622471] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    4.647045] ACPI: Dynamic OEM Table Load:
[    4.670461] ACPI: Dynamic OEM Table Load:
[    4.688365] ACPI: Dynamic OEM Table Load:
[    4.722519] ACPI: Dynamic OEM Table Load:
[    4.844879] ACPI: Interpreter enabled
[    4.848828] ACPI: (supports S0 S5)
[    4.851814] ACPI: Using IOAPIC for interrupt routing
[    4.856868] HEST: Table parsing has been initialized.
[    4.861814] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    4.871707] ACPI: Enabled 7 GPEs in block 00 to 7F
[    4.918961] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
[    4.924818] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    4.933871] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplu=
g AER LTR]
[    4.941863] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    4.949814] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    4.959007] PCI host bridge to bus 0000:00
[    4.962814] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    4.969814] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    4.976814] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    4.983814] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7ff=
f window]
[    4.991814] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010ff=
f window]
[    4.998814] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9d7ffff=
f window]
[    5.005814] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x383=
fffffffff window]
[    5.014814] pci_bus 0000:00: root bus resource [bus 00-16]
[    5.019822] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    5.026369] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
[    5.032825] pci 0000:00:04.0: reg 0x10: [mem 0x383ffff2c000-0x383ffff2ff=
ff 64bit]
[    5.040321] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
[    5.046823] pci 0000:00:04.1: reg 0x10: [mem 0x383ffff28000-0x383ffff2bf=
ff 64bit]
[    5.054322] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
[    5.059823] pci 0000:00:04.2: reg 0x10: [mem 0x383ffff24000-0x383ffff27f=
ff 64bit]
[    5.068320] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
[    5.073823] pci 0000:00:04.3: reg 0x10: [mem 0x383ffff20000-0x383ffff23f=
ff 64bit]
[    5.082318] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
[    5.087823] pci 0000:00:04.4: reg 0x10: [mem 0x383ffff1c000-0x383ffff1ff=
ff 64bit]
[    5.096318] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
[    5.101823] pci 0000:00:04.5: reg 0x10: [mem 0x383ffff18000-0x383ffff1bf=
ff 64bit]
[    5.110320] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
[    5.115823] pci 0000:00:04.6: reg 0x10: [mem 0x383ffff14000-0x383ffff17f=
ff 64bit]
[    5.124318] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
[    5.129823] pci 0000:00:04.7: reg 0x10: [mem 0x383ffff10000-0x383ffff13f=
ff 64bit]
[    5.138319] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    5.144314] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    5.151304] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    5.156821] pci 0000:00:05.4: reg 0x10: [mem 0x9220a000-0x9220afff]
[    5.163307] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    5.170299] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    5.176280] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    5.183302] pci 0000:00:11.0: [8086:a1ec] type 00 class 0xff0000
[    5.190001] pci 0000:00:11.1: [8086:a1ed] type 00 class 0xff0000
[    5.196333] pci 0000:00:11.5: [8086:a1d2] type 00 class 0x010601
[    5.201830] pci 0000:00:11.5: reg 0x10: [mem 0x92206000-0x92207fff]
[    5.208820] pci 0000:00:11.5: reg 0x14: [mem 0x92209000-0x922090ff]
[    5.214819] pci 0000:00:11.5: reg 0x18: [io  0x3068-0x306f]
[    5.219819] pci 0000:00:11.5: reg 0x1c: [io  0x3074-0x3077]
[    5.225819] pci 0000:00:11.5: reg 0x20: [io  0x3040-0x305f]
[    5.231819] pci 0000:00:11.5: reg 0x24: [mem 0x92180000-0x921fffff]
[    5.237849] pci 0000:00:11.5: PME# supported from D3hot
[    5.243333] pci 0000:00:14.0: [8086:a1af] type 00 class 0x0c0330
[    5.249834] pci 0000:00:14.0: reg 0x10: [mem 0x383ffff00000-0x383ffff0ff=
ff 64bit]
[    5.256873] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    5.263318] pci 0000:00:14.2: [8086:a1b1] type 00 class 0x118000
[    5.268833] pci 0000:00:14.2: reg 0x10: [mem 0x383ffff33000-0x383ffff33f=
ff 64bit]
[    5.277356] pci 0000:00:16.0: [8086:a1ba] type 00 class 0x078000
[    5.282840] pci 0000:00:16.0: reg 0x10: [mem 0x383ffff32000-0x383ffff32f=
ff 64bit]
[    5.290893] pci 0000:00:16.0: PME# supported from D3hot
[    5.296305] pci 0000:00:16.4: [8086:a1be] type 00 class 0x078000
[    5.302840] pci 0000:00:16.4: reg 0x10: [mem 0x383ffff31000-0x383ffff31f=
ff 64bit]
[    5.309893] pci 0000:00:16.4: PME# supported from D3hot
[    5.315298] pci 0000:00:17.0: [8086:a182] type 00 class 0x010601
[    5.321830] pci 0000:00:17.0: reg 0x10: [mem 0x92204000-0x92205fff]
[    5.327819] pci 0000:00:17.0: reg 0x14: [mem 0x92208000-0x922080ff]
[    5.333820] pci 0000:00:17.0: reg 0x18: [io  0x3060-0x3067]
[    5.339819] pci 0000:00:17.0: reg 0x1c: [io  0x3070-0x3073]
[    5.344819] pci 0000:00:17.0: reg 0x20: [io  0x3020-0x303f]
[    5.350819] pci 0000:00:17.0: reg 0x24: [mem 0x92100000-0x9217ffff]
[    5.356848] pci 0000:00:17.0: PME# supported from D3hot
[    5.362319] pci 0000:00:1c.0: [8086:a193] type 01 class 0x060400
[    5.368883] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    5.375353] pci 0000:00:1f.0: [8086:a1c3] type 00 class 0x060100
[    5.382371] pci 0000:00:1f.2: [8086:a1a1] type 00 class 0x058000
[    5.387826] pci 0000:00:1f.2: reg 0x10: [mem 0x92200000-0x92203fff]
[    5.394335] pci 0000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
[    5.400832] pci 0000:00:1f.4: reg 0x10: [mem 0x383ffff30000-0x383ffff300=
ff 64bit]
[    5.407834] pci 0000:00:1f.4: reg 0x20: [io  0x3000-0x301f]
[    5.414300] pci 0000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
[    5.419828] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    5.427377] pci 0000:01:00.0: [1a03:1150] type 01 class 0x060400
[    5.432926] pci 0000:01:00.0: supports D1 D2
[    5.437814] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    5.443894] pci 0000:00:1c.0: PCI bridge to [bus 01-02]
[    5.448815] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    5.455816] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x920fffff]
[    5.461850] pci_bus 0000:02: extended config space not accessible
[    5.467831] pci 0000:02:00.0: [1a03:2000] type 00 class 0x030000
[    5.473833] pci 0000:02:00.0: reg 0x10: [mem 0x91000000-0x91ffffff]
[    5.480824] pci 0000:02:00.0: reg 0x14: [mem 0x92000000-0x9201ffff]
[    5.486824] pci 0000:02:00.0: reg 0x18: [io  0x2000-0x207f]
[    5.491898] pci 0000:02:00.0: supports D1 D2
[    5.496814] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    5.502894] pci 0000:01:00.0: PCI bridge to [bus 02]
[    5.507818] pci 0000:01:00.0:   bridge window [io  0x2000-0x2fff]
[    5.514816] pci 0000:01:00.0:   bridge window [mem 0x91000000-0x920fffff]
[    5.520829] pci_bus 0000:00: on NUMA node 0
[    5.525054] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 1=
5), disabled.
[    5.533870] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 1=
5), disabled.
[    5.540868] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 1=
5), disabled.
[    5.548867] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5), disabled.
[    5.556867] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5), disabled.
[    5.564867] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5), disabled.
[    5.572867] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 1=
5), disabled.
[    5.580869] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 1=
5), disabled.
[    5.588064] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 17-39])
[    5.594816] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    5.604093] acpi PNP0A08:01: _OSC: platform does not support [SHPCHotplu=
g AER LTR]
[    5.611966] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    5.618814] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    5.627993] PCI host bridge to bus 0000:17
[    5.631814] pci_bus 0000:17: root bus resource [io  0x4000-0x5fff window]
[    5.638814] pci_bus 0000:17: root bus resource [mem 0x9d800000-0xaafffff=
f window]
[    5.645814] pci_bus 0000:17: root bus resource [mem 0x384000000000-0x387=
fffffffff window]
[    5.653814] pci_bus 0000:17: root bus resource [bus 17-39]
[    5.659821] pci 0000:17:00.0: [8086:2030] type 01 class 0x060400
[    5.665870] pci 0000:17:00.0: PME# supported from D0 D3hot D3cold
[    5.671914] pci 0000:17:05.0: [8086:2034] type 00 class 0x088000
[    5.677907] pci 0000:17:05.2: [8086:2035] type 00 class 0x088000
[    5.683903] pci 0000:17:05.4: [8086:2036] type 00 class 0x080020
[    5.689821] pci 0000:17:05.4: reg 0x10: [mem 0x9dd00000-0x9dd00fff]
[    5.695906] pci 0000:17:08.0: [8086:208d] type 00 class 0x088000
[    5.701892] pci 0000:17:08.1: [8086:208d] type 00 class 0x088000
[    5.707879] pci 0000:17:08.2: [8086:208d] type 00 class 0x088000
[    5.713879] pci 0000:17:08.3: [8086:208d] type 00 class 0x088000
[    5.720880] pci 0000:17:08.4: [8086:208d] type 00 class 0x088000
[    5.726878] pci 0000:17:08.5: [8086:208d] type 00 class 0x088000
[    5.732879] pci 0000:17:08.6: [8086:208d] type 00 class 0x088000
[    5.738880] pci 0000:17:08.7: [8086:208d] type 00 class 0x088000
[    5.744879] pci 0000:17:09.0: [8086:208d] type 00 class 0x088000
[    5.750892] pci 0000:17:09.1: [8086:208d] type 00 class 0x088000
[    5.756880] pci 0000:17:09.2: [8086:208d] type 00 class 0x088000
[    5.762880] pci 0000:17:09.3: [8086:208d] type 00 class 0x088000
[    5.768880] pci 0000:17:09.4: [8086:208d] type 00 class 0x088000
[    5.774880] pci 0000:17:09.5: [8086:208d] type 00 class 0x088000
[    5.780880] pci 0000:17:09.6: [8086:208d] type 00 class 0x088000
[    5.786881] pci 0000:17:09.7: [8086:208d] type 00 class 0x088000
[    5.792880] pci 0000:17:0a.0: [8086:208d] type 00 class 0x088000
[    5.798892] pci 0000:17:0a.1: [8086:208d] type 00 class 0x088000
[    5.804883] pci 0000:17:0a.2: [8086:208d] type 00 class 0x088000
[    5.810879] pci 0000:17:0a.3: [8086:208d] type 00 class 0x088000
[    5.816880] pci 0000:17:0a.4: [8086:208d] type 00 class 0x088000
[    5.822881] pci 0000:17:0a.5: [8086:208d] type 00 class 0x088000
[    5.828882] pci 0000:17:0a.6: [8086:208d] type 00 class 0x088000
[    5.834883] pci 0000:17:0a.7: [8086:208d] type 00 class 0x088000
[    5.841881] pci 0000:17:0b.0: [8086:208d] type 00 class 0x088000
[    5.847890] pci 0000:17:0b.1: [8086:208d] type 00 class 0x088000
[    5.853884] pci 0000:17:0b.2: [8086:208d] type 00 class 0x088000
[    5.859883] pci 0000:17:0b.3: [8086:208d] type 00 class 0x088000
[    5.865885] pci 0000:17:0e.0: [8086:208e] type 00 class 0x088000
[    5.871890] pci 0000:17:0e.1: [8086:208e] type 00 class 0x088000
[    5.877882] pci 0000:17:0e.2: [8086:208e] type 00 class 0x088000
[    5.883882] pci 0000:17:0e.3: [8086:208e] type 00 class 0x088000
[    5.889881] pci 0000:17:0e.4: [8086:208e] type 00 class 0x088000
[    5.895880] pci 0000:17:0e.5: [8086:208e] type 00 class 0x088000
[    5.901879] pci 0000:17:0e.6: [8086:208e] type 00 class 0x088000
[    5.907880] pci 0000:17:0e.7: [8086:208e] type 00 class 0x088000
[    5.913880] pci 0000:17:0f.0: [8086:208e] type 00 class 0x088000
[    5.919892] pci 0000:17:0f.1: [8086:208e] type 00 class 0x088000
[    5.925881] pci 0000:17:0f.2: [8086:208e] type 00 class 0x088000
[    5.931881] pci 0000:17:0f.3: [8086:208e] type 00 class 0x088000
[    5.937880] pci 0000:17:0f.4: [8086:208e] type 00 class 0x088000
[    5.943880] pci 0000:17:0f.5: [8086:208e] type 00 class 0x088000
[    5.949880] pci 0000:17:0f.6: [8086:208e] type 00 class 0x088000
[    5.956881] pci 0000:17:0f.7: [8086:208e] type 00 class 0x088000
[    5.962880] pci 0000:17:10.0: [8086:208e] type 00 class 0x088000
[    5.968892] pci 0000:17:10.1: [8086:208e] type 00 class 0x088000
[    5.974884] pci 0000:17:10.2: [8086:208e] type 00 class 0x088000
[    5.980897] pci 0000:17:10.3: [8086:208e] type 00 class 0x088000
[    5.986882] pci 0000:17:10.4: [8086:208e] type 00 class 0x088000
[    5.992882] pci 0000:17:10.5: [8086:208e] type 00 class 0x088000
[    5.998882] pci 0000:17:10.6: [8086:208e] type 00 class 0x088000
[    6.004883] pci 0000:17:10.7: [8086:208e] type 00 class 0x088000
[    6.010882] pci 0000:17:11.0: [8086:208e] type 00 class 0x088000
[    6.016896] pci 0000:17:11.1: [8086:208e] type 00 class 0x088000
[    6.022882] pci 0000:17:11.2: [8086:208e] type 00 class 0x088000
[    6.028883] pci 0000:17:11.3: [8086:208e] type 00 class 0x088000
[    6.034892] pci 0000:17:1d.0: [8086:2054] type 00 class 0x088000
[    6.040894] pci 0000:17:1d.1: [8086:2055] type 00 class 0x088000
[    6.046882] pci 0000:17:1d.2: [8086:2056] type 00 class 0x088000
[    6.052881] pci 0000:17:1d.3: [8086:2057] type 00 class 0x088000
[    6.058884] pci 0000:17:1e.0: [8086:2080] type 00 class 0x088000
[    6.064893] pci 0000:17:1e.1: [8086:2081] type 00 class 0x088000
[    6.071883] pci 0000:17:1e.2: [8086:2082] type 00 class 0x088000
[    6.077883] pci 0000:17:1e.3: [8086:2083] type 00 class 0x088000
[    6.083930] pci 0000:17:1e.4: [8086:2084] type 00 class 0x088000
[    6.089883] pci 0000:17:1e.5: [8086:2085] type 00 class 0x088000
[    6.095881] pci 0000:17:1e.6: [8086:2086] type 00 class 0x088000
[    6.101915] pci 0000:18:00.0: [8086:1521] type 00 class 0x020000
[    6.107832] pci 0000:18:00.0: reg 0x10: [mem 0x9db00000-0x9dbfffff]
[    6.113831] pci 0000:18:00.0: reg 0x1c: [mem 0x9dc0c000-0x9dc0ffff]
[    6.119894] pci 0000:18:00.0: PME# supported from D0 D3hot D3cold
[    6.126839] pci 0000:18:00.0: reg 0x184: [mem 0x387ffffe0000-0x387ffffe3=
fff 64bit pref]
[    6.134814] pci 0000:18:00.0: VF(n) BAR0 space: [mem 0x387ffffe0000-0x38=
7fffffffff 64bit pref] (contains BAR0 for 8 VFs)
[    6.144827] pci 0000:18:00.0: reg 0x190: [mem 0x387ffffc0000-0x387ffffc3=
fff 64bit pref]
[    6.152814] pci 0000:18:00.0: VF(n) BAR3 space: [mem 0x387ffffc0000-0x38=
7ffffdffff 64bit pref] (contains BAR3 for 8 VFs)
[    6.163901] pci 0000:18:00.1: [8086:1521] type 00 class 0x020000
[    6.169831] pci 0000:18:00.1: reg 0x10: [mem 0x9da00000-0x9dafffff]
[    6.175830] pci 0000:18:00.1: reg 0x1c: [mem 0x9dc08000-0x9dc0bfff]
[    6.182890] pci 0000:18:00.1: PME# supported from D0 D3hot D3cold
[    6.188835] pci 0000:18:00.1: reg 0x184: [mem 0x387ffffa0000-0x387ffffa3=
fff 64bit pref]
[    6.196814] pci 0000:18:00.1: VF(n) BAR0 space: [mem 0x387ffffa0000-0x38=
7ffffbffff 64bit pref] (contains BAR0 for 8 VFs)
[    6.207826] pci 0000:18:00.1: reg 0x190: [mem 0x387ffff80000-0x387ffff83=
fff 64bit pref]
[    6.215814] pci 0000:18:00.1: VF(n) BAR3 space: [mem 0x387ffff80000-0x38=
7ffff9ffff 64bit pref] (contains BAR3 for 8 VFs)
[    6.225896] pci 0000:18:00.2: [8086:1521] type 00 class 0x020000
[    6.232831] pci 0000:18:00.2: reg 0x10: [mem 0x9d900000-0x9d9fffff]
[    6.238830] pci 0000:18:00.2: reg 0x1c: [mem 0x9dc04000-0x9dc07fff]
[    6.244889] pci 0000:18:00.2: PME# supported from D0 D3hot D3cold
[    6.250835] pci 0000:18:00.2: reg 0x184: [mem 0x387ffff60000-0x387ffff63=
fff 64bit pref]
[    6.258814] pci 0000:18:00.2: VF(n) BAR0 space: [mem 0x387ffff60000-0x38=
7ffff7ffff 64bit pref] (contains BAR0 for 8 VFs)
[    6.269826] pci 0000:18:00.2: reg 0x190: [mem 0x387ffff40000-0x387ffff43=
fff 64bit pref]
[    6.277814] pci 0000:18:00.2: VF(n) BAR3 space: [mem 0x387ffff40000-0x38=
7ffff5ffff 64bit pref] (contains BAR3 for 8 VFs)
[    6.288890] pci 0000:18:00.3: [8086:1521] type 00 class 0x020000
[    6.294831] pci 0000:18:00.3: reg 0x10: [mem 0x9d800000-0x9d8fffff]
[    6.300830] pci 0000:18:00.3: reg 0x1c: [mem 0x9dc00000-0x9dc03fff]
[    6.306889] pci 0000:18:00.3: PME# supported from D0 D3hot D3cold
[    6.313835] pci 0000:18:00.3: reg 0x184: [mem 0x387ffff20000-0x387ffff23=
fff 64bit pref]
[    6.321814] pci 0000:18:00.3: VF(n) BAR0 space: [mem 0x387ffff20000-0x38=
7ffff3ffff 64bit pref] (contains BAR0 for 8 VFs)
[    6.331826] pci 0000:18:00.3: reg 0x190: [mem 0x387ffff00000-0x387ffff03=
fff 64bit pref]
[    6.339814] pci 0000:18:00.3: VF(n) BAR3 space: [mem 0x387ffff00000-0x38=
7ffff1ffff 64bit pref] (contains BAR3 for 8 VFs)
[    6.350909] pci 0000:17:00.0: PCI bridge to [bus 18-19]
[    6.355815] pci 0000:17:00.0:   bridge window [mem 0x9d800000-0x9dcfffff]
[    6.362815] pci 0000:17:00.0:   bridge window [mem 0x387ffff00000-0x387f=
ffffffff 64bit pref]
[    6.371820] pci_bus 0000:17: on NUMA node 0
[    6.375907] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 3a-5c])
[    6.381817] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    6.391099] acpi PNP0A08:02: _OSC: platform does not support [SHPCHotplu=
g AER LTR]
[    6.398964] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    6.406814] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    6.414931] PCI host bridge to bus 0000:3a
[    6.418814] pci_bus 0000:3a: root bus resource [io  0x6000-0x7fff window]
[    6.425814] pci_bus 0000:3a: root bus resource [mem 0xab000000-0xb87ffff=
f window]
[    6.432814] pci_bus 0000:3a: root bus resource [mem 0x388000000000-0x38b=
fffffffff window]
[    6.440814] pci_bus 0000:3a: root bus resource [bus 3a-5c]
[    6.446821] pci 0000:3a:00.0: [8086:2030] type 01 class 0x060400
[    6.452867] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
[    6.458887] pci 0000:3a:05.0: [8086:2034] type 00 class 0x088000
[    6.464881] pci 0000:3a:05.2: [8086:2035] type 00 class 0x088000
[    6.470879] pci 0000:3a:05.4: [8086:2036] type 00 class 0x080020
[    6.476821] pci 0000:3a:05.4: reg 0x10: [mem 0xadb00000-0xadb00fff]
[    6.482884] pci 0000:3a:08.0: [8086:2066] type 00 class 0x088000
[    6.488881] pci 0000:3a:09.0: [8086:2066] type 00 class 0x088000
[    6.494881] pci 0000:3a:0a.0: [8086:2040] type 00 class 0x088000
[    6.500881] pci 0000:3a:0a.1: [8086:2041] type 00 class 0x088000
[    6.506870] pci 0000:3a:0a.2: [8086:2042] type 00 class 0x088000
[    6.513870] pci 0000:3a:0a.3: [8086:2043] type 00 class 0x088000
[    6.519870] pci 0000:3a:0a.4: [8086:2044] type 00 class 0x088000
[    6.525870] pci 0000:3a:0a.5: [8086:2045] type 00 class 0x088000
[    6.531869] pci 0000:3a:0a.6: [8086:2046] type 00 class 0x088000
[    6.537869] pci 0000:3a:0a.7: [8086:2047] type 00 class 0x088000
[    6.543869] pci 0000:3a:0b.0: [8086:2048] type 00 class 0x088000
[    6.549883] pci 0000:3a:0b.1: [8086:2049] type 00 class 0x088000
[    6.555869] pci 0000:3a:0b.2: [8086:204a] type 00 class 0x088000
[    6.561869] pci 0000:3a:0b.3: [8086:204b] type 00 class 0x088000
[    6.567870] pci 0000:3a:0c.0: [8086:2040] type 00 class 0x088000
[    6.573883] pci 0000:3a:0c.1: [8086:2041] type 00 class 0x088000
[    6.579872] pci 0000:3a:0c.2: [8086:2042] type 00 class 0x088000
[    6.585871] pci 0000:3a:0c.3: [8086:2043] type 00 class 0x088000
[    6.591872] pci 0000:3a:0c.4: [8086:2044] type 00 class 0x088000
[    6.597873] pci 0000:3a:0c.5: [8086:2045] type 00 class 0x088000
[    6.603870] pci 0000:3a:0c.6: [8086:2046] type 00 class 0x088000
[    6.609871] pci 0000:3a:0c.7: [8086:2047] type 00 class 0x088000
[    6.615872] pci 0000:3a:0d.0: [8086:2048] type 00 class 0x088000
[    6.621884] pci 0000:3a:0d.1: [8086:2049] type 00 class 0x088000
[    6.627871] pci 0000:3a:0d.2: [8086:204a] type 00 class 0x088000
[    6.633871] pci 0000:3a:0d.3: [8086:204b] type 00 class 0x088000
[    6.639910] pci 0000:3b:00.0: [8086:37c0] type 01 class 0x060400
[    6.645830] pci 0000:3b:00.0: reg 0x10: [mem 0xada00000-0xada1ffff 64bit]
[    6.652818] pci 0000:3b:00.0: reg 0x38: [mem 0xfff00000-0xffffffff pref]
[    6.659858] pci 0000:3b:00.0: PME# supported from D0 D3hot D3cold
[    6.665884] pci 0000:3a:00.0: PCI bridge to [bus 3b-3e]
[    6.670816] pci 0000:3a:00.0:   bridge window [mem 0xada00000-0xadafffff]
[    6.677816] pci 0000:3a:00.0:   bridge window [mem 0xab000000-0xad9fffff=
 64bit pref]
[    6.685862] pci 0000:3c:03.0: [8086:37c5] type 01 class 0x060400
[    6.691890] pci 0000:3c:03.0: PME# supported from D0 D3hot D3cold
[    6.697888] pci 0000:3b:00.0: PCI bridge to [bus 3c-3e]
[    6.702819] pci 0000:3b:00.0:   bridge window [mem 0xab000000-0xad9fffff=
 64bit pref]
[    6.710862] pci 0000:3d:00.0: [8086:37d2] type 00 class 0x020000
[    6.716835] pci 0000:3d:00.0: reg 0x10: [mem 0xac000000-0xacffffff 64bit=
 pref]
[    6.723830] pci 0000:3d:00.0: reg 0x1c: [mem 0xad808000-0xad80ffff 64bit=
 pref]
[    6.730826] pci 0000:3d:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    6.737877] pci 0000:3d:00.0: PME# supported from D0 D3hot D3cold
[    6.743840] pci 0000:3d:00.0: reg 0x184: [mem 0xad400000-0xad41ffff 64bi=
t pref]
[    6.751814] pci 0000:3d:00.0: VF(n) BAR0 space: [mem 0xad400000-0xad7fff=
ff 64bit pref] (contains BAR0 for 32 VFs)
[    6.761827] pci 0000:3d:00.0: reg 0x190: [mem 0xad890000-0xad893fff 64bi=
t pref]
[    6.768814] pci 0000:3d:00.0: VF(n) BAR3 space: [mem 0xad890000-0xad90ff=
ff 64bit pref] (contains BAR3 for 32 VFs)
[    6.778964] pci 0000:3d:00.1: [8086:37d2] type 00 class 0x020000
[    6.784835] pci 0000:3d:00.1: reg 0x10: [mem 0xab000000-0xabffffff 64bit=
 pref]
[    6.792829] pci 0000:3d:00.1: reg 0x1c: [mem 0xad800000-0xad807fff 64bit=
 pref]
[    6.799826] pci 0000:3d:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    6.806877] pci 0000:3d:00.1: PME# supported from D0 D3hot D3cold
[    6.812836] pci 0000:3d:00.1: reg 0x184: [mem 0xad000000-0xad01ffff 64bi=
t pref]
[    6.819814] pci 0000:3d:00.1: VF(n) BAR0 space: [mem 0xad000000-0xad3fff=
ff 64bit pref] (contains BAR0 for 32 VFs)
[    6.829827] pci 0000:3d:00.1: reg 0x190: [mem 0xad810000-0xad813fff 64bi=
t pref]
[    6.836814] pci 0000:3d:00.1: VF(n) BAR3 space: [mem 0xad810000-0xad88ff=
ff 64bit pref] (contains BAR3 for 32 VFs)
[    6.847968] pci 0000:3c:03.0: PCI bridge to [bus 3d-3e]
[    6.852820] pci 0000:3c:03.0:   bridge window [mem 0xab000000-0xad9fffff=
 64bit pref]
[    6.860826] pci_bus 0000:3a: on NUMA node 0
[    6.864896] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus 5d-7f])
[    6.870815] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    6.880091] acpi PNP0A08:03: _OSC: platform does not support [SHPCHotplu=
g AER LTR]
[    6.887967] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    6.895814] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    6.903944] PCI host bridge to bus 0000:5d
[    6.907815] pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
[    6.914814] pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5fffff=
f window]
[    6.921820] pci_bus 0000:5d: root bus resource [mem 0x38c000000000-0x38f=
fffffffff window]
[    6.929814] pci_bus 0000:5d: root bus resource [bus 5d-7f]
[    6.935822] pci 0000:5d:02.0: [8086:2032] type 01 class 0x060400
[    6.941886] pci 0000:5d:02.0: PME# supported from D0 D3hot D3cold
[    6.947888] pci 0000:5d:03.0: [8086:2033] type 01 class 0x060400
[    6.953884] pci 0000:5d:03.0: PME# supported from D0 D3hot D3cold
[    6.959882] pci 0000:5d:05.0: [8086:2034] type 00 class 0x088000
[    6.965886] pci 0000:5d:05.2: [8086:2035] type 00 class 0x088000
[    6.971883] pci 0000:5d:05.4: [8086:2036] type 00 class 0x080020
[    6.977822] pci 0000:5d:05.4: reg 0x10: [mem 0xb8800000-0xb8800fff]
[    6.984889] pci 0000:5d:0e.0: [8086:2058] type 00 class 0x110100
[    6.990879] pci 0000:5d:0e.1: [8086:2059] type 00 class 0x088000
[    6.996870] pci 0000:5d:0f.0: [8086:2058] type 00 class 0x110100
[    7.002881] pci 0000:5d:0f.1: [8086:2059] type 00 class 0x088000
[    7.008872] pci 0000:5d:10.0: [8086:2058] type 00 class 0x110100
[    7.014882] pci 0000:5d:10.1: [8086:2059] type 00 class 0x088000
[    7.020872] pci 0000:5d:12.0: [8086:204c] type 00 class 0x110100
[    7.026876] pci 0000:5d:12.1: [8086:204d] type 00 class 0x110100
[    7.032857] pci 0000:5d:12.2: [8086:204e] type 00 class 0x088000
[    7.038860] pci 0000:5d:12.4: [8086:204c] type 00 class 0x110100
[    7.044867] pci 0000:5d:12.5: [8086:204d] type 00 class 0x110100
[    7.050858] pci 0000:5d:15.0: [8086:2018] type 00 class 0x088000
[    7.056865] pci 0000:5d:15.1: [8086:2088] type 00 class 0x110100
[    7.062858] pci 0000:5d:16.0: [8086:2018] type 00 class 0x088000
[    7.068866] pci 0000:5d:16.1: [8086:2088] type 00 class 0x110100
[    7.074857] pci 0000:5d:16.4: [8086:2018] type 00 class 0x088000
[    7.080865] pci 0000:5d:16.5: [8086:2088] type 00 class 0x110100
[    7.086856] pci 0000:5d:17.0: [8086:2018] type 00 class 0x088000
[    7.092867] pci 0000:5d:17.1: [8086:2088] type 00 class 0x110100
[    7.098884] pci 0000:5d:02.0: PCI bridge to [bus 5e]
[    7.103815] pci 0000:5d:02.0:   bridge window [io  0x8000-0x8fff]
[    7.110815] pci 0000:5d:02.0:   bridge window [mem 0xb8900000-0xb8afffff]
[    7.116816] pci 0000:5d:02.0:   bridge window [mem 0x38c000000000-0x38c0=
001fffff 64bit pref]
[    7.125837] pci 0000:5d:03.0: PCI bridge to [bus 5f]
[    7.130815] pci 0000:5d:03.0:   bridge window [io  0x9000-0x9fff]
[    7.136815] pci 0000:5d:03.0:   bridge window [mem 0xb8b00000-0xb8cfffff]
[    7.142815] pci 0000:5d:03.0:   bridge window [mem 0x38c000200000-0x38c0=
003fffff 64bit pref]
[    7.151822] pci_bus 0000:5d: on NUMA node 0
[    7.155925] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus 80-84])
[    7.161815] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    7.170970] acpi PNP0A08:06: _OSC: platform does not support [SHPCHotplu=
g AER LTR]
[    7.178925] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    7.186814] acpi PNP0A08:06: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    7.194920] PCI host bridge to bus 0000:80
[    7.198814] pci_bus 0000:80: root bus resource [io  0xa000-0xbfff window]
[    7.205814] pci_bus 0000:80: root bus resource [mem 0xc6000000-0xd37ffff=
f window]
[    7.212814] pci_bus 0000:80: root bus resource [mem 0x390000000000-0x393=
fffffffff window]
[    7.220814] pci_bus 0000:80: root bus resource [bus 80-84]
[    7.226827] pci 0000:80:00.0: [8086:2030] type 01 class 0x060400
[    7.232836] pci 0000:80:00.0: enabling Extended Tags
[    7.237840] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    7.243884] pci 0000:80:04.0: [8086:2021] type 00 class 0x088000
[    7.249822] pci 0000:80:04.0: reg 0x10: [mem 0x393ffff1c000-0x393ffff1ff=
ff 64bit]
[    7.256892] pci 0000:80:04.1: [8086:2021] type 00 class 0x088000
[    7.263822] pci 0000:80:04.1: reg 0x10: [mem 0x393ffff18000-0x393ffff1bf=
ff 64bit]
[    7.270890] pci 0000:80:04.2: [8086:2021] type 00 class 0x088000
[    7.276822] pci 0000:80:04.2: reg 0x10: [mem 0x393ffff14000-0x393ffff17f=
ff 64bit]
[    7.284890] pci 0000:80:04.3: [8086:2021] type 00 class 0x088000
[    7.290822] pci 0000:80:04.3: reg 0x10: [mem 0x393ffff10000-0x393ffff13f=
ff 64bit]
[    7.297888] pci 0000:80:04.4: [8086:2021] type 00 class 0x088000
[    7.303823] pci 0000:80:04.4: reg 0x10: [mem 0x393ffff0c000-0x393ffff0ff=
ff 64bit]
[    7.311890] pci 0000:80:04.5: [8086:2021] type 00 class 0x088000
[    7.317822] pci 0000:80:04.5: reg 0x10: [mem 0x393ffff08000-0x393ffff0bf=
ff 64bit]
[    7.324891] pci 0000:80:04.6: [8086:2021] type 00 class 0x088000
[    7.330821] pci 0000:80:04.6: reg 0x10: [mem 0x393ffff04000-0x393ffff07f=
ff 64bit]
[    7.338887] pci 0000:80:04.7: [8086:2021] type 00 class 0x088000
[    7.344822] pci 0000:80:04.7: reg 0x10: [mem 0x393ffff00000-0x393ffff03f=
ff 64bit]
[    7.351887] pci 0000:80:05.0: [8086:2024] type 00 class 0x088000
[    7.357884] pci 0000:80:05.2: [8086:2025] type 00 class 0x088000
[    7.363876] pci 0000:80:05.4: [8086:2026] type 00 class 0x080020
[    7.369820] pci 0000:80:05.4: reg 0x10: [mem 0xc6300000-0xc6300fff]
[    7.375878] pci 0000:80:08.0: [8086:2014] type 00 class 0x088000
[    7.382874] pci 0000:80:08.1: [8086:2015] type 00 class 0x110100
[    7.388855] pci 0000:80:08.2: [8086:2016] type 00 class 0x088000
[    7.394897] pci 0000:81:00.0: [10b5:8718] type 01 class 0x060400
[    7.400828] pci 0000:81:00.0: reg 0x10: [mem 0xc6200000-0xc623ffff]
[    7.406880] pci 0000:81:00.0: PME# supported from D0 D3hot D3cold
[    7.412847] pci 0000:81:00.0: 31.504 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x4 link at 0000:80:00.0 (capable of 63.008 Gb/s with 8=
=2E0 GT/s PCIe x8 link)
[    7.430824] pci 0000:80:00.0: PCI bridge to [bus 81-84]
[    7.435816] pci 0000:80:00.0:   bridge window [mem 0xc6000000-0xc62fffff]
[    7.442847] pci 0000:82:01.0: [10b5:8718] type 01 class 0x060400
[    7.448895] pci 0000:82:01.0: PME# supported from D0 D3hot D3cold
[    7.454871] pci 0000:82:02.0: [10b5:8718] type 01 class 0x060400
[    7.460895] pci 0000:82:02.0: PME# supported from D0 D3hot D3cold
[    7.467882] pci 0000:81:00.0: PCI bridge to [bus 82-84]
[    7.472817] pci 0000:81:00.0:   bridge window [mem 0xc6000000-0xc61fffff]
[    7.479845] pci 0000:83:00.0: [8086:0953] type 00 class 0x010802
[    7.485833] pci 0000:83:00.0: reg 0x10: [mem 0xc6100000-0xc6103fff 64bit]
[    7.491841] pci 0000:83:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    7.501827] pci 0000:82:01.0: PCI bridge to [bus 83]
[    7.506818] pci 0000:82:01.0:   bridge window [mem 0xc6100000-0xc61fffff]
[    7.513849] pci 0000:84:00.0: [8086:0953] type 00 class 0x010802
[    7.519833] pci 0000:84:00.0: reg 0x10: [mem 0xc6000000-0xc6003fff 64bit]
[    7.526840] pci 0000:84:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    7.535827] pci 0000:82:02.0: PCI bridge to [bus 84]
[    7.540818] pci 0000:82:02.0:   bridge window [mem 0xc6000000-0xc60fffff]
[    7.547829] pci_bus 0000:80: on NUMA node 1
[    7.551891] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus 85-ad])
[    7.557815] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    7.567094] acpi PNP0A08:07: _OSC: platform does not support [SHPCHotplu=
g AER LTR]
[    7.574964] acpi PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    7.582814] acpi PNP0A08:07: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    7.591011] PCI host bridge to bus 0000:85
[    7.594814] pci_bus 0000:85: root bus resource [io  0xc000-0xdfff window]
[    7.601814] pci_bus 0000:85: root bus resource [mem 0xd3800000-0xe0fffff=
f window]
[    7.609814] pci_bus 0000:85: root bus resource [mem 0x394000000000-0x397=
fffffffff window]
[    7.617814] pci_bus 0000:85: root bus resource [bus 85-ad]
[    7.622821] pci 0000:85:05.0: [8086:2034] type 00 class 0x088000
[    7.628913] pci 0000:85:05.2: [8086:2035] type 00 class 0x088000
[    7.634905] pci 0000:85:05.4: [8086:2036] type 00 class 0x080020
[    7.640820] pci 0000:85:05.4: reg 0x10: [mem 0xd3800000-0xd3800fff]
[    7.647902] pci 0000:85:08.0: [8086:208d] type 00 class 0x088000
[    7.653889] pci 0000:85:08.1: [8086:208d] type 00 class 0x088000
[    7.659878] pci 0000:85:08.2: [8086:208d] type 00 class 0x088000
[    7.665879] pci 0000:85:08.3: [8086:208d] type 00 class 0x088000
[    7.671877] pci 0000:85:08.4: [8086:208d] type 00 class 0x088000
[    7.677877] pci 0000:85:08.5: [8086:208d] type 00 class 0x088000
[    7.683877] pci 0000:85:08.6: [8086:208d] type 00 class 0x088000
[    7.689877] pci 0000:85:08.7: [8086:208d] type 00 class 0x088000
[    7.695876] pci 0000:85:09.0: [8086:208d] type 00 class 0x088000
[    7.701886] pci 0000:85:09.1: [8086:208d] type 00 class 0x088000
[    7.707876] pci 0000:85:09.2: [8086:208d] type 00 class 0x088000
[    7.713876] pci 0000:85:09.3: [8086:208d] type 00 class 0x088000
[    7.719876] pci 0000:85:09.4: [8086:208d] type 00 class 0x088000
[    7.725877] pci 0000:85:09.5: [8086:208d] type 00 class 0x088000
[    7.731876] pci 0000:85:09.6: [8086:208d] type 00 class 0x088000
[    7.737876] pci 0000:85:09.7: [8086:208d] type 00 class 0x088000
[    7.743876] pci 0000:85:0a.0: [8086:208d] type 00 class 0x088000
[    7.749886] pci 0000:85:0a.1: [8086:208d] type 00 class 0x088000
[    7.756878] pci 0000:85:0a.2: [8086:208d] type 00 class 0x088000
[    7.762877] pci 0000:85:0a.3: [8086:208d] type 00 class 0x088000
[    7.768877] pci 0000:85:0a.4: [8086:208d] type 00 class 0x088000
[    7.774878] pci 0000:85:0a.5: [8086:208d] type 00 class 0x088000
[    7.780880] pci 0000:85:0a.6: [8086:208d] type 00 class 0x088000
[    7.786878] pci 0000:85:0a.7: [8086:208d] type 00 class 0x088000
[    7.792877] pci 0000:85:0b.0: [8086:208d] type 00 class 0x088000
[    7.798889] pci 0000:85:0b.1: [8086:208d] type 00 class 0x088000
[    7.804879] pci 0000:85:0b.2: [8086:208d] type 00 class 0x088000
[    7.810876] pci 0000:85:0b.3: [8086:208d] type 00 class 0x088000
[    7.816879] pci 0000:85:0e.0: [8086:208e] type 00 class 0x088000
[    7.822886] pci 0000:85:0e.1: [8086:208e] type 00 class 0x088000
[    7.828876] pci 0000:85:0e.2: [8086:208e] type 00 class 0x088000
[    7.834876] pci 0000:85:0e.3: [8086:208e] type 00 class 0x088000
[    7.840876] pci 0000:85:0e.4: [8086:208e] type 00 class 0x088000
[    7.846877] pci 0000:85:0e.5: [8086:208e] type 00 class 0x088000
[    7.852877] pci 0000:85:0e.6: [8086:208e] type 00 class 0x088000
[    7.858877] pci 0000:85:0e.7: [8086:208e] type 00 class 0x088000
[    7.864877] pci 0000:85:0f.0: [8086:208e] type 00 class 0x088000
[    7.870890] pci 0000:85:0f.1: [8086:208e] type 00 class 0x088000
[    7.877880] pci 0000:85:0f.2: [8086:208e] type 00 class 0x088000
[    7.883879] pci 0000:85:0f.3: [8086:208e] type 00 class 0x088000
[    7.889879] pci 0000:85:0f.4: [8086:208e] type 00 class 0x088000
[    7.895879] pci 0000:85:0f.5: [8086:208e] type 00 class 0x088000
[    7.901879] pci 0000:85:0f.6: [8086:208e] type 00 class 0x088000
[    7.907879] pci 0000:85:0f.7: [8086:208e] type 00 class 0x088000
[    7.913877] pci 0000:85:10.0: [8086:208e] type 00 class 0x088000
[    7.919891] pci 0000:85:10.1: [8086:208e] type 00 class 0x088000
[    7.925879] pci 0000:85:10.2: [8086:208e] type 00 class 0x088000
[    7.931880] pci 0000:85:10.3: [8086:208e] type 00 class 0x088000
[    7.937880] pci 0000:85:10.4: [8086:208e] type 00 class 0x088000
[    7.943886] pci 0000:85:10.5: [8086:208e] type 00 class 0x088000
[    7.949879] pci 0000:85:10.6: [8086:208e] type 00 class 0x088000
[    7.955880] pci 0000:85:10.7: [8086:208e] type 00 class 0x088000
[    7.961878] pci 0000:85:11.0: [8086:208e] type 00 class 0x088000
[    7.967895] pci 0000:85:11.1: [8086:208e] type 00 class 0x088000
[    7.973884] pci 0000:85:11.2: [8086:208e] type 00 class 0x088000
[    7.979878] pci 0000:85:11.3: [8086:208e] type 00 class 0x088000
[    7.985888] pci 0000:85:1d.0: [8086:2054] type 00 class 0x088000
[    7.992890] pci 0000:85:1d.1: [8086:2055] type 00 class 0x088000
[    7.998878] pci 0000:85:1d.2: [8086:2056] type 00 class 0x088000
[    8.004890] pci 0000:85:1d.3: [8086:2057] type 00 class 0x088000
[    8.010883] pci 0000:85:1e.0: [8086:2080] type 00 class 0x088000
[    8.016889] pci 0000:85:1e.1: [8086:2081] type 00 class 0x088000
[    8.022879] pci 0000:85:1e.2: [8086:2082] type 00 class 0x088000
[    8.028879] pci 0000:85:1e.3: [8086:2083] type 00 class 0x088000
[    8.034880] pci 0000:85:1e.4: [8086:2084] type 00 class 0x088000
[    8.040878] pci 0000:85:1e.5: [8086:2085] type 00 class 0x088000
[    8.046877] pci 0000:85:1e.6: [8086:2086] type 00 class 0x088000
[    8.052879] pci_bus 0000:85: on NUMA node 1
[    8.056916] ACPI: PCI Root Bridge [PC08] (domain 0000 [bus ae-d6])
[    8.063816] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    8.073087] acpi PNP0A08:08: _OSC: platform does not support [SHPCHotplu=
g AER LTR]
[    8.079962] acpi PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    8.087814] acpi PNP0A08:08: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    8.095954] PCI host bridge to bus 0000:ae
[    8.100814] pci_bus 0000:ae: root bus resource [io  0xe000-0xefff window]
[    8.106814] pci_bus 0000:ae: root bus resource [mem 0xe1000000-0xee7ffff=
f window]
[    8.114814] pci_bus 0000:ae: root bus resource [mem 0x398000000000-0x39b=
fffffffff window]
[    8.122814] pci_bus 0000:ae: root bus resource [bus ae-d6]
[    8.127821] pci 0000:ae:05.0: [8086:2034] type 00 class 0x088000
[    8.133881] pci 0000:ae:05.2: [8086:2035] type 00 class 0x088000
[    8.139876] pci 0000:ae:05.4: [8086:2036] type 00 class 0x080020
[    8.145820] pci 0000:ae:05.4: reg 0x10: [mem 0xe1000000-0xe1000fff]
[    8.152879] pci 0000:ae:08.0: [8086:2066] type 00 class 0x088000
[    8.158876] pci 0000:ae:09.0: [8086:2066] type 00 class 0x088000
[    8.164880] pci 0000:ae:0a.0: [8086:2040] type 00 class 0x088000
[    8.170877] pci 0000:ae:0a.1: [8086:2041] type 00 class 0x088000
[    8.176865] pci 0000:ae:0a.2: [8086:2042] type 00 class 0x088000
[    8.182868] pci 0000:ae:0a.3: [8086:2043] type 00 class 0x088000
[    8.188865] pci 0000:ae:0a.4: [8086:2044] type 00 class 0x088000
[    8.194865] pci 0000:ae:0a.5: [8086:2045] type 00 class 0x088000
[    8.200870] pci 0000:ae:0a.6: [8086:2046] type 00 class 0x088000
[    8.206864] pci 0000:ae:0a.7: [8086:2047] type 00 class 0x088000
[    8.212864] pci 0000:ae:0b.0: [8086:2048] type 00 class 0x088000
[    8.218877] pci 0000:ae:0b.1: [8086:2049] type 00 class 0x088000
[    8.224864] pci 0000:ae:0b.2: [8086:204a] type 00 class 0x088000
[    8.230864] pci 0000:ae:0b.3: [8086:204b] type 00 class 0x088000
[    8.236866] pci 0000:ae:0c.0: [8086:2040] type 00 class 0x088000
[    8.242878] pci 0000:ae:0c.1: [8086:2041] type 00 class 0x088000
[    8.248867] pci 0000:ae:0c.2: [8086:2042] type 00 class 0x088000
[    8.254866] pci 0000:ae:0c.3: [8086:2043] type 00 class 0x088000
[    8.260866] pci 0000:ae:0c.4: [8086:2044] type 00 class 0x088000
[    8.266867] pci 0000:ae:0c.5: [8086:2045] type 00 class 0x088000
[    8.272868] pci 0000:ae:0c.6: [8086:2046] type 00 class 0x088000
[    8.278866] pci 0000:ae:0c.7: [8086:2047] type 00 class 0x088000
[    8.285866] pci 0000:ae:0d.0: [8086:2048] type 00 class 0x088000
[    8.291877] pci 0000:ae:0d.1: [8086:2049] type 00 class 0x088000
[    8.297866] pci 0000:ae:0d.2: [8086:204a] type 00 class 0x088000
[    8.303866] pci 0000:ae:0d.3: [8086:204b] type 00 class 0x088000
[    8.309876] pci_bus 0000:ae: on NUMA node 1
[    8.313897] ACPI: PCI Root Bridge [PC09] (domain 0000 [bus d7-ff])
[    8.319815] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    8.329093] acpi PNP0A08:09: _OSC: platform does not support [SHPCHotplu=
g AER LTR]
[    8.336965] acpi PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    8.344814] acpi PNP0A08:09: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    8.352950] PCI host bridge to bus 0000:d7
[    8.356814] pci_bus 0000:d7: root bus resource [io  0xf000-0xffff window]
[    8.363814] pci_bus 0000:d7: root bus resource [mem 0xee800000-0xfbfffff=
f window]
[    8.370814] pci_bus 0000:d7: root bus resource [mem 0x39c000000000-0x39f=
fffffffff window]
[    8.378814] pci_bus 0000:d7: root bus resource [bus d7-ff]
[    8.384821] pci 0000:d7:00.0: [8086:2030] type 01 class 0x060400
[    8.390879] pci 0000:d7:00.0: PME# supported from D0 D3hot D3cold
[    8.396884] pci 0000:d7:01.0: [8086:2031] type 01 class 0x060400
[    8.402876] pci 0000:d7:01.0: PME# supported from D0 D3hot D3cold
[    8.408884] pci 0000:d7:05.0: [8086:2034] type 00 class 0x088000
[    8.414881] pci 0000:d7:05.2: [8086:2035] type 00 class 0x088000
[    8.420880] pci 0000:d7:05.4: [8086:2036] type 00 class 0x080020
[    8.426821] pci 0000:d7:05.4: reg 0x10: [mem 0xee800000-0xee800fff]
[    8.433884] pci 0000:d7:0e.0: [8086:2058] type 00 class 0x110100
[    8.439877] pci 0000:d7:0e.1: [8086:2059] type 00 class 0x088000
[    8.445865] pci 0000:d7:0f.0: [8086:2058] type 00 class 0x110100
[    8.451873] pci 0000:d7:0f.1: [8086:2059] type 00 class 0x088000
[    8.457869] pci 0000:d7:10.0: [8086:2058] type 00 class 0x110100
[    8.463876] pci 0000:d7:10.1: [8086:2059] type 00 class 0x088000
[    8.469868] pci 0000:d7:12.0: [8086:204c] type 00 class 0x110100
[    8.475877] pci 0000:d7:12.1: [8086:204d] type 00 class 0x110100
[    8.481856] pci 0000:d7:12.2: [8086:204e] type 00 class 0x088000
[    8.487858] pci 0000:d7:12.4: [8086:204c] type 00 class 0x110100
[    8.493866] pci 0000:d7:12.5: [8086:204d] type 00 class 0x110100
[    8.499857] pci 0000:d7:15.0: [8086:2018] type 00 class 0x088000
[    8.505865] pci 0000:d7:15.1: [8086:2088] type 00 class 0x110100
[    8.511857] pci 0000:d7:16.0: [8086:2018] type 00 class 0x088000
[    8.517867] pci 0000:d7:16.1: [8086:2088] type 00 class 0x110100
[    8.523855] pci 0000:d7:16.4: [8086:2018] type 00 class 0x088000
[    8.529854] pci 0000:d7:16.5: [8086:2088] type 00 class 0x110100
[    8.535856] pci 0000:d7:17.0: [8086:2018] type 00 class 0x088000
[    8.541865] pci 0000:d7:17.1: [8086:2088] type 00 class 0x110100
[    8.547884] pci 0000:d7:00.0: PCI bridge to [bus d8]
[    8.552816] pci 0000:d7:00.0:   bridge window [mem 0xee900000-0xeeafffff]
[    8.559816] pci 0000:d7:00.0:   bridge window [mem 0x39c000000000-0x39c0=
001fffff 64bit pref]
[    8.567834] pci 0000:d7:01.0: PCI bridge to [bus d9]
[    8.572815] pci 0000:d7:01.0:   bridge window [io  0xf000-0xffff]
[    8.578814] pci 0000:d7:01.0:   bridge window [mem 0xeeb00000-0xeecfffff]
[    8.585817] pci 0000:d7:01.0:   bridge window [mem 0x39c000200000-0x39c0=
003fffff 64bit pref]
[    8.594821] pci_bus 0000:d7: on NUMA node 1
[    8.599835] iommu: Default domain type: Translated=20
[    8.604838] pci 0000:02:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    8.612944] pci 0000:02:00.0: vgaarb: bridge control possible
[    8.618815] pci 0000:02:00.0: vgaarb: setting as boot device (VGA legacy=
 resources not available)
[    8.627813] vgaarb: loaded
[    8.630060] SCSI subsystem initialized
[    8.633826] ACPI: bus type USB registered
[    8.637833] usbcore: registered new interface driver usbfs
[    8.643819] usbcore: registered new interface driver hub
[    8.649044] usbcore: registered new device driver usb
[    8.653831] pps_core: LinuxPPS API ver. 1 registered
[    8.658813] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    8.667815] PTP clock support registered
[    8.672832] EDAC MC: Ver: 3.0.0
[    8.676170] NetLabel: Initializing
[    8.679814] NetLabel:  domain hash size =3D 128
[    8.683813] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    8.689824] NetLabel:  unlabeled traffic allowed by default
[    8.694814] PCI: Using ACPI for IRQ routing
[    8.702955] PCI: pci_cache_line_size set to 64 bytes
[    8.708154] e820: reserve RAM buffer [mem 0x5a818000-0x5bffffff]
[    8.713815] e820: reserve RAM buffer [mem 0x5c714000-0x5fffffff]
[    8.719813] e820: reserve RAM buffer [mem 0x5ca11000-0x5fffffff]
[    8.725815] e820: reserve RAM buffer [mem 0x60776000-0x63ffffff]
[    8.731814] e820: reserve RAM buffer [mem 0x60839000-0x63ffffff]
[    8.737813] e820: reserve RAM buffer [mem 0x6464a000-0x67ffffff]
[    8.743814] e820: reserve RAM buffer [mem 0x648a7000-0x67ffffff]
[    8.749814] e820: reserve RAM buffer [mem 0x64bee000-0x67ffffff]
[    8.755814] e820: reserve RAM buffer [mem 0x652d4000-0x67ffffff]
[    8.761813] e820: reserve RAM buffer [mem 0x67d56000-0x67ffffff]
[    8.767813] e820: reserve RAM buffer [mem 0x6fb00000-0x6fffffff]
[    8.773963] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    8.779814] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    8.788079] clocksource: Switched to clocksource tsc-early
[    8.821253] VFS: Disk quotas dquot_6.6.0
[    8.825290] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    8.832403] AppArmor: AppArmor Filesystem Enabled
[    8.837105] pnp: PnP ACPI init
[    8.841298] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    8.848055] system 00:01: [io  0x0500-0x05fe] has been reserved
[    8.853967] system 00:01: [io  0x0400-0x047f] has been reserved
[    8.859881] system 00:01: [io  0x0600-0x061f] has been reserved
[    8.865795] system 00:01: [io  0x0ca0-0x0ca5] could not be reserved
[    8.872052] system 00:01: [io  0x0880-0x0883] has been reserved
[    8.877958] system 00:01: [io  0x0800-0x081f] has been reserved
[    8.883865] system 00:01: [mem 0xfed1c000-0xfed3ffff] has been reserved
[    8.890469] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    8.897065] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    8.903664] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    8.910260] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    8.916857] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    8.923453] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    8.930056] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    8.937024] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.943684] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.950405] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
[    8.957011] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
[    8.963615] system 00:04: [mem 0xfdb00000-0xfdffffff] has been reserved
[    8.970211] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
[    8.976807] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
[    8.983407] system 00:04: [mem 0xfe036000-0xfe03bfff] has been reserved
[    8.990012] system 00:04: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    8.996608] system 00:04: [mem 0xfe410000-0xfe7fffff] has been reserved
[    9.003206] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    9.010292] system 00:05: [io  0x1000-0x10fe] has been reserved
[    9.016202] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    9.023392] pnp: PnP ACPI: found 6 devices
[    9.033097] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    9.042052] NET: Registered protocol family 2
[    9.046921] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8=
, 1048576 bytes, vmalloc)
[    9.056023] TCP established hash table entries: 524288 (order: 10, 41943=
04 bytes, vmalloc)
[    9.064821] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 vmalloc)
[    9.072413] TCP: Hash tables configured (established 524288 bind 65536)
[    9.079220] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmal=
loc)
[    9.086583] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes,=
 vmalloc)
[    9.094595] NET: Registered protocol family 1
[    9.099185] RPC: Registered named UNIX socket transport module.
[    9.105091] RPC: Registered udp transport module.
[    9.109784] RPC: Registered tcp transport module.
[    9.114481] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    9.120907] NET: Registered protocol family 44
[    9.125367] pci 0000:3b:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffff=
ff pref]: no compatible bridge window
[    9.135258] pci 0000:3d:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffff=
ff pref]: no compatible bridge window
[    9.145139] pci 0000:3d:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffff=
ff pref]: no compatible bridge window
[    9.155022] pci 0000:83:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffff=
ff pref]: no compatible bridge window
[    9.164903] pci 0000:84:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffff=
ff pref]: no compatible bridge window
[    9.174801] pci 0000:01:00.0: PCI bridge to [bus 02]
[    9.179761] pci 0000:01:00.0:   bridge window [io  0x2000-0x2fff]
[    9.185850] pci 0000:01:00.0:   bridge window [mem 0x91000000-0x920fffff]
[    9.192632] pci 0000:00:1c.0: PCI bridge to [bus 01-02]
[    9.197846] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    9.203924] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x920fffff]
[    9.210699] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    9.216866] pci_bus 0000:00: resource 5 [io  0x1000-0x3fff window]
[    9.223030] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    9.229887] pci_bus 0000:00: resource 7 [mem 0x000c4000-0x000c7fff windo=
w]
[    9.236744] pci_bus 0000:00: resource 8 [mem 0xfe010000-0xfe010fff windo=
w]
[    9.243601] pci_bus 0000:00: resource 9 [mem 0x90000000-0x9d7fffff windo=
w]
[    9.250458] pci_bus 0000:00: resource 10 [mem 0x380000000000-0x383ffffff=
fff window]
[    9.258101] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    9.263657] pci_bus 0000:01: resource 1 [mem 0x91000000-0x920fffff]
[    9.269911] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    9.275471] pci_bus 0000:02: resource 1 [mem 0x91000000-0x920fffff]
[    9.281829] pci 0000:17:00.0: PCI bridge to [bus 18-19]
[    9.287048] pci 0000:17:00.0:   bridge window [mem 0x9d800000-0x9dcfffff]
[    9.293816] pci 0000:17:00.0:   bridge window [mem 0x387ffff00000-0x387f=
ffffffff 64bit pref]
[    9.302235] pci_bus 0000:17: resource 4 [io  0x4000-0x5fff window]
[    9.308402] pci_bus 0000:17: resource 5 [mem 0x9d800000-0xaaffffff windo=
w]
[    9.315259] pci_bus 0000:17: resource 6 [mem 0x384000000000-0x387fffffff=
ff window]
[    9.322807] pci_bus 0000:18: resource 1 [mem 0x9d800000-0x9dcfffff]
[    9.329057] pci_bus 0000:18: resource 2 [mem 0x387ffff00000-0x387fffffff=
ff 64bit pref]
[    9.336973] pci 0000:3b:00.0: BAR 6: no space for [mem size 0x00100000 p=
ref]
[    9.344008] pci 0000:3b:00.0: BAR 6: failed to assign [mem size 0x001000=
00 pref]
[    9.351382] pci 0000:3b:00.0: BAR 14: no space for [mem size 0x00100000]
[    9.358065] pci 0000:3b:00.0: BAR 14: failed to assign [mem size 0x00100=
000]
[    9.365096] pci 0000:3c:03.0: BAR 14: no space for [mem size 0x00100000]
[    9.371779] pci 0000:3c:03.0: BAR 14: failed to assign [mem size 0x00100=
000]
[    9.378811] pci 0000:3d:00.0: BAR 6: assigned [mem 0xad980000-0xad9fffff=
 pref]
[    9.386020] pci 0000:3d:00.1: BAR 6: no space for [mem size 0x00080000 p=
ref]
[    9.393046] pci 0000:3d:00.1: BAR 6: failed to assign [mem size 0x000800=
00 pref]
[    9.400424] pci 0000:3c:03.0: PCI bridge to [bus 3d-3e]
[    9.405641] pci 0000:3c:03.0:   bridge window [mem 0xab000000-0xad9fffff=
 64bit pref]
[    9.413369] pci 0000:3b:00.0: PCI bridge to [bus 3c-3e]
[    9.418593] pci 0000:3b:00.0:   bridge window [mem 0xab000000-0xad9fffff=
 64bit pref]
[    9.426319] pci 0000:3a:00.0: PCI bridge to [bus 3b-3e]
[    9.431533] pci 0000:3a:00.0:   bridge window [mem 0xada00000-0xadafffff]
[    9.438310] pci 0000:3a:00.0:   bridge window [mem 0xab000000-0xad9fffff=
 64bit pref]
[    9.446034] pci_bus 0000:3a: Some PCI device resources are unassigned, t=
ry booting with pci=3Drealloc
[    9.455056] pci_bus 0000:3a: resource 4 [io  0x6000-0x7fff window]
[    9.461223] pci_bus 0000:3a: resource 5 [mem 0xab000000-0xb87fffff windo=
w]
[    9.468076] pci_bus 0000:3a: resource 6 [mem 0x388000000000-0x38bfffffff=
ff window]
[    9.475628] pci_bus 0000:3b: resource 1 [mem 0xada00000-0xadafffff]
[    9.481878] pci_bus 0000:3b: resource 2 [mem 0xab000000-0xad9fffff 64bit=
 pref]
[    9.489078] pci_bus 0000:3c: resource 2 [mem 0xab000000-0xad9fffff 64bit=
 pref]
[    9.496283] pci_bus 0000:3d: resource 2 [mem 0xab000000-0xad9fffff 64bit=
 pref]
[    9.503503] pci 0000:5d:02.0: PCI bridge to [bus 5e]
[    9.508456] pci 0000:5d:02.0:   bridge window [io  0x8000-0x8fff]
[    9.514533] pci 0000:5d:02.0:   bridge window [mem 0xb8900000-0xb8afffff]
[    9.521305] pci 0000:5d:02.0:   bridge window [mem 0x38c000000000-0x38c0=
001fffff 64bit pref]
[    9.529718] pci 0000:5d:03.0: PCI bridge to [bus 5f]
[    9.534679] pci 0000:5d:03.0:   bridge window [io  0x9000-0x9fff]
[    9.540757] pci 0000:5d:03.0:   bridge window [mem 0xb8b00000-0xb8cfffff]
[    9.547529] pci 0000:5d:03.0:   bridge window [mem 0x38c000200000-0x38c0=
003fffff 64bit pref]
[    9.555951] pci_bus 0000:5d: resource 4 [io  0x8000-0x9fff window]
[    9.562123] pci_bus 0000:5d: resource 5 [mem 0xb8800000-0xc5ffffff windo=
w]
[    9.568985] pci_bus 0000:5d: resource 6 [mem 0x38c000000000-0x38ffffffff=
ff window]
[    9.576533] pci_bus 0000:5e: resource 0 [io  0x8000-0x8fff]
[    9.582093] pci_bus 0000:5e: resource 1 [mem 0xb8900000-0xb8afffff]
[    9.588346] pci_bus 0000:5e: resource 2 [mem 0x38c000000000-0x38c0001fff=
ff 64bit pref]
[    9.596239] pci_bus 0000:5f: resource 0 [io  0x9000-0x9fff]
[    9.601799] pci_bus 0000:5f: resource 1 [mem 0xb8b00000-0xb8cfffff]
[    9.608049] pci_bus 0000:5f: resource 2 [mem 0x38c000200000-0x38c0003fff=
ff 64bit pref]
[    9.615960] pci 0000:83:00.0: BAR 6: assigned [mem 0xc6110000-0xc611ffff=
 pref]
[    9.623164] pci 0000:82:01.0: PCI bridge to [bus 83]
[    9.628120] pci 0000:82:01.0:   bridge window [mem 0xc6100000-0xc61fffff]
[    9.634899] pci 0000:84:00.0: BAR 6: assigned [mem 0xc6010000-0xc601ffff=
 pref]
[    9.642107] pci 0000:82:02.0: PCI bridge to [bus 84]
[    9.647062] pci 0000:82:02.0:   bridge window [mem 0xc6000000-0xc60fffff]
[    9.653837] pci 0000:81:00.0: PCI bridge to [bus 82-84]
[    9.659055] pci 0000:81:00.0:   bridge window [mem 0xc6000000-0xc61fffff]
[    9.665834] pci 0000:80:00.0: PCI bridge to [bus 81-84]
[    9.671056] pci 0000:80:00.0:   bridge window [mem 0xc6000000-0xc62fffff]
[    9.677833] pci_bus 0000:80: resource 4 [io  0xa000-0xbfff window]
[    9.683996] pci_bus 0000:80: resource 5 [mem 0xc6000000-0xd37fffff windo=
w]
[    9.690852] pci_bus 0000:80: resource 6 [mem 0x390000000000-0x393fffffff=
ff window]
[    9.698400] pci_bus 0000:81: resource 1 [mem 0xc6000000-0xc62fffff]
[    9.704654] pci_bus 0000:82: resource 1 [mem 0xc6000000-0xc61fffff]
[    9.710912] pci_bus 0000:83: resource 1 [mem 0xc6100000-0xc61fffff]
[    9.717162] pci_bus 0000:84: resource 1 [mem 0xc6000000-0xc60fffff]
[    9.723434] pci_bus 0000:85: resource 4 [io  0xc000-0xdfff window]
[    9.729605] pci_bus 0000:85: resource 5 [mem 0xd3800000-0xe0ffffff windo=
w]
[    9.736461] pci_bus 0000:85: resource 6 [mem 0x394000000000-0x397fffffff=
ff window]
[    9.744030] pci_bus 0000:ae: resource 4 [io  0xe000-0xefff window]
[    9.750197] pci_bus 0000:ae: resource 5 [mem 0xe1000000-0xee7fffff windo=
w]
[    9.757055] pci_bus 0000:ae: resource 6 [mem 0x398000000000-0x39bfffffff=
ff window]
[    9.764616] pci 0000:d7:00.0: bridge window [io  0x1000-0x0fff] to [bus =
d8] add_size 1000
[    9.772781] pci 0000:d7:00.0: BAR 13: no space for [io  size 0x1000]
[    9.779122] pci 0000:d7:00.0: BAR 13: failed to assign [io  size 0x1000]
[    9.785806] pci 0000:d7:00.0: BAR 13: no space for [io  size 0x1000]
[    9.792142] pci 0000:d7:00.0: BAR 13: failed to assign [io  size 0x1000]
[    9.798826] pci 0000:d7:00.0: PCI bridge to [bus d8]
[    9.803780] pci 0000:d7:00.0:   bridge window [mem 0xee900000-0xeeafffff]
[    9.810552] pci 0000:d7:00.0:   bridge window [mem 0x39c000000000-0x39c0=
001fffff 64bit pref]
[    9.818973] pci 0000:d7:01.0: PCI bridge to [bus d9]
[    9.823934] pci 0000:d7:01.0:   bridge window [io  0xf000-0xffff]
[    9.830013] pci 0000:d7:01.0:   bridge window [mem 0xeeb00000-0xeecfffff]
[    9.836784] pci 0000:d7:01.0:   bridge window [mem 0x39c000200000-0x39c0=
003fffff 64bit pref]
[    9.845206] pci_bus 0000:d7: resource 4 [io  0xf000-0xffff window]
[    9.851374] pci_bus 0000:d7: resource 5 [mem 0xee800000-0xfbffffff windo=
w]
[    9.858231] pci_bus 0000:d7: resource 6 [mem 0x39c000000000-0x39ffffffff=
ff window]
[    9.865779] pci_bus 0000:d8: resource 1 [mem 0xee900000-0xeeafffff]
[    9.872032] pci_bus 0000:d8: resource 2 [mem 0x39c000000000-0x39c0001fff=
ff 64bit pref]
[    9.879927] pci_bus 0000:d9: resource 0 [io  0xf000-0xffff]
[    9.885491] pci_bus 0000:d9: resource 1 [mem 0xeeb00000-0xeecfffff]
[    9.891745] pci_bus 0000:d9: resource 2 [mem 0x39c000200000-0x39c0003fff=
ff 64bit pref]
[    9.899905] IOAPIC[0]: Set routing entry (8-16 -> 0xef -> IRQ 16 Mode:1 =
Active:1 Dest:0)
[    9.908145] pci 0000:17:05.0: disabled boot interrupts on device [8086:2=
034]
[    9.915264] pci 0000:3a:05.0: disabled boot interrupts on device [8086:2=
034]
[    9.922342] pci 0000:5d:05.0: disabled boot interrupts on device [8086:2=
034]
[    9.929425] pci 0000:85:05.0: disabled boot interrupts on device [8086:2=
034]
[    9.936531] pci 0000:ae:05.0: disabled boot interrupts on device [8086:2=
034]
[    9.943596] pci 0000:d7:05.0: disabled boot interrupts on device [8086:2=
034]
[    9.950648] PCI: CLS 32 bytes, default 64
[    9.954686] Trying to unpack rootfs image as initramfs...
[   13.856340] Freeing initrd memory: 275532K
[   13.860444] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   13.866873] software IO TLB: mapped [mem 0x6bb00000-0x6fb00000] (64MB)
[   13.881959] Initialise system trusted keyrings
[   13.886413] Key type blacklist registered
[   13.890475] workingset: timestamp_bits=3D36 max_order=3D25 bucket_order=
=3D0
[   13.897878] zbud: loaded
[   13.901343] 9p: Installing v9fs 9p2000 file system support
[   13.914324] NET: Registered protocol family 38
[   13.918768] Key type asymmetric registered
[   13.922863] Asymmetric key parser 'x509' registered
[   13.927733] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[   13.935253] io scheduler mq-deadline registered
[   13.939776] io scheduler kyber registered
[   13.943807] io scheduler bfq registered
[   13.948260] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[   13.955405] IOAPIC[0]: Set routing entry (8-19 -> 0xef -> IRQ 19 Mode:1 =
Active:1 Dest:0)
[   13.963538] pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
[   13.969589] IOAPIC[2]: Set routing entry (10-7 -> 0xef -> IRQ 25 Mode:1 =
Active:1 Dest:0)
[   13.977707] pcieport 0000:17:00.0: PME: Signaling with IRQ 26
[   13.983586] IOAPIC[3]: Set routing entry (11-7 -> 0xef -> IRQ 27 Mode:1 =
Active:1 Dest:0)
[   13.991703] pcieport 0000:3a:00.0: PME: Signaling with IRQ 28
[   13.997525] IOAPIC[3]: Set routing entry (11-0 -> 0xef -> IRQ 29 Mode:1 =
Active:1 Dest:0)
[   14.005787] IOAPIC[4]: Set routing entry (12-7 -> 0xef -> IRQ 30 Mode:1 =
Active:1 Dest:0)
[   14.013897] pcieport 0000:5d:02.0: PME: Signaling with IRQ 31
[   14.019648] pcieport 0000:5d:02.0: pciehp: Slot #257 AttnBtn- PwrCtrl- M=
RL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LLAc=
tRep+ (with Cmd Compl erratum)
[   14.035607] pcieport 0000:5d:03.0: PME: Signaling with IRQ 32
[   14.041354] pcieport 0000:5d:03.0: pciehp: Slot #258 AttnBtn- PwrCtrl- M=
RL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LLAc=
tRep+ (with Cmd Compl erratum)
[   14.057306] IOAPIC[5]: Set routing entry (15-7 -> 0xef -> IRQ 33 Mode:1 =
Active:1 Dest:0)
[   14.065446] pcieport 0000:80:00.0: PME: Signaling with IRQ 34
[   14.071284] IOAPIC[5]: Set routing entry (15-0 -> 0xef -> IRQ 35 Mode:1 =
Active:1 Dest:0)
[   14.079457] IOAPIC[5]: Set routing entry (15-4 -> 0xef -> IRQ 36 Mode:1 =
Active:1 Dest:0)
[   14.087648] IOAPIC[5]: Set routing entry (15-5 -> 0xef -> IRQ 38 Mode:1 =
Active:1 Dest:0)
[   14.095900] IOAPIC[8]: Set routing entry (18-7 -> 0xef -> IRQ 40 Mode:1 =
Active:1 Dest:0)
[   14.104019] pcieport 0000:d7:00.0: PME: Signaling with IRQ 41
[   14.109772] pcieport 0000:d7:00.0: pciehp: Slot #259 AttnBtn- PwrCtrl- M=
RL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LLAc=
tRep+ (with Cmd Compl erratum)
[   14.125730] pcieport 0000:d7:01.0: PME: Signaling with IRQ 42
[   14.131480] pcieport 0000:d7:01.0: pciehp: Slot #260 AttnBtn- PwrCtrl- M=
RL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LLAc=
tRep+ (with Cmd Compl erratum)
[   14.147645] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   14.154417] efifb: invalid framebuffer address
[   14.158863] intel_idle: MWAIT substates: 0x2020
[   14.163496] Monitor-Mwait will be used to enter C-1 state
[   14.168894] Monitor-Mwait will be used to enter C-2 state
[   14.174284] ACPI: \_SB_.SCK0.CP00: Found 2 idle states
[   14.179421] intel_idle: v0.5.1 model 0x55
[   14.186438] intel_idle: Local APIC timer is reliable in all C-states
[   14.193105] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[   14.200533] ACPI: Power Button [PWRF]
[   14.303484] ERST: Error Record Serialization Table (ERST) support is ini=
tialized.
[   14.310955] pstore: Registered erst as persistent store backend
[   14.317372] GHES: APEI firmware first mode is enabled by APEI bit and WH=
EA _OSC.
[   14.325299] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   14.331647] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   14.339131] 00:03: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[   14.347106] Non-volatile memory driver v1.3
[   14.364284] lpc_ich 0000:00:1f.0: I/O space for ACPI uninitialized
[   14.370455] lpc_ich 0000:00:1f.0: No MFD cells added
[   14.375660] rdac: device handler registered
[   14.379958] hp_sw: device handler registered
[   14.384224] emc: device handler registered
[   14.388535] alua: device handler registered
[   14.392830] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[   14.399864] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   14.405636] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   14.411461] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   14.417416] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.=
0-k
[   14.424360] igb: Copyright (c) 2007-2014 Intel Corporation.
[   14.430052] IOAPIC[2]: Set routing entry (10-0 -> 0xef -> IRQ 43 Mode:1 =
Active:1 Dest:0)
[   14.494498] igb 0000:18:00.0: added PHC on eth0
[   14.499032] igb 0000:18:00.0: Intel(R) Gigabit Ethernet Network Connecti=
on
[   14.505892] igb 0000:18:00.0: eth0: (PCIe:5.0Gb/s:Width x4) b4:96:91:32:=
4c:88
[   14.513293] igb 0000:18:00.0: eth0: PBA No: H47822-002
[   14.518421] igb 0000:18:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[   14.526081] IOAPIC[2]: Set routing entry (10-4 -> 0xef -> IRQ 53 Mode:1 =
Active:1 Dest:0)
[   14.590116] igb 0000:18:00.1: added PHC on eth1
[   14.594648] igb 0000:18:00.1: Intel(R) Gigabit Ethernet Network Connecti=
on
[   14.601510] igb 0000:18:00.1: eth1: (PCIe:5.0Gb/s:Width x4) b4:96:91:32:=
4c:89
[   14.608911] igb 0000:18:00.1: eth1: PBA No: H47822-002
[   14.614038] igb 0000:18:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[   14.621725] IOAPIC[2]: Set routing entry (10-5 -> 0xef -> IRQ 63 Mode:1 =
Active:1 Dest:0)
[   14.685944] igb 0000:18:00.2: added PHC on eth2
[   14.690471] igb 0000:18:00.2: Intel(R) Gigabit Ethernet Network Connecti=
on
[   14.697335] igb 0000:18:00.2: eth2: (PCIe:5.0Gb/s:Width x4) b4:96:91:32:=
4c:8a
[   14.704736] igb 0000:18:00.2: eth2: PBA No: H47822-002
[   14.709861] igb 0000:18:00.2: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[   14.717548] IOAPIC[2]: Set routing entry (10-6 -> 0xef -> IRQ 73 Mode:1 =
Active:1 Dest:0)
[   14.781834] igb 0000:18:00.3: added PHC on eth3
[   14.786363] igb 0000:18:00.3: Intel(R) Gigabit Ethernet Network Connecti=
on
[   14.793218] igb 0000:18:00.3: eth3: (PCIe:5.0Gb/s:Width x4) b4:96:91:32:=
4c:8b
[   14.800619] igb 0000:18:00.3: eth3: PBA No: H47822-002
[   14.805746] igb 0000:18:00.3: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[   14.813418] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - vers=
ion 5.1.0-k
[   14.821063] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   14.826963] i40e: Intel(R) Ethernet Connection XL710 Network Driver - ve=
rsion 2.8.20-k
[   14.834860] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[   14.840929] IOAPIC[3]: Set routing entry (11-6 -> 0xef -> IRQ 83 Mode:1 =
Active:1 Dest:0)
[   14.863811] i40e 0000:3d:00.0: fw 3.1.49755 api 1.5 nvm 3.1c 0x80000809 =
1.1548.0 [8086:37d2] [8086:35ce]
[   14.876878] i40e 0000:3d:00.0: MAC address: a4:bf:01:21:fd:56
[   14.882755] i40e 0000:3d:00.0: FW LLDP is enabled
[   14.895364] i40e 0000:3d:00.0: Added LAN device PF0 bus=3D0x3d dev=3D0x0=
0 func=3D0x00
[   14.903273] i40e 0000:3d:00.0: Features: PF-id[0] VFs: 32 VSIs: 34 QP: 9=
4 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[   14.914825] tsc: Refined TSC clocksource calibration: 2394.375 MHz
[   14.921042] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x228=
375ba3e9, max_idle_ns: 440795226324 ns
[   14.928010] i40e 0000:3d:00.1: fw 3.1.49755 api 1.5 nvm 3.1c 0x80000809 =
1.1548.0 [8086:37d2] [8086:35ce]
[   14.940560] clocksource: Switched to clocksource tsc
[   14.944436] i40e 0000:3d:00.1: MAC address: a4:bf:01:21:fd:57
[   14.951414] i40e 0000:3d:00.1: FW LLDP is enabled
[   14.963848] i40e 0000:3d:00.1: Added LAN device PF1 bus=3D0x3d dev=3D0x0=
0 func=3D0x01
[   14.971782] i40e 0000:3d:00.1: Features: PF-id[1] VFs: 32 VSIs: 34 QP: 9=
4 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[   14.982827] usbcore: registered new interface driver catc
[   14.988236] usbcore: registered new interface driver kaweth
[   14.993811] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Etherne=
t driver
[   15.001206] usbcore: registered new interface driver pegasus
[   15.006866] usbcore: registered new interface driver rtl8150
[   15.012526] usbcore: registered new interface driver asix
[   15.017936] usbcore: registered new interface driver ax88179_178a
[   15.024033] usbcore: registered new interface driver cdc_ether
[   15.029865] usbcore: registered new interface driver cdc_eem
[   15.035530] usbcore: registered new interface driver dm9601
[   15.041109] usbcore: registered new interface driver smsc75xx
[   15.046865] usbcore: registered new interface driver smsc95xx
[   15.052615] usbcore: registered new interface driver gl620a
[   15.058187] usbcore: registered new interface driver net1080
[   15.063846] usbcore: registered new interface driver plusb
[   15.069333] usbcore: registered new interface driver rndis_host
[   15.075254] usbcore: registered new interface driver cdc_subset
[   15.081181] usbcore: registered new interface driver zaurus
[   15.086762] usbcore: registered new interface driver MOSCHIP usb-etherne=
t driver
[   15.094162] usbcore: registered new interface driver int51x1
[   15.099822] usbcore: registered new interface driver ipheth
[   15.105406] usbcore: registered new interface driver sierra_net
[   15.111337] usbcore: registered new interface driver cdc_ncm
[   15.117097] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   15.123627] ehci-pci: EHCI PCI platform driver
[   15.128103] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   15.134289] ohci-pci: OHCI PCI platform driver
[   15.138765] uhci_hcd: USB Universal Host Controller Interface driver
[   15.145262] IOAPIC[0]: Set routing entry (8-16 -> 0xef -> IRQ 16 Mode:1 =
Active:1 Dest:0)
[   15.153428] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   15.158774] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[   15.167269] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000000009810
[   15.176404] xhci_hcd 0000:00:14.0: cache line size of 32 is not supported
[   15.183344] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.08
[   15.191607] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   15.198825] usb usb1: Product: xHCI Host Controller
[   15.203701] usb usb1: Manufacturer: Linux 5.8.0-rc7-00166-g6e85ab8532a52=
 xhci-hcd
[   15.211182] usb usb1: SerialNumber: 0000:00:14.0
[   15.215953] hub 1-0:1.0: USB hub found
[   15.219726] hub 1-0:1.0: 16 ports detected
[   15.224634] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   15.229905] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[   15.237305] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[   15.243591] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.08
[   15.251856] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   15.259075] usb usb2: Product: xHCI Host Controller
[   15.263950] usb usb2: Manufacturer: Linux 5.8.0-rc7-00166-g6e85ab8532a52=
 xhci-hcd
[   15.271433] usb usb2: SerialNumber: 0000:00:14.0
[   15.276183] hub 2-0:1.0: USB hub found
[   15.279959] hub 2-0:1.0: 10 ports detected
[   15.284324] usb: port power management may be unreliable
[   15.289953] i8042: PNP: No PS/2 controller found.
[   15.294776] mousedev: PS/2 mouse device common for all mice
[   15.300478] rtc_cmos 00:00: RTC can wake from S4
[   15.305455] rtc_cmos 00:00: registered as rtc0
[   15.310061] rtc_cmos 00:00: setting system clock to 2015-01-13T22:13:05 =
UTC (1421187185)
[   15.318164] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[   15.325966] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   15.331747] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   15.338553] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   15.344169] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by=
 hardware/BIOS
[   15.352087] iTCO_vendor_support: vendor-support=3D0
[   15.356799] intel_pstate: Intel P-state driver initializing
[   15.378202] intel_pstate: HWP enabled
[   15.382059] hid: raw HID events driver (C) Jiri Kosina
[   15.387262] usbcore: registered new interface driver usbhid
[   15.392843] usbhid: USB HID core driver
[   15.396948] drop_monitor: Initializing network drop monitor service
[   15.403300] Initializing XFRM netlink socket
[   15.407706] NET: Registered protocol family 10
[   15.413027] Segment Routing with IPv6
[   15.416717] NET: Registered protocol family 17
[   15.421336] 9pnet: Installing 9P2000 support
[   15.425625] mpls_gso: MPLS GSO support
[   15.441051] microcode: sig=3D0x50656, pf=3D0x80, revision=3D0x400002c
[   15.452801] microcode: Microcode Update Driver: v2.2.
[   15.459496] resctrl: MB allocation detected
[   15.468746] resctrl: L3 monitoring detected
[   15.472939] IPI shorthand broadcast: enabled
[   15.477278] ... APIC ID:      00000000 (0)
[   15.478271] ... APIC VERSION: 01060015
[   15.478271] 000000000000000000000000000000000000000000000000000000000000=
0000
[   15.478271] 000000000000000000000000000000000000000000000000000000000000=
0000
[   15.478271] 000000000000000000000000000000000000000000000000000000000000=
1000
[   15.506274] number of MP IRQ sources: 15.
[   15.510296] number of IO-APIC #8 registers: 24.
[   15.514828] number of IO-APIC #9 registers: 8.
[   15.519274] number of IO-APIC #10 registers: 8.
[   15.523806] number of IO-APIC #11 registers: 8.
[   15.528338] number of IO-APIC #12 registers: 8.
[   15.532871] number of IO-APIC #15 registers: 8.
[   15.537405] number of IO-APIC #16 registers: 8.
[   15.541944] number of IO-APIC #17 registers: 8.
[   15.546479] number of IO-APIC #18 registers: 8.
[   15.551020] testing the IO APIC.......................
[   15.556178] IO APIC #8......
[   15.559071] .... register #00: 08000000
[   15.560896] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[   15.562908] .......    : physical APIC id: 08
[   15.573804] .......    : Delivery Type: 0
[   15.577823] .......    : LTS          : 0
[   15.581838] .... register #01: 00170020
[   15.585682] .......     : max redirection entries: 17
[   15.590738] .......     : PRQ implemented: 0
[   15.595016] .......     : IO APIC version: 20
[   15.599378] .... register #02: 00000000
[   15.603223] .......     : arbitration: 00
[   15.607238] .... IRQ redirection table:
[   15.611077] IOAPIC 0:
[   15.613362]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.621195]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.629030]  pin02, enabled , edge , high, V(30), IRR(0), S(0), physical=
, D(00), M(0)
[   15.636881]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.644718]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.652550]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.660386]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.668221]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.676057]  pin08, enabled , edge , high, V(21), IRR(0), S(0), physical=
, D(20), M(0)
[   15.683889]  pin09, enabled , level, high, V(21), IRR(0), S(0), physical=
, D(02), M(0)
[   15.691722]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.695359] usb 1-2: New USB device found, idVendor=3D0000, idProduct=3D=
0001, bcdDevice=3D 0.00
[   15.699562]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.707735] usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[   15.708400] hub 1-2:1.0: USB hub found
[   15.715579]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.722892] hub 1-2:1.0: 5 ports detected
[   15.726477]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.746155]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.753993]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.761828]  pin10, enabled , level, low , V(21), IRR(0), S(0), physical=
, D(22), M(0)
[   15.769662]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.777494]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.785329]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.793161]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.800998]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.808831]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.816667]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.824497] IO APIC #9......
[   15.827389] .... register #00: 09000000
[   15.831229] .......    : physical APIC id: 09
[   15.835585] .......    : Delivery Type: 0
[   15.839601] .......    : LTS          : 0
[   15.843612] .... register #01: 00070020
[   15.847454] .......     : max redirection entries: 07
[   15.848906] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[   15.852515] .......     : PRQ implemented: 0
[   15.852515] .......     : IO APIC version: 20
[   15.852515] .... register #02: 00000000
[   15.852516] .......     : arbitration: 00
[   15.852516] .... register #03: 00000001
[   15.852516] .......     : Boot DT    : 1
[   15.852516] .... IRQ redirection table:
[   15.852517] IOAPIC 1:
[   15.852519]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.897257]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.905084]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.912911]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.920744]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.928573]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.936404]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.944234]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   15.952066] IO APIC #10......
[   15.955047] .... register #00: 0A000000
[   15.958891] .......    : physical APIC id: 0A
[   15.963253] .......    : Delivery Type: 0
[   15.967263] .......    : LTS          : 0
[   15.971279] .... register #01: 00070020
[   15.975124] .......     : max redirection entries: 07
[   15.980181] .......     : PRQ implemented: 0
[   15.984460] .......     : IO APIC version: 20
[   15.988828] .... register #02: 00000000
[   15.992676] .......     : arbitration: 00
[   15.996115] usb 1-4: New USB device found, idVendor=3D14dd, idProduct=3D=
1005, bcdDevice=3D 0.00
[   15.996688] .... register #03: 00000001
[   16.004867] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[   16.008708] .......     : Boot DT    : 1
[   16.015842] usb 1-4: Product: D2CIM-VUSB
[   16.015843] usb 1-4: Manufacturer: Raritan
[   16.015845] usb 1-4: SerialNumber: EFFB212D0A6EE2F
[   16.019775] .... IRQ redirection table:
[   16.031643] input: Raritan D2CIM-VUSB Keyboard as /devices/pci0000:00/00=
00:00:14.0/usb1/1-4/1-4:1.0/0003:14DD:1005.0001/input/input1
[   16.032609] IOAPIC 2:
[   16.032612]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.058483]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.066316]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.074148]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.075902] usb 1-2.1: new low-speed USB device number 4 using xhci_hcd
[   16.081977]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.088947] input: Raritan D2CIM-VUSB Mouse as /devices/pci0000:00/0000:=
00:14.0/usb1/1-4/1-4:1.0/0003:14DD:1005.0001/input/input2
[   16.096435]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.108219] hid-generic 0003:14DD:1005.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [Raritan D2CIM-VUSB] on usb-0000:00:14.0-4/input0
[   16.115917]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.135655]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.143504] IO APIC #11......
[   16.146478] .... register #00: 0B000000
[   16.150318] .......    : physical APIC id: 0B
[   16.154685] .......    : Delivery Type: 0
[   16.158697] .......    : LTS          : 0
[   16.162708] .... register #01: 00070020
[   16.166550] .......     : max redirection entries: 07
[   16.171612] .......     : PRQ implemented: 0
[   16.175890] .......     : IO APIC version: 20
[   16.180252] .... register #02: 00000000
[   16.184098] .......     : arbitration: 00
[   16.188109] .... register #03: 00000001
[   16.191948] .......     : Boot DT    : 1
[   16.195877] .... IRQ redirection table:
[   16.199724] IOAPIC 3:
[   16.202004]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.205282] usb 1-2.1: New USB device found, idVendor=3D0b1f, idProduct=
=3D03e9, bcdDevice=3D 1.00
[   16.209839]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.209842]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.218195] usb 1-2.1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[   16.226029]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.249000]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.256829]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.257161] input: HID 0b1f:03e9 as /devices/pci0000:00/0000:00:14.0/usb=
1/1-2/1-2.1/1-2.1:1.0/0003:0B1F:03E9.0002/input/input3
[   16.264666]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.283884]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.291717] IO APIC #12......
[   16.294689] .... register #00: 0C000000
[   16.298528] .......    : physical APIC id: 0C
[   16.302887] .......    : Delivery Type: 0
[   16.306900] .......    : LTS          : 0
[   16.310915] .... register #01: 00070020
[   16.314759] .......     : max redirection entries: 07
[   16.319811] .......     : PRQ implemented: 0
[   16.324083] .......     : IO APIC version: 20
[   16.328186] hid-generic 0003:0B1F:03E9.0002: input,hidraw1: USB HID v1.0=
0 Keyboard [HID 0b1f:03e9] on usb-0000:00:14.0-2.1/input0
[   16.328445] .... register #02: 00000000
[   16.343932] .......     : arbitration: 00
[   16.347945] .... register #03: 00000001
[   16.351784] .......     : Boot DT    : 1
[   16.355709] .... IRQ redirection table:
[   16.358156] input: HID 0b1f:03e9 as /devices/pci0000:00/0000:00:14.0/usb=
1/1-2/1-2.1/1-2.1:1.1/0003:0B1F:03E9.0003/input/input4
[   16.359552] IOAPIC 4:
[   16.359555]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.371071] hid-generic 0003:0B1F:03E9.0003: input,hidraw2: USB HID v1.0=
0 Mouse [HID 0b1f:03e9] on usb-0000:00:14.0-2.1/input1
[   16.373228]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.400285]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.408118]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.415952]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.423786]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.431620]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.439454]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.447287] IO APIC #15......
[   16.450260] .... register #00: 0F000000
[   16.454101] .......    : physical APIC id: 0F
[   16.458467] .......    : Delivery Type: 0
[   16.462478] .......    : LTS          : 0
[   16.466494] .... register #01: 00070020
[   16.470338] .......     : max redirection entries: 07
[   16.475393] .......     : PRQ implemented: 0
[   16.479663] .......     : IO APIC version: 20
[   16.484026] .... register #02: 00000000
[   16.487871] .......     : arbitration: 00
[   16.491883] .... register #03: 00000001
[   16.495723] .......     : Boot DT    : 1
[   16.499651] .... IRQ redirection table:
[   16.503496] IOAPIC 5:
[   16.505777]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.513604]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.521439]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.529271]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.537098]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.544934]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.552769]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.560600]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.568427] IO APIC #16......
[   16.571408] .... register #00: 00000000
[   16.575248] .......    : physical APIC id: 00
[   16.579613] .......    : Delivery Type: 0
[   16.583628] .......    : LTS          : 0
[   16.587649] .... register #01: 00070020
[   16.591489] .......     : max redirection entries: 07
[   16.596550] .......     : PRQ implemented: 0
[   16.600828] .......     : IO APIC version: 20
[   16.605190] .... register #02: 00000000
[   16.609035] .......     : arbitration: 00
[   16.613051] .... register #03: 00000001
[   16.616895] .......     : Boot DT    : 1
[   16.620823] .... IRQ redirection table:
[   16.624661] IOAPIC 6:
[   16.626942]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.634769]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.642604]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.650437]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.658264]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.666100]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.673930]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.681757]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.689584] IO APIC #17......
[   16.692565] .... register #00: 01000000
[   16.696409] .......    : physical APIC id: 01
[   16.700770] .......    : Delivery Type: 0
[   16.704782] .......    : LTS          : 0
[   16.708798] .... register #01: 00070020
[   16.712642] .......     : max redirection entries: 07
[   16.717698] .......     : PRQ implemented: 0
[   16.721976] .......     : IO APIC version: 20
[   16.726335] .... register #02: 00000000
[   16.730174] .......     : arbitration: 00
[   16.734186] .... register #03: 00000001
[   16.738026] .......     : Boot DT    : 1
[   16.741954] .... IRQ redirection table:
[   16.745803] IOAPIC 7:
[   16.748092]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.755927]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.763758]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.771586]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.779418]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.787246]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.795078]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.802905]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.810742] IO APIC #18......
[   16.813718] .... register #00: 02000000
[   16.817558] .......    : physical APIC id: 02
[   16.821916] .......    : Delivery Type: 0
[   16.825931] .......    : LTS          : 0
[   16.829944] .... register #01: 00070020
[   16.833779] .......     : max redirection entries: 07
[   16.838835] .......     : PRQ implemented: 0
[   16.843105] .......     : IO APIC version: 20
[   16.847467] .... register #02: 00000000
[   16.851303] .......     : arbitration: 00
[   16.855318] .... register #03: 00000001
[   16.859159] .......     : Boot DT    : 1
[   16.863091] .... IRQ redirection table:
[   16.866931] IOAPIC 8:
[   16.869212]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.877044]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.884872]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.892708]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.900540]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.908376]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.916209]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.924045]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   16.931879] IRQ to pin mappings:
[   16.935118] IRQ0 -> 0:2
[   16.937578] IRQ1 -> 0:1
[   16.940030] IRQ3 -> 0:3
[   16.942483] IRQ4 -> 0:4
[   16.944938] IRQ5 -> 0:5
[   16.947397] IRQ6 -> 0:6
[   16.949852] IRQ7 -> 0:7
[   16.952312] IRQ8 -> 0:8
[   16.954763] IRQ9 -> 0:9
[   16.957218] IRQ10 -> 0:10
[   16.959853] IRQ11 -> 0:11
[   16.962488] IRQ12 -> 0:12
[   16.965123] IRQ13 -> 0:13
[   16.967757] IRQ14 -> 0:14
[   16.970392] IRQ15 -> 0:15
[   16.973023] IRQ16 -> 0:16
[   16.975649] IRQ19 -> 0:19
[   16.978275] IRQ25 -> 2:7
[   16.980814] IRQ27 -> 3:7
[   16.983357] IRQ29 -> 3:0
[   16.985904] IRQ30 -> 4:7
[   16.988449] IRQ33 -> 5:7
[   16.990988] IRQ35 -> 5:0
[   16.993531] IRQ36 -> 5:4
[   16.996078] IRQ38 -> 5:5
[   16.998616] IRQ40 -> 8:7
[   17.001154] IRQ43 -> 2:0
[   17.003697] IRQ53 -> 2:4
[   17.006244] IRQ63 -> 2:5
[   17.008793] IRQ73 -> 2:6
[   17.011340] IRQ83 -> 3:6
[   17.013907] .................................... done.
[   17.019129] AVX2 version of gcm_enc/dec engaged.
[   17.023752] AES CTR mode by8 optimization enabled
[   17.029517] sched_clock: Marking stable (16532736550, 496775735)->(17388=
575241, -359062956)
[   17.038538] registered taskstats version 1
[   17.042652] Loading compiled-in X.509 certificates
[   17.048193] Loaded X.509 cert 'Build time autogenerated kernel key: 6da1=
fa08f8f6faad613cae30e8cdf1b80ffda083'
[   17.058184] zswap: loaded using pool lzo/zbud
[   17.062841] Key type ._fscrypt registered
[   17.066858] Key type .fscrypt registered
[   17.070791] Key type fscrypt-provisioning registered
[   17.075870] pstore: Using crash dump compression: deflate
[   17.084189] Key type encrypted registered
[   17.088204] AppArmor: AppArmor sha1 policy hashing enabled
[   17.093701] ima: No TPM chip found, activating TPM-bypass!
[   17.099191] ima: Allocated hash algorithm: sha1
[   17.103730] ima: No architecture policies found
[   17.108270] evm: Initialising EVM extended attributes:
[   17.113411] evm: security.selinux
[   17.116728] evm: security.apparmor
[   17.120134] evm: security.ima
[   17.123108] evm: security.capability
[   17.126689] evm: HMAC attrs: 0x1
[   17.131056] TAP version 14
[   17.133768]     # Subtest: property-entry
[   17.133770]     1..7
[   17.137978]     ok 1 - pe_test_uints
[   17.140359]     ok 2 - pe_test_uint_arrays
[   17.144109]     ok 3 - pe_test_strings
[   17.148361]     ok 4 - pe_test_bool
[   17.152249]     ok 5 - pe_test_move_inline_u8
[   17.155951]     ok 6 - pe_test_move_inline_str
[   17.160524]     ok 7 - pe_test_reference
[   17.164974] ok 1 - property-entry
[   20.875302] igb 0000:18:00.3 eth3: igb: eth3 NIC Link is Up 1000 Mbps Fu=
ll Duplex, Flow Control: RX/TX
[   20.884913] IPv6: ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
[   20.896892] Sending DHCP requests ., OK
[   20.904772] IP-Config: Got DHCP answer from 192.168.3.2, my address is 1=
92.168.3.151
[   20.912510] IP-Config: Complete:
[   20.915741]      device=3Deth3, hwaddr=3Db4:96:91:32:4c:8b, ipaddr=3D192=
=2E168.3.151, mask=3D255.255.255.0, gw=3D192.168.3.200
[   20.926085]      host=3Dlkp-csl-2sp3, domain=3Dlkp.intel.com, nis-domain=
=3D(none)
[   20.933048]      bootserver=3D192.168.3.200, rootserver=3D192.168.3.200,=
 rootpath=3D
[   20.933048]      nameserver0=3D192.168.3.200
[   21.198724] Freeing unused decrypted memory: 2040K
[   21.204187] Freeing unused kernel image (initmem) memory: 2412K
[   21.211819] Write protecting the kernel read-only data: 22528k
[   21.218360] Freeing unused kernel image (text/rodata gap) memory: 2040K
[   21.225417] Freeing unused kernel image (rodata/data gap) memory: 1252K
[   21.237853] Run /init as init process
[   21.241524]   with arguments:
[   21.244505]     /init
[   21.246789]     nokaslr
[   21.249243]   with environment:
[   21.252390]     HOME=3D/
[   21.254757]     TERM=3Dlinux
[   21.257474]     user=3Dlkp
[   21.260016]     job=3D/lkp/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-perf=
ormance-1SSD-btrfs-nfsv4-sync-100%-300s-write-128G-ucode=3D0x400002c-monito=
r=3Da122c70f-debian-10.4-x86_64-20200603-20200915-84129-1i8kzyy-0.yaml
[   21.278763]     ARCH=3Dx86_64
[   21.281567]     kconfig=3Dx86_64-rhel-8.3
[   21.285407]     branch=3Dlinux-devel/fixup-3b54a0a703f17d2b1317d24beefcd=
cca587a7667
[   21.292888]     commit=3D6e85ab8532a52e24a614dfc017c5e8a699c53cc6
[   21.298806]     BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/6e85ab8532=
a52e24a614dfc017c5e8a699c53cc6/vmlinuz-5.8.0-rc7-00166-g6e85ab8532a52
[   21.311313]     max_uptime=3D1500
[   21.314456]     RESULT_ROOT=3D/result/fio-basic/4k-performance-1SSD-btrf=
s-nfsv4-sync-100%-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f/lkp-=
csl-2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/6e85ab8532a5=
2e24a614dfc017c5e8a699c53cc6/2
[   21.336239]     LKP_SERVER=3Dinn
[   21.339303]     softlockup_panic=3D1
[   21.342708]     prompt_ramdisk=3D0
[   21.345943]     vga=3Dnormal
[   21.352843] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.
[   21.361724] systemd[1]: System time before build time, advancing clock.



[   21.657556] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   21.657697] IOAPIC[1]: Set routing entry (9-2 -> 0xef -> IRQ 343 Mode:1 =
Active:1 Dest:0)
[   21.660751] nvme nvme1: pci function 0000:84:00.0
[0;1;39mRPC Pipe
[   21.679695] ahci 0000:00:11.5: version 3.0
         Starting=20
[   21.698673] IOAPIC[1]: Set routing entry (9-3 -> 0xef -> IRQ 348 Mode:1 =
Active:1 Dest:0)
[   21.698681] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca2-0x0ca3] regsi=
ze 1 spacing 1 irq 0
[   21.713974] ahci 0000:00:11.5: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x=
30 impl SATA mode
[   21.724646] ahci 0000:00:11.5: flags: 64bit ncq sntf led clo only pio sl=
um part ems deso sadm sds apst=20
1;39mRemount Roo
[   21.760022] RAPL PMU: hw unit of domain package 2^-14 Joules
t and Kernel Fil
[   21.767064] RAPL PMU: hw unit of domain dram 2^-16 Joules
[   21.809787] [drm] AST 2500 detected
[   21.824412] [drm] Analog VGA only
[   21.827747] [drm] dram MCLK=3D800 Mhz type=3D7 bus_width=3D16 size=3D010=
00000
[   21.842254] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[   21.848644] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man=
_id: 0x000157, prod_id: 0x007b, dev_id: 0x22)
[   21.848785] [TTM] Initializing pool allocator
[   21.863787] [TTM] Initializing DMA pool allocator
ly Kernel Variab
[   21.868757] [drm] Initialized ast 0.1.0 20120228 for 0000:02:00.0 on min=
or 0
[   22.292884] ast 0000:02:00.0: VGA-1: EDID is invalid:
[   22.297951] 	[00] BAD  00 ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff
[   22.304484] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   22.311016] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   22.317552] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   22.324085] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   22.330621] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   22.337153] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   22.343680] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   22.351082] fbcon: astdrmfb (fb0) is primary device
[   22.362608] Console: switching to colour frame buffer device 128x48
[   22.376165] ast 0000:02:00.0: fb0: astdrmfb frame buffer device
[   22.441931] IOAPIC[5]: Set routing entry (15-2 -> 0xef -> IRQ 356 Mode:1=
 Active:1 Dest:0)
[   22.444227] scsi host0: ahci
m] Reached targe
[   22.458543] scsi host2: ahci
[   22.467115] scsi host4: ahci
[   22.471191] scsi host5: ahci
         Startin
[   22.474143] ata1: DUMMY
rc.local Compati
[   22.477977] ata3: DUMMY

[   22.477983] ata5: SATA max UDMA/133 abar m524288@0x92180000 port 0x92180=
300 irq 347
[   22.484007] random: ln: uninitialized urandom read (6 bytes read)
[   21.980372]=20
[   22.485654] ata6: SATA max UDMA/133 abar m524288@0x92180000 port 0x92180=
380 irq 347
rc.local
[   22.491152] random: ln: uninitialized urandom read (6 bytes read)
[1164]: PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin=
:/lkp/lkp/src/b
[   22.525626] IOAPIC[5]: Set routing entry (15-3 -> 0xef -> IRQ 358 Mode:1=
 Active:1 Dest:0)
in
LKP: HOSTNAME lkp-csl-2sp3, MAC=20
[   22.545312] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x=
ff impl SATA mode
b4:96:91:32:4c:8
[   22.553916] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio sl=
um part ems deso sadm sds apst=20
8, kernel 5.8.0-rc7-00166-g6e85ab8532a52 1, serial console /dev/ttyS0
[   22.693811] scsi host6: ahci
[   22.736881] scsi host10: ahci
[   22.748958] scsi host11: ahci
1;39mLSB: OpenIP
[   22.787264] ata8: SATA max UDMA/133 abar m524288@0x92100000 port 0x92100=
180 irq 360
MI Driver init s
[   22.796280] ata9: SATA max UDMA/133 abar m524288@0x92100000 port 0x92100=
200 irq 360
[   22.805316] ata10: SATA max UDMA/133 abar m524288@0x92100000 port 0x9210=
0280 irq 360
[   22.808463] ata6: SATA link down (SStatus 0 SControl 300)
[   22.814110] ata11: SATA max UDMA/133 abar m524288@0x92100000 port 0x9210=
0300 irq 360
[   22.819980] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   22.828062] ata12: SATA max UDMA/133 abar m524288@0x92100000 port 0x9210=
0380 irq 360
[   22.842819] ata13: SATA max UDMA/133 abar m524288@0x92100000 port 0x9210=
0400 irq 360
[   22.842821] ata14: SATA max UDMA/133 abar m524288@0x92100000 port 0x9210=
0480 irq 360
[   22.890426] ata5.00: configured for UDMA/100
[   22.890448] EDAC skx: Can't find size for NVDIMM ADR=3D0x0/SMBIOS=3D0x1a
[   22.902067] EDAC MC0: Giving out device to module skx_edac controller Sk=
ylake Socket#0 IMC#0: DEV 0000:3a:0a.0 (INTERRUPT)
[   22.914219] EDAC skx: Can't find size for NVDIMM ADR=3D0x100/SMBIOS=3D0x=
25
[   22.921385] EDAC MC1: Giving out device to module skx_edac controller Sk=
ylake Socket#0 IMC#1: DEV 0000:3a:0c.0 (INTERRUPT)
[   22.933938] EDAC skx: Can't find size for NVDIMM ADR=3D0x1000/SMBIOS=3D0=
x30
[   22.941170] EDAC MC2: Giving out device to module skx_edac controller Sk=
ylake Socket#1 IMC#0: DEV 0000:ae:0a.0 (INTERRUPT)
[   22.953553] EDAC skx: Can't find size for NVDIMM ADR=3D0x1100/SMBIOS=3D0=
x3b
[   22.960772] EDAC MC3: Giving out device to module skx_edac controller Sk=
ylake Socket#1 IMC#1: DEV 0000:ae:0c.0 (INTERRUPT)
[   22.972349] EDAC skx: No firmware support for address translation.
[   22.979072] EDAC skx: Only decoding DDR4 address!
[   23.042231] intel_rapl_common: Found RAPL domain package
[   23.056544] intel_rapl_common: Found RAPL domain dram
[   23.062183] intel_rapl_common: DRAM domain energy unit 15300pj
[   23.076997] intel_rapl_common: RAPL package-0 domain package locked by B=
IOS
[   23.093694] intel_rapl_common: Found RAPL domain package
[   23.108065] intel_rapl_common: Found RAPL domain dram
[   23.113633] intel_rapl_common: DRAM domain energy unit 15300pj
[   23.119980] intel_rapl_common: RAPL package-1 domain package locked by B=
IOS
[   23.168218] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   23.175142] ata8: SATA link down (SStatus 0 SControl 300)
[   23.181361] ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   23.188775] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   23.195806] ata13: SATA link down (SStatus 0 SControl 300)
[   23.202126] ata14: SATA link down (SStatus 0 SControl 300)
[   23.208387] ata12: SATA link down (SStatus 0 SControl 300)
[   23.214654] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   23.221925] ata9.00: ATA-7: ST910021AS, 3.06, max UDMA/133
[   23.228013] ata9.00: 195371568 sectors, multi 0: LBA48 NCQ (depth 32)
[   23.235057] ata10.00: ATA-9: INTEL SSDSC2CW240A3, 400i, max UDMA/133
[   23.242320] ata10.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[   23.250225] ata7.00: ATA-7: INTEL SSDSA2M080G2GN, 2CV102M3, max UDMA/133
[   23.257960] ata7.00: 156301488 sectors, multi 1: LBA48 NCQ (depth 32)
[   23.265456] ata11.00: ATA-8: WDC WD2500BEKT-00PVMT0, 01.01A01, max UDMA/=
133
[   23.273091] ata11.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 32), =
AA
[   23.280947] ata7.00: configured for UDMA/133
[   23.286052] ata9.00: configured for UDMA/133
[   23.290963] ata11.00: configured for UDMA/133
[   23.296397] ata10.00: configured for UDMA/133
[   23.534626] urandom_read: 2 callbacks suppressed
[   23.534627] random: perl: uninitialized urandom read (4 bytes read)
[   23.604715] random: update-rc.d: uninitialized urandom read (4 bytes rea=
d)
[   23.687546] random: deb-systemd-hel: uninitialized urandom read (4 bytes=
 read)
[   23.990841] random: crng init done
[   23.994840] random: 1 urandom warning(s) missed due to ratelimiting
[   24.026891]  nvme0n1: p1
[   24.287699] nvme nvme1: 31/0/0 default/read/poll queues
[   24.301156]  nvme1n1: p1
[   24.314104] scsi 4:0:0:0: CD-ROM            TEAC     DV-W28S-B        AT=
11 PQ: 0 ANSI: 5
[   24.346817] raid6: avx512x4 gen() 12752 MB/s
[   24.367819] raid6: avx512x4 xor()  7003 MB/s
[   24.388817] raid6: avx512x2 gen() 12883 MB/s
[   24.409818] raid6: avx512x2 xor() 29946 MB/s
[   24.430818] raid6: avx512x1 gen() 12855 MB/s
[   24.451817] raid6: avx512x1 xor() 26586 MB/s
[   24.472818] raid6: avx2x4   gen() 12849 MB/s
[   24.493819] raid6: avx2x4   xor()  6192 MB/s
[   24.514817] raid6: avx2x2   gen() 12830 MB/s
[   24.535816] raid6: avx2x2   xor() 22335 MB/s
[   24.556819] raid6: avx2x1   gen()  9036 MB/s
[   24.577818] raid6: avx2x1   xor() 18035 MB/s
[   24.598819] raid6: sse2x4   gen() 12070 MB/s
[   24.619818] raid6: sse2x4   xor()  6205 MB/s
[   24.640818] raid6: sse2x2   gen()  9079 MB/s
[   24.661818] raid6: sse2x2   xor()  7832 MB/s
[   24.682817] raid6: sse2x1   gen()  8951 MB/s
[   24.703818] raid6: sse2x1   xor()  6346 MB/s
[   24.708454] raid6: using algorithm avx512x2 gen() 12883 MB/s
[   24.714488] raid6: .... xor() 29946 MB/s, rmw enabled
[   24.719912] raid6: using avx512x2 recovery algorithm
[   24.740597] scsi 6:0:0:0: Direct-Access     ATA      INTEL SSDSA2M080 02=
M3 PQ: 0 ANSI: 5
[   24.749585] scsi 4:0:0:0: Attached scsi generic sg0 type 5
[   24.755654] scsi 6:0:0:0: Attached scsi generic sg1 type 0
[   24.761933] scsi 8:0:0:0: Direct-Access     ATA      ST910021AS       3.=
06 PQ: 0 ANSI: 5
[   24.770759] scsi 8:0:0:0: Attached scsi generic sg2 type 0
[   24.770981] ata7.00: Enabling discard_zeroes_data
[   24.781916] sd 8:0:0:0: [sdb] 195371568 512-byte logical blocks: (100 GB=
/93.2 GiB)
[   24.781918] scsi 9:0:0:0: Direct-Access     ATA      INTEL SSDSC2CW24 40=
0i PQ: 0 ANSI: 5
[   24.781922] sd 6:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 G=
B/74.5 GiB)
[   24.781927] sd 6:0:0:0: [sda] Write Protect is off
[   24.781928] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   24.781933] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   24.789964] sd 8:0:0:0: [sdb] Write Protect is off
[   24.798714] sd 9:0:0:0: Attached scsi generic sg3 type 0
[   24.798746] sd 9:0:0:0: [sdc] 468862128 512-byte logical blocks: (240 GB=
/224 GiB)
[   24.798751] sd 9:0:0:0: [sdc] Write Protect is off
[   24.798752] sd 9:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   24.798758] sd 9:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   24.806645] sd 8:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   24.806661] sd 8:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   24.812284] scsi 10:0:0:0: Direct-Access     ATA      WDC WD2500BEKT-0 1=
A01 PQ: 0 ANSI: 5
[   24.866472] xor: automatically using best checksumming function   avx   =
   =20
[   24.872230] sd 10:0:0:0: Attached scsi generic sg4 type 0
[   24.872235] sd 10:0:0:0: [sdd] 488397168 512-byte logical blocks: (250 G=
B/233 GiB)
[   24.872240] sd 10:0:0:0: [sdd] Write Protect is off
[   24.872241] sd 10:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   24.872247] sd 10:0:0:0: [sdd] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA
[   24.981065] ata7.00: Enabling discard_zeroes_data
[   24.987704]  sdc: sdc1
[   24.991647] sd 9:0:0:0: [sdc] Attached SCSI disk
[   25.005914]  sda: sda1 sda2 sda3
[   25.009295] sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd=
/rw xa/form2 cdda tray
[   25.014558] ata7.00: Enabling discard_zeroes_data
[   25.020892] cdrom: Uniform CD-ROM driver Revision: 3.20
[   25.026230] sd 6:0:0:0: [sda] Attached SCSI disk
[   25.026882]  sdb: sdb1 sdb2
[   25.027846] sd 8:0:0:0: [sdb] Attached SCSI disk
[   25.041443]  sdd: sdd1
[   25.051542] sd 10:0:0:0: [sdd] Attached SCSI disk
[   25.059297] Btrfs loaded, crc32c=3Dcrc32c-intel
[   25.067076] BTRFS: device fsid b3351cd9-d77a-4004-b712-cb4c7f0c147c devi=
d 1 transid 5 /dev/nvme1n1p1 scanned by systemd-udevd (1002)
[   25.082934] BTRFS: device fsid ded1dc4f-d9ce-4300-bd47-1ab807f65848 devi=
d 1 transid 2904 /dev/sdc1 scanned by systemd-udevd (1097)
[   25.097721] sr 4:0:0:0: Attached scsi CD-ROM sr0
[   26.822941] Kernel tests: Boot OK!
[   26.822948]=20
[   29.146506] memmap_init_zone_device initialised 65027584 pages in 3965ms
[   30.065323] memmap_init_zone_device initialised 65027584 pages in 4808ms
[   31.072727] install debs round one: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   31.072728]=20
[   31.086809] /opt/deb/libpython2.7_2.7.16-2+deb10u1_amd64.deb
[   31.086810]=20
[   31.095313] /opt/deb/libpython3.7_3.7.3-2+deb10u1_amd64.deb
[   31.095314]=20
[   31.103299] /opt/deb/sysstat_12.0.3-2_amd64.deb
[   31.103300]=20
[   31.110553] /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u1_amd64.deb
[   31.110554]=20
[   31.119561] /opt/deb/python3.7-minimal_3.7.3-2+deb10u1_amd64.deb
[   31.119562]=20
[   31.128303] /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   31.128304]=20
[   31.136183] /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u1_amd64.deb
[   31.136183]=20
[   31.144991] /opt/deb/python3.7_3.7.3-2+deb10u1_amd64.deb
[   31.144992]=20
[   31.152860] /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   31.152860]=20
[   31.160718] /opt/deb/python3_3.7.3-1_amd64.deb
[   31.160719]=20
[   31.167713] /opt/deb/libf2fs-format4_1.11.0-1.1_amd64.deb
[   31.167713]=20
[   31.175609] /opt/deb/gawk_1%3a4.2.1+dfsg-1_amd64.deb
[   31.175610]=20
[   31.183199] Selecting previously unselected package ntpdate.
[   31.183200]=20
[   31.192025] (Reading database ... 16553 files and directories currently =
installed.)
[   31.192026]=20
[   31.202919] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   31.202920]=20
[   31.212658] Unpacking ntpdate (1:4.2.8p12+dfsg-4) ...
[   31.212659]=20
[   31.220540] Selecting previously unselected package libpython2.7:amd64.
[   31.220541]=20
[   31.230416] Preparing to unpack .../libpython2.7_2.7.16-2+deb10u1_amd64.=
deb ...
[   31.230418]=20
[   31.240508] Unpacking libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.240508]=20
[   31.249261] Selecting previously unselected package libpython3.7:amd64.
[   31.249262]=20
[   31.258882] Preparing to unpack .../libpython3.7_3.7.3-2+deb10u1_amd64.d=
eb ...
[   31.258882]=20
[   31.270760] Unpacking libpython3.7:amd64 (3.7.3-2+deb10u1) ...
[   31.270761]=20
[   31.280366] Selecting previously unselected package sysstat.
[   31.280367]=20
[   31.289745] Preparing to unpack .../deb/sysstat_12.0.3-2_amd64.deb ...
[   31.289746]=20
[   31.299508] Unpacking sysstat (12.0.3-2) ...
[   31.299508]=20
[   31.307636] Selecting previously unselected package libpython3.7-minimal=
:amd64.
[   31.307637]=20
[   31.318993] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u1=
_amd64.deb ...
[   31.318994]=20
[   31.330646] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u1) ...
[   31.330647]=20
[   31.340862] Selecting previously unselected package python3.7-minimal.
[   31.340863]=20
[   31.351373] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u1_am=
d64.deb ...
[   31.351374]=20
[   31.362639] Unpacking python3.7-minimal (3.7.3-2+deb10u1) ...
[   31.362640]=20
[   31.372089] Selecting previously unselected package python3-minimal.
[   31.372090]=20
[   31.374894] error: dpkg -i /opt/deb/python3_3.7.3-1_amd64.deb failed.
[   31.374895]=20
[   31.380198] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   31.380199]=20
[   31.400624] Unpacking python3-minimal (3.7.3-1) ...
[   31.400625]=20
[   31.409411] Selecting previously unselected package libpython3.7-stdlib:=
amd64.
[   31.409412]=20
[   31.420728] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u1_=
amd64.deb ...
[   31.420728]=20
[   31.432385] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u1) ...
[   31.432385]=20
[   31.442468] Selecting previously unselected package python3.7.
[   31.442469]=20
[   31.452223] Preparing to unpack .../python3.7_3.7.3-2+deb10u1_amd64.deb =
=2E..
[   31.452224]=20
[   31.462673] Unpacking python3.7 (3.7.3-2+deb10u1) ...
[   31.462674]=20
[   31.471639] Selecting previously unselected package libpython3-stdlib:am=
d64.
[   31.471640]=20
[   31.482556] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   31.482557]=20
[   31.493116] Unpacking libpython3-stdlib:amd64 (3.7.3-1) ...
[   31.493117]=20
[   31.502294] Selecting previously unselected package python3.
[   31.502295]=20
[   31.511736] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   31.511737]=20
[   31.521492] Unpacking python3 (3.7.3-1) ...
[   31.521493]=20
[   31.529509] Selecting previously unselected package libf2fs-format4:amd6=
4.
[   31.529510]=20
[   31.540300] Preparing to unpack .../libf2fs-format4_1.11.0-1.1_amd64.deb=
 ...
[   31.540300]=20
[   31.550978] Unpacking libf2fs-format4:amd64 (1.11.0-1.1) ...
[   31.550979]=20
[   31.560227] Selecting previously unselected package gawk.
[   31.560228]=20
[   31.569412] Preparing to unpack .../gawk_1%3a4.2.1+dfsg-1_amd64.deb ...
[   31.569413]=20
[   31.579422] Unpacking gawk (1:4.2.1+dfsg-1) ...
[   31.579422]=20
[   31.587488] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   31.587489]=20
[   31.596289] Setting up libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.596289]=20
[   31.605598] Setting up sysstat (12.0.3-2) ...
[   31.605599]=20
[   31.613703] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u1) ...
[   31.613704]=20
[   31.623872] Setting up python3.7-minimal (3.7.3-2+deb10u1) ...
[   31.623872]=20
[   31.633096] Setting up python3-minimal (3.7.3-1) ...
[   31.633096]=20
[   31.641615] Setting up libf2fs-format4:amd64 (1.11.0-1.1) ...
[   31.641616]=20
[   31.650655] Setting up gawk (1:4.2.1+dfsg-1) ...
[   31.650655]=20
[   31.658795] Setting up libpython3.7:amd64 (3.7.3-2+deb10u1) ...
[   31.658795]=20
[   31.668353] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u1) ...
[   31.668354]=20
[   31.678259] Setting up python3.7 (3.7.3-2+deb10u1) ...
[   31.678260]=20
[   31.686873] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   31.686873]=20
[   31.695688] Setting up python3 (3.7.3-1) ...
[   31.695689]=20
[   31.703346] running python rtupdate hooks for python3.7...
[   31.703347]=20
[   31.712239] Processing triggers for libc-bin (2.28-10) ...
[   31.712239]=20
[   31.721179] Processing triggers for systemd (241-7~deb10u4) ...
[   31.721180]=20
[   31.730515] Processing triggers for mime-support (3.62) ...
[   31.730516]=20
[   31.740578] dpkg: regarding .../python3-minimal_3.7.3-1_amd64.deb contai=
ning python3-minimal, pre-dependency problem:
[   31.740579]=20
[   31.756175]  python3-minimal pre-depends on python3.7-minimal (>=3D 3.7.=
3-1~)
[   31.756176]=20
[   31.771077]   python3.7-minimal is unpacked, but has never been configur=
ed.
[   31.771078]=20
[   31.781915]=20
[   31.784835] dpkg: warning: ignoring pre-dependency problem!
[   31.784835]=20
[   31.794756] dpkg: regarding .../deb/python3_3.7.3-1_amd64.deb containing=
 python3, pre-dependency problem:
[   31.794757]=20
[   31.807853]  python3 pre-depends on python3-minimal (=3D 3.7.3-1)
[   31.807854]=20
[   31.817520]   python3-minimal is unpacked, but has never been configured.
[   31.817521]=20
[   31.826998]=20
[   31.829920] dpkg: warning: ignoring pre-dependency problem!
[   31.829921]=20
[   31.839799] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   31.839800]=20
[   31.853587]  gawk pre-depends on libmpfr6 (>=3D 3.1.3)
[   31.853588]=20
[   31.861988]   libmpfr6 is not installed.
[   31.861989]=20
[   31.868585]=20
[   31.871522] dpkg: warning: ignoring pre-dependency problem!
[   31.871523]=20
[   31.881419] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   31.881420]=20
[   31.894321]  gawk pre-depends on libsigsegv2 (>=3D 2.9)
[   31.894322]=20
[   31.902623]   libsigsegv2 is not installed.
[   31.902623]=20
[   31.909475]=20
[   31.912392] dpkg: warning: ignoring pre-dependency problem!
[   31.912393]=20
[   31.920627]=20
[   31.923736] Creating config file /etc/default/sysstat with new version
[   31.923737]=20
[   31.934576] update-alternatives: using /usr/bin/sar.sysstat to provide /=
usr/bin/sar (sar) in auto mode
[   31.934577]=20
[   31.948206] dpkg: libf2fs-format4:amd64: dependency problems, but config=
uring anyway as you requested:
[   31.948207]=20
[   31.961153]  libf2fs-format4:amd64 depends on libf2fs5; however:
[   31.961153]=20
[   31.970524]   Package libf2fs5 is not installed.
[   31.970525]=20
[   31.977852]=20
[   31.981266] dpkg: gawk: dependency problems, but configuring anyway as y=
ou requested:
[   31.981267]=20
[   31.992588]  gawk depends on libmpfr6 (>=3D 3.1.3); however:
[   31.992588]=20
[   32.001360]   Package libmpfr6 is not installed.
[   32.001361]=20
[   32.009458]  gawk depends on libsigsegv2 (>=3D 2.9); however:
[   32.009459]=20
[   32.018377]   Package libsigsegv2 is not installed.
[   32.018377]=20
[   32.025871]=20
[   32.029512] dpkg: libpython3.7:amd64: dependency problems, but configuri=
ng anyway as you requested:
[   32.029513]=20
[   32.043378]  libpython3.7:amd64 depends on libpython3.7-stdlib (=3D 3.7.=
3-2+deb10u1).
[   32.043379]=20
[   32.054841]=20
[   32.058664] dpkg: libpython3.7-stdlib:amd64: dependency problems, but co=
nfiguring anyway as you requested:
[   32.058665]=20
[   32.071999]  libpython3.7-stdlib:amd64 depends on libmpdec2; however:
[   32.072000]=20
[   32.081740]   Package libmpdec2 is not installed.
[   32.081741]=20
[   32.089082]=20
[   32.092124] dpkg-query: package 'linux-perf-4.19' is not installed
[   32.092125]=20
[   32.102337] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   32.102338]=20
[   32.113607] Traceback (most recent call last):
[   32.113608]=20
[   32.121554]   File "/usr/bin/py3clean", line 210, in <module>
[   32.121555]=20
[   32.130115]     main()
[   32.130115]=20
[   32.135900]   File "/usr/bin/py3clean", line 196, in main
[   32.135901]=20
[   32.144844]     pfiles =3D set(dpf.from_package(options.package))
[   32.144845]=20
[   32.154701]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   32.154702]=20
[   32.167006]     raise Exception("cannot get content of %s" % package_nam=
e)
[   32.167007]=20
[   32.177808] Exception: cannot get content of linux-perf-4.19
[   32.177808]=20
[   32.187146] error running python rtupdate hook linux-perf-4.19
[   32.187147]=20
[   32.196501] dpkg: error processing package python3 (--install):
[   32.196501]=20
[   32.206702]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   32.206703]=20
[   32.219439] Errors were encountered while processing:
[   32.219440]=20
[   32.227247]  python3
[   32.227248]=20
[   32.232576] handle /opt/deb/keep-deb.lkp...
[   32.232576]=20
[   32.241262] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/gawk_1%3a4.2.1+dfsg-1_amd64.deb
[   32.241263]=20
[   32.255664] (Reading database ... 17528 files and directories currently =
installed.)
[   32.255665]=20
[   32.267046] Preparing to unpack .../gawk_1%3a4.2.1+dfsg-1_amd64.deb ...
[   32.267047]=20
[   32.277334] Unpacking gawk (1:4.2.1+dfsg-1) over (1:4.2.1+dfsg-1) ...
[   32.277335]=20
[   32.287066] Setting up gawk (1:4.2.1+dfsg-1) ...
[   32.287067]=20
[   32.294845] handle /opt/deb/keep-deb.fs...
[   32.294846]=20
[   32.639000] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u1_amd64.deb
[   32.639001]=20
[   32.655953] (Reading database ... 17528 files and directories currently =
installed.)
[   32.655955]=20
[   32.668237] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u1=
_amd64.deb ...
[   32.668238]=20
[   32.688675] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u1) over =
(3.7.3-2+deb10u1) ...
[   32.688676]=20
[   32.701627] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u1) ...
[   32.701628]=20
[   32.713979] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7-minimal_3.7.3-2+deb10u1_amd64.deb
[   32.713980]=20
[   32.731257] (Reading database ... 17528 files and directories currently =
installed.)
[   32.731258]=20
[   32.744601] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u1_am=
d64.deb ...
[   32.744603]=20
[   32.757193] Unpacking python3.7-minimal (3.7.3-2+deb10u1) over (3.7.3-2+=
deb10u1) ...
[   32.757194]=20
[   32.776965] Setting up python3.7-minimal (3.7.3-2+deb10u1) ...
[   32.776965]=20
[   32.788511] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   32.788512]=20
[   32.804160] (Reading database ... 17528 files and directories currently =
installed.)
[   32.804161]=20
[   32.816914] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   32.816915]=20
[   32.828315] Unpacking python3-minimal (3.7.3-1) over (3.7.3-1) ...
[   32.828316]=20
[   32.838077] Setting up python3-minimal (3.7.3-1) ...
[   32.838078]=20
[   32.848050] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u1_amd64.deb
[   32.848051]=20
[   32.864643] (Reading database ... 17528 files and directories currently =
installed.)
[   32.864643]=20
[   32.876506] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u1_=
amd64.deb ...
[   32.876507]=20
[   32.888675] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u1) over (=
3.7.3-2+deb10u1) ...
[   32.888676]=20
[   32.901082] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u1) ...
[   32.901082]=20
[   32.912490] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7_3.7.3-2+deb10u1_amd64.deb
[   32.912491]=20
[   32.928088] (Reading database ... 17528 files and directories currently =
installed.)
[   32.928089]=20
[   32.941177] Preparing to unpack .../python3.7_3.7.3-2+deb10u1_amd64.deb =
=2E..
[   32.941178]=20
[   32.952128] Unpacking python3.7 (3.7.3-2+deb10u1) over (3.7.3-2+deb10u1)=
 ...
[   32.952129]=20
[   32.963623] Setting up python3.7 (3.7.3-2+deb10u1) ...
[   32.963624]=20
[   32.972585] Processing triggers for mime-support (3.62) ...
[   32.972586]=20
[   32.983021] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   32.983022]=20
[   32.998113] (Reading database ... 17528 files and directories currently =
installed.)
[   32.998114]=20
[   33.009849] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   33.009850]=20
[   33.020851] Unpacking libpython3-stdlib:amd64 (3.7.3-1) over (3.7.3-1) .=
=2E.
[   33.020852]=20
[   33.031534] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   33.031535]=20
[   33.041891] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3_3.7.3-1_amd64.deb
[   33.041892]=20
[   33.056104] (Reading database ... 17528 files and directories currently =
installed.)
[   33.056104]=20
[   33.067734] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   33.067735]=20
[   33.078170] running python pre-rtupdate hooks for python3.7...
[   33.078171]=20
[   33.087728] Unpacking python3 (3.7.3-1) over (3.7.3-1) ...
[   33.087729]=20
[   33.096696] Setting up python3 (3.7.3-1) ...
[   33.096697]=20
[   33.104664] running python rtupdate hooks for python3.7...
[   33.104664]=20
[   33.113985] dpkg-query: package 'linux-perf-4.19' is not installed
[   33.113986]=20
[   33.124358] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   33.124359]=20
[   33.135808] Traceback (most recent call last):
[   33.135808]=20
[   33.143966]   File "/usr/bin/py3clean", line 210, in <module>
[   33.143967]=20
[   33.152723]     main()
[   33.152723]=20
[   33.158662]   File "/usr/bin/py3clean", line 196, in main
[   33.158662]=20
[   33.167716]     pfiles =3D set(dpf.from_package(options.package))
[   33.167717]=20
[   33.177602]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   33.177603]=20
[   33.189135]     raise Exception("cannot get content of %s" % package_nam=
e)
[   33.189136]=20
[   33.199551] Exception: cannot get content of linux-perf-4.19
[   33.199552]=20
[   33.208784] error running python rtupdate hook linux-perf-4.19
[   33.208785]=20
[   33.218207] dpkg: error processing package python3 (--install):
[   33.218208]=20
[   33.228432]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   33.228433]=20
[   33.241217] Errors were encountered while processing:
[   33.241218]=20
[   33.249089]  python3
[   33.249090]=20
[   34.582706] 15 Sep 01:49:24 ntpdate[1864]: step time server 192.168.1.1 =
offset 49995433.752855 sec
[   34.582708]=20
[   34.603142] BTRFS info (device sdc1): disk space caching is enabled
[   34.610109] BTRFS info (device sdc1): has skinny extents
[   34.621301] BTRFS info (device sdc1): enabling ssd optimizations
[   34.639287] /lkp/lkp/src/bin/run-lkp
[   34.639289]=20
[   35.110528] device-mapper: uevent: version 1.0.3
[   35.116969] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised:=
 dm-devel@redhat.com
[   35.152733] BTRFS: device fsid 5ec63c22-d4b0-47fe-b22f-b765b3c072c1 devi=
d 1 transid 5 /dev/nvme1n1p1 scanned by mkfs.btrfs (2057)
[   35.173932] BTRFS info (device nvme1n1p1): disk space caching is enabled
[   35.181189] BTRFS info (device nvme1n1p1): has skinny extents
[   35.187477] BTRFS info (device nvme1n1p1): flagging fs with big metadata=
 feature
[   35.204585] BTRFS info (device nvme1n1p1): enabling ssd optimizations
[   35.213177] BTRFS info (device nvme1n1p1): checking UUID tree
[   36.486355] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   37.557702] NFSD: Using UMH upcall client tracking operations.
[   37.564125] NFSD: starting 90-second grace period (net f0000098)
[   37.580362] Key type dns_resolver registered
[   37.702893] NFS: Registering the id_resolver key type
[   37.708502] Key type id_resolver registered
[   37.713828] Key type id_legacy registered
[   37.758788] kernel profiling enabled schedstats, disable via kernel.sche=
d_schedstats.
[   38.070860] RESULT_ROOT=3D/result/fio-basic/4k-performance-1SSD-btrfs-nf=
sv4-sync-100%-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f/lkp-csl-=
2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/6e85ab8532a52e24=
a614dfc017c5e8a699c53cc6/2
[   38.070863]=20
[   38.101437] job=3D/lkp/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-performa=
nce-1SSD-btrfs-nfsv4-sync-100%-300s-write-128G-ucode=3D0x400002c-monitor=3D=
a122c70f-debian-10.4-x86_64-20200603-20200915-84129-1i8kzyy-0.yaml
[   38.101439]=20
[   39.505369] ------------------------------------------------------------
[   39.505371]=20
[   39.516219] perf_event_attr:
[   39.516221]=20
[   39.523015]   size                             120
[   39.523016]=20
[   39.531707]   { sample_period, sample_freq }   1000003
[   39.531708]=20
[   39.757647]   sample_type                      IP|TID|TIME|CALLCHAIN|ID|=
CPU
[   39.757649]=20
[   39.776879]   read_format                      ID
[   39.776880]=20
[   39.781845] result_service=3Dinn:/result, RESULT_MNT=3D/inn/result, RESU=
LT_ROOT=3D/inn/result/fio-basic/4k-performance-1SSD-btrfs-nfsv4-sync-100%-3=
00s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f/lkp-csl-2sp3/debian-10.=
4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/6e85ab8532a52e24a614dfc017c5e8a=
699c53cc6/2
[   39.781847]=20
[   39.783642]   disabled                         1
[   39.783644]=20
[   39.786004] mount.nfs: try 1 time... mount.nfs -o vers=3D3 inn:/result /=
inn/result
[   39.786005]=20
[   39.814608]   inherit                          1
[   39.814609]=20
[   39.819639] run-job /lkp/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-perfor=
mance-1SSD-btrfs-nfsv4-sync-100%-300s-write-128G-ucode=3D0x400002c-monitor=
=3Da122c70f-debian-10.4-x86_64-20200603-20200915-84129-1i8kzyy-0.yaml
[   39.819640]=20
[   39.821508]   precise_ip                       2
[   39.821509]=20
[   39.881051]   sample_id_all                    1
[   39.881053]=20
[   39.891030]   exclude_guest                    1
[   39.891031]=20
[   39.901355] ------------------------------------------------------------
[   39.901356]=20
[   39.913796] ------------------------------------------------------------
[   39.913797]=20
[   39.924769] perf_event_attr:
[   39.924770]=20
[   39.932663]   type                             1
[   39.932663]=20
[   39.942200]   size                             120
[   39.942201]=20
[   39.951844]   config                           0x9
[   39.951845]=20
[   39.961467]   { sample_period, sample_freq }   1000003
[   39.961468]=20
[   39.972002]   sample_type                      IP|TID|TIME|CALLCHAIN|ID|=
CPU
[   39.972003]=20
[   39.983430]   read_format                      ID
[   39.983431]=20
[   39.992482]   disabled                         1
[   39.992483]=20
[   40.001413]   inherit                          1
[   40.001414]=20
[   40.010342]   mmap                             1
[   40.010343]=20
[   40.019274]   comm                             1
[   40.019275]=20
[   40.028137]   enable_on_exec                   1
[   40.028137]=20
[   40.036999]   task                             1
[   40.037000]=20
[   40.045732]   sample_id_all                    1
[   40.045733]=20
[   40.054322]   mmap2                            1
[   40.054323]=20
[   40.062892]   comm_exec                        1
[   40.062893]=20
[   40.071385]   ksymbol                          1
[   40.071386]=20
[   40.079881]   bpf_event                        1
[   40.079881]=20
[   40.089033] ------------------------------------------------------------
[   40.089034]=20
[   40.100224] ------------------------------------------------------------
[   40.100225]=20
[   40.110124] perf_event_attr:
[   40.110125]=20
[   40.116825]   type                             1
[   40.116826]=20
[   40.125286]   size                             120
[   40.125287]=20
[   40.133853]   config                           0x9
[   40.133854]=20
[   40.142297]   watermark                        1
[   40.142299]=20
[   40.150550]   sample_id_all                    1
[   40.150551]=20
[   40.158802]   bpf_event                        1
[   40.158803]=20
[   40.167188]   { wakeup_events, wakeup_watermark } 1
[   40.167189]=20
[   40.176484] ------------------------------------------------------------
[   40.176485]=20
[   41.423696] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=3D/lk=
p/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-syn=
c-100%25-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f-debian-10.4-x=
86_64-20200603-20200915-84129-1i8kzyy-0.yaml&job_state=3Drunning -O /dev/nu=
ll
[   41.423699]=20
[   41.468707] target ucode: 0x400002c
[   41.468708]=20
[   41.484865] current_version: 400002c, target_version: 400002c
[   41.484866]=20
[   41.502923] 2020-09-15 01:49:25 dmsetup remove_all
[   41.502924]=20
[   41.520489] 2020-09-15 01:49:25 wipefs -a --force /dev/nvme1n1p1
[   41.520490]=20
[   41.540623] /dev/nvme1n1p1: 8 bytes were erased at offset 0x00010040 (bt=
rfs): 5f 42 48 52 66 53 5f 4d
[   41.540624]=20
[   41.562680] 2020-09-15 01:49:25 mkfs -t btrfs /dev/nvme1n1p1
[   41.562681]=20
[   41.580337] btrfs-progs v4.20.1=20
[   41.580338]=20
[   41.596595] See http://btrfs.wiki.kernel.org for more information.
[   41.596596]=20
[   41.614218]=20
[   41.628343] Detected a SSD, turning off metadata duplication.  Mkfs with=
 -m dup if you want to force metadata duplication.
[   41.628344]=20
[   41.651749] Label:              (null)
[   41.651750]=20
[   41.668820] UUID:               5ec63c22-d4b0-47fe-b22f-b765b3c072c1
[   41.668821]=20
[   41.687523] Node size:          16384
[   41.687524]=20
[   41.703430] Sector size:        4096
[   41.703431]=20
[   41.719394] Filesystem size:    745.21GiB
[   41.719395]=20
[   41.735559] Block group profiles:
[   41.735560]=20
[   41.751802]   Data:             single            8.00MiB
[   41.751803]=20
[   41.770209]   Metadata:         single            8.00MiB
[   41.770210]=20
[   41.788609]   System:           single            4.00MiB
[   41.788610]=20
[   41.806422] SSD detected:       yes
[   41.806423]=20
[   41.823245] Incompat features:  extref, skinny-metadata
[   41.823246]=20
[   41.840968] Number of devices:  1
[   41.840969]=20
[   41.856213] Devices:
[   41.856214]=20
[   41.869949]    ID        SIZE  PATH
[   41.869950]=20
[   41.885894]     1   745.21GiB  /dev/nvme1n1p1
[   41.885895]=20
[   41.901631]=20
[   41.913602] 2020-09-15 01:49:25 mkdir -p /fs/nvme1n1p1
[   41.913604]=20
[   41.930284] 	btrfs
[   41.930285]=20
[   41.945644] 2020-09-15 01:49:25 mount -t btrfs /dev/nvme1n1p1 /fs/nvme1n=
1p1
[   41.945646]=20
[   41.964526] 2020-09-15 01:49:26=20
[   41.964527]=20
[   41.980480] for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
[   41.980481]=20
[   41.997466] do
[   41.997467]=20
[   42.011288] 	online_file=3D"$cpu_dir"/online
[   42.011289]=20
[   42.028825] 	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] =
&& continue
[   42.028826]=20
[   42.047647]=20
[   42.059487] 	file=3D"$cpu_dir"/cpufreq/scaling_governor
[   42.059488]=20
[   42.077180] 	[ -f "$file" ] && echo "performance" > "$file"
[   42.077181]=20
[   42.094068] done
[   42.094069]=20
[   42.107061]=20
[   42.118689] 2020-09-15 01:49:26 mkdir /export
[   42.118690]=20
[   42.135246] 2020-09-15 01:49:26 mount -t tmpfs nfsv4_root_export /export
[   42.135247]=20
[   42.154732] 2020-09-15 01:49:26 mkdir -p /export//fs/nvme1n1p1
[   42.154733]=20
[   42.173974] 2020-09-15 01:49:26 mount --bind /fs/nvme1n1p1 /export//fs/n=
vme1n1p1
[   42.173975]=20
[   42.197286] 2020-09-15 01:49:26 echo '/export//fs/nvme1n1p1 *(rw,no_subt=
ree_check,no_root_squash)' >> /etc/exports
[   42.197287]=20
[   42.216870] 2020-09-15 01:49:26 systemctl restart rpcbind
[   42.216875]=20
[   42.235227] 2020-09-15 01:49:26 systemctl restart rpc-statd
[   42.235228]=20
[   42.253736] 2020-09-15 01:49:26 systemctl restart nfs-idmapd
[   42.253737]=20
[   42.272363] 2020-09-15 01:49:26 systemctl restart nfs-server
[   42.272364]=20
[   42.290880] 2020-09-15 01:49:27 mkdir -p /nfs/nvme1n1p1
[   42.290881]=20
[   42.310225] 2020-09-15 01:49:27 mount -t nfs -o vers=3D4 localhost:/fs/n=
vme1n1p1 /nfs/nvme1n1p1
[   42.310226]=20
[   42.332432] 2020-09-15 01:49:28 touch /nfs/nvme1n1p1/wait_for_nfs_grace_=
period
[   42.332434]=20
[   42.353433] IPMI BMC is not supported on this machine, skip bmc-watchdog=
 setup!
[   42.353434]=20
[   42.373525] 2020-09-15 01:49:29 echo '[global]
[   42.373526]=20
[   42.383799] bs=3D4k
[   42.383801]=20
[   42.407916] ioengine=3Dsync
[   42.407917]=20
[   42.415067] iodepth=3D32
[   42.415075]=20
[   42.428232] size=3D1431655765
[   42.428236]=20
[   42.441051] nr_files=3D1
[   42.441053]=20
[   42.449667] filesize=3D1431655765
[   42.449668]=20
[   42.456373] direct=3D0
[   42.456374]=20
[   42.465283] runtime=3D300
[   42.465285]=20
[   42.476826] invalidate=3D1
[   42.476827]=20
[   42.483000] fallocate=3Dposix
[   42.483001]=20
[   42.489412] io_size=3D1431655765
[   42.489413]=20
[   42.502809] file_service_type=3Droundrobin
[   42.502815]=20
[   42.512660] random_distribution=3Drandom
[   42.512661]=20
[   42.520013] group_reporting
[   42.520014]=20
[   42.526088] pre_read=3D0
[   42.526089]=20
[   42.533562]=20
[   42.539443] [task_0]
[   42.539445]=20
[   42.546125] rw=3Dwrite
[   42.546126]=20
[   42.551637] directory=3D/fs/nvme1n1p1
[   42.551638]=20
[   42.559135] numjobs=3D96' | fio --output-format=3Djson -
[   42.559136]=20
[   42.574513] perf version 5.9.rc4.g34d4ddd359db
[   42.574518]=20
[   56.152662] BTRFS error (device nvme1n1p1): invalid tree nritems, bytenr=
=3D13238272 owner=3D7 level=3D0 first_key=3D(18446744073709551606 128 96941=
895680) nritems=3D0 expect >0
[   56.152664] BTRFS error (device nvme1n1p1): invalid tree nritems, bytenr=
=3D13238272 owner=3D7 level=3D0 first_key=3D(18446744073709551606 128 96941=
895680) nritems=3D0 expect >0
[   56.152666] ------------[ cut here ]------------
[   56.168263] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered_io:2=
687: errno=3D-117 Filesystem corrupted
[   56.168264] BTRFS info (device nvme1n1p1): forced readonly
[   56.205009] BTRFS: Transaction aborted (error -117)
[   56.210368] WARNING: CPU: 71 PID: 537 at fs/btrfs/inode.c:2687 btrfs_fin=
ish_ordered_io+0x70a/0x820 [btrfs]
[   56.220466] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd a=
uth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core b=
trfs blake2b_generic sr_mod xor cdrom sd_mod zstd_decompress sg zstd_compre=
ss raid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg_tem=
p_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif kvm irqbypass ast d=
rm_vram_helper crct10dif_pclmul drm_ttm_helper crc32_pclmul ttm crc32c_inte=
l ghash_clmulni_intel rapl drm_kms_helper acpi_ipmi syscopyarea intel_cstat=
e sysfillrect ahci sysimgblt nvme libahci fb_sys_fops intel_uncore mei_me n=
vme_core ioatdma t10_pi drm mei libata joydev ipmi_si dca wmi ipmi_devintf =
ipmi_msghandler nfit libnvdimm ip_tables
[   56.285795] CPU: 71 PID: 537 Comm: kworker/u193:28 Not tainted 5.8.0-rc7=
-00166-g6e85ab8532a52 #1
[   56.295218] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[   56.302044] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]
[   56.308762] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 00 41 =
83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 a0 9c 2c c1 e8 58 2e ec bf <0f=
> 0b 44 89 f9 ba 7f 0a 00 00 48 c7 c6 50 c7 2b c1 48 89 df e8 15
[   56.328846] RSP: 0018:ffffc90007babd58 EFLAGS: 00010282
[   56.334755] RAX: 0000000000000000 RBX: ffff888fb85984e0 RCX: 00000000000=
00000
[   56.342577] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff8890401=
d7f60
[   56.350415] RBP: ffff889007e2e4c0 R08: 0000000001200000 R09: 00000000000=
00000
[   56.358255] R10: 0000000000000001 R11: ffffffffc00bd060 R12: 0000000010e=
7e000
[   56.366121] R13: 0000000010e7efff R14: ffff888fb86622a8 R15: 00000000fff=
fff8b
[   56.373983] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) knlGS:=
0000000000000000
[   56.382806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.389291] CR2: 00007fa44c4cc448 CR3: 0000005eac7c0006 CR4: 00000000007=
606e0
[   56.397176] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   56.405065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   56.412952] PKRU: 55555554
[   56.416419] Call Trace:
[   56.419631]  ? update_curr+0xc0/0x200
[   56.424060]  ? newidle_balance+0x232/0x3e0
[   56.428958]  btrfs_work_helper+0xc9/0x400 [btrfs]
[   56.434441]  ? __schedule+0x378/0x860
[   56.438895]  process_one_work+0x1b5/0x3a0
[   56.443690]  worker_thread+0x50/0x3c0
[   56.446698] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=3D/lk=
p/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-syn=
c-100%25-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f-debian-10.4-x=
86_64-20200603-20200915-84129-1i8kzyy-0.yaml&job_state=3Dpost_run -O /dev/n=
ull
[   56.446700]=20
[   56.448144]  ? process_one_work+0x3a0/0x3a0
[   56.491886]  kthread+0x114/0x160
[   56.495986]  ? kthread_park+0xa0/0xa0
[   56.500522]  ret_from_fork+0x1f/0x30
[   56.504966] ---[ end trace fbe43e164e851f97 ]---
[   56.510432] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered_io:2=
687: errno=3D-117 Filesystem corrupted
[   57.637893] kill 2492 vmstat --timestamp -n 10=20
[   57.637895]=20
[   57.646766] kill 2488 iostat -tkx 1 /dev/nvme1n1=20
[   57.646767]=20
[   57.655085] kill 2483 dmesg --follow --decode=20
[   57.655086]=20
[   57.663087] kill 2495 vmstat --timestamp -n 1=20
[   57.663088]=20
[   57.677626] wait for background processes: 2586 2539 2579 2524 2593 2508=
 2628 2521 2561 2499 2515 2505 2530 2614 2650 2554 2620 2638 nfsstat interr=
upts diskstats meminfo cpuidle numa-meminfo mpstat proc-stat softirqs numa-=
numastat proc-vmstat numa-vmstat slabinfo sched_debug oom-killer latency_st=
ats perf-stat perf-profile
[   57.677628]=20
[   57.996585] fio: io_u error on file /fs/nvme1n1p1/task_0.64.0: Read-only=
 file system: write offset=3D394838016, buflen=3D4096
[   57.996586]=20
[   58.020605] fio: io_u error on file /fs/nvme1n1p1/task_0.47.0: Read-only=
 file system: write offset=3D386719744, buflen=3D4096
[   58.020607]=20
[   58.044499] fio: io_u error on file /fs/nvme1n1p1/task_0.90.0: Read-only=
 file system: write offset=3D397451264, buflen=3D4096
[   58.044500]=20
[   58.068381] fio: io_u error on file /fs/nvme1n1p1/task_0.39.0: Read-only=
 file system: write offset=3D393887744, buflen=3D4096
[   58.068382]=20
[   58.092295] fio: io_u error on file /fs/nvme1n1p1/task_0.68.0: Read-only=
 file system: write offset=3D395218944, buflen=3D4096
[   58.092296]=20
[   58.116233] fio: io_u error on file /fs/nvme1n1p1/task_0.77.0: Read-only=
 file system: write offset=3D396726272, buflen=3D4096
[   58.116234]=20
[   58.140244] fio: io_u error on file /fs/nvme1n1p1/task_0.21.0: Read-only=
 file system: write offset=3D394244096, buflen=3D4096
[   58.140245]=20
[   58.164276] fio: io_u error on file /fs/nvme1n1p1/task_0.41.0: Read-only=
 file system: write offset=3D388759552, buflen=3D4096
[   58.164277]=20
[   58.188565] fio: io_u error on file /fs/nvme1n1p1/task_0.12.0: Read-only=
 file system: write offset=3D394850304, buflen=3D4096
[   58.188566]=20
[   58.212673] fio: io_u error on file /fs/nvme1n1p1/task_0.57.0: Read-only=
 file system: write offset=3D391036928, buflen=3D4096
[   58.212674]=20
[   58.236839] fio: io_u error on file /fs/nvme1n1p1/task_0.63.0: Read-only=
 file system: write offset=3D379236352, buflen=3D4096
[   58.236840]=20
[   58.254023] fio: io_u error on file /fs/nvme1n1p1/task_0.38.0: Read-only=
 file system: write offset=3D392155136, buflen=3D4096
[   58.254024]=20
[   58.278095] fio: io_u error on file /fs/nvme1n1p1/task_0.69.0: Read-only=
 file system: write offset=3D388558848, buflen=3D4096
[   58.278097]=20
[   58.302391] fio: io_u error on file /fs/nvme1n1p1/task_0.36.0: Read-only=
 file system: write offset=3D385282048, buflen=3D4096
[   58.302392]=20
[   58.326691] fio: io_u error on file /fs/nvme1n1p1/task_0.4.0: Read-only =
file system: write offset=3D395431936, buflen=3D4096
[   58.326693]=20
[   58.350899] fio: io_u error on file /fs/nvme1n1p1/task_0.30.0: Read-only=
 file system: write offset=3D392974336, buflen=3D4096
[   58.350900]=20
[   58.375257] fio: io_u error on file /fs/nvme1n1p1/task_0.31.0: Read-only=
 file system: write offset=3D381005824, buflen=3D4096
[   58.375258]=20
[   58.399658] fio: io_u error on file /fs/nvme1n1p1/task_0.92.0: Read-only=
 file system: write offset=3D413351936, buflen=3D4096
[   58.399659]=20
[   58.424067] fio: io_u error on file /fs/nvme1n1p1/task_0.19.0: Read-only=
 file system: write offset=3D388685824, buflen=3D4096
[   58.424068]=20
[   58.448524] fio: io_u error on file /fs/nvme1n1p1/task_0.81.0: Read-only=
 file system: write offset=3D411512832, buflen=3D4096
[   58.448525]=20
[   58.473012] fio: io_u error on file /fs/nvme1n1p1/task_0.9.0: Read-only =
file system: write offset=3D394457088, buflen=3D4096
[   58.473013]=20
[   58.496765] fio: io_u error on file /fs/nvme1n1p1/task_0.84.0: Read-only=
 file system: write offset=3D392839168, buflen=3D4096
[   58.496766]=20
[   58.521379] fio: io_u error on file /fs/nvme1n1p1/task_0.89.0: Read-only=
 file system: write offset=3D395825152, buflen=3D4096
[   58.521381]=20
[   58.545953] fio: io_u error on file /fs/nvme1n1p1/task_0.0.0: Read-only =
file system: write offset=3D389881856, buflen=3D4096
[   58.545954]=20
[   58.570442] fio: io_u error on file /fs/nvme1n1p1/task_0.2.0: Read-only =
file system: write offset=3D389853184, buflen=3D4096
[   58.570443]=20
[   58.594960] fio: io_u error on file /fs/nvme1n1p1/task_0.43.0: Read-only=
 file system: write offset=3D395550720, buflen=3D4096
[   58.594961]=20
[   58.619568] fio: io_u error on file /fs/nvme1n1p1/task_0.94.0: Read-only=
 file system: write offset=3D406122496, buflen=3D4096
[   58.619569]=20
[   58.644143] fio: io_u error on file /fs/nvme1n1p1/task_0.6.0: Read-only =
file system: write offset=3D398151680, buflen=3D4096
[   58.644144]=20
[   58.660870] fio: io_u error on file /fs/nvme1n1p1/task_0.71.0: Read-only=
 file system: write offset=3D366243840, buflen=3D4096
[   58.660871]=20
[   58.684048] fio: io_u error on file /fs/nvme1n1p1/task_0.91.0: Read-only=
 file system: write offset=3D396132352, buflen=3D4096
[   58.684049]=20
[   58.708668] fio: io_u error on file /fs/nvme1n1p1/task_0.52.0: Read-only=
 file system: write offset=3D393973760, buflen=3D4096
[   58.708669]=20
[   58.733275] fio: io_u error on file /fs/nvme1n1p1/task_0.70.0: Read-only=
 file system: write offset=3D348110848, buflen=3D4096
[   58.733276]=20
[   58.754781] fio: io_u error on file /fs/nvme1n1p1/task_0.33.0: Read-only=
 file system: write offset=3D393175040, buflen=3D4096
[   58.754782]=20
[   58.779422] fio: io_u error on file /fs/nvme1n1p1/task_0.61.0: Read-only=
 file system: write offset=3D394977280, buflen=3D4096
[   58.779423]=20
[   58.802850] fio: io_u error on file /fs/nvme1n1p1/task_0.26.0: Read-only=
 file system: write offset=3D394956800, buflen=3D4096
[   58.802852]=20
[   58.827464] fio: io_u error on file /fs/nvme1n1p1/task_0.66.0: Read-only=
 file system: write offset=3D393490432, buflen=3D4096
[   58.827465]=20
[   58.852058] fio: io_u error on file /fs/nvme1n1p1/task_0.29.0: Read-only=
 file system: write offset=3D392224768, buflen=3D4096
[   58.852059]=20
[   58.876652] fio: io_u error on file /fs/nvme1n1p1/task_0.80.0: Read-only=
 file system: write offset=3D387702784, buflen=3D4096
[   58.876653]=20
[   58.899910] fio: io_u error on file /fs/nvme1n1p1/task_0.53.0: Read-only=
 file system: write offset=3D370106368, buflen=3D4096
[   58.899915]=20
[   58.924516] fio: io_u error on file /fs/nvme1n1p1/task_0.55.0: Read-only=
 file system: write offset=3D393433088, buflen=3D4096
[   58.924518]=20
[   58.941848] fio: io_u error on file /fs/nvme1n1p1/task_0.51.0: Read-only=
 file system: write offset=3D394362880, buflen=3D4096
[   58.941849]=20
[   58.962792] fio: io_u error on file /fs/nvme1n1p1/task_0.3.0: Read-only =
file system: write offset=3D394600448, buflen=3D4096
[   58.962793]=20
[   58.986817] fio: io_u error on file /fs/nvme1n1p1/task_0.87.0: Read-only=
 file system: write offset=3D394653696, buflen=3D4096
[   58.986818]=20
[   59.011431] fio: io_u error on file /fs/nvme1n1p1/task_0.23.0: Read-only=
 file system: write offset=3D394838016, buflen=3D4096
[   59.011432]=20
[   59.036027] fio: io_u error on file /fs/nvme1n1p1/task_0.27.0: Read-only=
 file system: write offset=3D395550720, buflen=3D4096
[   59.036028]=20
[   59.060632] fio: io_u error on file /fs/nvme1n1p1/task_0.95.0: Read-only=
 file system: write offset=3D415043584, buflen=3D4096
[   59.060634]=20
[   59.085235] fio: io_u error on file /fs/nvme1n1p1/task_0.37.0: Read-only=
 file system: write offset=3D382984192, buflen=3D4096
[   59.085236]=20
[   59.109046] fio: io_u error on file /fs/nvme1n1p1/task_0.32.0: Read-only=
 file system: write offset=3D373907456, buflen=3D4096
[   59.109047]=20
[   59.133671] fio: io_u error on file /fs/nvme1n1p1/task_0.14.0: Read-only=
 file system: write offset=3D394084352, buflen=3D4096
[   59.133672]=20
[   59.158284] fio: io_u error on file /fs/nvme1n1p1/task_0.22.0: Read-only=
 file system: write offset=3D394838016, buflen=3D4096
[   59.158285]=20
[   59.182891] fio: io_u error on file /fs/nvme1n1p1/task_0.40.0: Read-only=
 file system: write offset=3D395251712, buflen=3D4096
[   59.182892]=20
[   59.199934] fio: io_u error on file /fs/nvme1n1p1/task_0.5.0: Read-only =
file system: write offset=3D394838016, buflen=3D4096
[   59.199935]=20
[   59.224487] fio: io_u error on file /fs/nvme1n1p1/task_0.60.0: Read-only=
 file system: write offset=3D380968960, buflen=3D4096
[   59.224488]=20
[   59.247796] fio: io_u error on file /fs/nvme1n1p1/task_0.10.0: Read-only=
 file system: write offset=3D394719232, buflen=3D4096
[   59.247797]=20
[   59.272406] fio: io_u error on file /fs/nvme1n1p1/task_0.15.0: Read-only=
 file system: write offset=3D395550720, buflen=3D4096
[   59.272407]=20
[   59.297008] fio: io_u error on file /fs/nvme1n1p1/task_0.59.0: Read-only=
 file system: write offset=3D397914112, buflen=3D4096
[   59.297009]=20
[   59.321600] fio: io_u error on file /fs/nvme1n1p1/task_0.54.0: Read-only=
 file system: write offset=3D397565952, buflen=3D4096
[   59.321601]=20
[   59.346219] fio: io_u error on file /fs/nvme1n1p1/task_0.86.0: Read-only=
 file system: write offset=3D395485184, buflen=3D4096
[   59.346220]=20
[   59.370661] fio: io_u error on file /fs/nvme1n1p1/task_0.35.0: Read-only=
 file system: write offset=3D379207680, buflen=3D4096
[   59.370662]=20
[   59.395269] fio: io_u error on file /fs/nvme1n1p1/task_0.34.0: Read-only=
 file system: write offset=3D397291520, buflen=3D4096
[   59.395270]=20
[   59.419870] fio: io_u error on file /fs/nvme1n1p1/task_0.25.0: Read-only=
 file system: write offset=3D395669504, buflen=3D4096
[   59.419871]=20
[   59.444481] fio: io_u error on file /fs/nvme1n1p1/task_0.83.0: Read-only=
 file system: write offset=3D398876672, buflen=3D4096
[   59.444482]=20
[   59.469089] fio: io_u error on file /fs/nvme1n1p1/task_0.11.0: Read-only=
 file system: write offset=3D386465792, buflen=3D4096
[   59.469090]=20
[   59.493681] fio: io_u error on file /fs/nvme1n1p1/task_0.62.0: Read-only=
 file system: write offset=3D394838016, buflen=3D4096
[   59.493682]=20
[   59.518296] fio: io_u error on file /fs/nvme1n1p1/task_0.24.0: Read-only=
 file system: write offset=3D393412608, buflen=3D4096
[   59.518298]=20
[   59.542896] fio: io_u error on file /fs/nvme1n1p1/task_0.85.0: Read-only=
 file system: write offset=3D376729600, buflen=3D4096
[   59.542897]=20
[   59.567511] fio: io_u error on file /fs/nvme1n1p1/task_0.20.0: Read-only=
 file system: write offset=3D394481664, buflen=3D4096
[   59.567512]=20
[   59.591793] fio: io_u error on file /fs/nvme1n1p1/task_0.56.0: Read-only=
 file system: write offset=3D394362880, buflen=3D4096
[   59.591794]=20
[   59.616399] fio: io_u error on file /fs/nvme1n1p1/task_0.42.0: Read-only=
 file system: write offset=3D395636736, buflen=3D4096
[   59.616401]=20
[   59.641025] fio: io_u error on file /fs/nvme1n1p1/task_0.18.0: Read-only=
 file system: write offset=3D373878784, buflen=3D4096
[   59.641026]=20
[   59.665727] fio: io_u error on file /fs/nvme1n1p1/task_0.16.0: Read-only=
 file system: write offset=3D395194368, buflen=3D4096
[   59.665728]=20
[   59.682769] fio: io_u error on file /fs/nvme1n1p1/task_0.46.0: Read-only=
 file system: write offset=3D394244096, buflen=3D4096
[   59.682770]=20
[   59.701345] fio: io_u error on file /fs/nvme1n1p1/task_0.13.0: Read-only=
 file system: write offset=3D397643776, buflen=3D4096
[   59.701346]=20
[   59.718331] fio: io_u error on file /fs/nvme1n1p1/task_0.75.0: Read-only=
 file system: write offset=3D395669504, buflen=3D4096
[   59.718333]=20
[   59.739132] fio: io_u error on file /fs/nvme1n1p1/task_0.8.0: Read-only =
file system: write offset=3D395223040, buflen=3D4096
[   59.739134]=20
[   59.763686] fio: io_u error on file /fs/nvme1n1p1/task_0.48.0: Read-only=
 file system: write offset=3D396574720, buflen=3D4096
[   59.763688]=20
[   59.787489] fio: io_u error on file /fs/nvme1n1p1/task_0.44.0: Read-only=
 file system: write offset=3D395030528, buflen=3D4096
[   59.787491]=20
[   59.812088] fio: io_u error on file /fs/nvme1n1p1/task_0.49.0: Read-only=
 file system: write offset=3D393969664, buflen=3D4096
[   59.812089]=20
[   59.835749] fio: io_u error on file /fs/nvme1n1p1/task_0.76.0: Read-only=
 file system: write offset=3D396873728, buflen=3D4096
[   59.835750]=20
[   59.859387] fio: io_u error on file /fs/nvme1n1p1/task_0.79.0: Read-only=
 file system: write offset=3D389816320, buflen=3D4096
[   59.859388]=20
[   59.883990] fio: io_u error on file /fs/nvme1n1p1/task_0.50.0: Read-only=
 file system: write offset=3D394989568, buflen=3D4096
[   59.883991]=20
[   59.908591] fio: io_u error on file /fs/nvme1n1p1/task_0.72.0: Read-only=
 file system: write offset=3D397697024, buflen=3D4096
[   59.908592]=20
[   59.933205] fio: io_u error on file /fs/nvme1n1p1/task_0.65.0: Read-only=
 file system: write offset=3D396374016, buflen=3D4096
[   59.933207]=20
[   59.957804] fio: io_u error on file /fs/nvme1n1p1/task_0.88.0: Read-only=
 file system: write offset=3D349822976, buflen=3D4096
[   59.957805]=20
[   59.982391] fio: io_u error on file /fs/nvme1n1p1/task_0.58.0: Read-only=
 file system: write offset=3D395313152, buflen=3D4096
[   59.982392]=20
[   60.000765] fio: io_u error on file /fs/nvme1n1p1/task_0.17.0: Read-only=
 file system: write offset=3D394600448, buflen=3D4096
[   60.000766]=20
[   60.025397] fio: io_u error on file /fs/nvme1n1p1/task_0.74.0: Read-only=
 file system: write offset=3D397451264, buflen=3D4096
[   60.025398]=20
[   60.050002] fio: io_u error on file /fs/nvme1n1p1/task_0.45.0: Read-only=
 file system: write offset=3D389406720, buflen=3D4096
[   60.050003]=20
[   60.074592] fio: io_u error on file /fs/nvme1n1p1/task_0.7.0: Read-only =
file system: write offset=3D386785280, buflen=3D4096
[   60.074593]=20
[   60.092772] fio: io_u error on file /fs/nvme1n1p1/task_0.1.0: Read-only =
file system: write offset=3D382296064, buflen=3D4096
[   60.092773]=20
[   60.117314] fio: io_u error on file /fs/nvme1n1p1/task_0.78.0: Read-only=
 file system: write offset=3D382431232, buflen=3D4096
[   60.117315]=20
[   60.141912] fio: io_u error on file /fs/nvme1n1p1/task_0.73.0: Read-only=
 file system: write offset=3D396312576, buflen=3D4096
[   60.141913]=20
[   60.165066] fio: io_u error on file /fs/nvme1n1p1/task_0.82.0: Read-only=
 file system: write offset=3D395743232, buflen=3D4096
[   60.165067]=20
[   60.189930] fio: io_u error on file /fs/nvme1n1p1/task_0.28.0: Read-only=
 file system: write offset=3D397926400, buflen=3D4096
[   60.189931]=20
[   60.214535] fio: io_u error on file /fs/nvme1n1p1/task_0.67.0: Read-only=
 file system: write offset=3D398237696, buflen=3D4096
[   60.214536]=20
[   60.236789] fio: io_u error on file /fs/nvme1n1p1/task_0.93.0: Read-only=
 file system: write offset=3D397766656, buflen=3D4096
[   60.236790]=20
[   63.897963] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=3D/lk=
p/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-syn=
c-100%25-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f-debian-10.4-x=
86_64-20200603-20200915-84129-1i8kzyy-0.yaml&loadavg=3D22.39%205.41%201.80%=
201/938%203717&start_time=3D1600134569&end_time=3D1600134586&version=3D/lkp=
/lkp/.src-20200915-081808:4c6b919a:1ad2a32de-dirty& -O /dev/null
[   63.897965]=20
[   63.960241] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=3D/lk=
p/jobs/scheduled/lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-syn=
c-100%25-300s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f-debian-10.4-x=
86_64-20200603-20200915-84129-1i8kzyy-0.yaml&job_state=3Dfailed -O /dev/null
[   63.960243]=20
[   64.011893] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-post-run?job_file=3D/lkp/jobs/sch=
eduled/lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-sync-100%25-3=
00s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f-debian-10.4-x86_64-2020=
0603-20200915-84129-1i8kzyy-0.yaml -O /dev/null
[   64.011895]=20
[   79.749457] getting new job...
[   79.749459]=20
[   79.781760] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/gpxelinux.cgi?hostname=3Dlkp-csl-2sp3=
&mac=3Db4:96:91:32:4c:88&last_kernel=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/6e8=
5ab8532a52e24a614dfc017c5e8a699c53cc6/vmlinuz-5.8.0-rc7-00166-g6e85ab8532a5=
2&lkp_wtmp -O /tmp/next-job-lkp
[   79.781762]=20
[   80.547537] no KERNEL found
[   80.547539]=20
[   80.550280] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3Dlkp-csl-2sp3&tbo=
x_state=3Dno_kernel_found -O /dev/null
[   80.550282]=20
[   80.782751] [2020-09-15 09:50:10]=20
[   80.782753]=20
[   80.798398] # LKPINFO: NO_KERNEL_NEED_TEST
[   80.798400]=20
[  380.783618] getting new job...
[  380.783623]=20
[  380.804626] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/gpxelinux.cgi?hostname=3Dlkp-csl-2sp3=
&mac=3Db4:96:91:32:4c:88&last_kernel=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/6e8=
5ab8532a52e24a614dfc017c5e8a699c53cc6/vmlinuz-5.8.0-rc7-00166-g6e85ab8532a5=
2&lkp_wtmp -O /tmp/next-job-lkp
[  380.804628]=20
[  381.534485] no KERNEL found
[  381.534487]=20
[  381.537570] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3Dlkp-csl-2sp3&tbo=
x_state=3Dno_kernel_found -O /dev/null
[  381.537571]=20
[  381.762754] [2020-09-15 09:55:11]=20
[  381.762755]=20
[  381.769688] [2020-09-15 09:55:11]=20
[  381.769689]=20
[  381.776832] # LKPINFO: NO_KERNEL_NEED_TEST
[  381.776833]=20
[  981.764137] getting new job...
[  981.764138]=20
[  981.783325] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/gpxelinux.cgi?hostname=3Dlkp-csl-2sp3=
&mac=3Db4:96:91:32:4c:88&last_kernel=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/6e8=
5ab8532a52e24a614dfc017c5e8a699c53cc6/vmlinuz-5.8.0-rc7-00166-g6e85ab8532a5=
2&lkp_wtmp -O /tmp/next-job-lkp
[  981.783327]=20
[  982.549497] no KERNEL found
[  982.549498]=20
[  982.554115] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3Dlkp-csl-2sp3&tbo=
x_state=3Dno_kernel_found -O /dev/null
[  982.554117]=20
[  982.809493] [2020-09-15 10:05:12]=20
[  982.809494]=20
[  982.816407] # LKPINFO: NO_KERNEL_NEED_TEST
[  982.816408]=20
[ 1882.810383] getting new job...
[ 1882.810384]=20
[ 1882.828927] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/gpxelinux.cgi?hostname=3Dlkp-csl-2sp3=
&mac=3Db4:96:91:32:4c:88&last_kernel=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/6e8=
5ab8532a52e24a614dfc017c5e8a699c53cc6/vmlinuz-5.8.0-rc7-00166-g6e85ab8532a5=
2&lkp_wtmp -O /tmp/next-job-lkp
[ 1882.828931]=20
[ 1883.660233] no KERNEL found
[ 1883.660235]=20
[ 1883.662943] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3Dlkp-csl-2sp3&tbo=
x_state=3Dno_kernel_found -O /dev/null
[ 1883.662944]=20
[ 1883.878121] [2020-09-15 10:20:14]=20
[ 1883.878123]=20
[ 1883.885473] # LKPINFO: NO_KERNEL_NEED_TEST
[ 1883.885475]=20
[ 3083.879149] getting new job...
[ 3083.879151]=20
[ 3083.899580] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/gpxelinux.cgi?hostname=3Dlkp-csl-2sp3=
&mac=3Db4:96:91:32:4c:88&last_kernel=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/6e8=
5ab8532a52e24a614dfc017c5e8a699c53cc6/vmlinuz-5.8.0-rc7-00166-g6e85ab8532a5=
2&lkp_wtmp -O /tmp/next-job-lkp
[ 3083.899582]=20
[ 3084.788116] no KERNEL found
[ 3084.788117]=20
[ 3084.790837] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3Dlkp-csl-2sp3&tbo=
x_state=3Dno_kernel_found -O /dev/null
[ 3084.790838]=20
[ 3084.993394] [2020-09-15 10:40:15]=20
[ 3084.993395]=20
[ 3084.999988] # LKPINFO: NO_KERNEL_NEED_TEST
[ 3084.999989]=20
input_data: 0x0000005f7f5873a8
input_len: 0x00000000009af87b
output: 0x0000005f7d000000
output_len: 0x0000000002ef74f0
kernel_total_size: 0x000000000242c000
needed_size: 0x0000000003000000
trampoline_32bit: 0x000000000009d000


KASLR disabled: 'nokaslr' on cmdline.



--dc+cDN39EJAMEtIO--

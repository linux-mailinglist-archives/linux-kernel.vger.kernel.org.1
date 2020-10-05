Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30608283218
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgJEIdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:33:44 -0400
Received: from david.siemens.de ([192.35.17.14]:39140 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgJEIdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:33:44 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0958XVUx015655
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Oct 2020 10:33:31 +0200
Received: from [167.87.39.163] ([167.87.39.163])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0958XUJ5026146;
        Mon, 5 Oct 2020 10:33:30 +0200
Subject: Re: scripts/gdb: issues when loading modules after lx-symbols
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org
References: <CAGxU2F7+Tf+hJxxadT_Rw01O43RU9RsasJiVLpukbhvo1w++fA@mail.gmail.com>
 <9e247182-2cc3-9fac-e12e-9743ef24ec43@siemens.com>
 <20201005081451.ajtm6rctimrg5frr@steredhat>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0b862e95-c2a7-ad00-5f57-8d958e4af20c@siemens.com>
Date:   Mon, 5 Oct 2020 10:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005081451.ajtm6rctimrg5frr@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.20 10:14, Stefano Garzarella wrote:
> On Sun, Oct 04, 2020 at 08:52:37PM +0200, Jan Kiszka wrote:
>> On 01.10.20 16:31, Stefano Garzarella wrote:
>>> Hi,
>>> I had some issues with gdb scripts and kernel modules in Linux 5.9-rc7.
>>>
>>> If the modules are already loaded, and I do 'lx-symbols', all work fine.
>>> But, if I load a kernel module after 'lx-symbols', I had this issue:
>>>
>>> [ 5093.393940] invalid opcode: 0000 [#1] SMP PTI
>>> [ 5093.395134] CPU: 0 PID: 576 Comm: modprobe Not tainted 5.9.0-rc7-ste-00010-gf0b671d9608d-dirty #2
>>> [ 5093.397566] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
>>> [ 5093.400761] RIP: 0010:do_init_module+0x1/0x270
>>> [ 5093.402553] Code: ff ff e9 cf fe ff ff 0f 0b 49 c7 c4 f2 ff ff ff e9 c1 fe ff ff e8 5f b2 65 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 cc <1f> 44 00 00 55 ba 10 00 00 00 be c0 0c 00 00 48 89 e5 41 56 41 55
>>> [ 5093.409505] RSP: 0018:ffffc90000563d18 EFLAGS: 00010246
>>> [ 5093.412056] RAX: 0000000000000000 RBX: ffffffffc010a0c0 RCX: 0000000000004ee3
>>> [ 5093.414472] RDX: 0000000000004ee2 RSI: ffffea0001efe188 RDI: ffffffffc010a0c0
>>> [ 5093.416349] RBP: ffffc90000563e50 R08: 0000000000000000 R09: 0000000000000002
>>> [ 5093.418044] R10: 0000000000000096 R11: 00000000000008a4 R12: ffff88807a0d1280
>>> [ 5093.424721] R13: ffffffffc010a110 R14: ffff88807a0d1300 R15: ffffc90000563e70
>>> [ 5093.427138] FS:  00007f018f632740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
>>> [ 5093.430037] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 5093.432279] CR2: 000055fbe282b239 CR3: 000000007922a006 CR4: 0000000000170ef0
>>> [ 5093.435096] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [ 5093.436765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [ 5093.439689] Call Trace:
>>> [ 5093.440954]  ? load_module+0x24b6/0x27d0
>>> [ 5093.443212]  ? __kernel_read+0xd6/0x150
>>> [ 5093.445140]  __do_sys_finit_module+0xd3/0xf0
>>> [ 5093.446877]  __x64_sys_finit_module+0x1a/0x20
>>> [ 5093.449098]  do_syscall_64+0x38/0x50
>>> [ 5093.450877]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [ 5093.456153] RIP: 0033:0x7f018f75c43d
>>> [ 5093.457728] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 6a 0c 00 f7 d8 64 89 01 48
>>> [ 5093.466349] RSP: 002b:00007ffd7f080368 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>>> [ 5093.470613] RAX: ffffffffffffffda RBX: 0000557e5c96f9c0 RCX: 00007f018f75c43d
>>> [ 5093.474747] RDX: 0000000000000000 RSI: 0000557e5c964288 RDI: 0000000000000003
>>> [ 5093.478049] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
>>> [ 5093.481298] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
>>> [ 5093.483725] R13: 0000557e5c964288 R14: 0000557e5c96f950 R15: 0000557e5c9775c0
>>> [ 5093.485778] Modules linked in: virtio_vdpa(+) vdpa sunrpc kvm_intel kvm irqbypass virtio_blk virtio_rng rng_core [last unloaded: virtio_vdpa]
>>> [ 5093.488695] ---[ end trace 23712ecebc11f53c ]---
>>>
>>> Guest kernel: Linux 5.9-rc7
>>> gdb: GNU gdb (GDB) Fedora 9.1-6.fc32
>>> I tried with QEMU 4.2.1 and the latest master branch: same issue.
>>>
>>>
>>> I did some digging, and skipping the gdb 'add-symbol-file' command in symbol.py
>>> avoid the issue, but of course I don't have the symbols loaded:
>>>
>>>     diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
>>>     index 1be9763cf8bb..eadfaa4d4907 100644
>>>     --- a/scripts/gdb/linux/symbols.py
>>>     +++ b/scripts/gdb/linux/symbols.py
>>>     @@ -129,7 +129,7 @@ lx-symbols command."""
>>>                      filename=module_file,
>>>                      addr=module_addr,
>>>                      sections=self._section_arguments(module))
>>>     -            gdb.execute(cmdline, to_string=True)
>>>     +            #gdb.execute(cmdline, to_string=True)
>>>                  if module_name not in self.loaded_modules:
>>>                      self.loaded_modules.append(module_name)
>>>              else:
>>>
>>> I tried several modules and this happens every time after '(gdb) lx-symbols'.
>>>
>>> Do you have any hints?
>>>
>> I assume you are debugging a kernel inside QEMU/KVM, right?
> 
> Right!
> 
>>                                                             Does it work
>> without -enable-kvm?
> 
> Yes, disabling kvm it works.
> 

OK, there it is, still...
What may also "work" is going down to single core.

>>
>> Debugging guests in KVM mode at least was unstable for a long time. I
>> avoided setting soft-BPs - which is what the script does for the sake of
>> tracking modules loading -, falling back to hw-BPs, as I had no time to
>> debug that further. /Maybe/ that's the issue here.
> 
> Thanks for the suggestion, I'll try to have a look.
> 

Would be great if this issue could finally be resolved. And then covered
by the kvm-unit tests. Those still succeed, I think.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

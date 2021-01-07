Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640AE2ED1E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbhAGOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:18:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:15774 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbhAGOSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:18:48 -0500
IronPort-SDR: ESWX/Q3i+uIvb4DRrsf9flaQWgDXYYVyc3QiZS2qWHQleWIx5yYRbLUKQPP4Vwhxr16VpJ28eq
 IpAmTQmXGTFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="165122901"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="165122901"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:17:02 -0800
IronPort-SDR: YQ7FP0OuL5kMVFc9DL2U+bZqPjXxboflCYPT+iT+D6BhkTSCiJZsEz9Ak+UgH/BH5Ehd32KaBO
 8xkICisimapg==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="379725338"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.170.115]) ([10.249.170.115])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:16:59 -0800
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, kevin.tian@intel.com,
        ashok.raj@intel.com, jun.j.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, dan.carpenter@oracle.com,
        Xin Zeng <xin.zeng@intel.com>
To:     Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>
References: <1609949037-25291-1-git-send-email-yi.l.liu@intel.com>
 <1609949037-25291-3-git-send-email-yi.l.liu@intel.com>
 <20210107134906.GA3043@willie-the-truck>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info
Message-ID: <591fa06b-8db1-57a5-8c61-d6ba28bc8c04@linux.intel.com>
Date:   Thu, 7 Jan 2021 22:16:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107134906.GA3043@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2021/1/7 21:49, Will Deacon wrote:
> On Thu, Jan 07, 2021 at 12:03:56AM +0800, Liu Yi L wrote:
>> In the existing code, loop all devices attached to a domain does not
>> include sub-devices attached via iommu_aux_attach_device().
>>
>> This was found by when I'm working on the below patch, There is no
>> device in the domain->devices list, thus unable to get the cap and
>> ecap of iommu unit. But this domain actually has subdevice which is
>> attached via aux-manner. But it is tracked by domain. This patch is
>> going to fix it.
>>
>> https://lore.kernel.org/kvm/1599734733-6431-17-git-send-email-yi.l.liu@intel.com/
>>
>> And this fix goes beyond the patch above, such sub-device tracking is
>> necessary for other cases. For example, flushing device_iotlb for a
>> domain which has sub-devices attached by auxiliary manner.
> 
> Sorry, but I'm having a really hard time understanding what this patch is
> doing based on this commit message. Baolu -- do you think you could reword
> it for me please? No need to resend the patch.

iommu/vt-d: Fix general protection fault in aux_detach_device()

The aux-domain attach/detach are not tracked, some data structures might
be used after free. This causes general protection faults when multiple
subdevices are created and assigned to a same guest machine.

The symptoms of this look like:
[ 1548.992644] general protection fault, probably for non-canonical
address 0xdead000000000100: 0000 [#1] SMP NOPTI
[ 1549.078610] RIP: 0010:intel_iommu_aux_detach_device+0x12a/0x1f0
[ 1549.095668] Code: 25 88 01 49 8b 8c 24 a0 02 00 00 85 c0 0f 84 b3 00
                      00 00 48 85 c9 0f 84 ac 00 00 00 48 8b 8b 68 f8 ff
                      ff 48 8b 83 70 f8 ff ff <48> 89 41 08 48 89 08 48
                      b9 00 01 00 00 00 00 ad de 48 b8 22 01 00
[ 1549.142717] RSP: 0018:ffffa19eca067b88 EFLAGS: 00010082
[ 1549.157403] RAX: dead000000000122 RBX: ffff8910a1d0a0b8 RCX: 
dead000000000100
[ 1549.175075] RDX: ffff8910ba752b00 RSI: 0000000000000000 RDI: 
ffff8910daee7ea0
[ 1549.192746] RBP: ffffa19eca067bc0 R08: 0000000000000000 R09: 
0000000000000018
[ 1549.208495] R10: ffff8910d5eb03b0 R11: 0000000000000001 R12: 
ffff8910cf3900b8
[ 1549.223652] R13: ffff8910daeba600 R14: 0000000000000246 R15: 
ffff8910a1fe1e58
[ 1549.240158] FS:  00007fc4449cad80(0000) GS:ffff8910de800000(0000) 
knlGS:0000000000000000
[ 1549.257316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1549.272424] CR2: 00005604b8b90000 CR3: 0000000859542004 CR4: 
0000000003762ee0
[ 1549.288201] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1549.302623] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 1549.316768] PKRU: 55555554
[ 1549.327711] Call Trace:
[ 1549.337400]  iommu_aux_detach_device+0x24/0x70
[ 1549.348268]  vfio_mdev_detach_domain+0x3b/0x60
[ 1549.361050]  ? vfio_mdev_set_domain+0x50/0x50
[ 1549.372811]  iommu_group_for_each_dev+0x4f/0x80
[ 1549.386160]  vfio_iommu_detach_group.isra.0+0x22/0x30
[ 1549.398160]  vfio_iommu_type1_detach_group.cold+0x71/0x211
[ 1549.411491]  ? find_exported_symbol_in_section+0x4a/0xd0
[ 1549.423097]  ? each_symbol_section+0x28/0x50
[ 1549.435137]  __vfio_group_unset_container+0x4d/0x150
[ 1549.448735]  vfio_group_try_dissolve_container+0x25/0x30
[ 1549.461213]  vfio_group_put_external_user+0x13/0x20
[ 1549.474632]  kvm_vfio_group_put_external_user+0x27/0x40 [kvm]
[ 1549.488017]  kvm_vfio_destroy+0x45/0xb0 [kvm]
[ 1549.500137]  kvm_put_kvm+0x1bb/0x2e0 [kvm]
[ 1549.509965]  kvm_vm_release+0x22/0x30 [kvm]
[ 1549.520706]  __fput+0xcc/0x260
[ 1549.530202]  ____fput+0xe/0x10
[ 1549.539426]  task_work_run+0x8f/0xb0
[ 1549.549440]  do_exit+0x358/0xaf0
[ 1549.558165]  ? wake_up_state+0x10/0x20
[ 1549.568318]  ? signal_wake_up_state+0x1a/0x30
[ 1549.579739]  do_group_exit+0x47/0xb0
[ 1549.589337]  __x64_sys_exit_group+0x18/0x20
[ 1549.599069]  do_syscall_64+0x57/0x1d0
[ 1549.609082]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1549.619044] RIP: 0033:0x7fc44e7e38a0
[ 1549.627488] Code: Bad RIP value.
[ 1549.635181] RSP: 002b:00007ffd23b6c038 EFLAGS: 00000246 ORIG_RAX: 
00000000000000e7
[ 1549.647761] RAX: ffffffffffffffda RBX: 00007fc44e8f2470 RCX: 
00007fc44e7e38a0
[ 1549.661439] RDX: 0000000000000000 RSI: 000000000000003c RDI: 
0000000000000000
[ 1549.673452] RBP: 00007fc44e8f2470 R08: 00000000000000e7 R09: 
ffffffffffffddb8
[ 1549.686293] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
[ 1549.699347] R13: 0000000000000000 R14: 0000000000000304 R15: 
0000000000000000

Fix it by tracking the subdevices when attaching and detaching aux-
domains.

Best regards,
baolu

> 
> Thanks,
> 
> Will
> 

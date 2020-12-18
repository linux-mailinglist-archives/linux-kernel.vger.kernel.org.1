Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA52D2DE387
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgLRNxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:53:41 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:30944
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbgLRNxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:53:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0hsBKm02TonHmye6gqdvoXQBkcSfogKUu5MeSuejKNvYK/c4IwjklQDIWkhAbnqQuPjDYRfhuS4Wx7Ml0X27cMCkfsNQ0MND8LX8oPnR+EH+HPSwr6L7T3d7jsC44RglBQJa1/F2M2tw5bQUuT3CpTasG+E5llh96hQC0MymAWADJi3TkSuUn43Kt9OIXJ2dkFGbnPms3kWLAJoRAQLe4ifRF/Nld4CPV6YX+jFkJcbOv4SXXvfo/u5yTj8WeHvU0G9psgPKgVoi2lvi/30jJzXR9Pd8buvWFWJlc/DVpx+/B+EziMpkMSM+8Y5C5j5ky+UVa6P0DpNJRDBMaSqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VgGfEEul4GgETA1YLf6u83unPqFC4Rrtd2/x9AzQXw=;
 b=f7w+tbpz0FUXu3MdRhVh2mvt77CG11CgCTev/UHlAMEYg7UaATyWvO5QrXKrYsnrNe00PQK9yBp/05VwKApNRl0kTQIn2LT3MhgUjAlMO6pKJh+COCpt4WUU8m5XIdHPvM5Op+iyu03ro7pcACPiKhUdzJiz0iPb9Qze3u5AFNUY4iuHxFNdOPdmvZ+dqZaRWuayt85RebRG1C5YV2XZuA6BQ/ib0IvX49+6n9tVIrlHKxowCXMHe4w1Cl1DWLWXltzLuuJMbMQnKts4vg19YWyOQmrRVIVkFJP/JtKpETrkwHojZMVFMxtD+Y5ycffiH/yzWA3lMOcd1jJ3Bg9cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VgGfEEul4GgETA1YLf6u83unPqFC4Rrtd2/x9AzQXw=;
 b=Ww14ruRx6A08s9DzEW0we5YK8wzcbkO9+e1r6LaX4Ezw+NWpU1fbgNBt38IcGfK3jBItDxObk4iTEmaKZF/AFeUU4VIzxYR2Gp3/JOYnbTS0tNJonhyKcibYfVDaEeUemAvoW6g/ZPU4s7cSvSZbOSov5VMULwbjkkJ682ZxfBg=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3902.namprd12.prod.outlook.com (2603:10b6:208:169::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 13:52:43 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 13:52:43 +0000
Subject: Re: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
To:     David Airlie <airlied@redhat.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
 <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
 <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
 <6f99d3ca-a7ff-69e9-8ca1-9d016a8d3f48@amd.com>
 <23bc1073395db9ccf55ecca45198375f4d5d6250.camel@gmx.de>
 <7cb43d5b-4e6a-defc-1ab6-5f713ad5a963@amd.com>
 <CAMwc25q6dXVidvhXBQzGY0BjNqs13ceDUFuoFv8vSB9pEP6ecg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f0202536-9471-87a0-4bea-b33ad3af8371@amd.com>
Date:   Fri, 18 Dec 2020 14:52:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAMwc25q6dXVidvhXBQzGY0BjNqs13ceDUFuoFv8vSB9pEP6ecg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0501CA0045.eurprd05.prod.outlook.com
 (2603:10a6:200:68::13) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0501CA0045.eurprd05.prod.outlook.com (2603:10a6:200:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend Transport; Fri, 18 Dec 2020 13:52:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 995f823a-f080-4d00-0640-08d8a35c313f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3902:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3902E731C85CF0015C48D84883C30@MN2PR12MB3902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYE3shJ0FRGb59sOmZloKFQaLmt3YBQnk8o2el90nxJnNz8F+IFzoS52AsXBcw9CoXLYxoLrAj/HhKoHN46+kjDmXE3kpnd6gD3AqwA60vsoPjAxQwKhd7ErwqW6RIOVl5XN6muvnT3KB7XKzGx7IqI0paojX1BaR+0vvIqg+A5LcFicOMyptqoQIFL801S6IzSiXE3tlwRDpBFy3nKthhoGRARgIRgf/gctb4WZ04btjrM3JvtnpVAY+AHhWfyTVKHpt0RQp/lp1MtMmGTpaUrvvKHgFw5ZKMMLmlG4bvomsBhiQKAomus2V7OpxVYW9jcOyjfj/W0L3wEUjmdeFCNXwIMIt4HVvUR+eViItuiPpgwB9hyla1dAM0vhoYGm7/JLIsKRlMmKe4BZmO9MtAVSnTu0WxXV9RO5aBAG0AXYzzsN3D9a5ksLOvvUaqqcyE1Rbwd5tuijcy4DWpBd6H5eHtMJCFXeVX9BCsNNqIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(5660300002)(186003)(16526019)(36756003)(31686004)(6666004)(45080400002)(53546011)(4326008)(66574015)(6916009)(4001150100001)(66946007)(8936002)(316002)(54906003)(2616005)(83380400001)(66476007)(66556008)(8676002)(2906002)(478600001)(31696002)(6486002)(86362001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SittWmk3NmhrQWlzaWRoS1BTQ3BHOWljcndrMUJackUrTUhKeGIxdDFWdnR6?=
 =?utf-8?B?NmJkYndOSWZvMktyUHFkem5wTDNtVFJNOXIvNEIrSnVoRkdvMWVsMHlvQlVs?=
 =?utf-8?B?emlCaGtXc2k3ZW1jeEpXNU1IZDd6Q3FZYkFUT1pNS1FxM0U5UW1adTVDdVdM?=
 =?utf-8?B?YmNZQ3VnQW9JVGJ5MDZvTmdkeWdpbXhZTjhWbWI3SGcwZmNwbFBkT3NpTnpL?=
 =?utf-8?B?ci9KZUFHdnlPaVJoenFleEg4UEJ3ZGkyMWgzU0w4dklodjFGNllvTWJFRDZX?=
 =?utf-8?B?akZmVEQzdUk5R0NJNUQxQnUzQ0hhdTAyd2FNbTM3Zit6ejFLSG1OMjE0VThD?=
 =?utf-8?B?WVdVOGxMNWdGSy9sQldIQ1puSFUzeUVNbXZZc3A1UUs1UThFQ0FVVkc0cVhz?=
 =?utf-8?B?UkRKMDhQUmFqUFhrTnpyQnJhYWl5dXpHbzN5cXdLdldiWWNRQUZINGIrSU1x?=
 =?utf-8?B?c0ZOdHM3OUorTVVERjRiQVVNTnhNckxhcjZhN3d6K1BWNkMzUmI4b2wyNVVI?=
 =?utf-8?B?eC9qWEc5WXZtYVd2bWo4SzVUUGZEMnc1U2h0b1JFUUt5dGVVR0pKRy84QzF4?=
 =?utf-8?B?MVl0OC9DVjdrNDliclhnL3lzVFhRTVJoZ0JJUk9qUnExZ3FCUWdjVnlCTitF?=
 =?utf-8?B?TmNXQ3ZJRmh3L2oyRnVZTVdiR3ZKL0QrSGNSVS9vV1BJVHlkeVcvNk8xdGNN?=
 =?utf-8?B?RG1MT2NMemxxVUhoenpMUmd1SW50SzB4WG5hNHhabXVVVzJLTjVEb0JyaytX?=
 =?utf-8?B?RnlXRzJuOHZaeXVadlZMc1V1K2FKdnIwdHdSZnhTanN2eks0NC9LYVZBdHpT?=
 =?utf-8?B?NmNPYWJsUXk2SDlrMTNNRHlxVHR5OVpSTDYwV3VGVkdZMkxQZUVicWZpa2Y5?=
 =?utf-8?B?WldlMHBiOEdlcTRtb1owT2RiSlEwUllkMXNWY3hIQ21COHl2d2h2M2s1WnQy?=
 =?utf-8?B?d2xGMGpDTFdzWWo5YU92K2FVL1JzMXNtakpaTXc2MW5hM1JhcGx1TFVGbCtk?=
 =?utf-8?B?RHA0R1J2a1huUnBBamRESy91UFBuOEw3MzlyMEQwaUlvRmxKMUJGY0JXQkc4?=
 =?utf-8?B?STNvNU1wUFliMUhxTlhKMnVQajJhT0Z4RFNFUWNKVHU1d25wWHF1enhiMWVS?=
 =?utf-8?B?TnVaUGEzTmxJaFA5M3J1T3BibTBPV0ljT216MlFTUjlkWjcyVjdQTkNlZk82?=
 =?utf-8?B?TnRSWTRYWHlzVXptOGJmVkpjMW53NTV6d0lVSm50TCtFaDBlallKWjFQTWlv?=
 =?utf-8?B?MEZGKzF1RGU1d0ZyTi85MlVGQy9sV01vQ1JIUS9wWGhpUGR6Y01GK2VielMw?=
 =?utf-8?B?bUJydUQ0dmJQZENKb3lHN0ZRQ0hzS0I3WC9GdmlIR2RmSEJ3WHVtZ0RjNENY?=
 =?utf-8?B?dVp6a0drMHgxWXZjTTFpZXpua2tFbFpjdFFBcVoxaDhtYkJZTHpybFJBMkIy?=
 =?utf-8?Q?AuvL07cD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 13:52:42.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 995f823a-f080-4d00-0640-08d8a35c313f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3VziL0210w4QkFicAE/VbMZg1YCVK5jLoxxlw58yqIMGhjCgolfV4Fj+GE90z1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3902
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since -rc1 is not out yet I've just pushed it to drm-misc-next-fixes.

Thanks,
Christian.

Am 17.12.20 um 19:50 schrieb David Airlie:
> Yes this looks correct, please add my rb and get into a fixes queue somewhere.
>
> Dave.
>
> On Fri, Dec 18, 2020 at 2:39 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 17.12.20 um 17:26 schrieb Mike Galbraith:
>>> On Thu, 2020-12-17 at 17:24 +0100, Christian König wrote:
>>>> Hi Mike,
>>>>
>>>> what exactly is the warning from qxl you are seeing?
>>> [    1.815561] WARNING: CPU: 7 PID: 355 at drivers/gpu/drm/ttm/ttm_pool.c:365 ttm_pool_alloc+0x41b/0x540 [ttm]
>> Yeah, that is an expected result.
>>
>> Looks like qxl does something quite odd here, it allocates an
>> dma_address array but doesn't have a device to fill them.
>>
>> On the other hand I don't see qxl using the allocated dma_addresses.
>> Dave do you have an idea why qxl is doing that?
>>
>> Mike can you test the attached patch?
>>
>> Thanks in advance,
>> Christian.
>>
>>> [    1.815561] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_generic(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pci(E) rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_ring(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) autofs4(E)
>>> [    1.815589] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G            E     5.10.0.g489e9fe-master #26
>>> [    1.815590] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>>> [    1.815614] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
>>> [    1.815621] RIP: 0010:ttm_pool_alloc+0x41b/0x540 [ttm]
>>> [    1.815623] Code: fc ff ff 89 ea 48 8d 04 d5 00 00 00 00 48 29 d0 48 8d 3c c5 00 1c 40 a0 e9 d7 fc ff ff 85 c0 0f 89 2f fc ff ff e9 28 fc ff ff <0f> 0b e9 35 fc ff ff 89 e9 49 8b 7d 00 b8 00 10 00 00 48 d3 e0 45
>>> [    1.815623] RSP: 0018:ffff888105d3b818 EFLAGS: 00010246
>>> [    1.815625] RAX: 0000000000000000 RBX: ffff888106978800 RCX: 0000000000000000
>>> [    1.815626] RDX: ffff888105d3bc68 RSI: 0000000000000001 RDI: ffff888106238820
>>> [    1.815626] RBP: ffff888106238758 R08: ffffc90000296000 R09: 800000000000016b
>>> [    1.815627] R10: 0000000000000001 R11: ffffc90000296000 R12: 0000000000000000
>>> [    1.815628] R13: ffff888106238820 R14: 0000000000000000 R15: ffff888106978800
>>> [    1.815628] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS:0000000000000000
>>> [    1.815632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    1.815633] CR2: 00007eff52a0d5b8 CR3: 0000000002010003 CR4: 00000000001706e0
>>> [    1.815633] Call Trace:
>>> [    1.815644]  ttm_tt_populate+0xb1/0xc0 [ttm]
>>> [    1.815647]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
>>> [    1.815652]  qxl_bo_move+0x230/0x2f0 [qxl]
>>> [    1.815655]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
>>> [    1.815657]  ttm_bo_evict+0x124/0x250 [ttm]
>>> [    1.815693]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
>>> [    1.815696]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
>>> [    1.815698]  ttm_bo_mem_space+0x261/0x270 [ttm]
>>> [    1.815702]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
>>> [    1.815705]  ttm_bo_validate+0x117/0x150 [ttm]
>>> [    1.815756]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
>>> [    1.815772]  qxl_bo_create+0x134/0x1d0 [qxl]
>>> [    1.815775]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
>>> [    1.815791]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
>>> [    1.815794]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
>>> [    1.815797]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
>>> [    1.815815]  ? _cond_resched+0x15/0x40
>>> [    1.815819]  ? ww_mutex_lock_interruptible+0x12/0x60
>>> [    1.815822]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
>>> [    1.815841]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
>>> [    1.815853]  process_one_work+0x1f5/0x3c0
>>> [    1.815866]  ? process_one_work+0x3c0/0x3c0
>>> [    1.815867]  worker_thread+0x2d/0x3d0
>>> [    1.815868]  ? process_one_work+0x3c0/0x3c0
>>> [    1.815872]  kthread+0x117/0x130
>>> [    1.815876]  ? kthread_park+0x90/0x90
>>> [    1.815880]  ret_from_fork+0x1f/0x30
>>> [    1.815886] ---[ end trace 51e464c1e89a1728 ]---
>>> [    1.815894] BUG: kernel NULL pointer dereference, address: 0000000000000230
>>> [    1.815895] #PF: supervisor read access in kernel mode
>>> [    1.815895] #PF: error_code(0x0000) - not-present page
>>> [    1.815896] PGD 0 P4D 0
>>> [    1.815898] Oops: 0000 [#1] SMP NOPTI
>>> [    1.815900] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G        W   E     5.10.0.g489e9fe-master #26
>>> [    1.815901] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>>> [    1.815916] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
>>> [    1.815921] RIP: 0010:dma_map_page_attrs+0xf/0x1c0
>>> [    1.815922] Code: 1f 17 5b 01 48 85 c0 75 e3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 41 55 41 54 55 53 48 83 ec 08 <48> 8b 87 30 02 00 00 48 85 c0 48 0f 44 05 e7 16 5b 01 41 83 f8 02
>>> [    1.815923] RSP: 0018:ffff888105d3b7e8 EFLAGS: 00010296
>>> [    1.815924] RAX: 0000000000001000 RBX: 0000000000000001 RCX: 0000000000001000
>>> [    1.815924] RDX: 0000000000000000 RSI: ffffea0004171e40 RDI: 0000000000000000
>>> [    1.815925] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>>> [    1.815925] R10: ffffea0004171e40 R11: ffffc90000296000 R12: 0000000000000001
>>> [    1.815926] R13: ffff888106238820 R14: ffff888105d07100 R15: ffff888106978800
>>> [    1.815926] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS:0000000000000000
>>> [    1.815928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    1.815929] CR2: 0000000000000230 CR3: 0000000002010003 CR4: 00000000001706e0
>>> [    1.815929] Call Trace:
>>> [    1.815937]  ttm_pool_alloc+0x448/0x540 [ttm]
>>> [    1.815940]  ttm_tt_populate+0xb1/0xc0 [ttm]
>>> [    1.815942]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
>>> [    1.815945]  qxl_bo_move+0x230/0x2f0 [qxl]
>>> [    1.815947]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
>>> [    1.815949]  ttm_bo_evict+0x124/0x250 [ttm]
>>> [    1.815982]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
>>> [    1.815984]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
>>> [    1.815988]  ttm_bo_mem_space+0x261/0x270 [ttm]
>>> [    1.890133]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
>>> [    1.890138]  ttm_bo_validate+0x117/0x150 [ttm]
>>> [    1.891740]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
>>> [    1.891744]  qxl_bo_create+0x134/0x1d0 [qxl]
>>> [    1.893398]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
>>> [    1.893400]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
>>> [    1.893402]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
>>> [    1.893405]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
>>> [    1.896515]  ? _cond_resched+0x15/0x40
>>> [    1.896517]  ? ww_mutex_lock_interruptible+0x12/0x60
>>> [    1.896520]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
>>> [    1.896533]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
>>> [    1.896537]  process_one_work+0x1f5/0x3c0
>>> [    1.900535]  ? process_one_work+0x3c0/0x3c0
>>> [    1.900536]  worker_thread+0x2d/0x3d0
>>> [    1.900538]  ? process_one_work+0x3c0/0x3c0
>>> [    1.902704]  kthread+0x117/0x130
>>> [    1.902706]  ? kthread_park+0x90/0x90
>>> [    1.902709]  ret_from_fork+0x1f/0x30
>>> [    1.902711] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_generic(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pci(E) rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_ring(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) autofs4(E)
>>> [    1.904797] Dumping ftrace buffer:
>>> [    1.911038]    (ftrace buffer empty)
>>> [    1.911041] CR2: 0000000000000230
>>>
>>>
>>>


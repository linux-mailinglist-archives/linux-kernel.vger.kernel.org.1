Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4F26790D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 11:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgILJJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 05:09:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21404 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgILJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 05:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599901781; x=1631437781;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7FehCVI+tB+rd+TgF+zYv+RcqWZrOwUDCWu/AqU6NxU=;
  b=eDbI+tVSg7E/4TlsDrWIW9zr9It5WzztQfBUpnZhZcoLEOFd5xzw9ZCJ
   5jrMY6kDIqcTb4RPRVEgEHE4AX6S8qjRZAFvuGHDtf9WYTrtTZRGOV+J8
   uXQqf4hb1YbDEGRuGDPFPpf8OnY7MHpJOJjqNExXeLFHeX3B+mkg7dbVQ
   UDe5GrKrK1MVvrqPLSInOAwsaGCCXOm3tU67CBjGl+FdL1qWWZ4KjmrFN
   uM1e+vDUkFygNF9KiEAtgas50k3X4DujPjPgxGW/YPojPjj9wkTm9r7lQ
   oDTSnvMavlMdNHwVFCDCPxxDwUXn7+tb1snAmvi9Qd3wvKp2N4SvmTGs7
   A==;
IronPort-SDR: cCuca9K0lFXnrkCjMva2tR6GJ+sVBCXZSy/s9Zeky+jy5HxrzQUmY+JO5eLW+Mi60/+3IgvDDY
 AoPv+PA3VawjyVgRK3o+k26e0GChowgro81c81z1+RJePs+vkl6cSpWNm7DXZK2ktaAjbW3eB6
 Jv6td0EW4KYTQ/nU67TWMEllqV2agTB2nh+mdJeZxwbMQ5w5j127F3weVjcEDWy8bXgs90qw84
 BJdlm0SJEokTP17MSQfh+vGkHNvtz01/zN4nPG1a6a7dwrX7vL7F3vAdlLpPBdSD10Zds7iRO8
 BbI=
X-IronPort-AV: E=Sophos;i="5.76,419,1592841600"; 
   d="scan'208";a="256805333"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 17:09:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciRO16BZZtjvd0G/HyJ7bg/ejJWWOw0DrrrALUsEM0CDg6s3TU2mIeJCnPBe2+IvPtDdMKFp9GyaKlp8IjrkbDNjsq+Bar/U9wYBWUAd8tr2J54P25lZPdKjO3DSqhX7K2hrJQFr3T6sW4Cvy8/5wSxVi5nC5Vc6IovraExiEl/X441Sfb64bG6eNn7yz4M+MFGERnvnDcydEG4oSO4id4lM7OTYWkzYNVpM1MS/jsCvFJqHVICfqO9AaE36ylWjn8DY9JMpX0gQoX9qGL65fILRT5cNEbs7jdGhuetu94QXZYQNnik9nQPodrU6a2r8iZyRJxyn0BMQxdOBJNKE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BZS9hyMpFp6YGJ/hb8GvKG98+oQJz9fFEtfFt9t2Bw=;
 b=WiLsEY5X83iz/csjuZiobMoF2EoS7NrCxe66k8g0I3f8KQtqy+ZDUR4p88O/TPpDITQPQ/M1JloSx9B2MN7Lghqr0U+Ym1wQ1yllNdmemIgREOkfs3RIdGFQOUbGHymXzQ2/yRcajtBVaVo/JrbWzaCxFtp6m7xjEXfLIi8c0G69UiB9Sx0Ra0xkjBbLtbt6YWRGaFPglCbEhOVm3npiHVa4kRfa6unvU6/MuNKMuLtZZKQAX9Dkh6aRLATc5wm6ZMfW4wFiVJ0E2Ny4OhqLmu5xMl8kondAwhrr8/nITdKlQ6+uLDdz6+JGaVuNjFFNGWd2zQYX//o8fkt9Po1CuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BZS9hyMpFp6YGJ/hb8GvKG98+oQJz9fFEtfFt9t2Bw=;
 b=lYLeouhYulSX6lg35btRn/dtlSFCX6h0trCF5xkBDimT/ipff+3QhZTSGA0COdgcNcNbYsHxvHH2XM5tfldTk/Mm5MoXpcxzk6YF0xE/z6dtBc6uKEUMC+3nnZTlWew43Y9FRJAOz09DqQecD7RTq2HvI9TNG2D2mt4yxB+vFno=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Sat, 12 Sep
 2020 09:09:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Sat, 12 Sep 2020
 09:09:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWiHU5D1XE6L8r8ki3RtN8f0xMug==
Date:   Sat, 12 Sep 2020 09:09:37 +0000
Message-ID: <SN4PR0401MB35988DE053A515756DBB123C9B250@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic> <20200911230703.GA2971@nazgul.tnic>
 <CY4PR04MB3751630AAB4A625BD64C66C3E7250@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:4db3:21d3:689d:c45f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b297d5f-5f0c-4473-adfa-08d856fb92f1
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB367753B860B90221357DA1AE9B250@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HP0tjHW3bR/qRYBW2FXJsCM0QKTUDZA4dkcx9LEq0xjySf1PL0hg+/vM6/ULE6Gs0Hm3AxNqFT5WBdGfairX/9VwCRpP9UZ6XKyJwYgsc69L4ei/QKHsr0INI5wjO1dbWZk5vDdi9YX4wPU4jRIVXLl0ZbHuZWC7YTIrNlk1QQ/NYpKpffT412qssMYa+mC53Omdg/mMzpXIiDVW7qtqz/hdyniTLb2vg1Wkii4NxuOY0qAKiUczZ8DOVOEJEYiFLNMtsLJXgTUBBabw7csq/1hnjz9kBz49slZJmHxw4hB90NBvCM4UqlYQY2n2MEb2wK4x5fsQ+QuYtgz8Y8Kohw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(54906003)(45080400002)(478600001)(71200400001)(52536014)(316002)(2906002)(55016002)(33656002)(9686003)(110136005)(5660300002)(64756008)(66556008)(66476007)(66446008)(66946007)(76116006)(91956017)(6506007)(86362001)(83380400001)(8676002)(8936002)(53546011)(7696005)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: teRNbwDi/GtGEk7vDWx0C0v5aSG5XGtItq95gEbt9eye5pOHll0swmPR6oVTlT2FHIqVryeVJ2mENVZzRlkY2k/Vrp6DF6rT9IorAYh/QYHpaQh8NEzApq7sCyfRK2YCcFAClXtb5AcLKxTv2oVU7uNPdwgWXVXltYDqP+mZY9MeuaVx/Wy2UP069/Vg6SQDVZTQfOjjRNvT3vjKSrwEbBSQHwr8hcfI3PEpcuu5nXAcAqasVWGLw+oHM8v7RwsBL0mYDbgE3yocTOnKRgPsOQhdasqtW3Twezuv1TfM81Qrtr2W7YeYAmr/7kivkVMcVKeTl0VAVsrFZxtlvkvvJNt1zDp/U3UWZBNSvRTVHRkaT+3CdZ56eVB0TVOwqyhDOFfA8OWhoR4I80cBSpLcvSiuVi8UVLxlxwOA+vFD4546l7Gc+StcQweUdge8GLA7rUi2IdCvkjWnr4Rs6M0U1xhVtLq6ozziuBbOSY9pZYoC2NQg15MFhowC0o4Oidt+5n2pQh0OJtSbNUM0G/xYH7bA57e37UWF0jrFyIk4doOOTPpAfkowfgLHWsAxRhAEkbA0MmjJswPUfws2VyJfTyGw3lnKoW7j6h5UKE+ASW6B76512aOPynW2yXlHEQkzCZUo++ASF5oN/rmCJ/K73TW8eXvZV8NbgfDnGIoBmEQrBdBMRzxriFpp7gm0bs+MaVh9HB/oehbCtQYdEFJ+NQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b297d5f-5f0c-4473-adfa-08d856fb92f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2020 09:09:37.3738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvqLnznuGcTMF26BnGYoCdEug/yTowW1MlWM0mW9sswPjK1EhLqh+Vh2VkVqbs8zLdJcPhecyFVRlJpB4JCzzpUtItadvpv9c3PQaPAJm5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2020 04:31, Damien Le Moal wrote:=0A=
> On 2020/09/12 8:07, Borislav Petkov wrote:=0A=
>> On Sat, Sep 12, 2020 at 12:17:59AM +0200, Borislav Petkov wrote:=0A=
>>> Enabling it, fixes the issue.=0A=
>>=0A=
>> Btw, I just hit the below warn with 5.8, while booting with the above=0A=
>> config option enabled. Looks familiar and I didn't trigger it with=0A=
>> 5.9-rc4+ so you guys either fixed it or something changed in-between:=0A=
>>=0A=
>> [    5.124321] ata4.00: NCQ Send/Recv Log not supported=0A=
>> [    5.131484] ata4.00: configured for UDMA/133=0A=
>> [    5.135847] scsi 3:0:0:0: Direct-Access     ATA      ST8000AS0022-1WL=
 SN01 PQ: 0 ANSI: 5=0A=
>> [    5.143972] sd 3:0:0:0: Attached scsi generic sg1 type 0=0A=
>> [    5.144033] sd 3:0:0:0: [sdb] Host-aware zoned block device=0A=
>> [    5.177105] sd 3:0:0:0: [sdb] 15628053168 512-byte logical blocks: (8=
.00 TB/7.28 TiB)=0A=
>> [    5.184880] sd 3:0:0:0: [sdb] 4096-byte physical blocks=0A=
>> [    5.190084] sd 3:0:0:0: [sdb] 29808 zones of 524288 logical blocks + =
1 runt zone=0A=
>> [    5.197439] sd 3:0:0:0: [sdb] Write Protect is off=0A=
>> [    5.202220] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00=0A=
>> [    5.207260] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabl=
ed, doesn't support DPO or FUA=0A=
>> [    5.356631]  sdb: sdb1=0A=
>> [    5.359014] sdb: disabling host aware zoned block device support due =
to partitions=0A=
>> [    5.389941] ------------[ cut here ]------------=0A=
>> [    5.394557] WARNING: CPU: 8 PID: 164 at block/blk-settings.c:236 blk_=
queue_max_zone_append_sectors+0x12/0x40=0A=
>> [    5.404300] Modules linked in:=0A=
>> [    5.407365] CPU: 8 PID: 164 Comm: kworker/u32:6 Not tainted 5.8.0 #7=
=0A=
>> [    5.413682] Hardware name: Micro-Star International Co., Ltd. MS-7B79=
/X470 GAMING PRO (MS-7B79), BIOS 1.70 01/23/2019=0A=
>> [    5.424191] Workqueue: events_unbound async_run_entry_fn=0A=
>> [    5.429482] RIP: 0010:blk_queue_max_zone_append_sectors+0x12/0x40=0A=
>> [    5.435543] Code: fe 0f 00 00 53 48 89 fb 0f 86 3d 07 00 00 48 89 b3 =
e0 03 00 00 5b c3 90 0f 1f 44 00 00 8b 87 40 04 00 00 ff c8 83 f8 01 76 03 =
<0f> 0b c3 8b 87 f8 03 00 00 39 87 f0 03 00 00 0f 46 87 f0 03 00 00=0A=
>> [    5.454099] RSP: 0018:ffffc90000697c60 EFLAGS: 00010282=0A=
>> [    5.459306] RAX: 00000000ffffffff RBX: ffff8887fa0a9400 RCX: 00000000=
00000000=0A=
>> [    5.466390] RDX: ffff8887faf0d400 RSI: 0000000000000540 RDI: ffff8887=
f0dde6c8=0A=
>> [    5.473474] RBP: 0000000000007471 R08: 00000000001d1c40 R09: ffff8887=
fee29ad0=0A=
>> [    5.480559] R10: 00000001434bac00 R11: 0000000000358275 R12: 00000000=
00080000=0A=
>> [    5.487643] R13: ffff8887f0dde6c8 R14: ffff8887fa0a9738 R15: 00000000=
00000000=0A=
>> [    5.494726] FS:  0000000000000000(0000) GS:ffff8887fee00000(0000) knl=
GS:0000000000000000=0A=
>> [    5.502757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
>> [    5.508474] CR2: 0000000000000000 CR3: 0000000002209000 CR4: 00000000=
003406e0=0A=
>> [    5.515558] Call Trace:=0A=
>> [    5.518026]  sd_zbc_read_zones+0x323/0x480=0A=
>> [    5.522122]  sd_revalidate_disk+0x122b/0x2000=0A=
>> [    5.526472]  ? __device_add_disk+0x2f7/0x4e0=0A=
>> [    5.530738]  sd_probe+0x347/0x44b=0A=
>> [    5.534058]  really_probe+0x2c4/0x3f0=0A=
>> [    5.537720]  driver_probe_device+0xe1/0x150=0A=
>> [    5.541902]  ? driver_allows_async_probing+0x50/0x50=0A=
>> [    5.546852]  bus_for_each_drv+0x6a/0xa0=0A=
>> [    5.550683]  __device_attach_async_helper+0x8c/0xd0=0A=
>> [    5.555547]  async_run_entry_fn+0x4a/0x180=0A=
>> [    5.559636]  process_one_work+0x1a5/0x3a0=0A=
>> [    5.563637]  worker_thread+0x50/0x3a0=0A=
>> [    5.567300]  ? process_one_work+0x3a0/0x3a0=0A=
>> [    5.571480]  kthread+0x117/0x160=0A=
>> [    5.574715]  ? kthread_park+0x90/0x90=0A=
>> [    5.578377]  ret_from_fork+0x22/0x30=0A=
>> [    5.581960] ---[ end trace 94141003236730cf ]---=0A=
>> [    5.586578] sd 3:0:0:0: [sdb] Attached SCSI disk=0A=
>> [    6.186783] ata5: failed to resume link (SControl 0)=0A=
>> [    6.191818] ata5: SATA link down (SStatus 0 SControl 0)=0A=
>>=0A=
=0A=
=0A=
This looks like we're trying to configure zone append max sectors =0A=
on a device that doesn't have the zoned flag set.=0A=
=0A=
> =0A=
> Can you try this:=0A=
> =0A=
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
> index 95018e650f2d..620539162ef1 100644=0A=
> --- a/drivers/scsi/sd.c=0A=
> +++ b/drivers/scsi/sd.c=0A=
> @@ -2968,8 +2968,13 @@ static void sd_read_block_characteristics(struct=
=0A=
> scsi_disk *sdkp)=0A=
>         } else {=0A=
>                 sdkp->zoned =3D (buffer[8] >> 4) & 3;=0A=
>                 if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->di=
sk)) {=0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>                         /* Host-aware */=0A=
>                         q->limits.zoned =3D BLK_ZONED_HA;=0A=
> +#else=0A=
> +                       /* Host-aware drive is treated as a regular disk =
*/=0A=
> +                       q->limits.zoned =3D BLK_ZONED_NONE;=0A=
> +#endif=0A=
>                 } else {=0A=
>                         /*=0A=
>                          * Treat drive-managed devices and host-aware dev=
ices=0A=
> @@ -3404,12 +3409,12 @@ static int sd_probe(struct device *dev)=0A=
>         sdkp->first_scan =3D 1;=0A=
>         sdkp->max_medium_access_timeouts =3D SD_MAX_MEDIUM_TIMEOUTS;=0A=
> =0A=
> +       sd_revalidate_disk(gd);=0A=
> +=0A=
>         error =3D sd_zbc_init_disk(sdkp);=0A=
>         if (error)=0A=
>                 goto out_free_index;=0A=
> =0A=
> -       sd_revalidate_disk(gd);=0A=
> -=0A=
=0A=
=0A=
I don't get how my patch may have broken this. If we have =0A=
CONFIG_BLK_DEV_ZONED=3Dn, sd_zbc_init_disk() is stubbed out and return 0=0A=
unconditionally. So the call path will remain exactly the same.=0A=
=0A=
>         gd->flags =3D GENHD_FL_EXT_DEVT;=0A=
>         if (sdp->removable) {=0A=
>                 gd->flags |=3D GENHD_FL_REMOVABLE;=0A=
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h=0A=
> index 4933e7daf17d..f4dc81d48a01 100644=0A=
> --- a/drivers/scsi/sd.h=0A=
> +++ b/drivers/scsi/sd.h=0A=
> @@ -241,6 +241,8 @@ static inline void sd_zbc_release_disk(struct scsi_di=
sk=0A=
> *sdkp) {}=0A=
>  static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,=0A=
>                                     unsigned char *buf)=0A=
>  {=0A=
> +       if (sd_is_zoned(sdkp))=0A=
> +               sdkp->capacity =3D 0;=0A=
>         return 0;=0A=
>  }=0A=
> =0A=
> That should fix the above as well as the hang on boot with CONFIG_BLK_DEV=
_ZONED=0A=
> disabled (for that one I do not totally understand what is going on...).=
=0A=
> =0A=
> We do not have any host-aware disk for testing (as far as I know, nobody =
is=0A=
> selling these anymore), so our test setup is a bit lame in this area. We'=
ll rig=0A=
> something up with tcmu-runner emulation to add tests for these devices to=
 avoid=0A=
> a repeat of such problem. And we'll make sure to add a test for=0A=
> host-aware+partitions, since we at least know for sure there is one user =
:)=0A=
> =0A=
> Johannes: The "goto out_free_index;" on sd_zbc_init_disk() failure is wro=
ng I=0A=
> think: the disk is already added and a ref taken on the dev, but out_free=
_index=0A=
> does not seem to do cleanup for that. Need to revisit this.=0A=
=0A=
Yes just seen it as well, will be cooking a fix for that.=0A=
=0A=
I'll build a test env to nail this down.=0A=
=0A=
Byte,=0A=
	Johannes=0A=

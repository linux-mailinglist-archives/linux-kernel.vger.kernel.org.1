Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6095D267A8E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgILM7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:59:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35803 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgILM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599915569; x=1631451569;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BD/rDSbjI+lX1REy/Z9+hzV4FY9VMeMuDnR3Q/nWCp4=;
  b=EczXQJQdcqn5kHAmfUgnclpQN4zAwRTKHvLENCxe2G1zF8PAlE77rq50
   w74s6mmGLmV8f/gATx94WFhD6U0TzoJxfp2UPhdCQIwUbccRCIsHaU4KP
   nOr8Q6GixLMArecMSE9Mz1lr3RfA7kw5ms+DXBUtJ4DUgZ9RVyAsWdZV1
   XZp1GOwbx92SMRiYqoumzeSMeWzV6CC6V5wqy6pxAhRQQsQbff/NJouLe
   Gr9lIzS/6RHQ98a6jrMHFwCd35FqLSgzM4RA5LEmTysUXKMBfX4fmMlkI
   WKOCrK5s2RN8Tlx6HsqzSU5Miqr4ZCG0GQv1XTrNTZgffmxtqVJ8o33zL
   w==;
IronPort-SDR: v5engVajzKdPdc8gf0Zc0Ll/ntWd/QWWlHRBfzPfUISSer91+vZ4w75K6IMdPxTuTcJL7/71gL
 TEGOfykh7FY6eOP3AuB4uTeUZs+zMVGXqunzKerK2xWZuSd/scZlGrCUFG/cF3nAa2v9kjUxLO
 RufpRvZpAkXktjmob4GaTNfeWrsf/uBYcjF5LsF1571hFhFzq1R5ka8zrhhgWJUA6IXP45Hfn3
 tCFiRi5bJjrja4l8McuE/Ur7Zzm71Ob22WVrsEo4SufzLwNXyM0F/BOFUlD5bDeHeyGe3MlAXc
 Zys=
X-IronPort-AV: E=Sophos;i="5.76,420,1592841600"; 
   d="scan'208";a="256812667"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 20:59:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9BIufZ7IUcb9ceqXJfsZEQKz+2UwMKQJPvggt3yT3YOSp6tDOQ5cF1nyT71Nn7foWA0D4c25+gJMXM0xx1qWcoHCJ877LFo2IX20UuiGWhQei8DtoluZ7+nPVLAw2Z7lMNXVtr7wOq7bBIZg9xTsRAIeFewm9RKWw/1y3+SmJRgsDZOtVmCaDV23ZHQvj40akv77V7vjG9tTe/BbHE/e/2EgzEFCFjze2QeCNFvalw4UrSxsjMLuab3QFb7kIue5AfODJFoxjK+GJVUejFMM/XDA3NYD+555esTqYmcsrsJvV8GMttf7AMrWdPcj+16YY/wJ/2grv/flTM6Pl2FPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0LLejdBbcZkG7LCXoBvvEw9/B0ypEedjt/2jueuuPs=;
 b=fPc34Y/qJvktz3WYa5u+2RB7R1HH245TbiycLKBYMRy6BpkgmkU2GbXRxYoxtWz1sdNG7KrmlL3cTrYoA60LYrF6Z7CLq/B9NNR1PJfZX/+6rNdOhoIjGqFyPq4RBj4NO8o9jEW9gzRVbHOuEUZxWaB9cK+H4Mwmnpq+Px8++0gJMNK+3sEfpCC63tJAkMFVTx5b/kjLWxUgsafSIoVAozsRvTwOyHFSrP1EmP3kOawoIcDMo/KcXvUKvWoWBZUYKvlzEYz/pc9LS1gHkrQIGE21+yFXxS1JS2ghVyDh6SSpSlKQzjLRtQ4FxGIigUuj6y3QcS2XSfZOkTcZWAMO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0LLejdBbcZkG7LCXoBvvEw9/B0ypEedjt/2jueuuPs=;
 b=ukpo0uUORNzFTZQPM2eI9ZdMZaAX7oQLy8tabpI1wHw4iz9UO7SeZnv1gm+ys7klVWw0dveWcmL1SNItC0M876VmWBbuoRQ3W+HgVDA+SayOyDv4KLRjzp5gloNsyGTKxoPgAVnTmlZh/ksJFXr1OtWq2FzZKhlMrXaxMvVYnp8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1033.namprd04.prod.outlook.com (2603:10b6:910:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Sat, 12 Sep
 2020 12:59:22 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.017; Sat, 12 Sep 2020
 12:59:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWiHU54Zgl03vp4EGth2S6djlYmA==
Date:   Sat, 12 Sep 2020 12:59:22 +0000
Message-ID: <CY4PR04MB375122843D6BC7200CE8461BE7250@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic> <20200911230703.GA2971@nazgul.tnic>
 <CY4PR04MB3751630AAB4A625BD64C66C3E7250@CY4PR04MB3751.namprd04.prod.outlook.com>
 <SN4PR0401MB35988DE053A515756DBB123C9B250@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:593c:8256:27ca:4ca5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb073d07-f538-40bb-bbd5-08d8571bab8f
x-ms-traffictypediagnostic: CY4PR04MB1033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB10332CF0F61520B859D4A04CE7250@CY4PR04MB1033.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bY0tOYf5bFiPe/Xr+NlvpFD5lJpIh0Tbj0xlEFI9S3NClObh0eFBmWs5ac/Qj8nceQGTzVW/cFn0ofnQMzSFT9DFgcZ8eFuRP1DKfT4LGWR8qbRa/a1Xo60tIxo3XEprhxOv7AVFM60w/WsRX70DXJKhg6ysMvYyk9/i8sVuA3TyQTxk8R0nsfakrG8hGLWH2Hy3A9cxOmPeAjjqb12c2M3GXwWZSH395MjhoKTvALejqjj3+qHPk1mLVpmX7+og1saU45uHRzCgbPVDlHpSWLJGtysH7BAaBvwo1hINX0eQHspj5cstIRxQieQloSxMlPLq3yfMctyaewgtYgBxzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(86362001)(7696005)(8936002)(8676002)(83380400001)(6506007)(2906002)(55016002)(52536014)(53546011)(186003)(71200400001)(9686003)(66556008)(66446008)(91956017)(4326008)(110136005)(76116006)(316002)(478600001)(64756008)(33656002)(66946007)(54906003)(66476007)(45080400002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bwfqsuM9Dh1rG789pTmzW0kqQc528kFZsXuOJAUa5EWdVpMmJQvgSXh68TgrnI5k5iGCtCPChxNdy2vZB8JzPl53M82IHZr0tbpEkroeocPlf5ZyQOnx1324c537y9haNf7Nih4KwDCHNXohZ7LgBeaShii1AnZVckf67mMO5VjXU/nCPi3H5I4FkEgT2ye0AEFPWrIAOhDhck9X7gAWLMeL3BhLeUdFmatIOy+605uNSEcQhw7mDjl1wowLUKN88/FKcS8mxhk3jyBfBEXweKQH/cIXVGnxzxONE5qHa/m7dLJF8pZe4Nd+b3AeJl25ghjPi/TBYLJHUWafoeMTN+Be7oW/vxUOJOm6rbHqKwimvtIzZBYsUsSdH2FTYHuXR77LwK6o3pM8H6/n9GZsAUfz35SR9vjOuf+/zAB2dQRn18hQ30mfEY7zP7TCUDWO6aXD6o+jYjKYaJLyRk2WX2hGP2qx097pjFRFDP4Fkvl1bB6QuINY8cWSdNWKD5IOpNocJP+OIkbdwDTx3tBjbj4MA+k8uqGekd+81nj+p+9OhLacJTZmwgj3QFSrc8fCphnfRwby3SMQLYADH/71vUOohEGYMMp9hWUdPfdZdvBSGwa4SWm095kFYwXBEtJU3p1AgzzBb+w6LHlZylbAkmYK/GpizI545ipBc4fTvpPCX4+SxcIr8ucg16jS5mSE1kFJ+WophAWenHRpUJjYJg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb073d07-f538-40bb-bbd5-08d8571bab8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2020 12:59:22.6462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnFLeMz5BvRhbz9TlMS8+n8WBp/b1pkd0OX9ubxTH185y9crjOPFnsbZgNlIFGamUf+XfTIxXTR/HroNmG9sww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/12 18:09, Johannes Thumshirn wrote:=0A=
> On 12/09/2020 04:31, Damien Le Moal wrote:=0A=
>> On 2020/09/12 8:07, Borislav Petkov wrote:=0A=
>>> On Sat, Sep 12, 2020 at 12:17:59AM +0200, Borislav Petkov wrote:=0A=
>>>> Enabling it, fixes the issue.=0A=
>>>=0A=
>>> Btw, I just hit the below warn with 5.8, while booting with the above=
=0A=
>>> config option enabled. Looks familiar and I didn't trigger it with=0A=
>>> 5.9-rc4+ so you guys either fixed it or something changed in-between:=
=0A=
>>>=0A=
>>> [    5.124321] ata4.00: NCQ Send/Recv Log not supported=0A=
>>> [    5.131484] ata4.00: configured for UDMA/133=0A=
>>> [    5.135847] scsi 3:0:0:0: Direct-Access     ATA      ST8000AS0022-1W=
L SN01 PQ: 0 ANSI: 5=0A=
>>> [    5.143972] sd 3:0:0:0: Attached scsi generic sg1 type 0=0A=
>>> [    5.144033] sd 3:0:0:0: [sdb] Host-aware zoned block device=0A=
>>> [    5.177105] sd 3:0:0:0: [sdb] 15628053168 512-byte logical blocks: (=
8.00 TB/7.28 TiB)=0A=
>>> [    5.184880] sd 3:0:0:0: [sdb] 4096-byte physical blocks=0A=
>>> [    5.190084] sd 3:0:0:0: [sdb] 29808 zones of 524288 logical blocks +=
 1 runt zone=0A=
>>> [    5.197439] sd 3:0:0:0: [sdb] Write Protect is off=0A=
>>> [    5.202220] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00=0A=
>>> [    5.207260] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA=0A=
>>> [    5.356631]  sdb: sdb1=0A=
>>> [    5.359014] sdb: disabling host aware zoned block device support due=
 to partitions=0A=
>>> [    5.389941] ------------[ cut here ]------------=0A=
>>> [    5.394557] WARNING: CPU: 8 PID: 164 at block/blk-settings.c:236 blk=
_queue_max_zone_append_sectors+0x12/0x40=0A=
>>> [    5.404300] Modules linked in:=0A=
>>> [    5.407365] CPU: 8 PID: 164 Comm: kworker/u32:6 Not tainted 5.8.0 #7=
=0A=
>>> [    5.413682] Hardware name: Micro-Star International Co., Ltd. MS-7B7=
9/X470 GAMING PRO (MS-7B79), BIOS 1.70 01/23/2019=0A=
>>> [    5.424191] Workqueue: events_unbound async_run_entry_fn=0A=
>>> [    5.429482] RIP: 0010:blk_queue_max_zone_append_sectors+0x12/0x40=0A=
>>> [    5.435543] Code: fe 0f 00 00 53 48 89 fb 0f 86 3d 07 00 00 48 89 b3=
 e0 03 00 00 5b c3 90 0f 1f 44 00 00 8b 87 40 04 00 00 ff c8 83 f8 01 76 03=
 <0f> 0b c3 8b 87 f8 03 00 00 39 87 f0 03 00 00 0f 46 87 f0 03 00 00=0A=
>>> [    5.454099] RSP: 0018:ffffc90000697c60 EFLAGS: 00010282=0A=
>>> [    5.459306] RAX: 00000000ffffffff RBX: ffff8887fa0a9400 RCX: 0000000=
000000000=0A=
>>> [    5.466390] RDX: ffff8887faf0d400 RSI: 0000000000000540 RDI: ffff888=
7f0dde6c8=0A=
>>> [    5.473474] RBP: 0000000000007471 R08: 00000000001d1c40 R09: ffff888=
7fee29ad0=0A=
>>> [    5.480559] R10: 00000001434bac00 R11: 0000000000358275 R12: 0000000=
000080000=0A=
>>> [    5.487643] R13: ffff8887f0dde6c8 R14: ffff8887fa0a9738 R15: 0000000=
000000000=0A=
>>> [    5.494726] FS:  0000000000000000(0000) GS:ffff8887fee00000(0000) kn=
lGS:0000000000000000=0A=
>>> [    5.502757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
>>> [    5.508474] CR2: 0000000000000000 CR3: 0000000002209000 CR4: 0000000=
0003406e0=0A=
>>> [    5.515558] Call Trace:=0A=
>>> [    5.518026]  sd_zbc_read_zones+0x323/0x480=0A=
>>> [    5.522122]  sd_revalidate_disk+0x122b/0x2000=0A=
>>> [    5.526472]  ? __device_add_disk+0x2f7/0x4e0=0A=
>>> [    5.530738]  sd_probe+0x347/0x44b=0A=
>>> [    5.534058]  really_probe+0x2c4/0x3f0=0A=
>>> [    5.537720]  driver_probe_device+0xe1/0x150=0A=
>>> [    5.541902]  ? driver_allows_async_probing+0x50/0x50=0A=
>>> [    5.546852]  bus_for_each_drv+0x6a/0xa0=0A=
>>> [    5.550683]  __device_attach_async_helper+0x8c/0xd0=0A=
>>> [    5.555547]  async_run_entry_fn+0x4a/0x180=0A=
>>> [    5.559636]  process_one_work+0x1a5/0x3a0=0A=
>>> [    5.563637]  worker_thread+0x50/0x3a0=0A=
>>> [    5.567300]  ? process_one_work+0x3a0/0x3a0=0A=
>>> [    5.571480]  kthread+0x117/0x160=0A=
>>> [    5.574715]  ? kthread_park+0x90/0x90=0A=
>>> [    5.578377]  ret_from_fork+0x22/0x30=0A=
>>> [    5.581960] ---[ end trace 94141003236730cf ]---=0A=
>>> [    5.586578] sd 3:0:0:0: [sdb] Attached SCSI disk=0A=
>>> [    6.186783] ata5: failed to resume link (SControl 0)=0A=
>>> [    6.191818] ata5: SATA link down (SStatus 0 SControl 0)=0A=
>>>=0A=
> =0A=
> =0A=
> This looks like we're trying to configure zone append max sectors =0A=
> on a device that doesn't have the zoned flag set.=0A=
=0A=
Yep. That's because sd_zbc_revalidate_zones() entry test uses sd_is_zoned()=
 and=0A=
does not look at queue->limits.zoned which was changed to BLK_ZONE_NONE whi=
le=0A=
sd_is_zoned() still correctly says that the drive is host-aware. We need to=
=0A=
change the entry test to use blk_queue_is_zoned() instead of sd_is_zoned().=
=0A=
=0A=
> =0A=
>>=0A=
>> Can you try this:=0A=
>>=0A=
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
>> index 95018e650f2d..620539162ef1 100644=0A=
>> --- a/drivers/scsi/sd.c=0A=
>> +++ b/drivers/scsi/sd.c=0A=
>> @@ -2968,8 +2968,13 @@ static void sd_read_block_characteristics(struct=
=0A=
>> scsi_disk *sdkp)=0A=
>>         } else {=0A=
>>                 sdkp->zoned =3D (buffer[8] >> 4) & 3;=0A=
>>                 if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->d=
isk)) {=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>>                         /* Host-aware */=0A=
>>                         q->limits.zoned =3D BLK_ZONED_HA;=0A=
>> +#else=0A=
>> +                       /* Host-aware drive is treated as a regular disk=
 */=0A=
>> +                       q->limits.zoned =3D BLK_ZONED_NONE;=0A=
>> +#endif=0A=
>>                 } else {=0A=
>>                         /*=0A=
>>                          * Treat drive-managed devices and host-aware de=
vices=0A=
>> @@ -3404,12 +3409,12 @@ static int sd_probe(struct device *dev)=0A=
>>         sdkp->first_scan =3D 1;=0A=
>>         sdkp->max_medium_access_timeouts =3D SD_MAX_MEDIUM_TIMEOUTS;=0A=
>>=0A=
>> +       sd_revalidate_disk(gd);=0A=
>> +=0A=
>>         error =3D sd_zbc_init_disk(sdkp);=0A=
>>         if (error)=0A=
>>                 goto out_free_index;=0A=
>>=0A=
>> -       sd_revalidate_disk(gd);=0A=
>> -=0A=
> =0A=
> =0A=
> I don't get how my patch may have broken this. If we have =0A=
> CONFIG_BLK_DEV_ZONED=3Dn, sd_zbc_init_disk() is stubbed out and return 0=
=0A=
> unconditionally. So the call path will remain exactly the same.=0A=
=0A=
Yes, I am not 100% sure what is going on with CONFIG_BLK_DEV_ZONED=3Dn. As =
far as=0A=
I can see, everything should be OK, but clearly not... Let's fix that Monda=
y=0A=
first thing.=0A=
=0A=
Also, partitions/core.c may need some attention: with the zone append=0A=
initialization already done, if a partition is created, changing  the disk =
from=0A=
HA to NONE should be done properly, cleaning up the zone offset array and m=
ax=0A=
zone append sectors... But we can't call into scsi directly, so need to che=
ck=0A=
that revalidation is triggered and detect the change... Not pretty. And the=
=0A=
reverse too: if partitions are deleted, we need to go back to zoned=3D=3DHA=
 and so=0A=
reinitialize zone append emulation.=0A=
=0A=
At this point, I really would love to simply treat host-aware disks as regu=
lar=0A=
disks, always...  That would make things *a lot* more simple.=0A=
=0A=
> =0A=
>>         gd->flags =3D GENHD_FL_EXT_DEVT;=0A=
>>         if (sdp->removable) {=0A=
>>                 gd->flags |=3D GENHD_FL_REMOVABLE;=0A=
>> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h=0A=
>> index 4933e7daf17d..f4dc81d48a01 100644=0A=
>> --- a/drivers/scsi/sd.h=0A=
>> +++ b/drivers/scsi/sd.h=0A=
>> @@ -241,6 +241,8 @@ static inline void sd_zbc_release_disk(struct scsi_d=
isk=0A=
>> *sdkp) {}=0A=
>>  static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,=0A=
>>                                     unsigned char *buf)=0A=
>>  {=0A=
>> +       if (sd_is_zoned(sdkp))=0A=
>> +               sdkp->capacity =3D 0;=0A=
>>         return 0;=0A=
>>  }=0A=
>>=0A=
>> That should fix the above as well as the hang on boot with CONFIG_BLK_DE=
V_ZONED=0A=
>> disabled (for that one I do not totally understand what is going on...).=
=0A=
>>=0A=
>> We do not have any host-aware disk for testing (as far as I know, nobody=
 is=0A=
>> selling these anymore), so our test setup is a bit lame in this area. We=
'll rig=0A=
>> something up with tcmu-runner emulation to add tests for these devices t=
o avoid=0A=
>> a repeat of such problem. And we'll make sure to add a test for=0A=
>> host-aware+partitions, since we at least know for sure there is one user=
 :)=0A=
>>=0A=
>> Johannes: The "goto out_free_index;" on sd_zbc_init_disk() failure is wr=
ong I=0A=
>> think: the disk is already added and a ref taken on the dev, but out_fre=
e_index=0A=
>> does not seem to do cleanup for that. Need to revisit this.=0A=
> =0A=
> Yes just seen it as well, will be cooking a fix for that.=0A=
> =0A=
> I'll build a test env to nail this down.=0A=
=0A=
Here is my patch, revisited. Not complete yet, b ut no space corruption thi=
s time !=0A=
=0A=
=0A=
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
index 95018e650f2d..49d6dc374fb6 100644=0A=
--- a/drivers/scsi/sd.c=0A=
+++ b/drivers/scsi/sd.c=0A=
@@ -2968,22 +2968,36 @@ static void sd_read_block_characteristics(struct=0A=
scsi_disk *sdkp)=0A=
 	} else {=0A=
 		sdkp->zoned =3D (buffer[8] >> 4) & 3;=0A=
 		if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->disk)) {=0A=
+#ifdef CONFIG_BLK_DEV_ZONED=0A=
 			/* Host-aware */=0A=
 			q->limits.zoned =3D BLK_ZONED_HA;=0A=
+#else=0A=
+			/* Host-aware drive is treated as a regular disk */=0A=
+			q->limits.zoned =3D BLK_ZONED_NONE;=0A=
+#endif=0A=
 		} else {=0A=
 			/*=0A=
 			 * Treat drive-managed devices and host-aware devices=0A=
 			 * with partitions as regular block devices.=0A=
 			 */=0A=
 			q->limits.zoned =3D BLK_ZONED_NONE;=0A=
-			if (sdkp->zoned =3D=3D 2 && sdkp->first_scan)=0A=
-				sd_printk(KERN_NOTICE, sdkp,=0A=
-					  "Drive-managed SMR disk\n");=0A=
 		}=0A=
 	}=0A=
-	if (blk_queue_is_zoned(q) && sdkp->first_scan)=0A=
+=0A=
+	if (!sdkp->first_scan)=0A=
+		goto out;=0A=
+=0A=
+	if (blk_queue_is_zoned(q)) {=0A=
 		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",=0A=
 		      q->limits.zoned =3D=3D BLK_ZONED_HM ? "managed" : "aware");=0A=
+	} else {=0A=
+		if (sdkp->zoned =3D=3D 1)=0A=
+			sd_printk(KERN_NOTICE, sdkp,=0A=
+				  "Host-aware SMR disk used as regular disk\n");=0A=
+		else if (sdkp->zoned =3D=3D 2)=0A=
+			sd_printk(KERN_NOTICE, sdkp,=0A=
+				  "Drive-managed SMR disk\n");=0A=
+	}=0A=
=0A=
  out:=0A=
 	kfree(buffer);=0A=
@@ -3404,12 +3418,12 @@ static int sd_probe(struct device *dev)=0A=
 	sdkp->first_scan =3D 1;=0A=
 	sdkp->max_medium_access_timeouts =3D SD_MAX_MEDIUM_TIMEOUTS;=0A=
=0A=
+	sd_revalidate_disk(gd);=0A=
+=0A=
 	error =3D sd_zbc_init_disk(sdkp);=0A=
 	if (error)=0A=
 		goto out_free_index;=0A=
=0A=
-	sd_revalidate_disk(gd);=0A=
-=0A=
 	gd->flags =3D GENHD_FL_EXT_DEVT;=0A=
 	if (sdp->removable) {=0A=
 		gd->flags |=3D GENHD_FL_REMOVABLE;=0A=
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h=0A=
index 4933e7daf17d..f4dc81d48a01 100644=0A=
--- a/drivers/scsi/sd.h=0A=
+++ b/drivers/scsi/sd.h=0A=
@@ -241,6 +241,8 @@ static inline void sd_zbc_release_disk(struct scsi_disk=
=0A=
*sdkp) {}=0A=
 static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,=0A=
 				    unsigned char *buf)=0A=
 {=0A=
+	if (sd_is_zoned(sdkp))=0A=
+		sdkp->capacity =3D 0;=0A=
 	return 0;=0A=
 }=0A=
=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

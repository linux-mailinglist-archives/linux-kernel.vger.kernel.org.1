Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2A267745
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 04:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgILCcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 22:32:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37981 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgILCcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 22:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599877919; x=1631413919;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iyxW44YwHnPFEY2W8p4IzAGa7Y9PTiS53R+K5ErzRf4=;
  b=aN5jyYKDr2aC44qYnqf0AauCLJQayH4CaeDfZ8HTQ5CP6drAsLNS1Bnm
   eqTazbvILZSX9qX0bwuhaaqvFrIAba/2FVwviUrB2LsA0Mo20ANlz+oSY
   iHL7TGtCEfXMzHfEanoBhTFmOaWarwkxv/BR9LGN/hSkruO8DVSQrVMv+
   8fdX6DM8jtWuDOPoGDlyjgm2sbih4wL5cJtwlrrnH9dW9+b06JCURrZ2G
   3H2++rolipdZ1racY3PihIsQeqO0CPiTUIlw48326N8Q097eOqqmF0VIR
   an/hsSe/cXuCysUf8f9YUnPwpZengLNLcBd+x9DxXLj8trtbjhv7QZckd
   w==;
IronPort-SDR: 3o6W3BRBBGVkpeJ5Vs0JagdME8DZJzHU3MIVO23Drv/pxDaH3ElcZxK3XJxQGIKLxTkwWWKCT+
 A2B2MyOoKr4Tj7dXqwojDupJTC0E0dNAD9kG/sOwhhUMrodFdO0XvURN2LrHF6K298Pu92vsr+
 XxQAjs23CPsK0r4eoHIYiAXLJKkH/p0ryUO2KJlSXE7mgHkkF7VqeuGCuaGOGo4ZwlaS/MN/Oa
 3hir85lyIrTaTbS2G/DdzvC+cThoNk4WvDrtoh/3apZhCY6krdGNHC/cgyaQpLxqg/TlOPKFgw
 ZQQ=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="147100776"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 10:31:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DExjk3JEJeNbSRKwAo5DLaoTOlG3NCWwYFyvZweRc2TOs8lM4sjYvCwUSAOtRS9scKsT1UfT8HGaOmLcEIxUpwjwKSUlhX5oKl1o9eMqwwDdn4I+YOpAPQFkkLzPK1nz8htDWSMgImxv0pzD9GcbUFEJs9ynYyp2xUSg+d45sUspkHq6Q8hoJ7+ZVFu1/+HNObo9hhhGo6F/cmIE6p8eo12GI6T+AL4nyXqSAFk5bSPI0aD0VpSvkipz3C4DDFpKShFEVC6GPEjJ1Bs4hvrdcyiJeee+rAu5toPtbpUqTQD6PN4aSAy1xgT2X+twZDTeZsMe2i9CkqNWAlvovilRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNJJBdnilbN9Sy5NnnMwuOd0uwlETCpZ049dvL3IsxM=;
 b=QTwHSdMojxJiv/SJ2fTEP4FvNtfOMADQ1BnPjEN/XR+WOQVgCx03YQrBIfSigJKSpiu8AKXQVglSXJKZ7GiyWG1G/OgreElnCfX4zSlN9jiYgm8ebikLySvXOZ+Bkxk2TDeJEnAM5fComk8XdOZ0SoFP5YVWalN8JKlfMGPCmq9gvmWXtu+LO4Evn3MGYrA8IJwdNgp/KZ+9q6wM/whmljcVIDUglrp7mIBkrfNav41sUsFpeJ9koiT2FnTyqGBKCcojmtbUUR53JOrIGU6HBrIUD25xQgNFTqpvMbePhWPkJd4H3oyjP1kUEz7DqrD6/DbyXJ7UQe2u++HA5wixrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNJJBdnilbN9Sy5NnnMwuOd0uwlETCpZ049dvL3IsxM=;
 b=ZM8uP1j/v68TKY+TRz0QsRblwa3E5DdEzXgRwjT4Ra1JGvvJgTRM934so0YkcWss5EuVbBTxIaPaizj2rDZN7pLkBapGN6dcxYJ4skEqq3eb+zAm1kIorOg+F3kaQ1UdxonyY30SdJfIUidsgNYfC6Z5lERhV/9isXcX1FCGlNc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0729.namprd04.prod.outlook.com (2603:10b6:903:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Sat, 12 Sep
 2020 02:31:55 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.017; Sat, 12 Sep 2020
 02:31:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Borislav Petkov <bp@alien8.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWiHU54Zgl03vp4EGth2S6djlYmA==
Date:   Sat, 12 Sep 2020 02:31:55 +0000
Message-ID: <CY4PR04MB3751630AAB4A625BD64C66C3E7250@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic> <20200911230703.GA2971@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:593c:8256:27ca:4ca5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e08450db-a84b-40d7-674f-08d856c40449
x-ms-traffictypediagnostic: CY4PR04MB0729:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB07296022572772008F058EB9E7250@CY4PR04MB0729.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkDYv9rtUzmd23jzMX6QQcHdch6evu5UMGH9J+nh1EhrMR/OTM74NoNoqxoHXMI3ZZiV3O3Vofv1yfKwZianwzTIf5OgmctdPZqieAGbQy2RqKVAxjOFJzDCPtNELbWmnlWieTSFpJ22uAlEQqtQ7+sZ9LGygBGvhrpm63dU5lEjqCDE2UNs+6leRM0PUDNqVu5puVVtmvrA1S26nQZPMorykI4k52A8aWTD0F+3eyoDCRda4TRUkt9le1iDbhl2GrxJmNHqh2ReAg0X7PQaipV83kNtdmSl2cJGasoKjMm+dTIOO4JT08j9QEfGRTfpA0BJALIilSS/GoPoozUxtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(53546011)(66556008)(83380400001)(66946007)(54906003)(110136005)(7696005)(8936002)(5660300002)(71200400001)(76116006)(64756008)(66476007)(91956017)(33656002)(52536014)(66446008)(186003)(4326008)(2906002)(6506007)(45080400002)(6636002)(478600001)(8676002)(86362001)(316002)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mp3lYJkKqMJCdBsQICNNiDXkCdYhhf3QbfOYK4ccby4nQHJJeMkqXNcybbWR1rh1B3Joy6UzNcg6t1IGHXGX0owXxq1qZ3gc7Ktaj3RLZP+jLafX6FrXDuVQhUONHGNUT6Oh8k/fTR0zJc3on3tqXMaE+XENrSXUmFfN0TBcfH0fTZnouD7G7noPLLivFl0spQ8u8AkWS145tNP11gshkXDCbn2BlbJlL2JP/gO0/sV5pjjTxkp4nlbKbWZtmIHwKT2KsYAt9bI4OhF4u9Tb9FQOv9X1AlM5RGzVqK6QoBIEYtUDzbS4oD3YEbYPG/6AT88nagFzk8qJXPd5XMy4KqnQ1tKb8GZwl3uNWRAA2/17EQnywK/tPK8hhaOn55fAf3TNrOncX1SBs+onM4sj/68pSLsdyd0RXwC2zGe2QnslJfJeIW/A0zZ0Ixh+3D3SIuC6ahjkJ8qo5lOaNY/4lLfXFK9WMU8XQ2JSYW8b0giOPalSFy7U+Z0pdRXeF3aG8kr46I/uex+JW8grb4tVqjvye1G1Qo2L2Zc2Lj6VDPPzKdUAbvvVQmyM1lA0u537VSECQjKM/wR8/9WKhBImLl6XgoP3yYH8nZx/7IK4tW3lXGyeBjA4/hL7WW6JvCm00vWPxW2Dx8eaTnpmRppqrJw2bqRx6olvod2Ynx/vW43S023sD3jouxUTw/D88w5au6wev2Q1QbiZld3Pjdy/Nw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08450db-a84b-40d7-674f-08d856c40449
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2020 02:31:55.7343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39zrRv22guaVOKS3wGeqMfMIoFlv3oMp57vcfacfMYLExF1r9yznG/7Xchx/ftkIUJrQlR2kusmEJnDuegrI1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0729
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/12 8:07, Borislav Petkov wrote:=0A=
> On Sat, Sep 12, 2020 at 12:17:59AM +0200, Borislav Petkov wrote:=0A=
>> Enabling it, fixes the issue.=0A=
> =0A=
> Btw, I just hit the below warn with 5.8, while booting with the above=0A=
> config option enabled. Looks familiar and I didn't trigger it with=0A=
> 5.9-rc4+ so you guys either fixed it or something changed in-between:=0A=
> =0A=
> [    5.124321] ata4.00: NCQ Send/Recv Log not supported=0A=
> [    5.131484] ata4.00: configured for UDMA/133=0A=
> [    5.135847] scsi 3:0:0:0: Direct-Access     ATA      ST8000AS0022-1WL =
SN01 PQ: 0 ANSI: 5=0A=
> [    5.143972] sd 3:0:0:0: Attached scsi generic sg1 type 0=0A=
> [    5.144033] sd 3:0:0:0: [sdb] Host-aware zoned block device=0A=
> [    5.177105] sd 3:0:0:0: [sdb] 15628053168 512-byte logical blocks: (8.=
00 TB/7.28 TiB)=0A=
> [    5.184880] sd 3:0:0:0: [sdb] 4096-byte physical blocks=0A=
> [    5.190084] sd 3:0:0:0: [sdb] 29808 zones of 524288 logical blocks + 1=
 runt zone=0A=
> [    5.197439] sd 3:0:0:0: [sdb] Write Protect is off=0A=
> [    5.202220] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00=0A=
> [    5.207260] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA=0A=
> [    5.356631]  sdb: sdb1=0A=
> [    5.359014] sdb: disabling host aware zoned block device support due t=
o partitions=0A=
> [    5.389941] ------------[ cut here ]------------=0A=
> [    5.394557] WARNING: CPU: 8 PID: 164 at block/blk-settings.c:236 blk_q=
ueue_max_zone_append_sectors+0x12/0x40=0A=
> [    5.404300] Modules linked in:=0A=
> [    5.407365] CPU: 8 PID: 164 Comm: kworker/u32:6 Not tainted 5.8.0 #7=
=0A=
> [    5.413682] Hardware name: Micro-Star International Co., Ltd. MS-7B79/=
X470 GAMING PRO (MS-7B79), BIOS 1.70 01/23/2019=0A=
> [    5.424191] Workqueue: events_unbound async_run_entry_fn=0A=
> [    5.429482] RIP: 0010:blk_queue_max_zone_append_sectors+0x12/0x40=0A=
> [    5.435543] Code: fe 0f 00 00 53 48 89 fb 0f 86 3d 07 00 00 48 89 b3 e=
0 03 00 00 5b c3 90 0f 1f 44 00 00 8b 87 40 04 00 00 ff c8 83 f8 01 76 03 <=
0f> 0b c3 8b 87 f8 03 00 00 39 87 f0 03 00 00 0f 46 87 f0 03 00 00=0A=
> [    5.454099] RSP: 0018:ffffc90000697c60 EFLAGS: 00010282=0A=
> [    5.459306] RAX: 00000000ffffffff RBX: ffff8887fa0a9400 RCX: 000000000=
0000000=0A=
> [    5.466390] RDX: ffff8887faf0d400 RSI: 0000000000000540 RDI: ffff8887f=
0dde6c8=0A=
> [    5.473474] RBP: 0000000000007471 R08: 00000000001d1c40 R09: ffff8887f=
ee29ad0=0A=
> [    5.480559] R10: 00000001434bac00 R11: 0000000000358275 R12: 000000000=
0080000=0A=
> [    5.487643] R13: ffff8887f0dde6c8 R14: ffff8887fa0a9738 R15: 000000000=
0000000=0A=
> [    5.494726] FS:  0000000000000000(0000) GS:ffff8887fee00000(0000) knlG=
S:0000000000000000=0A=
> [    5.502757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
> [    5.508474] CR2: 0000000000000000 CR3: 0000000002209000 CR4: 000000000=
03406e0=0A=
> [    5.515558] Call Trace:=0A=
> [    5.518026]  sd_zbc_read_zones+0x323/0x480=0A=
> [    5.522122]  sd_revalidate_disk+0x122b/0x2000=0A=
> [    5.526472]  ? __device_add_disk+0x2f7/0x4e0=0A=
> [    5.530738]  sd_probe+0x347/0x44b=0A=
> [    5.534058]  really_probe+0x2c4/0x3f0=0A=
> [    5.537720]  driver_probe_device+0xe1/0x150=0A=
> [    5.541902]  ? driver_allows_async_probing+0x50/0x50=0A=
> [    5.546852]  bus_for_each_drv+0x6a/0xa0=0A=
> [    5.550683]  __device_attach_async_helper+0x8c/0xd0=0A=
> [    5.555547]  async_run_entry_fn+0x4a/0x180=0A=
> [    5.559636]  process_one_work+0x1a5/0x3a0=0A=
> [    5.563637]  worker_thread+0x50/0x3a0=0A=
> [    5.567300]  ? process_one_work+0x3a0/0x3a0=0A=
> [    5.571480]  kthread+0x117/0x160=0A=
> [    5.574715]  ? kthread_park+0x90/0x90=0A=
> [    5.578377]  ret_from_fork+0x22/0x30=0A=
> [    5.581960] ---[ end trace 94141003236730cf ]---=0A=
> [    5.586578] sd 3:0:0:0: [sdb] Attached SCSI disk=0A=
> [    6.186783] ata5: failed to resume link (SControl 0)=0A=
> [    6.191818] ata5: SATA link down (SStatus 0 SControl 0)=0A=
> =0A=
=0A=
Can you try this:=0A=
=0A=
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
index 95018e650f2d..620539162ef1 100644=0A=
--- a/drivers/scsi/sd.c=0A=
+++ b/drivers/scsi/sd.c=0A=
@@ -2968,8 +2968,13 @@ static void sd_read_block_characteristics(struct=0A=
scsi_disk *sdkp)=0A=
        } else {=0A=
                sdkp->zoned =3D (buffer[8] >> 4) & 3;=0A=
                if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->disk=
)) {=0A=
+#ifdef CONFIG_BLK_DEV_ZONED=0A=
                        /* Host-aware */=0A=
                        q->limits.zoned =3D BLK_ZONED_HA;=0A=
+#else=0A=
+                       /* Host-aware drive is treated as a regular disk */=
=0A=
+                       q->limits.zoned =3D BLK_ZONED_NONE;=0A=
+#endif=0A=
                } else {=0A=
                        /*=0A=
                         * Treat drive-managed devices and host-aware devic=
es=0A=
@@ -3404,12 +3409,12 @@ static int sd_probe(struct device *dev)=0A=
        sdkp->first_scan =3D 1;=0A=
        sdkp->max_medium_access_timeouts =3D SD_MAX_MEDIUM_TIMEOUTS;=0A=
=0A=
+       sd_revalidate_disk(gd);=0A=
+=0A=
        error =3D sd_zbc_init_disk(sdkp);=0A=
        if (error)=0A=
                goto out_free_index;=0A=
=0A=
-       sd_revalidate_disk(gd);=0A=
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
+       if (sd_is_zoned(sdkp))=0A=
+               sdkp->capacity =3D 0;=0A=
        return 0;=0A=
 }=0A=
=0A=
That should fix the above as well as the hang on boot with CONFIG_BLK_DEV_Z=
ONED=0A=
disabled (for that one I do not totally understand what is going on...).=0A=
=0A=
We do not have any host-aware disk for testing (as far as I know, nobody is=
=0A=
selling these anymore), so our test setup is a bit lame in this area. We'll=
 rig=0A=
something up with tcmu-runner emulation to add tests for these devices to a=
void=0A=
a repeat of such problem. And we'll make sure to add a test for=0A=
host-aware+partitions, since we at least know for sure there is one user :)=
=0A=
=0A=
Johannes: The "goto out_free_index;" on sd_zbc_init_disk() failure is wrong=
 I=0A=
think: the disk is already added and a ref taken on the dev, but out_free_i=
ndex=0A=
does not seem to do cleanup for that. Need to revisit this.=0A=
=0A=
Cheers.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

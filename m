Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A22F4FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhAMQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:19:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49692 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610554774; x=1642090774;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=k+3gkpEmkYWXEMlcK9LgKlLQmCnkEFvDv3TlVX2QVmY=;
  b=c1NdLcv+1KFwl6IDeLQJbRQ+Qc7lDFvAwG3fBtuSiRgez3KpOzY5OYy/
   hdx4RQb3jKncXrLyoM/2fY0m1uNdObVKFzO8VfcmJDOpJItx0Xd46I/sm
   GFLinpoA26F8ricofDlat8FxF6m7PYoqgZexxH866ZVzTngmQiUUXXoOE
   slJ6M4icymQyjqMD+IxpSTi7Ktm7H1ZZo168FWsvkV+zSg5iX4+9xGggM
   NYt3uO29f3mpTjctMNqZE10T04Qk/oW/ThMNSHzFtUwTItIxwcjdMlhu/
   Ysu7+/OG82N4wvIu/K2uTU9V0OKNCzXGSTx3AjzXo6oGnEP7MgpbXu5xM
   w==;
IronPort-SDR: /cpoqSpCx5YQU+hlCYuGwrkq+EiqdycGSOkYiIGyL9OSeHmIgriPQVPrZyzhNxqNp0snAE5wDY
 LkQ8slqVB8yH3h/S6oMKENi4yUNq/L25Pz2U0HjmaJDxt46nWn2gC+Hoa/CbOa6liXvmOQT02r
 D4m6UP84koB9DfGQs4PFfbwewsuDh4+5QFd7R51ltak7urCaEny9ihPK8q40i9Yrhzsw8C/3IO
 OZCi7dNhrpsTaZrYButorsvQOk0ZMn8Zc6plhPRWA0fDqnb++CnzOE5+NE9PQ9ifP61yfwW/RC
 Fkk=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; 
   d="scan'208";a="161785390"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 00:18:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f22wFLqbjmo/O2SwAZkBp8C9KYKPyAEhv3Dmw4rfDTnH1AJmfmid7N7XQOSjT0U3S0lD+2RjtqiWV+dWiTkkn+0IiSyPpzGAQ3ecYQ8hejnJNCn17y0iLKZddUskJxJeZGmDj8kMstdhbFZLvhmZRNXPTXSSToKe561Ka7GU462XdrnFKVCK+9ygMsgowAV/E/Cgs9rRGP3+jC8g6KtW4tk+dSTFus2mkXD36ZR/r6dVTq6kKFMjTwrXkPDuZNVQOcct84SZ+sPcBrofd1vbpoXc9g3cUkxpdAf2qBt42kHPyzpa8sfm8uL4ehp1cvZfOjk2PXJuyKU5Kxn+kbNQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Esrvh2jZ7Pcl2YZL5+wmdUluzkTPA+R8JCSGHMRNI=;
 b=bQy1j8QfIg9lEFo96m0fHdA4N3u9hIRZR/k1T2j0n7H+IkpoNX1QmRC9gsyq+VXvbAZ4k8hhzYsRLfeeV8NIcqbQkOqfonrrRX7GAVsaBKTQwvU8Ugx7kfj9XjRBGDX2FcihKdo84CnXffoUWIVW5icfK1Pg2yqN/Y5agwkSBkP7ulwDO1D5bJkPiiachkPoELHfhEUdf0XXGa05jUCKW8q+207hC73G5c1hBghJKNh3OTGMF2yHGnNEd+LA2c3YnDGCoITmbLKpbkLqMznevyFc/od/mZrWgjwy91BX1nv/d59gU2iEoFnlp4CKEMHcCZBJbWKXxPNViKpcCTn7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Esrvh2jZ7Pcl2YZL5+wmdUluzkTPA+R8JCSGHMRNI=;
 b=bIAk5YDYIEoitjN3+AHfHrBbQdQAGm4uyk3GYfvhFzMNLrRUM5EkKD/7Zy728pFjCeAIvxgdLkmhDkU7go8y84OJ4O6GHHNNfT2QosEuHXGkvc5mT8PMzbrPcUJ4gfDTTKTCqW9sgmK6uBhrBZWM/QGX0W8xS0wjYmBS8IF6Xvg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4160.namprd04.prod.outlook.com
 (2603:10b6:805:35::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 16:18:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 16:18:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Li Feng <fengli@smartx.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
Thread-Topic: [PATCH] nvme: reject the ns when the block size is smaller than
 a sector
Thread-Index: AQHW6cYiQ8r0UOC3okaYJHPdW7DXCw==
Date:   Wed, 13 Jan 2021 16:18:26 +0000
Message-ID: <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210113160621.98615-1-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: smartx.com; dkim=none (message not signed)
 header.d=none;smartx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:c8b:c088:e383:ecf6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b11ee09-8063-4ebe-8c8b-08d8b7dedb54
x-ms-traffictypediagnostic: SN6PR04MB4160:
x-microsoft-antispam-prvs: <SN6PR04MB41603B6AA8E289EAC0CBC1F19BA90@SN6PR04MB4160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Hg0CMWZs6gC/p9+OHQM+UztcHvlJK1JIHTrO138RZ7kormg281Hh01Nl2LtS11Lw7AvrxkmqZgVzj2MSGQiHAxd4sHEeJ89QY87OouQ/OoF8QQjPHiXCU51mkSOJMpk4hxYdri6/HED5jam7iA/HQVaRhzRdAIMJP9fyDOtw2IsbtiQyrtNGZh/AQ+0grTWYTqRiNT4uR2DbnTgaVfIlt5BJihqsNlHKo9JAnxbCntSuUd2NDrXJ8cMNTd2zlbTGCFTay2JVEGmSH8MsZH6SPk0E61EEzLKfFBTaZo8KkzjwXorLWp2XqsrprM4noLpG/U5fjkO8iNA+0qh3dz7CKVsvTb7DTtHGb5D6qt6SFfLabbHtn5UlmrQQ7z3CaI/NbMIyqti0vicWpTcj2T7lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(4326008)(186003)(86362001)(71200400001)(8936002)(8676002)(9686003)(7696005)(110136005)(55016002)(2906002)(91956017)(53546011)(478600001)(5660300002)(64756008)(66476007)(76116006)(66446008)(66556008)(66946007)(83380400001)(33656002)(316002)(6506007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?R5zpLXegbSgegiFgTn8xSIcSJosTeURblg7KMihQGXU5Lw1Wry13Z6M3vRe3?=
 =?us-ascii?Q?i0xh/O5qPX1EnQEKN1GL24af3NFYfIe3tW0Inc+cZAtnYLRvQQ3iWv2Z5bdy?=
 =?us-ascii?Q?apqUaBLwemh0wfJGIQkrAYWAY1Q9KcQEm8hl0pf4qMCrlWntB2qgtwIFFs4X?=
 =?us-ascii?Q?6+Hn8eD0wcLKOygv3ZkYLp04iyRQarG7FX0oNrKJ2G9KqqySoHUOuL1sUlAt?=
 =?us-ascii?Q?b1nhcH2vfywp1TecgMafxmKLYtBTwni89BGY246IM6vk+s+MyeIaPjl0mBFb?=
 =?us-ascii?Q?5gQtuCUoPhkVcqj8zss51LUF7l0LoBxz7PmO2Vrd4Gqmo/fkJfwebYyVRDW9?=
 =?us-ascii?Q?2er3V77MqROzv97w+CFS8r1ADgk7FsncalXCm01MPtQ6fjgxUDo96XHclym4?=
 =?us-ascii?Q?+zaZGWJ8hEvoa46B6UH1ludbbCU5y9b/DzIz7Ju4HUp0aZDWTgHmoTpDfBDs?=
 =?us-ascii?Q?PO1TTBS/wJSiiYhDmcCCPHgX3wOZWhz8e9iz0re6QbQfMOjiedJ4vSgrmHR/?=
 =?us-ascii?Q?R24IAzFAJITLnbat6BZ0xtkuX3iM7qaC1lT1KdN7TGgNzHsR7tJs8aX43Fod?=
 =?us-ascii?Q?n2/m68aarz2tLvFg/5xI2aSL3bIli7KV7yyQ2yyUc512yeUor8SwjHWdD+h9?=
 =?us-ascii?Q?o7Fu2Kehr/RtAqqvNl/CioMcxutN4SqwVWE13Awx5ju8XP1JID0mfHgPYRq0?=
 =?us-ascii?Q?tL05lqDZV9Ns8ou1rrPpteXilVb7kQKjEMArNoBttdcxHxx3Dn9iMs/bg5ix?=
 =?us-ascii?Q?82FI6CXH1UBn6sHnja+FMtjBL2PKcaW4wXbTET5NcZWJOoemF8Oo42MS5vhr?=
 =?us-ascii?Q?PRApqoYmbaMu/Q3K0LX+cE8NEoYRGUnuDdfW9DYmQjk8w4BFRGslMF236dD8?=
 =?us-ascii?Q?GYn9R6hJWAGTu3dJGErp8jq5HiwTcj57+UmISBF9X2o2BWA4tKv/i/chNlfp?=
 =?us-ascii?Q?rqZEzwamweQYPBKn13xuLhLskV6tDoocC5a3vwTdVCEm4Gd/ztVrsHaJZOZt?=
 =?us-ascii?Q?z6O0fIX9voEQelKRBuR3pzmkeOi7Of4b18rF8InKk1+739bJjhxdTqM/VAE5?=
 =?us-ascii?Q?BT13uHeu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b11ee09-8063-4ebe-8c8b-08d8b7dedb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 16:18:26.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teadxG2QjroiHl9WQq6Mo3r8R6jk9O6Jo/GX192p1+kbfK7xzKOI9TLiHygmU62ju7wYj3mXPwCfeLInZbDucDR+0LR7NBOQe7zyhzDA1DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2021 17:07, Li Feng wrote:=0A=
> The nvme spec(1.4a, figure 248) says:=0A=
> "A value smaller than 9 (i.e., 512 bytes) is not supported."=0A=
> =0A=
> Signed-off-by: Li Feng <fengli@smartx.com>=0A=
> ---=0A=
>  drivers/nvme/host/core.c | 6 ++++++=0A=
>  1 file changed, 6 insertions(+)=0A=
> =0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index f320273fc672..1f02e6e49a05 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -2161,6 +2161,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns,=
 struct nvme_id_ns *id)=0A=
>  =0A=
>  	blk_mq_freeze_queue(ns->disk->queue);=0A=
>  	ns->lba_shift =3D id->lbaf[lbaf].ds;=0A=
> +	if (ns->lba_shift < 9) {=0A=
> +		pr_warn("%s: bad lba_shift(%d)\n", ns->disk->disk_name, ns->lba_shift)=
;=0A=
> +		ret =3D -1;=0A=
> +		goto out_unfreeze;=0A=
> +	}=0A=
> +=0A=
>  	nvme_set_queue_limits(ns->ctrl, ns->queue);=0A=
>  =0A=
>  	if (ns->head->ids.csi =3D=3D NVME_CSI_ZNS) {=0A=
> =0A=
=0A=
=0A=
But this only catches a physical block size < 512 for NVMe, not any other b=
lock device.=0A=
=0A=
Please fix it for the general case in blk_queue_physical_block_size().=0A=
=0A=
Thanks,=0A=
	Johannes=0A=

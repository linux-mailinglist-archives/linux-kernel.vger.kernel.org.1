Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4442675E0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgIKW15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:27:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39994 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgIKW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599863228; x=1631399228;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3TMzYydpa3NeX3bV2ElfXSee8xTDnLfEn215xEtYRok=;
  b=kd6wfStsQGDIFGG2Bs5G9BRx8FxZoGIARAfGyBIcoXTZmD/hMwHwDx/y
   OzkYkAHgG0mtwuFmPKh1qAH7gw/zEzVd+cFd8uXqCNd7Y6grKbWjoXW0g
   zj+l6KNWd24ULB2+QCxtXXlb5Hcf4nxn51JaLh5FA3KeFJ8II3zLpvYvr
   zIz1ayGruMjm+9DfeIuxvi1VO2g7WL/1Bdt4pyajNEirpgpHpJXDJHgkb
   LyGrBVLieBdjwwdTSaSxEqh4TluOUcwa1vejv6w5FYIT6Dj0M2dH7eKz/
   DlSDcYAvOhf843HNWz1WeHYaNrdj6tpn3Nf3jPrfu4oKZdeHaOk8uksdV
   w==;
IronPort-SDR: kJOEVshVTmQr8qydGoAVdEaS2vDpz4ui4vka6rRfc/3t6qo2rF72O1wXxDOatknrGikuT69X15
 vYTdYqqqmvqFPlDdMnUoz1gxw1V0DScSlA4CzUC7//e969kks7OEbWtpYb+uZ46BVtnYfj6BX1
 oKttlDfZMW7pEq/ySkrUFfPuk0S+/aLbuq8XkKkYYVQGni2KZY19LjFO+JOPDgyhX20d1/LLSQ
 fzy3XOVoLw14t8e/yQ+vyDZakwGQme36ZulRJPH7TsyW+k9NprAQhrtZeQB6oCN8m/P6Qk1lnq
 i+g=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="250478288"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 06:27:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZJ7sPFOCqb5PYFlVSJ21z8n0lhle6luaznWUnx599M0YyQ91fF3/KCxquZ8XngRLFV0IP5XleACo5dE67BhiY+GcS7IZu2IsoiM1CutKcuAdoDj2ZAeK3ZapAltfc8NpwNvpBWsypFPCKXLHXYXPbzZseRRbohAoPxChASKbLyBTjNYR6+cj6gCVPaJI8jlIVXjJPyapaL+S6/+0Ekxx5WxSrDlEb7XBwPu80hfU7nYugcVKt8BQdPSqw5H5kEIi9XD/0YxmsGy4Jt9vlnf6ZOHz+RK6v5OfrDjON9gyGnFIm8J/JVACwYm6UjWOW8ct9nDhlsUgsHjjdoLVlB3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsU3TcIjjYUtWH/SUxF7LL4SoMxarmJ2qnC0C5XGcoM=;
 b=eQVegAZ6/b+7/v7FLQpSig5KoaHTb7Zfs3ypscWEzNYa1l8JH+hhA/+S0ZjE7BgaRBODKPKWDe9jmMzrSMS0ByYHIpFFrQB8zGCuwlHocnXe2hK2gCDGYpFVqtyZKSru0KLyHPdGicNN+DvabBgfoRji7I+4M8m2CZmdS4KfBNFaUwPfI/svZ7CmBUlQPvlv1XyU/lHwX4myehzJS9C4AkRTOkSiY0Ig63U/Vfoxn/vUSYZP/IlbF/MJ43ggrJDCDWsQf7Uwnns79RuQug/sCZFCp8NoFagFuMob20tlgx+BRudym8bmHA2cziPoblCKOfBw/fWDSobwj/wIy0Vo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsU3TcIjjYUtWH/SUxF7LL4SoMxarmJ2qnC0C5XGcoM=;
 b=raecDm5nJOJKtjnzgZ8aDDcFNIiPX8ukrEafMhCwXf1cyVMKzt7VM8X/3MtzvIMzG7H/vfqiER9jgVoZ64wXwlE1F8RbUiIm+JTmaaIdvfk5z+k5TPs7xtc9K1MaJIvn9S9jM7+zuTZvSqyoTnD5kzHGX6zd0/V6QuEHPI5obLY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4461.namprd04.prod.outlook.com
 (2603:10b6:805:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 22:26:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 22:26:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWiHU5D1XE6L8r8ki3RtN8f0xMug==
Date:   Fri, 11 Sep 2020 22:26:58 +0000
Message-ID: <SN4PR0401MB3598C3B9A281C3748D24954C9B240@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic>
 <d7549a8f-ec57-7cee-577e-902f70c8bd42@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:4db3:21d3:689d:c45f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3c36848-f5a1-45f9-1a63-08d856a1cbf3
x-ms-traffictypediagnostic: SN6PR04MB4461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB446185F1A5CE5D2C89017F439B240@SN6PR04MB4461.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XN98lmIRQw1j5ZL97Ip0YkvB9yeezZsyXV3OlTQe1+u5wd2gBkeadQLPQRAGqsOq4C9n0SGPdnJTeAJ7nDSCt1vmeiC2dW0boUjbWii362x+K7Z2IHDNlgi9eEhwMHIYQLCUCLV9A5fvJ7JANMjpxiXtuSUNw86ITkfPMfe5MqtO2nhvRuxUapw0ghXNdxj7E6mITKYmTo38LJUlb1yceBeqyU0MVxlfDy22+LOTM1UrQlYoIG1RKfSI++cwBuKKHuVBfTpW+u1/FOEUAp377z76LM1YhwcKD3HpXBsUFW9j+V8PpO7A9KVm/3zhP4yAsgAt/4kPFBZrrHv8a+q++g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(33656002)(52536014)(5660300002)(53546011)(83380400001)(186003)(4326008)(316002)(8676002)(8936002)(64756008)(66446008)(66946007)(55016002)(66476007)(66556008)(91956017)(478600001)(76116006)(6636002)(110136005)(86362001)(71200400001)(9686003)(7696005)(54906003)(2906002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: DTftBoCST8sEke/LDt122spN92elQETbwNig6ljwchb3r1hshmLrLbjtCrKvtpiGg8JblURE/NFNwPgPftDxDkZHtLHBuruBUv1t9nva3/3oUDXDGWhrgRuAaTQN62qFjEc2sotLmi5Pqyz5T3EwYTOH3LT+0pxfZoQ+yTkHeCQtqNQJl03mzFXee+RuDeRtDSrGg0UhAzam4JGcOX5hH1mY/l4tkbKVBnTgpedM1o6um4SkiVlXGFmdtEMCbXKOohIb0eCRIyFW6GhfBnRdD2DdENeYbNqJop41GqcPFApcMhHNfWoG+bVFO4hpG7R5pClXFFqw09dxbrUJ3wTRMyR6bLP8aJgcOvR88O2RiDmWj/zbC3UKnN3thdM3myAROOpL+V1LDz3O0LDmTD3SLUev5P+7BgDSgwXqi41WphSKl6QDjgpT3vpbN9YFGDqpx9PdvPE1LNwHzgGHt+aDDpQZcLJKsYKGxhD4c+0hWLYsoov7Zr7xg+j79nHvInJRKUjeOMoisb3UozSpa4jpkdG9Uqyc6EKIu05556YU1cODn/IBffs6kUQKoeTFQLH8oCDWc+XKd/6/i1qhe07VWf266nfxT1PQKJJAWDQXJLEt3cj0O0rkqjeD9taRNHxPx2EeDiBr1EoIbP5WXat/59Ln8Xk9IPq2lakGrTQpNnY5g4oKO0cCw5dvehPRbWFNhIx679iMMXrSGHuywIkMVA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c36848-f5a1-45f9-1a63-08d856a1cbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 22:26:58.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YfaeRcCqjNErHgdDykdYjx2uqVE4pbvsL0ktP5Cvrf35uS2kHaI5BtvNMz8MCk9yOnnwP8+g1SkOsIQy6esp03sOTqjxpsi+2jRBNF5gp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2020 00:22, Randy Dunlap wrote:=0A=
> On 9/11/20 3:17 PM, Borislav Petkov wrote:=0A=
>> On Fri, Sep 11, 2020 at 09:53:12PM +0200, Borislav Petkov wrote:=0A=
>>> Now, looking at that patch:=0A=
>>>=0A=
>>>   5795eb443060 ("scsi: sd_zbc: emulate ZONE_APPEND commands")=0A=
>>>=0A=
>>> yeah, that doesn't revert cleanly. But it talks about zoned-something=
=0A=
>>> devices and that rings a bell because you guys broke my zoned device=0A=
>>> once already:=0A=
>>=0A=
>> Ok, so Johannes and I poked a bit on IRC and here it is:=0A=
>>=0A=
>> # CONFIG_BLK_DEV_ZONED is not set.=0A=
>>=0A=
>> Enabling it, fixes the issue.=0A=
>>=0A=
> =0A=
> Uh, you are not saying that enabling that CONFIG_ is the final fix, are y=
ou?=0A=
> =0A=
> If so, do I need to enable it, even if I don't have a zoned block device?=
=0A=
>=0A=
=0A=
No he does have a zoned block device and no this is not the final fix, I =
=0A=
think one of the stubbed out functions is broken, but it's midnight here=0A=
so we're calling it a day and chime back in on Monday.=0A=
=0A=
And this setup is a bit special, as Boris is using partitions on a host-awa=
re=0A=
zoned block device which is somewhat exotic (see add_partition()).=0A=
=0A=
Byte,=0A=
	Johannes=0A=
=0A=

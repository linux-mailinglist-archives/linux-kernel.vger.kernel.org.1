Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D8A267A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgILMTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:19:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50244 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgILMS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599913137; x=1631449137;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gFMTaNsUSLgaFd4DApTzkLcwNb6JLRf1G4SQtlwcoog=;
  b=QFBZ+lpQlhxNMvKFnZy1TAiA7up7+Jn8f2puCOybRBNANw/MOCykP7qc
   Y8NOURVY5cwWmkfc2/2lxIK/dHhVmYtFX1cTie+7r5v0OhQNQ0EmSK5DM
   iusKanr5o9uYliOfrX0uiLyVXUZhpmnO3yUlgLoqJLPMSxtdX03HPAYMP
   7jiSz28HMAzarXgC+o46u1l9oqtpPajKMj3SJoba5j1+fqTTFAg44TMwH
   kGCYXg4ynaEA+Z4jT4/evhALEQHTYM0NYo6x5Zis0WWL3szKceiwMGHv2
   kCF4/7QoggjZFRnsDgZQNB1AQLuiF4f8zDkz57+pVS6SoJHljGAnJtYlv
   A==;
IronPort-SDR: fpNLmmI/faqU7UnmTCxmjNZ4Q3FDmluqnoMpwiqWZOdFdKfmEqK+JTSDs8Ej8Y6RFswBOQiBxH
 akxPmS3qTlJxm0ffAOwTJIwu3DWOHyHdTWWaarTviQxC+p9Uc5bSdGWYbAuCdGN64U2YrNb0Dq
 g3RAmjdclkOEN43EtD0E510mwBmsZVM1dmuipEQo/LT5D+xoltTpRh8TmLOSG8DDrWZCzxd8d+
 phRnqX7uKRyM8MGp7rPM64QxO+OyUmJ3NRnXW6I1po3M1wJJgPbzkuPUwNwmXmPjk4ChXeRD3c
 VaE=
X-IronPort-AV: E=Sophos;i="5.76,420,1592841600"; 
   d="scan'208";a="147197325"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 20:18:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzP6vNRA98U3IZ+H/eIIUAfgvZc6cq48lAoHqsrXBkDhfi6nSmnUmD8JGiwSxRvn1nzBcJaMmDXmUs1tpUWqqpk7gEQOds5N4SCQd7J4/3X0Pk74ZdQapekTZWLzMLf/v5sdPmzZ7ycp+CQfo+4KzkfUoNOlBW6LNnTdVmtPKJpUyo4zA2QvFomX8Bn+WdqFIgR7Lf8Zy7A8IywoNc5CNXee54N0LeM6G8tKSnSK6mZfrYwN4X0PWq8+JmE23uRCWBJ6ZWml3r2294t9QsGLoTB492izUhRDFu4f1C/vP1zqhpS96twGkw1AZnEXylNDbWgUJN+mggC/h5oDe4oDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFMTaNsUSLgaFd4DApTzkLcwNb6JLRf1G4SQtlwcoog=;
 b=ZsLyNGBfOldfWkGsE7mWNhRNd4qudyT+QsUkH8fH/3cnycS+OPdrNh/RCMli8mIK0BNwNCyeNDFO9m5cP3Mgdvdrh+ZwXuKANJNMXom81+BfGAgEzhwFVoPvtIjt39vvtn403mgTai0jXOTRGwCJzVAEpvlUQkurkGa+U5S0ClHNeA8gK70Bwi9D4E/OPNV2mV5Z0bBHu5wLlZPKWHy7xbXp1alAOor4ki9IvpCm+KZjUZ5x61QpbySyQl9WW1TKXH0lWcU0J2akMqkcZW85j6yfXJk7C1RyFUm7uv8xcGX9S6+T8nJYdKPGzMP97PjNuRUk1W+NRvukZ0oIfV1ltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFMTaNsUSLgaFd4DApTzkLcwNb6JLRf1G4SQtlwcoog=;
 b=ItEQZbwLQXwNAUL/WsOehlbHOs8lwQZn14YPLxoudMnzjB2MZ/U+0W1QN3zoZskFmMzqh8iweZngi1CsllD/UL8n6zjHFkP05vuvLMncv/ZydR0XMKKmsm7NKRBXlz5ZlkbrNk3Z2ShENPqmfMmxyQ7B8obkfESdQyZNvZDRX/g=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0422.namprd04.prod.outlook.com (2603:10b6:903:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Sat, 12 Sep
 2020 12:18:52 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.017; Sat, 12 Sep 2020
 12:18:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWiHU54Zgl03vp4EGth2S6djlYmA==
Date:   Sat, 12 Sep 2020 12:18:52 +0000
Message-ID: <CY4PR04MB3751C8FA76C49708370E928DE7250@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic> <20200911230703.GA2971@nazgul.tnic>
 <CY4PR04MB3751630AAB4A625BD64C66C3E7250@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200912083739.GA4827@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:593c:8256:27ca:4ca5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af86a684-1530-449e-b3d6-08d85716032f
x-ms-traffictypediagnostic: CY4PR04MB0422:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB042201F244C032DF6624130FE7250@CY4PR04MB0422.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ja8N+Ve+HYRaaBSEjUJf73zuNCgXgOGJmqizu29+v2gVRC6u/Il2GYV2cLyzha0mfZnjiJHXiqboiZZ2252l25mgnUKNdGK9AD+0pLO5wXfCAJycu06y0c2VorlUjqsbPHxVG6ox0KVmUtaE6jPYspWHPXXgxeUtEOXA8C53GsXkSM/p1Lqwyw9VY49q3Gs1LVvmerXChsqzcDvOfA50JSr2XDxBmfaVd9VtMi+LlFYyZD8b252Y0TFyAkdrNE7QBYSVPba7Ao+WA7AjsDOTGZZFjvTOMgQp0tCXREaR1O+io4IBCG+7vSvXbl/dp8v655EATBiDcgfS479000mHNDgwH0odOmFWu+f+QCq5uJ2TNEa92eP8pvfOTW4kbfWPhMRV05GwSw+kxudnFB1RRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(55016002)(6506007)(966005)(9686003)(53546011)(86362001)(316002)(7696005)(52536014)(478600001)(4326008)(45080400002)(6916009)(5660300002)(83380400001)(71200400001)(64756008)(66946007)(186003)(66446008)(66556008)(54906003)(33656002)(8936002)(66476007)(76116006)(8676002)(91956017)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mGq9bo/S+wzFSl3wTC9kLvTYaTOjmIihdM7vWXzjslsANgBYCSpXPF2JlzJiNd3ZkMA2/jd5YZNuLj4HuOrA+ODVuumtZYUQBavJpL04pPC9pSA5ibZ9utlLEwAo/wiKgsntDQLzdNTigFY/7NzM6a01Vv+Lam2YjmDNaampddQKr5NKYjVv/mXTZZ8bAfFZ0w2+jM4FF0KC+nbNPvQXz69R+q1zXoK8CToMiEpIdwfPQ6wMMrORcpwwRT3EalplhACck2PHh7v2dnqb/+ZxD6tPNEB+8nw+HrKyVKPtweB8bHougW6vaNxQqCB7F+DT+2Gd9zD4w1QfVhbtF4FfJ1TYp8VClWHd/qh3fn1zpW2edjerE/vEIyqUXKnV6qKnciuigk1/XRzCDJOB0+2p4+8qZdHMQcfHkjpqLQSbbR+J3W8/WcAS/JDWDUDS/CQxaNn3+nhjA+4mFiKVhYKbcImlyyqt5kacG90JX3n7HLdyrYW5bn9uOTJ1vkKzzQ3J7nvufoCIk+ggej+fk0dBsnX1HN7FVj2s9Jy1G5OtVwFqUByeKKO++XdgYj5l4/D+WmzSUIVZHMuNGfguJwMMJ3MurPypgUKs3zJTDsSrsKpVzU34mvnmccZ94Z5FZirkBSya9tl6EfobFymXUnigEVGtWid9h9yFRDiMNksaU36SKY+QFRSo/Ap/58wKycbLTmsHOWw1FIbuj/7+IxDCYQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af86a684-1530-449e-b3d6-08d85716032f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2020 12:18:52.5830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9a1RaN7t6JRdd+iMXWVMETfA6b7ul7ukGUrRj2SZDuC0xeF9eSxqwznird0uKW8tAhA4Rc5feFhrq4sNr+spRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/12 17:37, Borislav Petkov wrote:=0A=
> Hi Damien,=0A=
> =0A=
> On Sat, Sep 12, 2020 at 02:31:55AM +0000, Damien Le Moal wrote:=0A=
>> Can you try this:=0A=
> =0A=
> sure, but it is white-space damaged:=0A=
> =0A=
> checking file drivers/scsi/sd.c=0A=
> patch: **** malformed patch at line 86: scsi_disk *sdkp)=0A=
> =0A=
> Welcome to the world of outlook and how sending patches with it never=0A=
> works. You guys might need linux.wdc.com now :-)))=0A=
=0A=
Working on it :)=0A=
But it was Thunderbird, getting real plain text emails with outlook is=0A=
impossible. Corruption I think came from the copy-paste from the Mac bash=
=0A=
terminal... Tabs get replaced by spacers.=0A=
=0A=
>> That should fix the above as well as the hang on boot with CONFIG_BLK_DE=
V_ZONED=0A=
>> disabled (for that one I do not totally understand what is going on...).=
=0A=
>>=0A=
>> We do not have any host-aware disk for testing (as far as I know, nobody=
 is=0A=
>> selling these anymore),=0A=
> =0A=
> Yeah, so Johannes said. I love it how a (relatively) brand new=0A=
> technology gets immediately deprecated :-\=0A=
=0A=
Host-managed is still a thing, getting bigger. But host-aware never really=
=0A=
gained a lot of traction due to, I think, the potentially very weird perfor=
mance=0A=
profile they can get into (Hmmm... similar to recent drive-managed noise...=
)=0A=
=0A=
>> so our test setup is a bit lame in this area. We'll rig something up=0A=
>> with tcmu-runner emulation to add tests for these devices to avoid=0A=
>> a repeat of such problem. And we'll make sure to add a test for=0A=
>> host-aware+partitions, since we at least know for sure there is one=0A=
>> user :)=0A=
> =0A=
> Bah, I use it as a big data dump so if you say, I should make use of it=
=0A=
> as a proper zoned device (I've skimmed through http://zonedstorage.io/ a=
=0A=
> bit last night), I can try to find some time...=0A=
=0A=
No worries, we will fix the mess (sorry we hit you again !).=0A=
Also, Naohiro just posted btrfs zone support v7 !! Luckily, we can get that=
 into=0A=
5.11.=0A=
=0A=
The patch was space corrupted, but could you still try it ? Did it solve yo=
ur=0A=
problem ? I can recend it (minus space corruption) if needed.=0A=
=0A=
Cheers.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

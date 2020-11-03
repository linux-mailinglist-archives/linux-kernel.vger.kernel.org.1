Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20212A580C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbgKCVrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:47:42 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:48266 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731899AbgKCVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:47:40 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3LiJh4000580;
        Tue, 3 Nov 2020 21:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=9rEJiaTtnEHDUEpKQjli6wW2rbpxAYsowPK3HdFLwZQ=;
 b=fSEJVBSNVsUG540rWVD2FoxEcJJIAdjrjefvuzAGac5/SY2M9PgVm0t/nDboIfTLDrKo
 oX1KrE2DmMhsrgB9Z+7tSiydwr8eaEUfOZAlPNI7rEfLUp1TfPHKPTG1lfJAqt2TG/eo
 sATFyAArS/YJtmYUrPw31GSW35oFtBW+xoHC22zmgbIU3S63uO9/9AKBIDgsaDuWrKtR
 C4hq2cQivgrpwRvZN1BE+oIUq95b8NAnNI1ef+EU7vsPYtG912rLQRKnDGcjxTywpKau
 5UwQ3FiElwT6IhXBZwECamqgX7725CXIym0yxJX/rn+Wh6vh9AUa8J8P9imH4ZJ7apVY 0A== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 34kdb1guu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 21:47:29 +0000
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 3C74B65;
        Tue,  3 Nov 2020 21:47:28 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 3 Nov 2020 21:47:27 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 3 Nov 2020 21:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6x5jkZa/Wm61459CmRvS2DjQJaFMrlaREm7H75svilnJqG7sB08ycshVJW26UIaCiqsp/kBH0UN6r2NfbptbbrkP4rOErw9reLPnKO8O253Kw18i3V9/0RWWL1R1Hez6ef7nMn3fq4heEkJq5UYYiht9jbSUrfoiOZFQSXOC5Xw7kHOrwTTVmgmLanwzUccr7IuPM6k6hYZVrRu3MYpH3ZxbJRtfpRo8aQphFm6iKJCLqsnD5HoLgLRA49vNPho/vVj1+oIyhCVNWIQVkWN/a6EhqJ6bdLUZlvotyF94429oim5YUx4J8482IeiN8ehgp88PflV5tk2Gf3SWWGNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rEJiaTtnEHDUEpKQjli6wW2rbpxAYsowPK3HdFLwZQ=;
 b=VJiY1uuTEaC0XDhluMTPueG2WgaS682pi8FR6E+5QpbWfmNAsIo06zNWw+M0219PPk1Lu6slObM7TXL1G981KIhb0FEVc25H1G8dwtbrrN+Vd1mtiHrZscZad1/isZ/Lg1WMW2r7PHxJLjUqp0diD6J69dPi8oKdbVf4mot9iuBnmfpwIpVQ+846EFN7AQ3AVJCm62WrnvTHbhkms2ioxymTfG1k9wFhvgv45oOPDyR15HucpM8QCtjvAezJz5Q1L7HLxWtSZVJjSPfzd8Dmr0084loJyiwUTeZz58DzUSipnqVfF/Ts24T+4Yu+f2LB6dmC5zugVPJxDSaXHqlvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760e::14) by DF4PR8401MB1323.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 21:47:26 +0000
Received: from DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1c5f:7a1e:9244:f08]) by DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1c5f:7a1e:9244:f08%9]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 21:47:26 +0000
From:   "Meyer, Kyle" <kyle.meyer@hpe.com>
To:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake
 Server
Thread-Topic: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake
 Server
Thread-Index: AQHWlYE8WxPO4bs5eE+etvuI0+CzGKmPXWOigAZUf4CAIXi53Q==
Date:   Tue, 3 Nov 2020 21:47:26 +0000
Message-ID: <DF4PR8401MB10356D373986227465D6CC749B110@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200928102133.61041-1-alexander.antonov@linux.intel.com>
 <DF4PR8401MB1035CE7DBCCD58B531748BC69B080@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>,<da9bc69d-07b3-8817-bb7a-22a927b826e7@linux.intel.com>
In-Reply-To: <da9bc69d-07b3-8817-bb7a-22a927b826e7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [24.183.125.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20351021-bbe1-40d4-dbaa-08d880420e52
x-ms-traffictypediagnostic: DF4PR8401MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DF4PR8401MB1323E9D1DBA51A601037E2A69B110@DF4PR8401MB1323.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLp2YNlDoxAr4EtRmxvZ6++slHwJLQYtIyLSVs1ePru0Z8zhDvFB7+4rBG8NkGqxRrMhcAiCJ7KQJNlPhCWiMm86UL6xB9sF5hofdEm/VmUkdG701FwlNusoeyKahDAZJIeG3Fsf9emGuPKInABQbqWtL+x499F4npK433AEJ9XWhhdRVJWUL9Jeq5YvTd0n8lIQN6Inc3T1IQKp9SA8Tz14+m1A2OfwNECekQEXzzOJkxODqeZqJM+6Pd8lQLWcFSe4mzgOS5QSq2WTo3V9c1yzt0pVKZA+v5PrcvnsrC5xIVYJhLixWDamYeKYDauk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39860400002)(52536014)(76116006)(478600001)(66946007)(86362001)(53546011)(9686003)(66446008)(33656002)(66476007)(66556008)(55016002)(2906002)(64756008)(4326008)(5660300002)(7416002)(6506007)(7696005)(83380400001)(26005)(316002)(8936002)(8676002)(186003)(110136005)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i/Gf9Jr4MrSUUVwv0HqjDRjSoXoBSBsdA4OYgvMfq0R2j+x+rr0e6m1IuBPdcZ+tMwnvMsHRuUZ5acPBqIJM6+91vrROtsunBTSqjbgaH9tN842kTyDavUTT3iDV+ufiKXLPGDiy9nr3R7BkqkDXz9fZh7iBlxNpi9lwbbiQphbiluwjgY/UQSfJ6cS/y+kNp2GMY6P2dQfeS4oygot5W0Io2sJbnL3v1T9xNsa9vH+f1w/qfGlstKuSszMLiPPUCqkOWyznS6ikZ/7D5TyLpp1c3SaH978loExY375nfkKwVi2NBeYQ60+SSVBSk55NYjdnXB99GReVBT2leGPlrfIwq8SZ97xoBGhNVYwi08FMke6CptVCUD1xwu+BgRG3QkY/EpzKKOwLwWfeMqJlBAE+qHo/G22V7+oxEE0E2WHQhd0OqGM5ZGUh61yTgWD2QYwD+T5HTahh4z+reMQlNXQmvs8XxWIb+UYGB1NjVttyDgkkBi9iRbNNF7BejMm3tuj3zvempveIZhKBlSdU0mDzd++39VUSgATgBgkremVpWnwWZZgMY1M2l1pSZ4QW4FSVG3r1Sq5w6SuD3Lqv1/baFO/xHruFl+gmRQzDLZ2gT41r/u8vVj5sJeUfV1akFfatlPx48ngiSzeoYF+M2g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20351021-bbe1-40d4-dbaa-08d880420e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 21:47:26.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6s5ceRQfHDBCh3uautFhxx4Ts7Dl31n5wd56dG71tUwv2efHHeTCFChJBg8oCYhZnIYB2pOO8TU2ho0iyEvTCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1323
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_14:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 clxscore=1011 mlxlogscore=999 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander,=0A=
=0A=
PCI Uncore mapping details including domains:=0A=
=0A=
On HUB'd based systems each Socket is on it's own Segment, and we use=0A=
MMFCG space (0x80000000-0x8FFFFFFF) for segment zero. All the other=0A=
segments we use the UV-HUBs ConfigPassthru space (a 64bit config space).=0A=
For a 2 chassis, 8 socket system it looks like this: (On a 32 socket=0A=
system everything quadruples.)=0A=
=0A=
$ dmsg | grep MMCONFIG=0A=
[=A0=A0=A0 5.128486] PCI: MMCONFIG for domain 0000 [bus 00-fe] at [mem 0x80=
000000-0x8fefffff] (base 0x80000000)=0A=
[=A0=A0=A0 5.132003] PCI: MMCONFIG for domain 0001 [bus 00-fe] at [mem 0xff=
f00000000-0xfff0fefffff] (base 0xfff00000000)=0A=
[=A0=A0=A0 5.136003] PCI: MMCONFIG for domain 0002 [bus 00-fe] at [mem 0xff=
f30000000-0xfff3fefffff] (base 0xfff30000000)=0A=
[=A0=A0=A0 5.140002] PCI: MMCONFIG for domain 0003 [bus 00-fe] at [mem 0xff=
f20000000-0xfff2fefffff] (base 0xfff20000000)=0A=
[=A0=A0=A0 5.144003] PCI: MMCONFIG for domain 0004 [bus 00-fe] at [mem 0xff=
f50000000-0xfff5fefffff] (base 0xfff50000000)=0A=
[=A0=A0=A0 5.148003] PCI: MMCONFIG for domain 0005 [bus 00-fe] at [mem 0xff=
f40000000-0xfff4fefffff] (base 0xfff40000000)=0A=
[=A0=A0=A0 5.152003] PCI: MMCONFIG for domain 0006 [bus 00-fe] at [mem 0xff=
f70000000-0xfff7fefffff] (base 0xfff70000000)=0A=
[=A0=A0=A0 5.156003] PCI: MMCONFIG for domain 0007 [bus 00-fe] at [mem 0xff=
f60000000-0xfff6fefffff] (base 0xfff60000000)=0A=
[=A0=A0=A0 5.160207] PCI: MMCONFIG at [mem 0x80000000-0x8fefffff] reserved =
in E820=0A=
[=A0=A0=A0 5.164000] PCI: MMCONFIG at [mem 0xfff00000000-0xfff0fefffff] res=
erved in E820=0A=
[=A0=A0=A0 5.172003] PCI: MMCONFIG at [mem 0xfff30000000-0xfff3fefffff] res=
erved in E820=0A=
[=A0=A0=A0 5.184001] PCI: MMCONFIG at [mem 0xfff20000000-0xfff2fefffff] res=
erved in E820=0A=
[=A0=A0=A0 5.192001] PCI: MMCONFIG at [mem 0xfff50000000-0xfff5fefffff] res=
erved in E820=0A=
[=A0=A0=A0 5.200001] PCI: MMCONFIG at [mem 0xfff40000000-0xfff4fefffff] res=
erved in E820=0A=
[=A0=A0=A0 5.208001] PCI: MMCONFIG at [mem 0xfff70000000-0xfff7fefffff] res=
erved in E820=0A=
[=A0=A0=A0 5.216002] PCI: MMCONFIG at [mem 0xfff60000000-0xfff6fefffff] res=
erved in E820=0A=
=0A=
On hubless systems like cooperhawk we put multiple sockets under a segment=
=0A=
(all sockets in a given chassis reside on the same segment). This also=0A=
assigns up to 4 sockets per segment depending on how many sockets are=0A=
enabled and use a larger MMCFG space (0x80000000-0x9FFFFFFF) thus=0A=
=0A=
# dmesg | grep MMCONFIG=0A=
[=A0=A0=A0 5.760989] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80=
000000-0x8fffffff] (base 0x80000000)=0A=
[=A0=A0=A0 5.763803] PCI: MMCONFIG for domain 0001 [bus 00-ff] at [mem 0x90=
000000-0x9fffffff] (base 0x90000000)=0A=
[=A0=A0=A0 5.767807] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved =
in E820=0A=
[=A0=A0=A0 5.771805] PCI: MMCONFIG at [mem 0x90000000-0x9fffffff] reserved =
in E820=0A=
=0A=
Notes:=0A=
=0A=
This last approach is how it is done on a Intel whitebox too. But that=0A=
doesn't scale to the number of sockets we support on a HUB'd based system=
=0A=
so we use a different approach.=0A=
=0A=
For Intel to make this flexible, they need to get the PCIe topology=0A=
from the ACPI tables. (MCFG/DSDT/SSDT has all the info they need).=0A=
Intel does support segments in their default BIOSes starting with=0A=
CooperLake so they should also support segments in their OS drivers/tools.=
=0A=
=0A=
Thanks,=0A=
Kyle Meyer=0A=
=0A=
________________________________________=0A=
From: Alexander Antonov <alexander.antonov@linux.intel.com>=0A=
Sent: Tuesday, October 13, 2020 9:37 AM=0A=
To: Meyer, Kyle; peterz@infradead.org; linux-kernel@vger.kernel.org; x86@ke=
rnel.org=0A=
Cc: alexander.shishkin@linux.intel.com; kan.liang@linux.intel.com; alexey.b=
udankov@linux.intel.com; ak@linux.intel.com; acme@kernel.org; mingo@redhat.=
com; Anderson, Russ=0A=
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake =
Server=0A=
=0A=
Hello Kyle,=0A=
=0A=
Currently we do not have plans on supporting the Uncore units to IIO PMON=
=0A=
mapping on multiple segment platforms due to a variety of such platforms.=
=0A=
It would be great if you describe your case, I mean how you configure=0A=
segments=0A=
on your platform. It will help to cover your configuration and determine a=
=0A=
common approach for the mapping algorithm.=0A=
=0A=
Thanks,=0A=
Alexander=0A=
=0A=
On 10/09/2020 05:11 PM, Meyer, Kyle wrote:=0A=
> Hello Alexander,=0A=
>=0A=
> Do you plan on supporting multiple segment platforms?=0A=
>=0A=
> Thanks,=0A=
> Kyle Meyer=0A=
>=0A=
> ________________________________________=0A=
> From: alexander.antonov@linux.intel.com <alexander.antonov@linux.intel.co=
m>=0A=
> Sent: Monday, September 28, 2020 5:21 AM=0A=
> To: peterz@infradead.org; linux-kernel@vger.kernel.org; x86@kernel.org=0A=
> Cc: alexander.shishkin@linux.intel.com; kan.liang@linux.intel.com; alexey=
.budankov@linux.intel.com; ak@linux.intel.com; acme@kernel.org; mingo@redha=
t.com; alexander.antonov@linux.intel.com; Meyer, Kyle; Anderson, Russ=0A=
> Subject: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake Se=
rver=0A=
>=0A=
> From: Alexander Antonov <alexander.antonov@linux.intel.com>=0A=
>=0A=
> Introduced early attributes /sys/devices/uncore_iio_<pmu_idx>/die* are=0A=
> initialized by skx_iio_set_mapping(), however, for example, for multiple=
=0A=
> segment platforms skx_iio_get_topology() returns -EPERM before a list of=
=0A=
> attributes in skx_iio_mapping_group will have been initialized.=0A=
> As a result the list is being NULL. Thus the warning=0A=
> "sysfs: (bin_)attrs not set by subsystem for group: uncore_iio_*/" appear=
s=0A=
> and uncore_iio pmus are not available in sysfs. Clear IIO attr_update=0A=
> to properly handle the cases when topology information cannot be=0A=
> retrieved.=0A=
>=0A=
> Fixes: bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to IIO=
 PMON mapping")=0A=
> Reported-by: Kyle Meyer <kyle.meyer@hpe.com>=0A=
> Suggested-by: Kan Liang <kan.liang@linux.intel.com>=0A=
> Reviewed-by: Alexei Budankov <alexey.budankov@linux.intel.com>=0A=
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>=0A=
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>=0A=
> ---=0A=
>   arch/x86/events/intel/uncore_snbep.c | 7 +++++--=0A=
>   1 file changed, 5 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c=0A=
> index 62e88ad919ff..ccfa1d6b6aa0 100644=0A=
> --- a/arch/x86/events/intel/uncore_snbep.c=0A=
> +++ b/arch/x86/events/intel/uncore_snbep.c=0A=
> @@ -3749,7 +3749,9 @@ static int skx_iio_set_mapping(struct intel_uncore_=
type *type)=0A=
>=0A=
>          ret =3D skx_iio_get_topology(type);=0A=
>          if (ret)=0A=
> -               return ret;=0A=
> +               goto clear_attr_update;=0A=
> +=0A=
> +       ret =3D -ENOMEM;=0A=
>=0A=
>          /* One more for NULL. */=0A=
>          attrs =3D kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_K=
ERNEL);=0A=
> @@ -3781,8 +3783,9 @@ static int skx_iio_set_mapping(struct intel_uncore_=
type *type)=0A=
>          kfree(eas);=0A=
>          kfree(attrs);=0A=
>          kfree(type->topology);=0A=
> +clear_attr_update:=0A=
>          type->attr_update =3D NULL;=0A=
> -       return -ENOMEM;=0A=
> +       return ret;=0A=
>   }=0A=
>=0A=
>   static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)=0A=
>=0A=
> base-commit: a1b8638ba1320e6684aa98233c15255eb803fac7=0A=
> --=0A=
> 2.19.1=0A=
>=0A=
=0A=

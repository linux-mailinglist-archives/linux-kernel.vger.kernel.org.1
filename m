Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4425D27F3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgI3VCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:02:52 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:38360 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgI3VCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:02:51 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UL26Kb018839;
        Wed, 30 Sep 2020 17:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=fdx8C0g4YJhJ+Kh0jI3yEj+rF/5N61Is+haWyG4KC9Q=;
 b=SvGVCm3lLce2WMzrhMubNxkfNR6kVwyEre0ppYlwFxGLDT0vIEgoe9OCHagOe1klX7RN
 hO0o7jGP/1K/iVOYGPLdULRJzRqn4kgrR4D0CFJnJcg0nd5xtpvdIl75kgomO1lpnDz1
 yPN8SlxPxKSq2OfESgHt36ENC/CcfOrJ4NBBI1EDF/IvgnvG8o0k2wSzuDzz7Giq01X8
 v7C98iqa6F9wHplyez5jCEk97rUrYMgpWwuYUWhtntaYGEm3AIdhxL9busUSi4raDcki
 KRz0I7FRBulMX5eLHuJlBU/kAPU2fveVnx89DAQ6zT2Rb8WI4pfcQig4RcK9kd1yFxa0 aQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33t2ap786g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 17:02:41 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UL1CUM038378;
        Wed, 30 Sep 2020 17:02:40 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00154901.pphosted.com with ESMTP id 33vu746emd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 17:02:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EupnHuCVNR+csb3nh/zqNeocUmOK0zeamO5ya00sEjOnWm+vmDXpVEVieaMgIPFRCyvpksgzWot1AWB1FDyymIV3K4JceGGIUGNNJcaqo4KODm7WxrXAJi5r4aAh/KrVwOuzu8/kLNAPqsQ+Zda8B0JDVAQbUFSj3KPgOvJo2q93TYu1ICPRxs8awpDkg04rWkNMnqqk553cEE7ifYgkHXpl2YIhIF1TrQ/KLWsV5hP7mT2gOQ9/+yBdulvXqBUtOTyJDoTE3x5P5axk9L7kO9FQpCitrk2LD2CKAsoJf4CbA1q03P7WP1tdxJhYSMxkVkO2DIdXgnOBhCmaGa6ZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdx8C0g4YJhJ+Kh0jI3yEj+rF/5N61Is+haWyG4KC9Q=;
 b=Sg/DVkY9SjemMINH0hIDf5Mp/bb9fNH6WmNb0mV+ByMZ3cwKMh+e6YzmHES1mm0aFBeMJ/LG+bvzrzDHVtU/5a6Rdze1V+PxHOFMhPl/RcEknrsl5pDJ7SRtP1jxA95ZPsApU8DEF1+P7AH405n74wFA2s7f/fP65ygMixznFimfjmer7mSz7MkVB34hjfCckQR5WC98QLM48r4xfgy2I3+BSP3ml6pn64xYrJ6ke6DEs1huCQn5HVisTYEw6KY493mdfFOTKNjoP0Knq/2Kvn9svvLGyW5WmJ7kSno2TnKs9Qd/8oQbd1VDtjzD/Evs75z6kTpVFdVAUt4aXrXBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdx8C0g4YJhJ+Kh0jI3yEj+rF/5N61Is+haWyG4KC9Q=;
 b=MwVdOKYaJTbzCw2AuTZU6OIILnwUykMeB1MwukYxdJBoJ1+LxBm2d8YzedsL6OnS7L2d8vjSLHrg261Fe5kD8AA9Fiq1by/29ePa5rCOpn90IeZuIacvsoyGe4v15ICpQEgwvMWwGv9B5h0MH+JqDFRvTRoMm+rWMmvYZRTKKVU=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR1901MB2182.namprd19.prod.outlook.com (2603:10b6:4:a1::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 21:02:39 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 21:02:39 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        Divya Bharathi <divya27392@gmail.com>
CC:     "dvhart@infradead.org" <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Topic: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Index: AQHWlgw7aMsAV+e0GEu/dASzG9J9LamAU7KAgAFJLIA=
Date:   Wed, 30 Sep 2020 21:02:38 +0000
Message-ID: <DM6PR19MB2636FB3D94EBA95B7CE0DE54FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <20200930002319.GI19084@mtg-dev.jf.intel.com>
In-Reply-To: <20200930002319.GI19084@mtg-dev.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-30T21:02:30.6173758Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=1443f5ad-a40b-4209-98b5-c61b71632fe0;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 582f7106-6463-4adf-fb82-08d865842a2c
x-ms-traffictypediagnostic: DM5PR1901MB2182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1901MB21821AF6135DCA0A4B986E32FA330@DM5PR1901MB2182.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfD0/k2Bi+nqvobqq8z5zkupuXEmcgC2AN8B2mMKs4rrWWJY86zSpcDiSUAOzUysx0jjiFG20r6gv9K6I0gk/83ImeUzNGY5jNjF4tTPVX4uW9uTZ3uoqdULkfXIuHOtV6OFfPsyl2C4Qk2zLRzZQzGN5RGq63nAdmFp0ug4LdzXK7ZsdbO60Qqipc7z9+d8xnp742neaImqmR6yAz/QVNEqEsSfZi42RmdP3aUFBKejnxC7RYV7JUmPpDRWa9wP4YDF40JkkD36zPQ7Q/BdENWErx8a/qL1uWvACY4fqvpIrCotK8rEixDlwKgowr6V4TL0vTwwQNHpa2pb0v9Wjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(9686003)(186003)(2906002)(76116006)(5660300002)(55016002)(26005)(110136005)(86362001)(7696005)(33656002)(52536014)(54906003)(83380400001)(71200400001)(6506007)(8936002)(66946007)(66446008)(4326008)(316002)(66476007)(8676002)(64756008)(786003)(66556008)(107886003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tiL/6FJsRDRUPR2ndKvN6D7T0ueH+Ny4JNZzNnYB8bGUa248mjqVRkZdagUgnjz1UztaSLfNIMXmzi9IMcGBA2biGaT+kCF9+opGxuk7Qu+vDu/NfCnd4MXk9c6waEi5Y7J1juyqTjfeXGgxjCSm9fzmMP5xM7yXCtjaRgtVIV4ssBG4j4VAwyLF/n/sspxtDXc17klFOpteePhB/vBqGDW/7ku8QFDD0H7cEO6HFLzrqoV6vRC3CLSBq1YSKgC7SAJbH7mbctv9UeFXp7zlQZsUFFix//+5NoRFyT7dEkbHOClCNszQMK2hJyS1xh6kku52lz7X0VIH5lVuFql8Ix03w0fWXoulDEGWoIwWR0ws6ZLtlp6xH3WLRL7digrck+H726CYfQ8okxFVDSRdB1o4LuatpPOE+P9BHnhBYEYVcCiaGR8UZhIKpTkRrUDlYnE2vzY8hRSsl98rnNUZPUQFBpEg8/aD0s1udxBvJVH7jRonMMvohocfRgZmhrfTW6uSg9cTxbFcoqx6Zci/0QHkdCtWGjJm5ntMWpuUjDrccKqZhN2CYyXdkKTKQvh48N/rOP8Ld/rvSRCz6R1vPlmzYe87K7GpsvUoGDc7rhRIF8Uvpst45PUwyGY6zZlTA/dg/k8Zwe4RxP1e15ZBjQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582f7106-6463-4adf-fb82-08d865842a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 21:02:38.9115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLOd7eN9zNG/OO4tfHTdew+B/vuEyTOzXCuu90i6GSRQ5vHjjUL5Igqk049x6G6SN+ByYNvCx6r9zwUR0SAfwOhLhRDlzK6I5zDNf+wFeGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2182
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_13:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300170
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +		possible_values:	A file that can be read to obtain the possible
> > +					values of the <attr>. Values are separated using
> > +					semi-colon (``;``).
> why not use set notation from math classes assuming intergers?  i.e.
> (a, b)  all integers beween a and b but not including a or b (open set)
> or
> [a, b] all integerger betwen a and b including and b?  (closed set)
>=20
> Anyway its ambiguous if the the extremes are included in the set of possi=
ble
> values as written.
>=20

Enumeration attributes mean that there are fixed values, specifically not i=
ntegers.
Integers are in the "integer" type and explained below.

An example value that would be seen here is possible_values:

Enabled;Disabled;

> > +
> > +	security_area_size =3D calculate_security_buffer();
> > +	buffer_size =3D security_area_size + integer_area_size;
> > +	buffer =3D kzalloc(buffer_size, GFP_KERNEL);
> > +	if (!buffer)
> > +		return -ENOMEM;
> if you hit this error return I think you will leak the wmi_priv.mutex loc=
k.
> I think this is a bug.

Yes, thanks this is a great finding.
Team will fix in v6 after we have Hans' feedback for v5.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ECA2A5B97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgKDBLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:11:53 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:1752 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729144AbgKDBLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:11:49 -0500
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A416qCv004421;
        Tue, 3 Nov 2020 20:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=FdWPKPs7jTL5MX+NXOp7Lac1QCmh20EkO5eAQtQATS4=;
 b=XHdUUt9Hj6jGY8hvLai4U67iUU0DDvQ5yWCeRUlwehV9f65jvzRHW5A76Eyr+LulE5Ah
 FncQxFfxgQPSVlKfCg08bBOgFOkU5r05/MFgk3u3axnPORJuxb+TI8S1a+fdYWDSajUR
 nrQkEz6VPlWV+SLmYo7spIXOWTPWSLYC3TDG064ZGyhYA4JnmOIH21Z4Qsj1gnrFUBMo
 EjNQ0kvfwRzdAPn5hMC+c7Npt+t1KC+hWz90uFO2BvTQ1jyWnbtCpY+C1q3ASjlvcxnI
 a5dYpJppcdjRUJVonF9F/fKCbo+fHkMnFcpvU1MQy7wpUiu+GVzCKa32Kc3+G72v6mnp Ng== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 34h302vyvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 20:11:43 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A41BeRE093142;
        Tue, 3 Nov 2020 20:11:43 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by mx0a-00154901.pphosted.com with ESMTP id 34k9jaymby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 20:11:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3UsoNKumpU6Tjk6Pjo9BJ5YC/cJQmP43m8S58XnGeVnowBsG7DQ4XfAs36DXtYs75NaB/ZeQ/KaZzpF5Az2JnPH32uhEmcTwHK6vBxeAHPDFhyGhVPwdJFg1GAqe7TEc2Y/9ZvqqoPzTRwhqzNz2OHNW0kPlsu84aAA9VKeGOLXXB4wiC5s/mceMwPzRSF9DIhyQPMk0YKPphJtDVwdZ8fagGcjV2NClUrF3HoEjm3PP7T4ULeylcdeMPBF3TAlk42xRcVAiEpGJj77w2jQUPWfjhs1OHX2DupyXsV0RzBMmtuc+cXvltCcYXd9XrOGvR7gey5GJGC/ZISnXXMqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdWPKPs7jTL5MX+NXOp7Lac1QCmh20EkO5eAQtQATS4=;
 b=D/FdzNOGGPp/Gkb7e/Z0S3acSNa9jDtrrfIzbf412tdJMC6EmgYfCb1tGrSIdwMD5zuO5J3QgxiBjmNfLvp++ojuqkSVr5X2nzNzkHCgLBBKiE+QulTra2putLRvnVXJm7zgFIK2OzweaWBblr3qY2x+flU3QfBhcW8NrRCdgOB5+9Txl2RAYn6a7d7ZbAyixWe0RySo+dwfYhn0vHd/3Wels2EkrwOdz2uLUztL9DvRzZSYbi58zqSjMT9MFu6TRO7XPa+RihQ9T8TQDJfKU7Q/edEb0JjxLta9x3ghHo/XK1SUTP4Zji1Rs1Yt/x0fbAeP6gy+vW7Kdewz6UtOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdWPKPs7jTL5MX+NXOp7Lac1QCmh20EkO5eAQtQATS4=;
 b=DVkqWLXIoTiNLBB9WiJE9eDcO9jPsR9phV0ZkQDr6a7hEWuCvvcZVBInxyMNoYx8ma0i2AY178djNfgHaZs4wbE/YL7vcW2Ztvdf1rEdfDPeDU9PJD6tpVL7sR7PoaezNCbxrj6+1/baopI7qOdrm0nknh10fALnFWYzMLbp1z8=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB1161.namprd19.prod.outlook.com (2603:10b6:3:bd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.28; Wed, 4 Nov 2020 01:09:57 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 01:09:57 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Christian Kujau <lists@nerdbynature.de>,
        Andy Lutomirski <luto@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: acpi PNP0C14:02: duplicate WMI GUID
 05901221-D566-11D1-B2F0-00A0C9062910
Thread-Topic: acpi PNP0C14:02: duplicate WMI GUID
 05901221-D566-11D1-B2F0-00A0C9062910
Thread-Index: AQHWsjrgmruNKS9zREG2cNpTPr/AS6m3KP7A
Date:   Wed, 4 Nov 2020 01:09:57 +0000
Message-ID: <DM6PR19MB263616900AA4EFA2EAD22AB6FAEF0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <88716562-a1c3-c8e2-655c-e41cff5f8aec@trent.utfs.org>
In-Reply-To: <88716562-a1c3-c8e2-655c-e41cff5f8aec@trent.utfs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-04T01:09:55.8993380Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=acc00204-1441-455a-91e8-d920ad4f178e;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: nerdbynature.de; dkim=none (message not signed)
 header.d=none;nerdbynature.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d6bff60-ab89-4392-6063-08d8805e58b9
x-ms-traffictypediagnostic: DM5PR19MB1161:
x-microsoft-antispam-prvs: <DM5PR19MB1161EBB691AE50F6E3AC2441FAEF0@DM5PR19MB1161.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OeAk/dqcmPvG6rkil8r/khH6nxoXA3hVuBSOad5e4BoPfaV0ZkUvPGRPh2KYcf1VEzfRH8fy8SUdXXuXKrHDJw1bExtucdRZOkAvE2u49WShsdoO2+jn9j2a1VT7vEmQa8lhEOjLPxmPBPUlX856X7H08DpkDltacNfkVsDIMPg9KATCfsjPxF3H3WL6lzZ1A3DYdkCLmtSI0TiKCPxUGQkTb12paHuKWhuSwD8TOahaa2fyHeuafSZdStYva0YysTv7RzxNoKWKjH77tpmmdPMWCzHMg/eUGMVZADPQCnQFqlB90xoEoui5QF05qbSEG3mFAmHjv5Yho+IQ55gky7aOFCOIqzl+7Luv7yWPTagjStCdlKprLK6ogXfEbAafXTgix13GYBTWFUx1QmK0cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(8936002)(498600001)(26005)(8676002)(4326008)(186003)(966005)(86362001)(71200400001)(9686003)(76116006)(66476007)(7696005)(33656002)(83380400001)(2906002)(5660300002)(66446008)(66556008)(64756008)(53546011)(6506007)(66946007)(55016002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lgeFQ+Y+cqMdgi3O7GVJkb0ljJ2AQt0wMFqam6r7gVFAw97XLOGydj4FXN0x8tff6O2Ut6NiIYJf84wBfNoZZ0gdn/5W9GKdUqc9h9wG29gUnNonOTa4Kew9rP8Wrdz6BGsKt3HVFgyyX7BrIqQ8JD04uebzDRx5LRlXLOzkC5y3jGj0h+B/kOkVJGTSH6CnL8DULbaGGUQn31fTl6xLWFWS4wDQ3ZXm8H4uFMjd441IaKeG6ZypXpW88SuudlHghh5W61pWRc8v0OnuBhLo7oyqKFNuV2CmSHuyQveEVhvTlhNw1RxqOVhDcMnq+o5WTLBHmBMlPSMNHgh3QR/yeV3Aff/oPORPMNV/lvhl78ZGf9olPq2VkLXke0yD0CevNQPoIvSb/XM6xiqzFHjtsyVU4GaG7GxNqgPYYWtUeRjpRRHG+F2ycYWF788bQvyURL5c5KcoHTQhO0eEvU9Xo2wP9LEFrWXE7pECv3Mm9rO+39Yex+CaYB9cY7EtbUZ0AslyTk3AHsQYWUAXHUBMBcRk9iuuoLolGjKRltCMQWH7NMjL5ChhfGiDC+t6AwU6m7ZCLCKTFLMsddDs7OeQsLGcoMtwUynBCzsq964EYlGgoP2KtOhDZWDmQCvN6y38hsS37RyP62mWCQHEL/rmdA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6bff60-ab89-4392-6063-08d8805e58b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 01:09:57.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCzIjkW1shZimNQmh6wLyr/MHoTKgsGpIf4HxEgeyP6kdkM6a9DUurJhAuUtqX/9S24e9KFsFFCkAay652lMQ06Wl/s8beX+nWIpkA0UC7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_17:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=987 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1011 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040005
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Christian Kujau <lists@nerdbynature.de>
> Sent: Tuesday, November 3, 2020 17:41
> To: Limonciello, Mario; Andy Lutomirski; platform-driver-x86@vger.kernel.=
org
> Cc: linux-kernel@vger.kernel.org
> Subject: acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-
> 00A0C9062910
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Hi,
>=20
> while looking through boot messages I came across the following on a
> Lenovo T470 laptop with Linux 5.8:
>=20
>   acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C906291=
0
> (first instance was on PNP0C14:01)
>   acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C906291=
0
> (first instance was on PNP0C14:01)
>=20
> Searching the interwebs brought me to an old patch proposal:
>=20
>  > https://lkml.org/lkml/2017/12/8/914
>  > Fri, 8 Dec 2017 20:34:21 -0600
>  > [PATCH 2/2] platform/x86: wmi: Allow creating WMI devices with the sam=
e
> GUID
>=20
> The patch was proposed, but never made it into mainline. It's not really =
a
> big deal, booting continues and all devices appear to work, only these tw=
o
> messages get logged during boot. I'm just wondering if this needs to be
> fixed or if it's really just a cosmetic issue.
>=20
> Full dmesg: https://pastebin.ubuntu.com/p/2pPv3hywPF/
>=20

The message is correct.  An assumption has been made that two devices can't
provide the same GUID in the kernel early on, but this is an incorrect assu=
mption.

We haven't had a situation that we actually need to bind to devices that bo=
th provide
the same GUID so this has never been a priority to solve.

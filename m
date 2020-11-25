Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50FB2C38F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKYGI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:08:27 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1378 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgKYGI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:08:26 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AP67OMI029647;
        Tue, 24 Nov 2020 22:07:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=U4GySC93lhxPCnNNtzco4p4sc3FeaH8H7ZotwpUGm9M=;
 b=LEw5Ur/ofvLRXsLOi5+hWZDqXBsIMHiPhVcwaZt3JGKaVleLxDZoaPNUSDui65XbqKQe
 NDfzA9o9Q/y+2xsLTmiwucHg8ZgjcNZhL9CL3QK3TtSr59PjpmZsjsF2BAii27J8wkGS
 +d5hv9NSP4pwQeSzaDQcLh13z4LsSE33yEwLfkR7MWcjVviG8pd7MaYNwExDp/e6Du1S
 kxh4/wNd9U0R1Qn7AsN34FN0bSRPye9QtJKQPJeLwuqvkg2/L0XmbKYq8ho+9MIQO77Z
 mI/k4ClrNfXkQMRybDeAvW0tUpUD6SNHrtCcXFxajQzmh/YcjXd3xKc53vQWmH2MUvow jg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34y0b06axa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 22:07:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdwmZ0B0KuyaJ1QdtzGFkv31DwqUWjIgZ+GIWTAvolq3B7XlYX+3xM1zSzh9T++MZq/pZUpdAvkYiLXxCgFsCm0rSwchDEjDbZTr+DHOPmZy5z78Z8i10EYTyP0vLj5M0h/+EwtgGCARDfLKpfDZ35+vNDG+2IMk4qG2CRJ6qfv2LUoUuHV3cx5TzqMAxq90PW7NQgtRW6REmNAHbU50itMutiBvC/ZswgQNkO/RgQQM8QTgKYMvMqfnkoxOb8evabD/8pQwOQhMopvFWIGdd4AfBjpp3JU3lm+fHAO1Tm/wMzA6+r49S3K48BxDsUNhI6/Vq/caBchKIubRA25asw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4GySC93lhxPCnNNtzco4p4sc3FeaH8H7ZotwpUGm9M=;
 b=NzM8DXU2pxOhpV0ajbkbcj9hlzTsWdhSkWFnm52j5wXgPw17Vkr9hiMcrnw2SBYW9iaHxn+Kxfu6u3AtWyhL86X7iEB6tSbYIeK+BIo/WztN60c8BW5oxhWOYIrB4fb1ky7oZ8Pn7/pUw1sTIBV1pTTJwc3K5cykYQPeKFbXBgXbNacWFjBq56+6I2EhM0QB2klXXBZRtYOh4AfZ53zutNffIYqsTlhNLsHUSvEhhoJ5D0aUNk69AfynsYubtFVM9ZBw6nNM8ynNeR3PH+3m5Z6Aay+ZvJ8atp/DUxz5CceDJulipcsmFwU4wehFxqMN+jVdYXooChJjY0tjyHiTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4GySC93lhxPCnNNtzco4p4sc3FeaH8H7ZotwpUGm9M=;
 b=GtRRZvQkmsH7skGj85KYzOYzDP+o0yPjwYXSFQtQVUr7KhJ8wuuubt98jAoK+twF1Kue5maGsgmdUBNw+QYHuPY75d9zWAYOxaqVi1z1E/OnYkyEGQ4/DOIEu1SsBnbdBOcAl634AXBGvqi1Q8xr9v5+opjVmTgX7/POHGnqFuk=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB6220.namprd07.prod.outlook.com (2603:10b6:5:155::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20; Wed, 25 Nov 2020 06:07:45 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1%3]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 06:07:45 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWvn5OSwS8ExQKVEepEyu7IWVrI6nW8BSAgAAYUOCAAVuGsA==
Date:   Wed, 25 Nov 2020 06:07:45 +0000
Message-ID: <DM6PR07MB55294D86FE79E85F41838918DDFA0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201119141307.8342-1-pawell@cadence.com>
 <20201124075023.GC32310@b29397-desktop>
 <DM6PR07MB55299F262CEA81216999CB05DDFB0@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB55299F262CEA81216999CB05DDFB0@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODZmYjJkYjYtMmVlNC0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDg2ZmIyZGI3LTJlZTQtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMzMwNCIgdD0iMTMyNTA3NTgwNjI3NTUzNTUxIiBoPSJIbGFUbmJxQk1ITTRnenhJRGNENDhjTDVFdHc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29ae5e37-5c14-4b41-8150-08d891086d9a
x-ms-traffictypediagnostic: DM6PR07MB6220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB62200DC9C9D010B81284144FDDFA0@DM6PR07MB6220.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7e/F2tpw6V/mtm9/lR6pHXhZf+AyBchyTzcfLHGzhttwkLxzUObVaoLubSm0+uuOTit5Aqmd94kjFLmz1WkZ020F23AfuJghIWErZNx1I4XtA7GH5HmWmlhCkCc6o2JvWKfqu3yX5YY3MHd2av5O68a9SRcGEopiwNPewKMXjpcfxVNOAjlaNqms+ezKmboJuBCJoa/3BTKTuVUCqzstupojpdNtBdf/kiNDL9wH9wGZodvhHft4VFNW/+DeTP0/ro8Gx//uRQ2J2dJzK1DDOjWXLmQT1rWXPKh+Q6GaqELNP4h6IngNPMCsEXt0oTYidGpNBb5jc2bEo3yqobTuOpIMVy63isreYdD8RNKa8A8eAmi1dDRBz2iIingv4HKF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(36092001)(54906003)(55016002)(66556008)(8936002)(64756008)(6916009)(8676002)(66476007)(5660300002)(66946007)(2906002)(316002)(66446008)(4326008)(478600001)(76116006)(71200400001)(52536014)(86362001)(186003)(26005)(6506007)(7696005)(83380400001)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IxrOcOTa5NLb2K3Y5SLeZYFsero7SAqmlAunUYcnRjbnif3Nx2jj80M0R6Vp?=
 =?us-ascii?Q?/xomDvWiNwRme6+Z6l4vkFuTjIOPP5H3fuRxvjsi1+xVGjaUncVFi7BpLm95?=
 =?us-ascii?Q?AozmeeLu7/c/8FHF/dgNyAgE9fhZe8iSFatF5hiEz2Osk3D9nDX0OuyUaH25?=
 =?us-ascii?Q?p28ZDAxi5lqW/vsfsi5azieqcnLxR9GBugPvVb+nHqLrhULunA3Ks8e2cdZE?=
 =?us-ascii?Q?oHgpXYwatdN/SpIPzuay164IfFjgOasCVTNgcmJDFiHWxT6VBB+fbHcppvl0?=
 =?us-ascii?Q?UHq0baI77OyaYmud1LfIoLGbPP0s15oeLzz/MdZoB5am/mfIMfu9MgNuY6Vj?=
 =?us-ascii?Q?1cFjklJbnaUIg53aoCY71jnfI4qBHzW4W8KB6SviTfym0KQLtGJqNVXxrXA+?=
 =?us-ascii?Q?ugGFdyDe9NvIJg0RTACwjhriJ6wYEd4NqtX6hq1pMvzKKF5BQARklhkEhUyS?=
 =?us-ascii?Q?m+t/qCUVxfL+idWCEMSlRe5kf2DFWEbi+q/58GDdjcBeLV6UEbBL6nnXkNib?=
 =?us-ascii?Q?Xqb39i14o/ufSffGGdVLyZeVWlIb38rbdttOLn3qfBV4LWnmYhXouqqoA2qs?=
 =?us-ascii?Q?8PBz90+irLLdro5AIHrysHh2vDszljoKqN0dR0dl5NOHXfl1LnykXvD3XnqS?=
 =?us-ascii?Q?ofRnqR14sMnSydFMO7WiMgifXhOKaejbkbJLMmse2fPOz7TVCJD0E7MPEWSM?=
 =?us-ascii?Q?OpVCUzXc42II/EdJb8JZn7NheFuwF0932q1/eiwfGhwqTLgGCtcmipjlKScI?=
 =?us-ascii?Q?KxVVFv8qzo+oz1jOfB3BCtycGJGMpQeoKmAO8yHSXcskXM4hosIECGNaIfIm?=
 =?us-ascii?Q?pG/wQpRos2EtIoSOmqwTMr+dgt9Ef89+UOK6pBpU5DCE14tOXx4devmN6BXl?=
 =?us-ascii?Q?E1hB5ylShPqETfvImG/8/MGvpGN7rrzIKUW512ICMx1Q2N9i86x0lVDT7HNo?=
 =?us-ascii?Q?V51IhmWeXC1N64LT1Swbu3gyoDy/A8q/fH0kA0Ud/2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ae5e37-5c14-4b41-8150-08d891086d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:07:45.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mgr7xa6xhxLawVanjhBOxSmWfVyX0c7g1iUxm2OdeTENM1+X911bhpvFc4VjcmJ7DTc5HtHMmOhFMSpb/gjj1fdwrT0RNNSY3Oi2NHyWoE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6220
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_02:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011250037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

>
>>On 20-11-19 15:12:57, Pawel Laszczak wrote:
>>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>>
>>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>>> Host Only (XHCI)configurations.
>>>
>>> The current driver has been validated with FPGA burned. We have support
>>> for PCIe bus, which is used on FPGA prototyping.
>>>
>>> The host side of USBSS-DRD controller is compliance with XHCI
>>> specification, so it works with standard XHCI Linux driver.
>>>
>>> The device side of USBSS DRD controller is compliant with XHCI.
>>> The architecture for device side is almost the same as for host side,
>>> and most of the XHCI specification can be used to understand how
>>> this controller operates.
>>>
>>> This controller and driver support Full Speed, Hight Speed, Supper Spee=
d
>>> and Supper Speed Plus USB protocol.
>>>
>>> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
>>> The last letter of this acronym means PLUS. The formal name of controll=
er
>>> is USBSSP but it's to generic so I've decided to use CDNSP.
>>>
>>> The patch 1: adds support for DRD CDNSP.
>>> The patch 2: separates common code that can be reusable by cdnsp driver=
.
>>> The patch 3: moves reusable code to separate module.
>>> The patch 4: changes prefixes in reusable code from cdns3 to common cdn=
s.
>>> The patch 5: adopts gadget_dev pointer in cdns structure to make possib=
le
>>>              use it in both drivers.
>>> The patches 6-8: add the main part of driver and has been intentionally
>>>              split into 3 part. In my opinion such division should not
>>>              affect understanding and reviewing the driver, and cause t=
hat
>>>              main patch (7/8) is little smaller. Patch 6 introduces mai=
n
>>>              header file for driver, 7 is the main part that implements=
 all
>>>              functionality of driver and 8 introduces tracepoints.
>>> The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
>>> the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.
>>>
>>> Changlog from v2:
>>> - removed not used pdev parameter from cdnsp_read/wite_64 functions
>>> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
>>> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
>>> - replaced 'true' with '1' in bits description in cdnsp-gadget.h file
>>> - fixed some typos
>>> - some other less important changes suggested by Peter Chen
>>
>>Hi Pawel,
>>
>>I have updated my -next tree as the latest usb-next tree which v5.10-rc4
>>is included, would you please rebase my tree and send again, I could appl=
y your
>>patches and test, if test could pass, I will apply it to my -next tree.
>>You don't need to rebase again since it is a huge patch set, will take so=
me
>>efforts for rebase.
>>
>
>I'll try to post it tomorrow.

Can I send the new version CDNSP or I should wait for completion
'Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch class"' =
and=20
applying the appropriate fix to your repo ?

<snip>

Thanks
Pawel

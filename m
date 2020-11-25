Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928752C3831
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 05:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKYEmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 23:42:37 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21434 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725817AbgKYEmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 23:42:36 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AP4Tb8b013142;
        Tue, 24 Nov 2020 20:42:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=GWpAz1pdsUfuFgTwCa3nOFr0xcn7x6mdK/cV7M61o8A=;
 b=Gu2CjMDoQgOpEvpNE4tl+aU4ghNIg5NODYNBHgM4CNuA3eItap3uECmHPy7oUtgHm6eD
 8jxleIjr6sjC4zRWwhCXKqyvc9lNdxX+HFzGbDFPoaFx9fheYG9KVmtYNhjZ8qfZGqE6
 02VhXd5xgmsANHwI8pf94+0rMJUyox8DJv2RvTYgpNa+rI/prLAYlroxxRgXHEgwbdl9
 2HRlDozaWiOmVyJuRns1Hd0R3XYnWH8H6Q7qTi6mSAdi5NKpRyeJUUsJkSfEVS0le3Cj
 OoiHby004Ltsj9+jdUP0PpMVG8EgcQtqnkrYT36PX+LdBtedjwh3rpZI4VL7TsVJXG7l VA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34y0bvegqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 20:42:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRJ2sQ8UOj24GfH1zA75CRZafafSlKo+k3L8fAQTCcXHCfuDhuvv2MDeMvUaVUhGYqq/K0XgQBZMFgN+zke28dmnGosBs+XX8Aj4lNGLIrR1Inw8RkpBtktlKYzsj/CWLHgd+0E00NjBZvEqk4Yl5CnqnWfXFaOPUmmgipBnHLR3lpK6UaB2C2TVJVnaSWz7naix37PbHpQVxtgpoF05Phu3uBSMHccRciAw2jGOEkqr7n1tGO1IZ22bNRjf19ioX580anWVxwzpFP0icGlyAA9qs8eqxPm6HmOIIMiY963x6W9JzuysgAZx6zgp7e7WQZHB7d73QKMwGcG2vAWKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWpAz1pdsUfuFgTwCa3nOFr0xcn7x6mdK/cV7M61o8A=;
 b=CwEpGGK8bIZdBrpcLq+SvO2Y5NKuejd2W9xyqy3w+upEl9+juAnoknqs8BjzcGPhya2v1fFNj5HGiStgYq1brASSZHD3sOxt3Tt0zEt3xzZrvBZGpfCD4Egdp5ZJoyr5bBwTtRhctFAH0d3Jz6PKkBySSg45Vobc0WBf2PqhXx1CDosHn9mtFHU0I6aNweo+DJjyc6P/w70cFCE+vTpreBL2mRZZmKYaEP2MtH6tsZcac9eKv0ycbNwZcda9bnHI+bNM+GOQVACBHEkg8Lcj2sq3C0d3f0OAWjbPOzknL3B8v2jvg/2t5vVdz8GuhnhsDf39UkMVBUuqNaH+f5AMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWpAz1pdsUfuFgTwCa3nOFr0xcn7x6mdK/cV7M61o8A=;
 b=wu5GPWWx2eGpfPKaslZjGZT9zHRVbHltvTzlimX76i0zlOSAhrFtRkYIuD2RbBBym9oeBmAnOnqFukbPKBTU1Y3tWMv1POKHhtRI42BArjGycXCEvAYOoLxvXVIxPFVsHqgmgs4rOJglH9Z8Jsi8RgA4/C8Gy/1f+8tuJTkWmys=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM5PR07MB3017.namprd07.prod.outlook.com (2603:10b6:3:df::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Wed, 25 Nov 2020 04:41:58 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1%3]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 04:41:58 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v3 10/10] MAINTAINERS: add Cadence USBSSP DRD IP driver
 entry
Thread-Topic: [PATCH v3 10/10] MAINTAINERS: add Cadence USBSSP DRD IP driver
 entry
Thread-Index: AQHWvn5VThDxVdNZYkqk3u4Wq9ZpyKnYEn8AgAA6gXA=
Date:   Wed, 25 Nov 2020 04:41:58 +0000
Message-ID: <DM6PR07MB55297B6A1A2DE7D29AE80A6DDDFA0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201119141307.8342-1-pawell@cadence.com>
 <20201119141307.8342-11-pawell@cadence.com>
 <20201125010951.GC9929@b29397-desktop>
In-Reply-To: <20201125010951.GC9929@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOGFiMjJkODYtMmVkOC0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDhhYjIyZDg4LTJlZDgtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTA2OSIgdD0iMTMyNTA3NTI5MTQ5ODI3ODgyIiBoPSJKRnNoRHoyQzlSSXBaK1VNVHRwZks4YkliMjg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fdbf032-aa5c-45d5-d680-08d890fc7179
x-ms-traffictypediagnostic: DM5PR07MB3017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB3017FD4AC60F77EF1F736F63DDFA0@DM5PR07MB3017.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OVCk7joCdzloh2f6C3ELkh25REOmvRfMWC7p15QWoWfMhRSOHm6BSFljo1lSIt1ecD6YQEFFabJGKEI6QIJsHbCRKFwXL9q7DosPK1ISvwx+gWcNzCMJv/SvJ6GWmxOLYzK9VakZfGBKHAXYKSf1NWYFzP9+p1RlOojnKvq1V+Bqwx0sLJ3qbCa0UNsLhgo0tZQDKVqKiLHU3l1GEqXo/tbAqVMSCUCHEobsh4hf7or4d/H50Yi//gme41yI4bZCWUBmZAApsmVK5dMlaw/l+DMVmrmaCVO94VpXrVT66OAWnJX2yNRqLXFGTOyJI/WKTDgRWuHKNV35/xegmR5C9+zN1z2DBYSR3xsFHn4/jtBmVaezdTtmgygY/0dzy4qo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(36092001)(186003)(66556008)(64756008)(66946007)(8676002)(71200400001)(54906003)(76116006)(9686003)(66476007)(26005)(66446008)(4744005)(55016002)(316002)(52536014)(6506007)(2906002)(7696005)(478600001)(5660300002)(8936002)(6916009)(86362001)(33656002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5Mm+nuuW/AJhtI8hIp8nfFI7C3GYI5PSttfQeieWQXHNHEyrYp4dxQhSTkUA?=
 =?us-ascii?Q?V1gVtwnzhaaAFncZsN+UomvHe/Ev6pmVso3EmsMZZju/VNq1hsU63G1pHIOQ?=
 =?us-ascii?Q?XcMHsu0hVHh3yZzJiD+VOiIWEeANLngZvjUkVXsHNHRNGwQ/HlUGhTDfVdow?=
 =?us-ascii?Q?rPHKJOMOrzLBmKMqS7AzI5L3V7fLVFXXsQdZPR8mEJIcwgA63AqNokhTEtoO?=
 =?us-ascii?Q?iMU7+0Imyr5jInSO350KED02tvQ61eGRvmF0tuvb3HR+h9IlVrDzRIejVUk9?=
 =?us-ascii?Q?TEqsZ9oP+5E4uekMmXV7+veRAAq6yV+XnFqxtjUDx6IGuBBjiJzFwHA2msvt?=
 =?us-ascii?Q?QsFZcX4kBAZEJb00HO1HPdzM4AOnVRbqyw9wRLTaGRszj2zm2JUJXwxSLypF?=
 =?us-ascii?Q?dNcE06BiSNFbS+BqXE/SDHDK/q0qMOcwerkaK3lgDwURZKdQlna07ncXtUX0?=
 =?us-ascii?Q?3hdstmEdZq4zVo2YnNgG6tD17Q3zX9rzkjhDgJX4QNde2H6/89Gnss3JjJD9?=
 =?us-ascii?Q?SFfBUjYucompwR2xIhXqeh9RQ4KfDQxyFKEGxkup31MlL8ZS2/O6h78fFtx6?=
 =?us-ascii?Q?PUXfQb8tht+zC3aB+/n4Yso8uP9hTIVjbtgTRAVTxFOiTxYA+F1guQDom4pJ?=
 =?us-ascii?Q?EUZuMwVTceuRMgS/JSWc2q+/J9+ph2Nrj6W68NRxPvXsaC2YNWJzCOuQi2s7?=
 =?us-ascii?Q?XgVbXcDFNtVGA6sYfSKeOi0nKhAuOhAuWuBrTHdkgylh2xPjapcjaI4myF5p?=
 =?us-ascii?Q?scxqRzAvnxtf2OnhISsAKtzZkGFgVeTMgLqW1xLgvQCHg9bISctVPoZoOjKB?=
 =?us-ascii?Q?/KILVPRELZy1L3oftbhwM/GgU+ZgWeT06MstncwBfHSSpCulLmA8u7ItyKgN?=
 =?us-ascii?Q?/bZJX8vtX1wH0sudD/pd7Kg6twk6PXW2oYGOiE3O6/cupCYyygKhO0efq1hq?=
 =?us-ascii?Q?50rOqEq9GrdEB/2PjkiTjqhVkiCPA1HpoULRbJHgWLE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdbf032-aa5c-45d5-d680-08d890fc7179
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 04:41:58.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SVODO88ssCfG1OuGawfSeJrFcjxypdAzuiLBZmbha9HK4nYfrVH5VHyq06pRrU17JSaxdzPi5y/sUQOC6ElIOnErlLSMU9gSKfrs+PfLb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_02:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=730 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011250027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

>
>On 20-11-19 15:13:07, Pawel Laszczak wrote:
>> Patch adds entry for USBSSP (CDNSP) driver into MAINTARNERS file.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  MAINTAINERS | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 842fef329119..70c31fd2cd61 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3867,6 +3867,14 @@ S:	Maintained
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
>>  F:	Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>  F:	drivers/usb/cdns3/
>> +X:	drivers/usb/cdns3/cdnsp*
>> +
>> +CADENCE USBSSP DRD IP DRIVER
>> +M:	Pawel Laszczak <pawell@cadence.com>
>> +L:	linux-usb@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/usb/cdns3/
>> +X:	drivers/usb/cdns3/cdns3*
>>
>
>Hi Pawel,
>
>You may add "T" for which tree for cdns3 ssp driver.

It make sense. I will do it.

--

Thanks,
Pawel

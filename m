Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A672EF684
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbhAHRfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:35:45 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:42316 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727785AbhAHRfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:35:44 -0500
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108HVQqs024082;
        Fri, 8 Jan 2021 12:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=a3LZwy73+UnbaCtY0DlIj5A6nJfiPAp10oY2vnpIJuI=;
 b=atf6Wb3cDrRtoaJC+s+x8xtaaZNGWOLRkzZhUDsiAt6LBByEgV0J3mzFOKtK10kg3E8g
 FXuxa36jv6Eqp7OJjOJ1wwoW8zCPNluvMzthA7xM4cN6wf/HMhVic8vYiHSF9VUToXiQ
 0KWK0rGss+Toxm5MwoYLGY/kiRlFPX2Y6t9lXa5l03oKe7ncN7RPIv606PlJuUM5U3/h
 5CvMT90hAumFQmENC9T45ctp+aASCY/quy58p67wdLlGJY3Vjt9d+jsKhwwdD+IbcCMw
 V8XjqwO7Wv7pus/Vc1vl5OfVEvaCZokchdWCwUCufD47/XM+x80mcdqkOB7u2wTdvIQY KA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 35wpd1ey81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 12:34:51 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108HYdiU180610;
        Fri, 8 Jan 2021 12:34:50 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00154901.pphosted.com with ESMTP id 35xugd8ed2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 12:34:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWMy1QmroBw50O16AvtweQwvBSoYGrPSJRmCiZ1rIIzo8MzquDC4w0V+6pADqDBdcP+1wfpftJDYA1wm0PDL8ueKfy6Bb6ELFa0DUIvQWxxZOZzIYVhRCP9goCrguJVA+oDJ/UoXnMSV9En5/H93qsgQ7dl2/yb2r1pxNbVXHbFisx3khFaB1fxolBx3hNXmav4wvGLqapCgxnZFspMQVdKy72AeyFoDBdeJ43Ytxn0x5Sfrx/BavbjX/SShaCmi7SCiCBOMOrFtSNLCf0VmPxIq7w6ORuxGeqMcGk1bHvsBDUtdPNsU6+iH5JmAT5ZCzZ7LEvhP4zhSeHibG0OTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3LZwy73+UnbaCtY0DlIj5A6nJfiPAp10oY2vnpIJuI=;
 b=FVQrttmou+Kz/uYIgMCZk0NAopZLDfb9nwmp4mvD1XYiPIcQioTWVbr+RGld2nukmtPev5PloUFMUAXBfOK6ELCxTxEsCq0j56jTrrtJYUdxsj3MTuGBYhygmvl4/C7EyiYO5Xr1ZPtvu1rJHo7k+I/X+/Zmj6qFBkZrykiKSwRRjgKtEZYGUFdd9eND9KRLhPbtsBVENF9TJsnH8jDSG+ny1XwguX+/9t3jaROBaG3bTSe6IG5+EzRjC4k/zpYuvI+p/HriUMpHcFk3RglMxkyllsyr3BTLMCEzaLEcFdcuWbeaaUW9uvBJCDFezz+WK9MfNU/VgehCEDigLVZSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3LZwy73+UnbaCtY0DlIj5A6nJfiPAp10oY2vnpIJuI=;
 b=UodyGFfmTW7enxEosDKVgAdigy0zZpbWcDYCo/6YGw9npeCAH6zMuJXXEmvoztLuPQdvpMQF2YgnG86JZr+iWmiFQvYAukQdaJpjoLuIL5jyUvaqlgVjUH/ecDmwOVFh5hdfH/ZC7A/WpDA9vM4MW2bOqw0lT+JDuDgcH/zgC1k=
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com (2603:10b6:a03:28a::6)
 by SJ0PR19MB4413.namprd19.prod.outlook.com (2603:10b6:a03:287::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 17:34:46 +0000
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::f49a:eb87:f48b:9e13]) by SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::f49a:eb87:f48b:9e13%5]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 17:34:46 +0000
From:   "Yuan, Perry" <Perry.Yuan@dell.com>
To:     =?utf-8?B?QmFybmFiw6FzIFBvY3pl?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Wang, David D" <David.D.Wang@dell.com>,
        "Zhang, Zorro" <Zorro.Zhang@dell.com>,
        "Martinez3, Juan" <Juan.Martinez@Dell.com>
Subject: RE: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
Thread-Topic: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
Thread-Index: AQHW3R16PXb+LpE5eU2W8kW/5H5C0KobUR6AgAESAgCAAatoQA==
Date:   Fri, 8 Jan 2021 17:34:45 +0000
Message-ID: <SJ0PR19MB45282B7FD837E5BB5287969084AE0@SJ0PR19MB4528.namprd19.prod.outlook.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
 <d1d31281-d5c8-ea09-9e2d-1c5acb35deef@redhat.com>
 <kt8PP3Pj3sI0-gL28bw5rPCvcv3S8STD0pMFoQUrixarFRv_36In5dPDtrOtSSJk2WhEo4FN9duHO_pNG8kDDPng06mDOX9UvmXeaPNI6sE=@protonmail.com>
In-Reply-To: <kt8PP3Pj3sI0-gL28bw5rPCvcv3S8STD0pMFoQUrixarFRv_36In5dPDtrOtSSJk2WhEo4FN9duHO_pNG8kDDPng06mDOX9UvmXeaPNI6sE=@protonmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Perry_Yuan@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-08T17:34:43.0720093Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=05553443-9a20-4db4-b492-424ecdec523f;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: protonmail.com; dkim=none (message not signed)
 header.d=none;protonmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [114.84.248.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 046a1e15-49af-4d57-7c5a-08d8b3fbb104
x-ms-traffictypediagnostic: SJ0PR19MB4413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR19MB441390265E76603793EB47A884AE0@SJ0PR19MB4413.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxE1Cdz6dBG4AsOVeXpW5pxUmVm9D6f+dLG/9xI+z3T7c1rvV+sN0SqcngDtkT3SP77ugVCqjv67akebCuGlTt/S9lN4h1DfhnVrkU6t0ZAvrFcn03AsqimKv94z0r8/yC47ABlagXFp9anueRXuQSY9V6kMe+S5twvkWVgMXI5fm/p4eLtGYceb9GTW0IfyWoil2NWBVl1wz1asaSwYcpYJ86cn+dsLq+I3ylsA6VTKERDfgcTicqeTuyExeVAaH23TW20kPqi9y9QjX6aS1vBCz7Tdufr4zz1jV4D1hey4gk8+4V0g9pVco0bEpCNqR0C13K0+z60HL2IklZ02T7VYUYXp+eWOf5iAWndh9PsULlpCf8svneW0aqJyXmdCQyzI4gHmAuklk3Pb61FJ0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4528.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(8676002)(8936002)(71200400001)(5660300002)(786003)(4326008)(186003)(9686003)(66446008)(53546011)(55016002)(54906003)(83380400001)(26005)(6506007)(107886003)(110136005)(2906002)(52536014)(66476007)(316002)(33656002)(64756008)(66946007)(66556008)(86362001)(76116006)(478600001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkVtWFBtVmlRUWZxNXZIWU0wNXhDUmY1SE1jMyt5K1NOWjMzaGpXMnV0V0lk?=
 =?utf-8?B?Mi9jV1lTUFpiR1g4YWxGWEVEUWFLcWFMczhhaUh4aWJpdmhIcHlWanpKeWoy?=
 =?utf-8?B?c096WWhqYzVJT2NUUjFuWVZuVzRvVzhia01UUjN6T1MwYXNETzliSFlTZWF4?=
 =?utf-8?B?RFlTUyt2OUJVS2RSNUt2Mk90Rlo4WkJrMGF6bG1zS1RSRXMvZlZLUU13QTZU?=
 =?utf-8?B?NERvc1V3NzBYY2tBdFU3MjBxcXJWMWlzc0lKckdtemZMc09KWnV6cVNJcW1L?=
 =?utf-8?B?RVRjMW5WbnZrOUxyZXFQN3BidkRRWDlUV0M0NnZ4dVdOY1d0dVpxVGIwbXNh?=
 =?utf-8?B?RVBmRmZIVEQ2RkhRWE1UcWxrYkFNQW1YZTdXaHNsUkxvYXZiOUQ1WWpUcjEz?=
 =?utf-8?B?TWJBN3ZMM1psSHFjRXBxdnBKSjJHNEhTQXNLendveDdMd2Y3K0NhTmsrYVg5?=
 =?utf-8?B?dlJhUCtpdWdaSVRUUzNWdVZKVXBVOE1zdm1EWEdWNkFsTkhRcm9hSDFaZEYv?=
 =?utf-8?B?blJzN0tna25ueWMvY1hoQnd0YmkxL0d1cGtobzlNZXdnSkgwYkttLzJEWEUr?=
 =?utf-8?B?ZmJjeDRlMTlBc3dzNmlKR285Q1lLZzQ1WXk4eXUybWJ1cGtwcW10MWU5Uloz?=
 =?utf-8?B?dmU1YjI5RTY1NCtlU0cxMTBockVmYXNLdTFiVFE2WjBQMU85SkpCdEY3QWR0?=
 =?utf-8?B?UVFxN3pJcmIrSEdscXQyU1RiZUFKNG1vc28vUW5TbCs2VmttSFJmRjUzUVM0?=
 =?utf-8?B?Z000Yi9YRkdKcEsyeElKM3o4Z2piTXRRN25NTEp0TGgySUxZUEkzU0taY1Rm?=
 =?utf-8?B?Qndvc083RHF0NDBrU3dMM29ham1pam85Zjlmb2xTM0dkSkVLb1lGM21NODcr?=
 =?utf-8?B?TDkzQjBKdW9zaldMQVJsZFQ5Z3JiQ3hxZGFPajV3Yk5RMEVqR1hhNy9yTFFx?=
 =?utf-8?B?VzlTbVFGQ1ZVd0YxQWIvOEVZUHYyMmVwbWJaR0I1dGJFaWpyaUx2UCtVRXAv?=
 =?utf-8?B?THJyUUs3bkhkTlhuMkcwZmF4aW5uZTNReE40SHpwdm5IVHRkYzR0MDFRdFRP?=
 =?utf-8?B?OWI3dlFoOXFhMXN6TGRwVXFXL2tsN2IyTlVzWUJLZmg5M2pyYTZNMjRKNVhU?=
 =?utf-8?B?bk4yeWpFWVJhQkhoOWZ2UE9qc3hwOHFiditMclphbThiZHVocG0xUTBWcnZ3?=
 =?utf-8?B?SjhDQjNwc0ZRbDJ6dU4xZXRVSEJ4eXBZQ2hmWnFXSWRnc25USi8vb2s0Ry8z?=
 =?utf-8?B?M1NrajNnRWlXS05kWHdCY3AyOWUySU5Xa3ZLdFYra3BIc2RZSmNRVzAyajVJ?=
 =?utf-8?Q?dpcG5HBciwDlE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4528.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046a1e15-49af-4d57-7c5a-08d8b3fbb104
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 17:34:45.9695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJtjm68jmm8Q03RddOQMplwb52NNk7hy3VlfbboJoIjWXZlhblS3bkgjpYp66WvQ3TSwD5eKh2fa7qxprOKQBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4413
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_08:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080096
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJhcm5hYsOhcyBQxZFjemUg
PHBvYnJuQHByb3Rvbm1haWwuY29tPg0KPiBTZW50OiAyMDIx5bm0MeaciDjml6UgMDowNA0KPiBU
bzogSGFucyBkZSBHb2VkZQ0KPiBDYzogWXVhbiwgUGVycnk7IG1ncm9zc0BsaW51eC5pbnRlbC5j
b207IHBsYXRmb3JtLWRyaXZlci0NCj4geDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgTGltb25jaWVsbG8sIE1hcmlvDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgMS8yXSBwbGF0Zm9ybS94ODY6IGRlbGwtcHJpdmFjeTogQWRkIHN1cHBvcnQgZm9yIERl
bGwNCj4gaGFyZHdhcmUgcHJpdmFjeQ0KPiANCj4gDQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4gDQo+
IEhpDQo+IA0KPiANCj4gMjAyMS4gamFudcOhciA3LiwgY3PDvHTDtnJ0w7ZrIDA6NDMga2VsdGV6
w6lzc2VsLCBIYW5zIGRlIEdvZWRlIMOtcnRhOg0KPiANCj4gPiBIaSBQZXJyeSwNCj4gPg0KPiA+
IE9uIDEyLzI4LzIwIDI6MjggUE0sIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206
IFBlcnJ5IFl1YW4gcGVycnlfeXVhbkBkZWxsLmNvbSBhZGQgc3VwcG9ydCBmb3IgZGVsbCBwcml2
YWN5DQo+ID4gPiBkcml2ZXIgZm9yIHRoZSBkZWxsIHVuaXRzIGVxdWlwcGVkIGhhcmR3YXJlIHBy
aXZhY3kgZGVzaWduLCB3aGljaA0KPiA+ID4gcHJvdGVjdCB1c2VycyBwcml2YWN5IG9mIGF1ZGlv
IGFuZCBjYW1lcmEgZnJvbSBoYXJkd2FyZSBsZXZlbC4gb25jZQ0KPiA+ID4gdGhlIGF1ZGlvIG9y
IGNhbWVyYSBwcml2YWN5IG1vZGUgZW5hYmxlZCwgYW55IGFwcGxpY2F0aW9ucyB3aWxsIG5vdA0K
PiA+ID4gZ2V0IGFueSBhdWRpbyBvciB2aWRlbyBzdHJlYW0uDQo+ID4gPiB3aGVuIHVzZXIgcHJl
c3NlZCBjdHJsK0Y0IGhvdGtleSwgYXVkaW8gcHJpdmFjeSBtb2RlIHdpbGwgYmUNCj4gPiA+IGVu
YWJsZWQsTWljbXV0ZSBsZWQgd2lsbCBiZSBhbHNvIGNoYW5nZWQgYWNjb3JkaW5nbHkuDQo+ID4g
PiBUaGUgbWljbXV0ZSBsZWQgaXMgZnVsbHkgY29udHJvbGxlZCBieSBoYXJkd2FyZSAmIEVDLg0K
PiA+ID4gYW5kIGNhbWVyYSBtdXRlIGhvdGtleSBpcyBjdHJsK0Y5LmN1cnJlbnRseSBkZXNpZ24g
b25seSBlbW1pdA0KPiA+ID4gU1dfQ0FNRVJBX0xFTlNfQ09WRVIgZXZlbnQgd2hpbGUgdGhlIGNh
bWVyYSBMRU5TIHNodXR0ZXIgd2lsbCBiZQ0KPiA+ID4gY2hhbmdlZCBieSBFQyAmIEhXIGNvbnRy
b2wuDQo+ID4gPiAqVGhlIGZsb3cgaXMgbGlrZSB0aGlzOg0KPiA+ID4NCj4gPiA+IDEuICBVc2Vy
IHByZXNzZXMga2V5LiBIVyBkb2VzIHN0dWZmIHdpdGggdGhpcyBrZXkgKHRpbWVvdXQgaXMNCj4g
PiA+IHN0YXJ0ZWQpIDIuICBFdmVudCBpcyBlbWl0dGVkIGZyb20gRlcgMy4gIEV2ZW50IHJlY2Vp
dmVkIGJ5DQo+ID4gPiBkZWxsLXByaXZhY3kgNC4gIEtFWV9NSUNNVVRFIGVtaXR0ZWQgZnJvbSBk
ZWxsLXByaXZhY3kgNS4gIFVzZXJsYW5kDQo+ID4gPiBwaWNrcyB1cCBrZXkgYW5kIG1vZGlmaWVz
IGtjb250cm9sIGZvciBTVyBtdXRlIDYuICBDb2RlYyBrZXJuZWwNCj4gPiA+IGRyaXZlciBjYXRj
aGVzIGFuZCBjYWxscyBsZWR0cmlnX2F1ZGlvX3NldCwgbGlrZSB0aGlzOg0KPiA+ID4gICAgIGxl
ZHRyaWdfYXVkaW9fc2V0KExFRF9BVURJT19NSUNNVVRFLA0KPiA+ID4gICAgIHJ0NzE1LT5taWNt
dXRlX2xlZCA/IExFRF9PTiA6TEVEX09GRik7DQo+ID4gPg0KPiA+ID4gNy4gIElmICJMRUQiIGlz
IHNldCB0byBvbiBkZWxsLXByaXZhY3kgbm90aWZpZXMgZWMsDQo+ID4gPiAgICAgYW5kIHRpbWVv
dXQgaXMgY2FuY2VsbGVkLEhXIG1pYyBtdXRlIGFjdGl2YXRlZC4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiBwZXJyeV95dWFuQGRlbGwuY29tDQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBMaW1vbmNpZWxsbyBNYXJpbyBtYXJpb19saW1vbmNpZWxsb0BkZWxsLmNv
bQ0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLCBwbGVhc2Ugc2VuZCBhIG5ldyB2
ZXJzaW9uIGFkZHJlc3NpbmcNCj4gPiBCYXJuYWLDoXMnIHJldmlldyBjb21tZW50IGFuZCBpbmNs
dWRpbmcgdGhlIHNlY29uZCBwYXRjaCBvZiB0aGUgc2VyaWVzLg0KPiA+IFsuLi5dDQo+IA0KPiBJ
IHRoaW5rIGZpcnN0IHNvbWV0aGluZyBuZWVkcyB0byBiZSBmaWd1cmVkIG91dCByZWdhcmRpbmcg
dGhlIGludGVncmF0aW9uIHdpdGgNCj4gdGhlIHJlc3Qgb2YgdGhlIERlbGwgbW9kdWxlcy4gSSBm
ZWVsIHRoYXQgbGlzdCBpcyBub3QgYSBkZXNpcmFibGUgd2F5IHRvIGRvIGl0Lg0KPiANCj4gDQo+
IFJlZ2FyZHMsDQo+IEJhcm5hYsOhcyBQxZFjemUNCg0KSGkgQmFybmFiw6FzLCBIYW5zLg0KVGhh
bmtzIGZvciB5b3VyIHJldmlldyBhbmQgY29tbWVudHMuDQpCZWZvcmUgSSBzZW5kIFYzLCBJIHdv
dWxkIGV4cGxhaW4gc29tZSBkZXRhaWwgd2h5IHdlIGhhdmUgdHdvIGZpbGVzIGZvciB0aGUgZGVs
bCBwcml2YWN5IGFyY2ggZGVzaWduLg0KDQpGaXJzdGx5LCBhbGwgdGhlc2UgcHJpdmFjeSBmZWF0
dXJlIGFyZSBoYXJkd2FyZSBsZXZlbCBwcml2YWN5IHNvbHV0aW9uLiAgDQpEZWxsIGlzIGdvaW5n
IHRvIGltcGxlbWVudCAgc29tZSBvdGhlciBkZWxsIHByaXZhY3kgZGV2aWNlcyB1c2luZyBpbnRl
cmZhY2UgYWNwaSBhbmQgIHdtaSBkaWZmZXJlbnRseS4NCnN1Y2ggYXMgZWxlY3Ryb25pYyBwcml2
YWN5IGRpc3BsYXksIHByaXZhY3kgY2FtZXJhLCBhbmQgb3RoZXIgcHJpdmFjeSB0ZWNobm9sb2d5
IHRoYXQgaXMgY29taW5nIHNvb24uDQp3ZSBuZWVkIHRvIGhhdmUgZGVsbC1wcml2YWN5LWFjcGkg
YW5kIGRlbGwtcHJpdmFjeS13bWkgZmlsZXMgdG8gaGFuZGxlIHRoZSBwcml2YWN5IGRldmljZSBp
bnRlcmFjdGlvbiB3aXRoIEJJT1MgYW5kIEVDKGVtYmVkZGVkIGNvbnRyb2xsZXIpDQogIC0gdGhl
IGRlbGwtcHJpdmFjeS13bWkgZmlsZSBoYW5kbGUgdGhlIHdtaSBldmVudCBmcm9tIEJJT1MgYW5k
IGVtaXQgaXQgdG8gdXNlcnNwYWNlICwgaXQgaXMgd21pIGludGVyZmFjZSByZWxhdGVkIGRyaXZl
ciBmaWxlLg0KICAtIHRoZSBkZWxsLXByaXZhY3ktYWNwaSBpbnRlcmFjdCB3aXRoIEFDUEkgaW50
ZXJmYWNlICxkZWxsIHByaXZhY3kgZmVhdHVyZSBuZWVkIHRvIHNlbmQgQUNLIGNvbnRlbnQgdG8g
RUMgIHRocm91Z2ggQUNQSSBpbnRlcmZhY2UuDQogIC0gb3RoZXIgcHJpdmFjeSBkZXZpY2UgZnVu
Y3Rpb24gd2lsbCBiZSBkZXZlbG9wZWQgYWNjb3JkaW5nIHRvIHRoZSBpbnRlcmZhY2UgdHlwZS4g
dGhlIHR3byBkcml2ZXIgZmlsZXMgd2lsbCBiZSBleHRlbmRlZCBmb3IgbmV3IGRldmljZXMuDQoN
CklmIHlvdSBoYXZlIGFueSBvdGhlciBjb25jZXJucyBmb3IgYXJjaCBkZXNpZ24gLCBNYXJpbyBj
b3VsZCBoZWxwIHRvIGV4cGxhaW4gc29tZSBtb3JlIGRldGFpbHMgdG8gZ2V0IHRoaXMgY2xlYXIu
DQoNClBlcnJ5ICBZdWFuDQpEZWxsIHwgQ2xpZW50IFNvZnR3YXJlIEdyb3VwIHwgQ0RDIExpbnV4
IE9TICANCg==

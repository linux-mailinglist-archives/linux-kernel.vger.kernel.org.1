Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314392C904B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgK3Vvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:51:32 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:20438 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730334AbgK3Vva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:51:30 -0500
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AULkebo003293;
        Mon, 30 Nov 2020 16:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=YjXui3QZ7FXQXCoi7AP0u9cmMT8R21YkkS08TNblNrU=;
 b=HwAkQfRzIrLK0uZAYZ6SKV5VfnNL0n9RURefnS2oBofRuijdzok81pH0vbSWGGbVkLrE
 hnJq71JX8tubQKgPs4ECVOCfcRBzcgaR4APYoW6qjJx6mwI/VcwIqCrBLjM768bDyBG2
 cwa9YHsaPZRq7Myxk/s6nJht8aOmm9WliivI9WA0evG11lqlM6DFdL8xxO/uAPjKqW7s
 yqKBv8rMzII4+y23h9b2Ak1IFbEPKVkNY5fJk2JmnB+FpFifppnwjnHEHJfZkJtmLHzh
 t7nF3UqtrUVtUGKUcBgAYFB3UVjtpOs8e+XNjtLvXI3qRkJqmjgV4/tX3zovfVu1LyDP 6g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 353m3sygsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 16:50:46 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AULjg6W039160;
        Mon, 30 Nov 2020 16:50:45 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00154901.pphosted.com with ESMTP id 3558698qaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Nov 2020 16:50:44 -0500
Received: from m0142699.ppops.net (m0142699.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AULk5iO040347;
        Mon, 30 Nov 2020 16:50:44 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00154901.pphosted.com with ESMTP id 3558698qaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 16:50:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2WfaLMHpiToldJpGschXCiytVO8Z1Wzo4+Vc2f7EB3r+IuB1nA5cnsFtaPpc/xWJHt4KS7m6lYwNhwtd2MNX+RZ7rKx2DebZbcBbHZwi4DUEng1UQAd6oz7pfB4mHeSf6ErUjCftXTGk84hFNVjZnaEyFhHOeEcCHvqc4e1wlt0cPEXaI4JUa+JJb2PLwYKCQxVFIQiPLMyTv5oQ0ACeUA5yuqbf85d+I7yQPVA6BXW7TwYesZPJLb8FY5rxz5lVS/L+gtfqRJv1OV9+EPKrdqehZdwdqGLUgPfHyIwKITUK72pKip5K6CM543iTP1FOVipKz4EQy5GOlJ2c18f/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjXui3QZ7FXQXCoi7AP0u9cmMT8R21YkkS08TNblNrU=;
 b=L9bztdkOEaE8I0KMbLGxv/6yzr2XbXDE8wnKPt7CuwcJAl4m6xXpE7XIHolCBqg6NsPuRQDaki74nBmZp/98Jny1usCKFxCrbNRDtcOzmssHXmkwFxQZOVX267F9cX/DaHNFM5WUwmp4wM2qhimjIgvb+KV48JCLj/W9R/P3bq558hdzpejaG1WGZv3Hxp38q/u05VtfCY1uVaym8MORQFnnRbIqgCzZy1vnURsWXpJFlAU8Lowo0yBwDI6TyLdPTBw3oauj9On0PDsYily3fJV7j0tiq+MfOM3byD7/en2TtseYuDzWADpF8S5et+TqSOnxX/DnqEv0JzbaHsipNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjXui3QZ7FXQXCoi7AP0u9cmMT8R21YkkS08TNblNrU=;
 b=PBj1iwyxkPb5pgk4YSwNqpQgZYHl0B2xOQ+cdIeYmUwz+hZVFjS3bIdRiKq1a+tc+lWia2EgiJ9Dq+068RtFg/R/6CdZtT+doxqdd6sqpx69FJTw6ODp7jXk0h3kVqmFVrXx0wQPj6hIRyCCmx9jW7tb8I+riqBw01wd/ie8+i4=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DS7PR19MB4392.namprd19.prod.outlook.com (2603:10b6:5:2c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 30 Nov
 2020 21:50:12 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::8a8:3eb2:917f:3914]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::8a8:3eb2:917f:3914%7]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 21:50:12 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Mark Gross <mgross@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-smbios-base: Fix error return code in
 dell_smbios_init
Thread-Topic: [PATCH] platform/x86: dell-smbios-base: Fix error return code in
 dell_smbios_init
Thread-Index: AQHWwvcHHUn53F5W5Ui4cW+Cm/z1uqnZFFGAgAgrMmA=
Date:   Mon, 30 Nov 2020 21:50:12 +0000
Message-ID: <DM6PR19MB26363C4F46BFBF973298F7E8FAF50@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201125065032.154125-1-miaoqinglang@huawei.com>
 <9f86ac03-1c90-e6b6-4f7d-e9584a19e46d@redhat.com>
In-Reply-To: <9f86ac03-1c90-e6b6-4f7d-e9584a19e46d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-30T21:50:11.3286833Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e47e4f44-3383-4d34-b281-b8bb1a1a6020;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32ef3857-b043-4d37-299e-08d89579ea6a
x-ms-traffictypediagnostic: DS7PR19MB4392:
x-microsoft-antispam-prvs: <DS7PR19MB43929DF2AEC9FCEAC3B53D9CFAF50@DS7PR19MB4392.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiyhrFoVA77gJhNgLZH0aPCwWTRYIbt1HhrV/DqS5hFsLxmdUsO47hlNysXwxu3FuKIuxwPTwSySdkMaR3vL2GuC5lYC7ZH6Bez7mdtg9xQxAjYH1WFCi+byDCL6lOK8+ncBErt4Smy4Ln6bSCg7qsOIghxcBpwkpvQ4HNXsImaEd7yXX+GwqpZ+KLn3hBz9x3X7l8dEpXRH10nTLn+7CIK9GLCzPuCcO5vYWp8mamwt4Ni9vOVqMzPXGI1xlz1OjcNgUaxPqjkKs/0mVaCJn5TE5lZT86OdMUn8j6bbpTjcXD9NKJvevpJ78z5CMvRw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(110136005)(786003)(8936002)(316002)(54906003)(2906002)(33656002)(4326008)(6506007)(66446008)(64756008)(66556008)(76116006)(71200400001)(8676002)(7696005)(26005)(9686003)(478600001)(86362001)(186003)(52536014)(53546011)(55016002)(66476007)(5660300002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UzJtbk41RCtVaUt2N05JaE5Sd1BrTkFFZy95VnJ2RnNvZW9IUnhjdCt5dUh1?=
 =?utf-8?B?Sk03dmZab2tVcGl3VFlJRmpFaDJRZURmd3IyU2pFakJ3SWMrbmoyL2NwMStH?=
 =?utf-8?B?eU5rQTVlcW5BRGJMUlBrWi9EamJSeENycEtXbnhxdzhBbWhMWlB1dWNPVUNS?=
 =?utf-8?B?Y21rdnZ6d3VKWnBNaGF3RTl0aGRsRFVQMjMwZWE3c2U2VFhzVlRXTW9VOXBm?=
 =?utf-8?B?TFVodkRXVTd2blhKUktIT1hWNm5IVnRIVmxjakE4TlNMcGVuNjljc3dCSm44?=
 =?utf-8?B?YlNNOUFMaFhsaUpSYWF4cWU0eENvbUtBb3J4S0k2UjlrM0xlOWIvQVhnT2dp?=
 =?utf-8?B?NU03RWdRakNuUnNhOWl1NkQ3aUJ1SDlFandyWEpWNDdmWkN2ODBEby9GYjA5?=
 =?utf-8?B?TVF4bXFzVmU4YTBxWEtCQlFOdlpMcGRSNkdPdklYSnNxd0dmcWt5RmNCYXVa?=
 =?utf-8?B?cHA4M1Q3cThwL2lyQ2xKOVFOTi96R0IyU0JXQnRpejRpVTdiQW1FbmdKZTU0?=
 =?utf-8?B?eU1jTCtYTjJhZk1BWUJub09xcm5LZC9tajBXWXZuQTltTUhUQSthVkhSSzly?=
 =?utf-8?B?V0VxQkFuSXJKVjRiMkNsclhBWmliekk0N2lTY2tYaENnQVJ4VVF6NkNjdFhF?=
 =?utf-8?B?WkhPNnlQLzFwNndmUkZxbWFIZzI5QUttZW1ndXRuNmxHZzJRMlRnZHRiZldv?=
 =?utf-8?B?a3B1c0R4NGtLQ0RwdHNPaUxIZ1FvZmg5ZjdQalo1QWpEZnNvTXJJTGpLOEdW?=
 =?utf-8?B?cFRPaDhYUVZpT0RvSDM1OUFQeFBzOG9EMGliTVRqMzJqZ1ltREN5QTlCZUZm?=
 =?utf-8?B?T0ZUL0FGMEtIeFJiblo1K0lWLzhxN1A3RTBrVEFqZ3pJYjZlK1ZzZ0pURjFz?=
 =?utf-8?B?YXQ4U0tWMWswUWJ0THlrbEpxWjFjMmw2Q0JHY2NmZ3o0WXhhZGlkdERNMGhB?=
 =?utf-8?B?SG9tRnpDYmQ4a2FPQ0c4NkthbGJ3dGIrMWZ6OVZXbTF0d1AvTWd5V1haUkR3?=
 =?utf-8?B?RGVqWElIWGsvcU5iUjZvN1lrTGJ1ckUveHl3blFYUUhuTERBQ1dGM3JwaW9M?=
 =?utf-8?B?MTNyUmxnWFIvTmhUL25BVkdrVlQ5aVJkOEhwRGljaDlScS9aOW92SkxyQTZU?=
 =?utf-8?B?SjhpY2hYWnNDcTlQU3k2N1NHTkZDZDVYa3BNRlpDQngzaU9vNlJqbU0vMjl5?=
 =?utf-8?B?Wm1TMkg1ZC90T0E3N2tGTWJXd2VOUGJqSTJPNWRmUjJQMWVubnJZOWNwSGQw?=
 =?utf-8?B?Zk9uclZBZ2t4V3BhUGVVYzFTOXZjaHpOeVJUb3pKcjZuME01anJpeFB5MlpV?=
 =?utf-8?Q?8F6RFfqpBNMa8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ef3857-b043-4d37-299e-08d89579ea6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 21:50:12.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4JScvNibMox/9TxQUXK2g7GEAO5EG4p2D3c9yAGI3yFfMOfHRhyvNebFpp1YG99RzKWKVLmFBx8uhx3EXBJHeMlXjoDLlVDHAC5EfXs6C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_11:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300136
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSGksDQo+IA0KPiArQ2MgTWFyaW8NCj4gDQo+IE9uIDExLzI1LzIwIDc6NTAgQU0sIFFp
bmdsYW5nIE1pYW8gd3JvdGU6DQo+ID4gRml4IHRvIHJldHVybiB0aGUgZXJyb3IgY29kZSAtRU5P
REVWIHdoZW4gZmFpbHMgdG8gaW5pdCB3bWkgYW5kDQo+ID4gc21tLg0KPiA+DQo+ID4gRml4ZXM6
IDQxZTM2ZjJmODVhZiAoInBsYXRmb3JtL3g4NjogZGVsbC1zbWJpb3M6IExpbmsgYWxsIGRlbGwt
c21iaW9zLSoNCj4gbW9kdWxlcyB0b2dldGhlciIpDQo+ID4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9i
b3QgPGh1bGtjaUBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFFpbmdsYW5nIE1pYW8g
PG1pYW9xaW5nbGFuZ0BodWF3ZWkuY29tPg0KPiANCj4gTWFyaW8sIHRoaXMgc2VlbXMgbGlrZSBh
IHRyaXZpYWwgZml4IHRvIG1lLCBidXQgSSdtIG5vdCAxMDAlIHN1cmUsIGFueQ0KPiBjb21tZW50
cyBvbiB0aGlzPw0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCg0KWWVhaCwgaXQncyByZWFz
b25hYmxlIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxp
bW9uY2llbGxvQGRlbGwuY29tPg0KDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wbGF0
Zm9ybS94ODYvZGVsbC1zbWJpb3MtYmFzZS5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2RlbGwtc21iaW9zLWJhc2UuYw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtc21iaW9z
LWJhc2UuYw0KPiA+IGluZGV4IDJlMmNkNTY1OS4uM2ExZGJmMTk5IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtc21iaW9zLWJhc2UuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2RlbGwtc21iaW9zLWJhc2UuYw0KPiA+IEBAIC01OTQsNiArNTk0LDcg
QEAgc3RhdGljIGludCBfX2luaXQgZGVsbF9zbWJpb3NfaW5pdCh2b2lkKQ0KPiA+ICAJaWYgKHdt
aSAmJiBzbW0pIHsNCj4gPiAgCQlwcl9lcnIoIk5vIFNNQklPUyBiYWNrZW5kcyBhdmFpbGFibGUg
KHdtaTogJWQsIHNtbTogJWQpXG4iLA0KPiA+ICAJCQl3bWksIHNtbSk7DQo+ID4gKwkJcmV0ID0g
LUVOT0RFVjsNCj4gPiAgCQlnb3RvIGZhaWxfY3JlYXRlX2dyb3VwOw0KPiA+ICAJfQ0KPiA+DQo+
ID4NCg0K

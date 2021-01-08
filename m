Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC32EF636
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbhAHRFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:05:41 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:5606 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726749AbhAHRFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:05:40 -0500
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108GunPJ015655;
        Fri, 8 Jan 2021 12:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=vGgEU0L7gPpQsaOorfPRp8cKxR6GWLNnHp72JOcrgyU=;
 b=oBBTb+sL3u+ZLeJ+MsDElF53pFA9maY7D2i9PQxu8e3VGkq8uta1/NO1jE7lkCVJqbqY
 j+Gvbm0q19KFUkiEzrWtH1jreTv1vSRVMb3oQWNDQb6tJ9cYmore8SxyvgFadeRexmOe
 Uu4dt2HGMAVBxhNzi6PFe/HopQCkwhWVz/lw+RTh3d/WZdst2/qBs9Ov3NIluMj8CpOR
 NRXA9D8sSSVybV/8BlnM7uNMgT27SwMv+3ePSaH+KY4gfaXgsMPLhyXQREwwO95xAts3
 wzqjn7laUppvuDng8xWAYE8JA9UkFrjOynG8Tg8K9lU2GNjcWaIe5aQLBI7N+6O4D4nA dA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 35wnk7y04d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 12:04:51 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108GuXFB099730;
        Fri, 8 Jan 2021 12:04:50 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-00154901.pphosted.com with ESMTP id 35xubf853f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 12:04:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYGzgulP6luXzs+T92bQN8XmJYHUXOLD73GIj9wBLnWLA2YkA9Pcu17XNUZ42LA4X5jugZqO/q86mQW2Lf436rZMCMo0ogUs6ueX7qiuvGezwobvil2vpFz9Fi9U874AdAo8SARgHjmd6H23xFbyRfCwKRuuM68PzIGJifBMBMSV7uX9pfWNhpPKDVCz7jiOMKO+DewM5o4CJobBmmBmvGdGExV3rgb6X9Z3NEXnp2EE4OG9WIlLD/A2e1vk4Polb7dH69UuasbVpzZl9JxigaVgglq0YGyi++NGO7ITOIkN8MoiI9v/O17o9oYOzT8ie8COrlYGJUd/KXiWbB0Z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGgEU0L7gPpQsaOorfPRp8cKxR6GWLNnHp72JOcrgyU=;
 b=KudwLdPype+itSZuOUMHV6f54zrMC9VSgfuqTSKr6AvBRJDl/ipA/KQI9bF3EkdI+m9PwbTI5yy5R2nvqq2TrF7fGCVOScPeer1etTgwkcSn54wWUqsCmXBUrN6AoaTIwElhY2x7nEt9xihxyZmg2TnZayrxfXyc5VRHM4TZ+wH385MvMTSZw3dquMo39wcjhUcpZCaaaulyFeGuGM7l6n4PkaCaHyoX+S6/ekIBuwtklq5Mx4/EDcLCEnPq6L0ulFDUCdS1S6wZvacM8oWS/VKnH2zEtXmAATjxa8UvstbfJx98l0IQhEYYbejpIWaYJEyVTZLBxBXlRhB8753mLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGgEU0L7gPpQsaOorfPRp8cKxR6GWLNnHp72JOcrgyU=;
 b=m9VIRqJf5UCe2zUJ795Rqlop1D0xLn4JY5T7eaTW6vbHxePG9Kle+Ejcdf0jxB0xlRovmHvH5oKI7osPgXOBA+8SjJV8DLY5IHnTlCIdLJOZ8qMq1TXRSO4bqQiqb+LPguE3og1vIxb0xHvkU+WJX9pnIDzbDdkWqP8BnFr/2x0=
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com (2603:10b6:a03:28a::6)
 by SJ0PR19MB4542.namprd19.prod.outlook.com (2603:10b6:a03:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 17:04:49 +0000
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::f49a:eb87:f48b:9e13]) by SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::f49a:eb87:f48b:9e13%5]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 17:04:48 +0000
From:   "Yuan, Perry" <Perry.Yuan@dell.com>
To:     =?utf-8?B?QmFybmFiw6FzIFBvY3pl?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Wang, David D" <David.D.Wang@dell.com>,
        "Zhang, Zorro" <Zorro.Zhang@dell.com>
Subject: RE: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
Thread-Topic: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
Thread-Index: AQHW3R16PXb+LpE5eU2W8kW/5H5C0KobUR6AgAESAgCAAZMDgA==
Date:   Fri, 8 Jan 2021 17:04:48 +0000
Message-ID: <SJ0PR19MB4528F933A2FD758D2EDECB0484AE0@SJ0PR19MB4528.namprd19.prod.outlook.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
 <d1d31281-d5c8-ea09-9e2d-1c5acb35deef@redhat.com>
 <kt8PP3Pj3sI0-gL28bw5rPCvcv3S8STD0pMFoQUrixarFRv_36In5dPDtrOtSSJk2WhEo4FN9duHO_pNG8kDDPng06mDOX9UvmXeaPNI6sE=@protonmail.com>
In-Reply-To: <kt8PP3Pj3sI0-gL28bw5rPCvcv3S8STD0pMFoQUrixarFRv_36In5dPDtrOtSSJk2WhEo4FN9duHO_pNG8kDDPng06mDOX9UvmXeaPNI6sE=@protonmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Enabled=True;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Owner=Perry_Yuan@Dell.com;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_SetDate=2021-01-08T16:57:57.9042099Z;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Name=Customer Communication;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_ActionId=572b0802-0f66-4dfc-946d-48bba748db53;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Extended_MSFT_Method=Manual
authentication-results: protonmail.com; dkim=none (message not signed)
 header.d=none;protonmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [114.84.248.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dcf1826-868f-41ac-5309-08d8b3f781d2
x-ms-traffictypediagnostic: SJ0PR19MB4542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR19MB4542F79CCE2022A8724B68F984AE0@SJ0PR19MB4542.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RD9adivl1dcI/CC5CFNr+IMFwpavfGLb6fXt1syMDlwL69mLAcp10cTF/GAjR9LLXn72pCoH99Mu+D1Da55KDrtiLpTo/Yyw4UBqdbsUuu8RXhoRbBUYfFpHhojRRGjJ06JJrBqg4UvRNZ6CsQTfudixiGTZQRc/MpbneChvNE8HBqWRwHNZCc9V0fC37XDdb8MPwhdwJVBI1h7zYP59pUrCJA/qLe9aCwY9FoDSiG0AEKRY8+WCTrdZYkY+mlLklIxHnA/GjcEKTuZGAA/c4d5Z6ZVGcBBnZdrnoMlLeVePS5E5UaXZaEFzIuNyKkTmYbyxjlxGPQqaaiXtXhMxbrpCnZVm2VjRu7kDjVVvHXCjgj/kL9dUkNY0++ms6yf0pGsS3BUUgDkC2iaV2KwdZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4528.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(83380400001)(64756008)(53546011)(2906002)(66946007)(55016002)(66446008)(8936002)(66476007)(5660300002)(66556008)(76116006)(107886003)(478600001)(52536014)(54906003)(71200400001)(316002)(786003)(26005)(110136005)(33656002)(9686003)(7696005)(86362001)(6506007)(4326008)(8676002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MGpKMXRJQXhSVW9YSTdOQjdMaENOVUdVQW5vbUpCcnVJNmZaSWg4NFJ1eTZ6?=
 =?utf-8?B?VC9ic1NvazErcVAxcEFFR3hsWW9BbkE0TW4wQ2JZRm1NOCs3RkVydEZ3UkJU?=
 =?utf-8?B?c1cvT3drMlRXeWhpeWZ2S20rYXF5MlhMVXkyOFBQNkVNbnFnK0ZtT2NPSnBz?=
 =?utf-8?B?VUtCNCtEd0xkcmk0WEUwVW9HazZvQ0RQem5kNFhaQUNXM08rMlRDRmdqUUlW?=
 =?utf-8?B?bURSWWNiY3BKU1R0K05NUStrTkUwbW4wM2FvY3hUb0lGdnVOMjlqeVphaFRo?=
 =?utf-8?B?WWRCNmEwOU9uUmZMeTg4eThjVGdpTDB4R3E1WWhOeFRLanErR09Pbk5hTkww?=
 =?utf-8?B?YUh1Q1FWVTcrellRakg0ZXJTVkZDa1JmMy8xbHl0aEVZVGtDRlBrN1lqZkd0?=
 =?utf-8?B?Mk5XanNSSUFCVnhvNGx3Ri9vQ3hOWkdVekZsVExSc1J3TUZBQWNoMm03cFp1?=
 =?utf-8?B?R3NKckU4TjR0RE1ucFdrbXJWbXh4WnVzSmllbG1tdHJkZzlwN0NFTDB4Uitp?=
 =?utf-8?B?VElOV3RQRGZ5c3F5eXBNbEp6N0pNQmY5Y3c5Z0JKSk9DdzU1SXZWK21yRTYy?=
 =?utf-8?B?Q0hwNGFYRTd3T25PWTQyeVU5cTdXd04xMWJjQzJQdTlQa3k2Wmo3R1ljYmhH?=
 =?utf-8?B?U2tudktIZXM5ZTFsemsrZGUyRWtyajg1bEt1elRQQVdLZHIxVzhJVm92S0JL?=
 =?utf-8?B?enkzSkZ0MzJTcXIrYnAxUjVVemVMWFBpN205R0hJakhUaFVpdmY1dmFWV0pE?=
 =?utf-8?B?U0xTMUFJUTEybDljVlJMY3VmWURoRmthVEdRUzJ1YXZjMlcrV2NRL3lRY09a?=
 =?utf-8?B?M2VMWDJkZE5peUJHOFdUUzFJT3htd1B2Qzk4U01vOHU1UGN0Q1Q0S3VoN20y?=
 =?utf-8?B?NlZIWXplWG00YmQ3ZkJ1TE92QS82c1BOR29lVk5aYm9yYjFUMTNnSnBOTVFG?=
 =?utf-8?B?SFo2TWZhNEF6TnhIdzlzSjNuL1RLeUcyRk1FU3pNZ1MvZ1AvN1hwZWVaWk9i?=
 =?utf-8?B?dEVmVmNYZDlpeldKV1pJWXFwTmVYMmFRcXREYUF1NDV2UkswM2g1WVZpRFBu?=
 =?utf-8?B?UHNxbk1RWFVUUVE2dFF0RitnRU9UQWVTRG9lR1BBVHZoaHZTNnFKSkM0YkYv?=
 =?utf-8?B?dEFWZ0J4Tk10ZmVURWxDYndja0liUnQ2WS9tWnlXNjNGU3EwN3FzTVBVT1pD?=
 =?utf-8?B?blVwZG5ZMGlSU0R3YU4rVEgvZll5bXZVb2oxTWlkLzZVVVB0QWQ3NG4xTDF0?=
 =?utf-8?B?NzdaaWFKRHAyY3BDNFpic2tqN0ZjYnJsRUg1NnFqSGdrbFlSanBDYU01NFNF?=
 =?utf-8?Q?O1bCUDYS7KJ58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4528.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcf1826-868f-41ac-5309-08d8b3f781d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 17:04:48.7740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvcyKmYwKp3vfh6V5U/sVR3SB4TvsqMdSt20ImxK7ds4AT/QpI+qkbIo3dzUBEA76Tc33yL/wPeN9NXQG/Gwhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4542
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_08:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080095
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVsbCBDdXN0b21lciBDb21tdW5pY2F0aW9uIC0gQ29uZmlkZW50aWFsDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFybmFiw6FzIFDFkWN6ZSA8cG9icm5AcHJvdG9u
bWFpbC5jb20+DQo+IFNlbnQ6IDIwMjHlubQx5pyIOOaXpSAwOjA0DQo+IFRvOiBIYW5zIGRlIEdv
ZWRlDQo+IENjOiBZdWFuLCBQZXJyeTsgbWdyb3NzQGxpbnV4LmludGVsLmNvbTsgcGxhdGZvcm0t
ZHJpdmVyLQ0KPiB4ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIHBs
YXRmb3JtL3g4NjogZGVsbC1wcml2YWN5OiBBZGQgc3VwcG9ydCBmb3IgRGVsbA0KPiBoYXJkd2Fy
ZSBwcml2YWN5DQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gSGkNCj4gDQo+IA0K
PiAyMDIxLiBqYW51w6FyIDcuLCBjc8O8dMO2cnTDtmsgMDo0MyBrZWx0ZXrDqXNzZWwsIEhhbnMg
ZGUgR29lZGUgw61ydGE6DQo+IA0KPiA+IEhpIFBlcnJ5LA0KPiA+DQo+ID4gT24gMTIvMjgvMjAg
MjoyOCBQTSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPg0KPiA+ID4gRnJvbTogUGVycnkgWXVhbiBw
ZXJyeV95dWFuQGRlbGwuY29tIGFkZCBzdXBwb3J0IGZvciBkZWxsIHByaXZhY3kNCj4gPiA+IGRy
aXZlciBmb3IgdGhlIGRlbGwgdW5pdHMgZXF1aXBwZWQgaGFyZHdhcmUgcHJpdmFjeSBkZXNpZ24s
IHdoaWNoDQo+ID4gPiBwcm90ZWN0IHVzZXJzIHByaXZhY3kgb2YgYXVkaW8gYW5kIGNhbWVyYSBm
cm9tIGhhcmR3YXJlIGxldmVsLiBvbmNlDQo+ID4gPiB0aGUgYXVkaW8gb3IgY2FtZXJhIHByaXZh
Y3kgbW9kZSBlbmFibGVkLCBhbnkgYXBwbGljYXRpb25zIHdpbGwgbm90DQo+ID4gPiBnZXQgYW55
IGF1ZGlvIG9yIHZpZGVvIHN0cmVhbS4NCj4gPiA+IHdoZW4gdXNlciBwcmVzc2VkIGN0cmwrRjQg
aG90a2V5LCBhdWRpbyBwcml2YWN5IG1vZGUgd2lsbCBiZQ0KPiA+ID4gZW5hYmxlZCxNaWNtdXRl
IGxlZCB3aWxsIGJlIGFsc28gY2hhbmdlZCBhY2NvcmRpbmdseS4NCj4gPiA+IFRoZSBtaWNtdXRl
IGxlZCBpcyBmdWxseSBjb250cm9sbGVkIGJ5IGhhcmR3YXJlICYgRUMuDQo+ID4gPiBhbmQgY2Ft
ZXJhIG11dGUgaG90a2V5IGlzIGN0cmwrRjkuY3VycmVudGx5IGRlc2lnbiBvbmx5IGVtbWl0DQo+
ID4gPiBTV19DQU1FUkFfTEVOU19DT1ZFUiBldmVudCB3aGlsZSB0aGUgY2FtZXJhIExFTlMgc2h1
dHRlciB3aWxsIGJlDQo+ID4gPiBjaGFuZ2VkIGJ5IEVDICYgSFcgY29udHJvbC4NCj4gPiA+ICpU
aGUgZmxvdyBpcyBsaWtlIHRoaXM6DQo+ID4gPg0KPiA+ID4gMS4gIFVzZXIgcHJlc3NlcyBrZXku
IEhXIGRvZXMgc3R1ZmYgd2l0aCB0aGlzIGtleSAodGltZW91dCBpcw0KPiA+ID4gc3RhcnRlZCkg
Mi4gIEV2ZW50IGlzIGVtaXR0ZWQgZnJvbSBGVyAzLiAgRXZlbnQgcmVjZWl2ZWQgYnkNCj4gPiA+
IGRlbGwtcHJpdmFjeSA0LiAgS0VZX01JQ01VVEUgZW1pdHRlZCBmcm9tIGRlbGwtcHJpdmFjeSA1
LiAgVXNlcmxhbmQNCj4gPiA+IHBpY2tzIHVwIGtleSBhbmQgbW9kaWZpZXMga2NvbnRyb2wgZm9y
IFNXIG11dGUgNi4gIENvZGVjIGtlcm5lbA0KPiA+ID4gZHJpdmVyIGNhdGNoZXMgYW5kIGNhbGxz
IGxlZHRyaWdfYXVkaW9fc2V0LCBsaWtlIHRoaXM6DQo+ID4gPiAgICAgbGVkdHJpZ19hdWRpb19z
ZXQoTEVEX0FVRElPX01JQ01VVEUsDQo+ID4gPiAgICAgcnQ3MTUtPm1pY211dGVfbGVkID8gTEVE
X09OIDpMRURfT0ZGKTsNCj4gPiA+DQo+ID4gPiA3LiAgSWYgIkxFRCIgaXMgc2V0IHRvIG9uIGRl
bGwtcHJpdmFjeSBub3RpZmllcyBlYywNCj4gPiA+ICAgICBhbmQgdGltZW91dCBpcyBjYW5jZWxs
ZWQsSFcgbWljIG11dGUgYWN0aXZhdGVkLg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBQZXJyeSBZdWFuIHBlcnJ5X3l1YW5AZGVsbC5jb20NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IExpbW9uY2llbGxvIE1hcmlvIG1hcmlvX2xpbW9uY2llbGxvQGRlbGwuY29tDQo+ID4NCj4gPiBU
aGFuayB5b3UgZm9yIHlvdXIgcGF0Y2gsIHBsZWFzZSBzZW5kIGEgbmV3IHZlcnNpb24gYWRkcmVz
c2luZw0KPiA+IEJhcm5hYsOhcycgcmV2aWV3IGNvbW1lbnQgYW5kIGluY2x1ZGluZyB0aGUgc2Vj
b25kIHBhdGNoIG9mIHRoZSBzZXJpZXMuDQo+ID4gWy4uLl0NCj4gDQo+IEkgdGhpbmsgZmlyc3Qg
c29tZXRoaW5nIG5lZWRzIHRvIGJlIGZpZ3VyZWQgb3V0IHJlZ2FyZGluZyB0aGUgaW50ZWdyYXRp
b24gd2l0aA0KPiB0aGUgcmVzdCBvZiB0aGUgRGVsbCBtb2R1bGVzLiBJIGZlZWwgdGhhdCBsaXN0
IGlzIG5vdCBhIGRlc2lyYWJsZSB3YXkgdG8gZG8gaXQuDQo+IA0KPiANCj4gUmVnYXJkcywNCj4g
QmFybmFiw6FzIFDFkWN6ZQ0KDQpIaSBCYXJuYWLDoXMsIEhhbnMuDQpUaGFua3MgZm9yIHlvdXIg
cmV2aWV3IGFuZCBjb21tZW50cy4NCkJlZm9yZSBJIHNlbmQgVjMsIEkgd291bGQgZXhwbGFpbiBz
b21lIGRldGFpbCB3aHkgd2UgaGF2ZSB0d28gZmlsZXMgZm9yIHRoZSBkZWxsIHByaXZhY3kgYXJj
aCBkZXNpZ24uDQoNCkZpcnN0bHksIGFsbCB0aGVzZSBwcml2YWN5IGZlYXR1cmUgYXJlIGhhcmR3
YXJlIGxldmVsIHByaXZhY3kgc29sdXRpb24uICANCkRlbGwgaXMgZ29pbmcgdG8gaW1wbGVtZW50
ICBzb21lIG90aGVyIGRlbGwgcHJpdmFjeSBkZXZpY2VzIHVzaW5nIGludGVyZmFjZSBhY3BpIGFu
ZCAgd21pIGRpZmZlcmVudGx5Lg0Kc3VjaCBhcyBlbGVjdHJvbmljIHByaXZhY3kgZGlzcGxheSwg
cHJpdmFjeSBjYW1lcmEsIGFuZCBvdGhlciBwcml2YWN5IHRlY2hub2xvZ3kgdGhhdCBpcyBjb21p
bmcgc29vbi4NCndlIG5lZWQgdG8gaGF2ZSBkZWxsLXByaXZhY3ktYWNwaSBhbmQgZGVsbC1wcml2
YWN5LXdtaSBmaWxlcyB0byBoYW5kbGUgdGhlIHByaXZhY3kgZGV2aWNlIGludGVyYWN0aW9uIHdp
dGggQklPUyBhbmQgRUMoZW1iZWRkZWQgY29udHJvbGxlcikNCiAgLSB0aGUgZGVsbC1wcml2YWN5
LXdtaSBmaWxlIGhhbmRsZSB0aGUgd21pIGV2ZW50IGZyb20gQklPUyBhbmQgZW1pdCBpdCB0byB1
c2Vyc3BhY2UgLCBpdCBpcyB3bWkgaW50ZXJmYWNlIHJlbGF0ZWQgZHJpdmVyIGZpbGUuDQogIC0g
dGhlIGRlbGwtcHJpdmFjeS1hY3BpIGludGVyYWN0IHdpdGggQUNQSSBpbnRlcmZhY2UgLGRlbGwg
cHJpdmFjeSBmZWF0dXJlIG5lZWQgdG8gc2VuZCBBQ0sgY29udGVudCB0byBFQyAgdGhyb3VnaCBB
Q1BJIGludGVyZmFjZS4NCiAgLSBvdGhlciBwcml2YWN5IGRldmljZSBmdW5jdGlvbiB3aWxsIGJl
IGRldmVsb3BlZCBhY2NvcmRpbmcgdG8gdGhlIGludGVyZmFjZSB0eXBlLiB0aGUgdHdvIGRyaXZl
ciBmaWxlcyB3aWxsIGJlIGV4dGVuZGVkIGZvciBuZXcgZGV2aWNlcy4NCg0KTWVhbndoaWxlLCBh
Y3R1YWxseSB3ZSB3aWxsIGNvbnNpZGVyIHRvIGFkZCBvbmUgQUNQSSBkZXZpY2UgdG8gQklPUyBE
U0RUIHRhYmxlIGluIGZ1dHVyZSAsIHRoZW4gZGVsbC1wcml2YWN5LWFjcGkgZHJpdmVyIGNhbiBy
ZWdpc3RlciB0byBrZXJuZWwgbWF0Y2hpbmcgdGhhdCBkZXZpY2Ugd2l0aCBzcGVjaWZpYyBBQ1BJ
IGRldmljZSBJRC4NCg0KSWYgeW91IGhhdmUgYW55IG90aGVyIGNvbmNlcm5zIGZvciBhcmNoIGRl
c2lnbiAsIE1hcmlvIGNvdWxkIGhlbHAgdG8gZXhwbGFpbiBzb21lIG1vcmUgZGV0YWlscyB0byBn
ZXQgdGhpcyBjbGVhci4NCg0KDQo=

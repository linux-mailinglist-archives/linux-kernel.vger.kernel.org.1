Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C029913D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784005AbgJZPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:39:46 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:25090 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1773479AbgJZPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:39:46 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QFaeeS018093;
        Mon, 26 Oct 2020 11:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7cgYTowMLsLulpZqxmQ/IS8IkeCUXdwt93CYFLHW/Uc=;
 b=W/5JEF42t76fQHgmLObo3i9sJOxZ5pBCWRlLGn1mUzixLYOc3UAdOlJzZbN1AlLbcJBv
 1E0O4rMx+KH6Bji4WPmuAnnritsOwLQJLCgcwljb2VeST5G77TO4cImHQT3dYlFaAkBm
 b2JaNFGLZSKl1hpkAhDFteiHGap/PJvnMNjuRi6dcI86ddhf1vSYE4ipqvmKHNiu6UQu
 YSDIIQovh0hBQ/5tPjgAtQdjSZwaaF4wFya/tpQxoORVKfEGrhOUVYFMEXTTHuwmB6S5
 fB/VVkWfEkyK7NC43AEq4PMi7tNHF8//Xc3yNdYIGlc7ej45FSXv1jYTl6gJX/ilcbYd +Q== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 34cfdwf00y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 11:39:38 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QFVb8w116221;
        Mon, 26 Oct 2020 11:39:37 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0b-00154901.pphosted.com with ESMTP id 34e161g43p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 11:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX4Lh5Aj+s5v5m+MOG9xx2lmXX/y7eWZBUKSyq9+s0b/suMypu3FtxqZJg8NMhAlQIUhkyKL7Yo/CB63/E03ZNzrFFKpWAwjuL9MfBh0rzC9QzxGzl2rDLcvTLj3ftItns1tZ70tDWcvx1tm0VcjH8q8agvpyVAmpPLfviom92mJeijI/xXNEeO8JsR3YsB7yocU2zdicIr6qeKtf6KRKOV+76nqj7/2g8I3mg56kU7ujhzEiUOcAkl4xeSwWKxnkYc3Z/5ezx4wdjLzwxf0BSiV4UsvHccv/e81u3oxcWNCT6ggtbfWTMgHXWRf1GC4PtOUiUptFC5oeEdzASR0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cgYTowMLsLulpZqxmQ/IS8IkeCUXdwt93CYFLHW/Uc=;
 b=BoyFXMbe652T8bH330j46tFkA7yFKmyMPdq8FuxMZ9sG1MWSJ07vjjDXZ9BKheYe+aen3hFHCHUd8HU1/avkxqb1dtalX/QmQuWHp6P2WIRDD9mIru6TwB/WO/6mJq5x7mZurhw5pgK0k7JoEdVF5ixh2Y0U3wUJCND6eaRCUU1HnlVTgIfb6kbF2vuX4mDuV/TsHVC6fy7xFV8vuXsG7Lq7Ohow5uI6t/UkqTe8gsSwnzyvPXlsYx8cAdVwPaT7y+wMcLFE9kOoafB3oSjDehiuMXcJ/4EbDN+xlUJ2tGVcENEoVzbPzKVN48WqI9firCYMxKz+MsJUE97THJfuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cgYTowMLsLulpZqxmQ/IS8IkeCUXdwt93CYFLHW/Uc=;
 b=AO/lUoWYn4I19XWhY0+tU0TjdFYyQSbW65odKMIeIt0YUk2xQiYuM+zDH8sk13oAEJWljual4cusbR4ZknjjVEwYcyKt5QyFfQ+z6k6PfqNHWbE0ZU5953TWu17XiuG42uwC5s2wwXokD7zuTKP4qhc0w7W7CwrFbcfQMZxB3RA=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR1901MB2117.namprd19.prod.outlook.com (2603:10b6:4:a6::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 15:39:35 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 15:39:34 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH v6] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Topic: [PATCH v6] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Index: AQHWm7qb+Fl+xPp0qE6t08FS2LR06KmqE3oAgAARPYA=
Date:   Mon, 26 Oct 2020 15:39:34 +0000
Message-ID: <DM6PR19MB26367BCFE51C45BC00D13F6BFA190@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201006082618.209287-1-divya.bharathi@dell.com>
 <101db8e3-70f0-4e85-b4b9-008995939b1a@redhat.com>
In-Reply-To: <101db8e3-70f0-4e85-b4b9-008995939b1a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-26T15:39:30.6439617Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=c12848c9-2e22-40f7-9c4b-8f6f8e7dd7cc;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00c0c144-ae75-423d-d889-08d879c55718
x-ms-traffictypediagnostic: DM5PR1901MB2117:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1901MB2117C10E468EA9F73DEA378CFA190@DM5PR1901MB2117.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X16GW+b98zMhouBcebuseVFUSpcn0u9qkRZ2fAg+lCoaGJvWyENhAOgWtKPRxwPSSqfmpkD9Qcxjf+h1e0pcC1dmVjJ9kKjxxhuba5EG/Icy1xI4o2RBKM1CoExxkJ1io1eqDULyZT9wq4B90t1DIX2sJnx2srvoNIHyRdfB0WphfhvT33EOFIWo4V3AFVR4rkhzbJaGYft9Kb93kHjxaPCYCSMBJlx8DQjIitrdPBjCVkM2Mnj5V06v2NN81M3zRb5Jqx//3bk5VKanBYBNcxdifJzId6ZCxZ5G2Iu4hNs/+9UVb7boMAlLI+a98Hgj9U1B5ojarrsxt0AOFG8B0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(316002)(6506007)(86362001)(478600001)(66476007)(64756008)(54906003)(186003)(83380400001)(66446008)(66556008)(76116006)(66946007)(26005)(7696005)(2906002)(8936002)(786003)(8676002)(4326008)(55016002)(71200400001)(9686003)(5660300002)(52536014)(107886003)(110136005)(33656002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JyLTGB8w4152JgSA/QKPlYTgleOA3gcViIU0VUHtwCFpx7afyLcdUSXcJ/eaAT0vnvN8z+2pJ5gb1wZoyExnNgk/uEsl16j8Nd4dsWwYUDfpo7mFPlQiR5ZvGbPgqALr/h6rNVerrfZww/Ddrr9j3DUbcrpR01IWt72RddOOtLxv7v2kJSKfgYc+k1x4+Ck9jxMIxmE22UglApiRDPFyRR/cm9IVhhYmjixwreRAatZIIRw4zwm5enP0x47QqmaJWeefXVwl4TPrbbHsusi+u6nt74cur5FOFEVzOOkQiJdLNjDmvzpT/Vs0fjNjlI6uSBng/jnUHez9mtIqial5dV4HZ2lBqSuQx4n5Xlean2gFtnLnBZXxx8NqVYR4KmX9CRcJWfBIT8PrfAu0bSyMvqVrGaXOOdpR6rVKoTOTiFvPPxYTU4b3bf723q0NdA45ocKT02NVyOzrDT4nzcBqc70rtGu6YT/d1tU9EbM4Qh2pKy2/1basBMnrnXo/y6kydic1yo3rsVOnUVey6GAuj0le9d8u4wJy3qb7pCo/jwYPDVX34ou8vhGdQ+CoI+163nv4i2cMSmC40h42x12eyIjkG3Iu77/Wmj8XR+QvH+bFIzW8W6oDJeFZnGbXCzxMhzVue9nu39lYGorxf+jMLw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c0c144-ae75-423d-d889-08d879c55718
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 15:39:34.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6TWktBq8qcc+Xbp4uudPbrGyR2KanWyZv5vOuxriZh9RzNWbLTupgk3r7D2CCzN3gCC4wRMA4W6x/hPIywbTSLsiS3CuguYHSrzSG1T6qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2117
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_08:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260108
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIHdhcyBwcmVzZW50IGluIHByZXZpb3VzIHZlcnNpb25zIHRvbywgYnV0IEkganVzdCBu
b3RpY2VkIHRoaXMgYXJlIHlvdQ0KPiBzdXJlIHRoYXQgdXNpbmcNCj4gLnN0cmluZy5wb2ludGVy
IGlzIGNvcnJlY3QgaGVyZT8gVGhhdCBzZWVtcyB3cm9uZyBzaW5jZSB0aGUgcG9pbnRlciBnZXRz
DQo+IGFsbG9jYXRlZCBieQ0KPiB0aGUgTGludXggQUNQSSBjb3JlLCBzbyBpdCBpcyBub3QgdW5k
ZXIgaW5mbHVlbmNlIG9mIHRoZSBBTUwgY29kZT8NCj4gDQo+IEkgdGhpbmsgeW91IHdhbnQgLyBu
ZWVkIHRvIHVzZSAiLmludGVnZXIudmFsdWUiIGhlcmUgPw0KPiANCj4gQW5kIG1heWJlIGZpcnN0
IGRvIGEgdHlwZSBjaGVjaywgZS5nLjoNCj4gDQo+IAlpZiAob2JqLT5wYWNrYWdlLmVsZW1lbnRz
W0NVUlJFTlRfVkFMXS50eXBlICE9IEFDUElfVFlQRV9JTlRFR0VSKSB7DQo+IAkJcmV0ID0gLUVJ
TlZBTDsNCj4gCQlnb3RvIG91dDsNCj4gCX0NCj4gDQo+IEFkZGluZyB0aGlzIHR5cGUgY2hlY2sg
d2lsbCBhbHNvIHNob3cgaWYgSSdtIHJpZ2h0IHRoYXQgeW91IHNob3VsZCB1c2UNCj4gLmludGVn
ZXIudmFsdWUgLi4uDQo+IA0KPiAJcmV0ID0gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlbGxk
XG4iLCBvYmotDQoNCldlJ2xsIG5lZWQgdG8gZG91YmxlIGNoZWNrIHRoaXMsIGJ1dCBJJ20gcHJl
dHR5IHN1cmUgdGhlIGZpcm13YXJlIG91dHB1dHMNCmV2ZXJ5dGhpbmcgYXMgYSBzdHJpbmcuDQoN
Cg0K

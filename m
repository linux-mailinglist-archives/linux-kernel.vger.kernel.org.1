Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622FA2731EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgIUS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:26:50 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:19338 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgIUS0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:26:49 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LINpR9016494;
        Mon, 21 Sep 2020 14:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=jR/cjSp/UIvUJjAqoaZRhu8TTeZgYiu83nbpySdKArs=;
 b=qDyOnHmJxuD/jYswrbPN7r+xnh5nNFIp7iywisv99FOAS8ii4UiW/6I2WHmyPF/z1eTT
 dtldCR/J9pUG28SB/uOgxhx667pVgVQMXNPFwTctxkdNCqweLmpfY1Wb4xZRxHrBWjm4
 +OB7epbfusLL7TIqEAcO3Vw0lz/Lf4aG55w1hbqq3tS5CBG4M86gXuVkI+sSub4vJ2Ge
 H7ZuiO4gH8wv9fmdRVYJ/yH67elWYb+tI0BhLV49lNWKPZgZfOJrXzXrRftK3bZFHShR
 U1UVq69b6Z8gAhi4ivctxQ2y7Ry+zimz61/M7TAlSiEfvg1M4wkgcActlDynjVhBZgZ2 oQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 33ndtxwmjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 14:26:42 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LIQWmN002080;
        Mon, 21 Sep 2020 14:26:42 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0b-00154901.pphosted.com with ESMTP id 33nxtcdjuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 14:26:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlVCHr3LrDLLh/Qff4yUB5OgFJ10jBvwoNG7Qbw0djL1zxZ7W63fMXQfe1uWm4HzSiQ863woEIFdsX77WcsXWFb9oSK9OK+duhrQmDqJDZGEdK3YNW3zYERH8QURqNCsBXuyQsdNJJuHWUO+j6xWqIWJ/gR5vXoar5qRxX7Pj+ablTUfR+MjX/E1rH4IalA3YBN5Wq+fdfDVq0rcvT/o3u48FtH6pLSi8KiwkPIiZofs3URt2NbXRsySw+1G4egpj/i4tO+TuCcEFcGewMOvj9Nc1IjgZKQ3J8HgTWKifiI+sXPY82cFhuKd31fC7KqKEDNkbrAkMtGiN8l/VOZEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR/cjSp/UIvUJjAqoaZRhu8TTeZgYiu83nbpySdKArs=;
 b=RvusNWG99LtSfsRQyHLlOBfVKpjWBQ05BDAwwlZuA/dfVdQdCXfIW5epX5fOjT7MDdhcIsRYg6YvXlpsAIOYscTrh/Vl9+Qp5F5gurlHCiVSCcK82kJR4nOZbyesymG/k6ZZFSwG0McIrOmyjfuwzZ7YESdkwoX0Uge7gTQb7eZPV1VWTXoMwcfm9HftmMW3ZaoL6oboJjwonFQCANg6ZSMDc6gRRek442L8QdJz6+zRQvmnkKxcqvG41GARpmSH7QNCAyhRvXDpIGrJzaVR59Y/iZ5IDFi7t4Ch19U8N3T9olfxzfNN6t22GE/iZyetmHCwyO6S6zcCZaCbrIQscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR/cjSp/UIvUJjAqoaZRhu8TTeZgYiu83nbpySdKArs=;
 b=hkVT42pKzfxpDwyuH3B4fJ/Qh7k5YhtmRxSKB5k5qV3V92zbHj8lVYsi+JL4SVH1Xo19xLIAI43MCEt+WE3waSTUNAABREm2zoenzcxeY7wfy6apVYuxHuRFz4Cw37jDkrwONBPMT8/PTa9J8Cefld7o1zVhYjacwEk1zuTw+cc=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3066.namprd19.prod.outlook.com (2603:10b6:5:187::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 18:23:11 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 18:23:11 +0000
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
Subject: RE: [PATCH v3] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Topic: [PATCH v3] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Index: AQHWjL/dre3txKvXR0eFHGaek7GAw6ly8ooAgAB5WaA=
Date:   Mon, 21 Sep 2020 18:23:11 +0000
Message-ID: <DM6PR19MB26361E423C4430923850E1DCFA3A0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200917065550.127400-1-divya_bharathi@dell.com>
 <2795ca15-59b1-8435-14ef-6e0c1d532b22@redhat.com>
In-Reply-To: <2795ca15-59b1-8435-14ef-6e0c1d532b22@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-21T18:18:57.5272191Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=2cd2f209-6dde-40ea-b2cc-8d31c64ce530;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 513b61af-ae64-44ae-4e04-08d85e5b65f0
x-ms-traffictypediagnostic: DM6PR19MB3066:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB30666D390555172F717895B9FA3A0@DM6PR19MB3066.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6oyDLf745aCNNkVEvBvx6L5i45cdPBlndugPY0LiXvB3tJVEFfMR493RiMq27m1pPI+J5pR1PKwklMktOJKgpqUber1JBv7nogbRg7k2dFO4XRfGa/ZSXu3GdeGiUcGodlpsfrce7AQlJ/Wb5Z/uAuM26eNrwpad+qjA2m54kcXhL6g1LlprfRyYGGjEAtUGee2KA+XkAXu1UjUGa4olz4rnRt/M9pPWIIiAAVlEeUbNgHBvGPoHO2CCSr95HRtDMldCH8RNOQOedGTCqG13FEjxSEU+gTpxy/hJQEa7uKhYMbYhi525q+1rx87El+U1Ux6FPvg3J24k8GtHS/R365+j0diGJUzHoQgDzQXblpj2wKEOILHGGYzMgoqOz993j6tvjM5jbm1OVx6k3Dteg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(54906003)(8676002)(64756008)(66556008)(66446008)(66476007)(76116006)(26005)(478600001)(33656002)(83380400001)(8936002)(66946007)(966005)(107886003)(9686003)(2906002)(4326008)(7696005)(86362001)(6506007)(52536014)(186003)(316002)(110136005)(786003)(5660300002)(71200400001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SZo1YSlV90S1jOokVMJ1UhvbD/kzFt/AYW/o0+uEU/LIXIryUT5oqYJFW3+LLs6woxeijhizL7gg3LGXXkVFZ7Rs2IFw8Sxb3lCQ+CO9uKn8jXo03+K8Woyplh7U3QlGHqdJXKDFpuU/ePcn/rthNolrMlEWD6jl/F9E2lg0ydAvQNnDBgpKlSMSUNhqET0u/j8cgPzBp0deBwb/vRJxy9oMpH8a8pjoTeAoRnq8QMbbz3CgwEq6k3b53ljeNt4rH5cqi4hcjmdx4e0iyUUDgSUSCc5kBTRgfQjtv5FeiN+SpDnMitaK7VPojbloWoJpf/ay1kvVAgCsAV2tGe3TZgpeJPcuZcpnIq1vWeHNV8sUsBq30Cw7+pTEeKa2s5fDDRTxYpjjG5CH51jxa82P4IQUY4vdNQ4xXGUpoZ/GEY3EGcFgeATD7VdV/9JOZgjVbKsV35iMue+3NgmYkKZ9OYXRor0S5Reu1bVKp7MZKdTvKqGHzCwMK0nE3C/qiLrGeR1yv9Ip356MHNwHd0gx8Gnen/0av9MoRSE81+YqxZiLgzRTRai/BSitqk7Jq2zKCJ+cMfyCvAZrtGSZFVHNPo5lqfWIC/MAXFY6m+AmTpYLuagqPGRKFryZHon1hN2QJ9mstxipljMUV60W2rKcqA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513b61af-ae64-44ae-4e04-08d85e5b65f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 18:23:11.6878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HJV4zv2Eevfu276K+FydHH5V3lqq8n0TpvLLSzx2y8tO+PDbZBKBPkVuK/uRewPJF4DGdoNY7dCMYh6CzrhRfZGl7YV9o4ICzUlMJwcAEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3066
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_08:2020-09-21,2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009210131
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiArDQo+ID4gKwkJImludGVnZXIiLXR5cGUgc3BlY2lmaWMgcHJvcGVydGllczoNCj4g
PiArDQo+ID4gKwkJbWluX3ZhbHVlOglBIGZpbGUgdGhhdCBjYW4gYmUgcmVhZCB0byBvYnRhaW4g
dGhlIGxvd2VyDQo+ID4gKwkJYm91bmQgdmFsdWUgb2YgdGhlIDxhdHRyPg0KPiA+ICsNCj4gPiAr
CQltYXhfdmFsdWU6CUEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbiB0aGUgdXBwZXIN
Cj4gPiArCQlib3VuZCB2YWx1ZSBvZiB0aGUgPGF0dHI+DQo+ID4gKw0KPiA+ICsJCXNjYWxhcl9p
bmNyZW1lbnQ6CUEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbiB0aGUNCj4gPiArCQly
ZXNvbHV0aW9uIG9mIHRoZSBpbmNyZW1lbnRhbCB2YWx1ZSB0aGlzIGF0dHJpYnV0ZSBhY2NlcHRz
Lg0KPiA+ICsNCj4gPiArCQkic3RyaW5nIi10eXBlIHNwZWNpZmljIHByb3BlcnRpZXM6DQo+ID4g
Kw0KPiA+ICsJCW1heF9sZW5ndGg6CUEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbiB0
aGUgbWF4aW11bQ0KPiA+ICsJCWxlbmd0aCB2YWx1ZSBvZiB0aGUgPGF0dHI+DQo+ID4gKw0KPiA+
ICsJCW1pbl9sZW5ndGg6CUEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbiB0aGUgbWlu
aW11bQ0KPiA+ICsJCWxlbmd0aCB2YWx1ZSBvZiB0aGUgPGF0dHI+DQo+ID4gKw0KPiA+ICtXaGF0
OgkJL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2RlbGwtd21pLXN5c21hbi9wYXNzd29yZHMvDQo+ID4g
K0RhdGU6CQlEZWNlbWJlciAyMDIwDQo+ID4gK0tlcm5lbFZlcnNpb246CTUuMTANCj4gPiArQ29u
dGFjdDoJRGl2eWEgQmhhcmF0aGkgPERpdnlhLkJoYXJhdGhpQERlbGwuY29tPiwNCj4gPiArCQlN
YXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AZGVsbC5jb20+LA0KPiA+ICsJCVBy
YXNhbnRoIEtTUiA8cHJhc2FudGgua3NyQGRlbGwuY29tPg0KPiA+ICsNCj4gPiArCQlBIEJJT1Mg
QWRtaW4gcGFzc3dvcmQgYW5kIFN5c3RlbSBQYXNzd29yZCBjYW4gYmUgc2V0LCByZXNldCBvcg0K
PiA+ICsJCWNsZWFyZWQgdXNpbmcgdGhlc2UgYXR0cmlidXRlcy4gQW4gIkFkbWluIiBwYXNzd29y
ZCBpcyB1c2VkIGZvcg0KPiA+ICsJCXByZXZlbnRpbmcgbW9kaWZpY2F0aW9uIHRvIHRoZSBCSU9T
IHNldHRpbmdzLiBBICJTeXN0ZW0iIHBhc3N3b3JkDQo+IGlzDQo+ID4gKwkJcmVxdWlyZWQgdG8g
Ym9vdCBhIG1hY2hpbmUuDQo+ID4gKw0KPiA+ICsJCWlzX3Bhc3N3b3JkX3NldDoJQSBmaWxlIHRo
YXQgY2FuIGJlIHJlYWQNCj4gPiArCQl0byBvYnRhaW4gZmxhZyB0byBzZWUgaWYgYSBwYXNzd29y
ZCBpcyBzZXQgb24gPGF0dHI+DQo+ID4gKw0KPiA+ICsJCW1heF9wYXNzd29yZF9sZW5ndGg6CUEg
ZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbiB0aGUNCj4gPiArCQltYXhpbXVtIGxlbmd0
aCBvZiB0aGUgUGFzc3dvcmQNCj4gPiArDQo+ID4gKwkJbWluX3Bhc3N3b3JkX2xlbmd0aDoJQSBm
aWxlIHRoYXQgY2FuIGJlIHJlYWQgdG8gb2J0YWluIHRoZQ0KPiA+ICsJCW1pbmltdW0gbGVuZ3Ro
IG9mIHRoZSBQYXNzd29yZA0KPiA+ICsNCj4gPiArCQljdXJyZW50X3Bhc3N3b3JkOiBBIHdyaXRl
IG9ubHkgdmFsdWUgdXNlZCBmb3IgcHJpdmlsZWdlZCBhY2Nlc3MNCj4gPiArCQlzdWNoIGFzIHNl
dHRpbmcgYXR0cmlidXRlcyB3aGVuIGEgc3lzdGVtIG9yIGFkbWluIHBhc3N3b3JkIGlzIHNldA0K
PiA+ICsJCW9yIHJlc2V0dGluZyB0byBhIG5ldyBwYXNzd29yZA0KPiA+ICsNCj4gPiArCQluZXdf
cGFzc3dvcmQ6IEEgd3JpdGUgb25seSB2YWx1ZSB0aGF0IHdoZW4gdXNlZCBpbiB0YW5kZW0gd2l0
aA0KPiA+ICsJCWN1cnJlbnRfcGFzc3dvcmQgd2lsbCByZXNldCBhIHN5c3RlbSBvciBhZG1pbiBw
YXNzd29yZC4NCj4gPiArDQo+ID4gKwkJTm90ZSwgcGFzc3dvcmQgbWFuYWdlbWVudCBpcyBzZXNz
aW9uIHNwZWNpZmljLiBJZiBBZG1pbi9TeXN0ZW0NCj4gPiArCQlwYXNzd29yZCBpcyBzZXQsIHNh
bWUgcGFzc3dvcmQgbXVzdCBiZSB3cml0ZW4gaW50byBjdXJyZW50X3Bhc3N3b3JkDQo+ID4gKwkJ
ZmlsZSAocmVxdWllZCBmb3IgcGFzd29yZC12YWxpZGF0aW9uKSBhbmQgbXVzdCBiZSBjbGVhcmVk
IG9uY2UgdGhlDQo+ID4gKwkJc2Vzc2lvbglpcyBvdmVyLiBGb3IgZXhhbXBsZSwNCj4gPiArCQkJ
ZWNobyAicGFzc3dvcmQiID4gY3VycmVudF9wYXNzd29yZA0KPiA+ICsJCQllY2hvICJkaXNhYmxl
ZCIgPiBUb3VjaFNjcmVlbi9jdXJyZW50X3ZhbHVlDQo+ID4gKwkJCWVjaG8gIiIgPiBjdXJyZW50
X3Bhc3N3b3JkDQo+IA0KPiBTbyBJIGtub3cgdGhpcyB3YXMgbWVudGlvbmVkIGJlZm9yZSBhbHJl
YWR5IGJ1dCBvbmUgY29uY2VybiBJIGhhdmUgaGVyZQ0KPiBpcyB0aGF0IHRoZXJlIGlzIGEgcmFj
ZSB3aGVyZSBvdGhlciB1c2VycyB3aXRoIHdyaXRlIGFjY2VzcyB0byBzYXkNCj4gVG91Y2hTY3Jl
ZW4vY3VycmVudF92YWx1ZQ0KPiBtYXkgY2hhbmdlIGl0IGJldHdlZW4gdGhlIHNldHRpbmcgYW5k
IHRoZSBjbGVhcmluZyBvZiB0aGUgY3VycmVudF9wYXNzd29yZA0KPiBldmVuIGlmDQo+IHRoZXkg
ZG9uJ3QgaGF2ZSB0aGUgcGFzc3dvcmQuDQoNCkkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgbXVjaCB0
aGF0IGNhbiBiZSBkb25lIGhlcmUgb3RoZXIgdGhhbiBtb3ZlIHRvIHNvbWV0aGluZyBhdG9taWMN
Cmxpa2Ugc2VuZGluZyB0aGUgcGFzc3dvcmQgYXMgcGFydCBvZiB0aGUgcmVxdWVzdC4NCg0KZWNo
byAiZm9vYmFyMTIzfGVuYWJsZWQiIHwgc3VkbyB0ZWUgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2Rl
bGwtd21pLXN5c21hbi8NCg0KVGhhdCBpc24ndCByZWFsbHkgcHJldHR5IC0gYW5kIHdvcnNlIHlv
dSBjYW4gbm8gbG9uZ2VyIGhhdmUgYSBwcm9jZXNzIGZldGNoaW5nDQphdXRoZW50aWNhdGlvbiBm
cm9tIGVzY3JvdyB0aGF0IGlzIGRpZmZlcmVudCBmcm9tIHlvdXIgInNldHRlciIgcHJvY2Vzcy4N
Cg0KPiANCj4gVGhpcyBpcyBlc3AuIHJlbGV2YW50IHdpdGggY29udGFpbmVycy4gSSdtIG5vdCBh
d2FyZSBhYm91dCBhbGwgdGhlIGludHJpbnNpY3MNCj4gb2YNCj4gc3lzZnMgYW5kIGNvbnRhaW5l
cnMsIGF0IGEgbWluaW11bSB3ZSBuZWVkIHRvIGNoZWNrIGlmIGl0IGlzIHBvc3NpYmxlIHRvDQo+
IGRpc2FsbG93DQo+IGFsbCB3cml0ZXMgdG8gdGhlIGF0dHJpYnV0ZXMgd2hlbiBzeXNmcyBpcyBt
b3VudGVkIGluc2lkZSBhIGNvbnRhaW5lciAoc28NCj4gb3V0c2lkZSBvZiB0aGUNCj4gbWFpbiBm
aWxlc3lzdGVtIG5hbWVzcGFjZSkuDQoNCkNvbnRhaW5lcnMgYnkgZGVmYXVsdCBtb3VudCBzeXNm
cyBhcyByZWFkIG9ubHkgdW5sZXNzIHlvdSB1c2UgdGhlICctLXByaXZpbGVnZWQnDQpmbGFnLg0K
DQpodHRwczovL3d3dy5yZWRoYXQuY29tL3N5c2FkbWluL3ByaXZpbGVnZWQtZmxhZy1jb250YWlu
ZXItZW5naW5lcw0KDQo+IA0KPiBJZiBzb21lb25lIGlzIHJlYWRpbmcgYWxvbmcgd2hvIGhhcHBl
biB0byBrbm93cyB0aGlzLCBwbGVhc2UgZW5saWdodGVuIG1lIDopDQo+IA0KPiA+ICsNCj4gPiAr
DQo+ID4gK1doYXQ6CQkvc3lzL2RldmljZXMvcGxhdGZvcm0vZGVsbC13bWktc3lzbWFuL2F0dHJp
YnV0ZXMvcmVzZXRfYmlvcw0KPiA+ICtEYXRlOgkJRGVjZW1iZXIgMjAyMA0KPiA+ICtLZXJuZWxW
ZXJzaW9uOgk1LjEwDQo+ID4gK0NvbnRhY3Q6CURpdnlhIEJoYXJhdGhpIDxEaXZ5YS5CaGFyYXRo
aUBEZWxsLmNvbT4sDQo+ID4gKwkJTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxv
QGRlbGwuY29tPiwNCj4gPiArCQlQcmFzYW50aCBLU1IgPHByYXNhbnRoLmtzckBkZWxsLmNvbT4N
Cj4gPiArRGVzY3JpcHRpb246DQo+ID4gKwkJVGhpcyBhdHRyaWJ1dGUgY2FuIGJlIHVzZWQgdG8g
cmVzZXQgdGhlIEJJT1MgQ29uZmlndXJhdGlvbi4NCj4gPiArCQlTcGVjaWZpY2FsbHksIGl0IHRl
bGxzIHdoaWNoIHR5cGUgb2YgcmVzZXQgQklPUyBjb25maWd1cmF0aW9uIGlzDQo+IGJlaW5nDQo+
ID4gKwkJcmVxdWVzdGVkIG9uIHRoZSBob3N0Lg0KPiA+ICsNCj4gPiArCQlSZWFkaW5nIGZyb20g
aXQgcmV0dXJucyBhIGxpc3Qgb2Ygc3VwcG9ydGVkIG9wdGlvbnMgZW5jb2RlZCBhczoNCj4gPiAr
DQo+ID4gKwkJCSdidWlsdGluc2FmZScgKEJ1aWx0IGluIHNhZmUgY29uZmlndXJhdGlvbiBwcm9m
aWxlKQ0KPiA+ICsJCQknbGFzdGtub3duZ29vZCcgKExhc3Qga25vd24gZ29vZCBzYXZlZCBjb25m
aWd1cmF0aW9uIHByb2ZpbGUpDQo+ID4gKwkJCSdmYWN0b3J5JyAoRGVmYXVsdCBmYWN0b3J5IHNl
dHRpbmdzIGNvbmZpZ3VyYXRpb24gcHJvZmlsZSkNCj4gPiArCQkJJ2N1c3RvbScgKEN1c3RvbSBz
YXZlZCBjb25maWd1cmF0aW9uIHByb2ZpbGUpDQo+ID4gKw0KPiA+ICsJCVRoZSBjdXJyZW50bHkg
c2VsZWN0ZWQgb3B0aW9uIGlzIHByaW50ZWQgaW4gc3F1YXJlIGJyYWNrZXRzIGFzDQo+ID4gKwkJ
c2hvd24gYmVsb3c6DQo+ID4gKw0KPiA+ICsJCSMgZWNobyAiZmFjdG9yeSIgPiBzeXMvZGV2aWNl
cy9wbGF0Zm9ybS9kZWxsLXdtaS0NCj4gc3lzbWFuL2F0dHJpYnV0ZXMvcmVzZXRfYmlvcw0KPiA+
ICsNCj4gPiArCQkjIGNhdCBzeXMvZGV2aWNlcy9wbGF0Zm9ybS9kZWxsLXdtaS1zeXNtYW4vYXR0
cmlidXRlcy9yZXNldF9iaW9zDQo+ID4gKwkJIyBidWlsdGluc2FmZSBsYXN0a25vd25nb29kIFtm
YWN0b3J5XSBjdXN0b20NCj4gPiArDQo+ID4gKwkJTm90ZSB0aGF0IGFueSBjaGFuZ2VzIHRvIHRo
aXMgYXR0cmlidXRlIHJlcXVpcmVzIGEgcmVib290DQo+ID4gKwkJZm9yIGNoYW5nZXMgdG8gdGFr
ZSBlZmZlY3QuDQo+ID4gKw0KPiA+ICtXaGF0OgkJL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2RlbGwt
d21pLQ0KPiBzeXNtYW4vYXR0cmlidXRlcy9wZW5kaW5nX3JlYm9vdA0KPiA+ICtEYXRlOgkJRGVj
ZW1iZXIgMjAyMA0KPiA+ICtLZXJuZWxWZXJzaW9uOgk1LjEwDQo+ID4gK0NvbnRhY3Q6CURpdnlh
IEJoYXJhdGhpIDxEaXZ5YS5CaGFyYXRoaUBEZWxsLmNvbT4sDQo+ID4gKwkJTWFyaW8gTGltb25j
aWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGRlbGwuY29tPiwNCj4gPiArCQlQcmFzYW50aCBLU1Ig
PHByYXNhbnRoLmtzckBkZWxsLmNvbT4NCj4gPiArRGVzY3JpcHRpb246DQo+ID4gKwkJQSByZWFk
LW9ubHkgYXR0cmlidXRlIHJlYWRzIDEgaWYgYSByZWJvb3QgaXMgbmVjZXNzYXJ5IHRvIGFwcGx5
DQo+ID4gKwkJcGVuZGluZyBCSU9TIGF0dHJpYnV0ZSBjaGFuZ2VzLg0KPiA+ICsNCj4gPiArCQkJ
MDoJQWxsIEJJT1MgYXR0cmlidXRlcyBzZXR0aW5nIGFyZSBjdXJyZW50DQo+ID4gKwkJCTE6CUEg
cmVib290IGlzIG5lY2Vzc2FyeSB0byBnZXQgcGVuZGluZyBCSU9TIGF0dHJpYnV0ZQ0KPiBjaGFu
Z2VzDQo+ID4gKwkJCQlhcHBsaWVkDQo+ID4gKw0KPiA+ICsNCj4gPiArCQlOb3RlLCB1c2Vyc3Bh
Y2UgYXBwbGljYXRpb25zIG5lZWQgdG8gZm9sbG93IGJlbG93IHN0ZXBzIGZvcg0KPiBlZmZpY2ll
bnQNCj4gPiArCQlCSU9TIG1hbmFnZW1lbnQsDQo+ID4gKwkJMS4JQ2hlY2sgaWYgYWRtaW4gcGFz
c3dvcmQgaXMgc2V0LiBJZiB5ZXMsIGZvbGxvdyBzZXNzaW9uIG1ldGhvZA0KPiBmb3INCj4gPiAr
CQkJcGFzc3dvcmQgbWFuYWdlbWVudCBhcyBicmllZmVkIHVuZGVyIHBhc3N3b3JkIHNlY3Rpb24g
YWJvdmUuDQo+ID4gKwkJMi4JQmVmb3JlIHNldHRpbmcgYW55IGF0dHJpYnV0ZSwgY2hlY2sgaWYg
aXQgaGFzIGFueSBtb2RpZmllcnMNCj4gPiArCQkJb3IgdmFsdWVfbW9kaWZpZXJzLiBJZiB5ZXMs
IGluY29ycG9yYXRlIHRoZW0gYW5kIHRoZW4gbW9kaWZ5DQo+ID4gKwkJCWF0dHJpYnV0ZS4NCj4g
DQo+IE9LLCBzbyBhcyBhbHNvIG1lbnRpb25lZCBpbiB0aGUgdjEgdGhyZWFkLCBJIHdvdWxkIGxp
a2UgdG8gc2VlIHRoZSB1ZXZlbnQNCj4gZGlzYXBwZWFyDQo+IHNpbmNlIGl0IGlzIHNvbWV3aGF0
IG9mIGEgaGVhdnkgbWVjaGFuaXNtIGFuZCBub3QgbmVjZXNzYXJ5IHdoZW4gdXNlcnNwYWNlDQo+
IHNwZWNpZmljYWxseQ0KPiBjYXJlcyBhYm91dCBhIHNpbmdsZSBzeXNmcyBhdHRyaWJ1dGUgY2hh
bmdpbmcuDQo+IA0KPiBJbnN0ZWFkIHdlIGNhbiBhbGxvdyB1c2Vyc3BhY2UgdG8gdXNlIHBvbGwo
KSBmb3IgUE9MTF9QUkkgb24gdGhpcyBmaWxlIHRvIGJlDQo+IG5vdGlmaWVkDQo+IHdoZW4gaXQg
Z29lcyBmcm9tIDAgLT4gMS4gU2VlIHRoZSB2MSB0aHJlYWQgZm9yIHNvbWUgZXhhbXBsZSBjb2Rl
IGhvdyB0byB3YWtlDQo+IHRoZQ0KPiBwb2xsKCkgaW4gdGhpcyBjYXNlLg0KPiANCj4gUmVnYXJk
cywNCj4gDQo+IEhhbnMNCg0K

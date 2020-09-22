Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239B02748F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVTSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:18:40 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:59234 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:18:39 -0400
X-Greylist: delayed 4530 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 15:18:38 EDT
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MHsqA4027149;
        Tue, 22 Sep 2020 14:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=YqXOoMHm73720qzMnyQE4t7TE3afBut8vfQAwPYeZZo=;
 b=VdVkziW8kZ42FkeL6NI58e+AOwsDLwZQmyqbNukSBk7EgMq8op7xcgwRESuCEjjs5+IL
 Hj1MjI54UTjuuP3ThLXPbzo4cV8aNSZYBBs1ER/PNrSEvXZUm5+qZGoD7YJyyezWI2X9
 s9BzNDEOYKL+Hce5YNum4QKpdoyDnqoaokE2frokQHAs3hnI2vIxP//6pPMwNkXoPJxB
 JwtUEEvFnw/97/yu9A6k26Pst3fiCNOfu3ZwGbUXwIKG9zohYod733KlVB45kYFT9lxR
 OE/6c49Odr1FkOL8/8aMLyfvCvUFyFcZ6LThFyiQv/OAopVwns6qT8dOlkmR75Uqa5gf gA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 33nd5da5ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 14:02:57 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MHxXXP062567;
        Tue, 22 Sep 2020 14:02:56 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-00154901.pphosted.com with ESMTP id 33qmj29w89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 14:02:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7HqWnswXdfgQd2vZdCtm8uiBaB2yygnFB/q9QfQQyO5MJnhs17WgZgo/yXYPH+GWyqhvD9Knd/vvLNVy7UNtXwNURUdaNKGjBdv7L+jpH4t9Myq42dhxjWib25joIvn0FVNmuI05nJenoSY6AG1rm4nZ/BS1+91MKh6x4Vi/sJIMSm9j36wWWED4H/k3oNrSwckFs1A+qhP6gdgBllk5O2D9HCtWOYEqVapzWpGUKe+u/WkB7lTNcqus2pIE/nS06ybGvfMSX89ptMuaC+YrfU4a5u/7SahRVh6tpKnSTdz13xHg1r+iEBXIVH/rY+003p5xuVzUP3YiVOkQ+FteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqXOoMHm73720qzMnyQE4t7TE3afBut8vfQAwPYeZZo=;
 b=jHJla1KgklM4E5YbOGoOGhYkUEh2AXuxjZM5DCqkLc6D3TqeZJXoCHiNQzxDVDd77x/bwelMxR0DOmKuloDszI1gFfN86E9QJ9HMe96RrAd17vNNFhFgzVYAvEIrnsyT64J3WIku9xuNVNWgvFx3sztJs0qSNM8dKr8zGkZcdXFhYl6m0RkQ7PpzCSYuQDVS1J1z24I+mGIgKupPoMDKyZyP3OoWccnqpDcLlL8d5Z2Y0oWFf23lC4lL29nCfff9DpD9d+KUvrvp9l9o2/OIXFVK2B4tA/HJ3o+itkYdCXL092hRmP/hx8X7y3WzcP+OPbiwRirznX7SiLaUYOKa/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqXOoMHm73720qzMnyQE4t7TE3afBut8vfQAwPYeZZo=;
 b=FepE8SPyzDvj8XmlNrw0OwC/CnnbwWgK53T7+ud4lEqaEtFrMzBu4XO3GqeSXE64Mmn0aU49PNfFrMoFB/Wm34FKLXue7YS7G4+yVI7PrzXpw9UphjZ+X2bjRGeKwVgrQtU/WhpWSga1svPLjg9GKa+H/OjPktzHvUh/H1JIJTQ=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3802.namprd19.prod.outlook.com (2603:10b6:5:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 22 Sep
 2020 18:02:54 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 18:02:54 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        Richard Hughes <rhughes@redhat.com>,
        Jared Dominguez <jaredz@redhat.com>
Subject: RE: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Topic: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Index: AQHWZn4rqCTeVrGp2k+MCJMiO1QTGalTvXYAgBRkaN2AAGzIkIAEWlCAgABEH2CABgKtAIAAUMlAgAEvSoCAAATcgIAAkmEA
Date:   Tue, 22 Sep 2020 18:02:54 +0000
Message-ID: <DM6PR19MB263605096186885BF90680E3FA3B0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <d3de1d27-25ac-be43-54d8-dcbfffa31e1d@redhat.com>
 <DM6PR19MB26364970D0981212E811E1B0FA2E0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <67ca316a-227f-80f6-ad22-7d08112b2584@redhat.com>
 <DM6PR19MB26368BB2B8C4D7CE58DF7C31FA230@DM6PR19MB2636.namprd19.prod.outlook.com>
 <5847917c-2c34-5d74-b5db-f33bb8fc9e13@redhat.com>
 <DM6PR19MB2636626A94385EDC7C0CACF9FA3E0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <33666ec6-be47-2c33-d4c5-6b23b53f6185@redhat.com>
 <DM6PR19MB263615C1060108E5661AE615FA3A0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <52fb287e-e683-63bc-3641-90abd78c605a@redhat.com>
 <01c6632a-4e21-dfc0-c5d8-42a7016bfa16@redhat.com>
In-Reply-To: <01c6632a-4e21-dfc0-c5d8-42a7016bfa16@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-22T18:02:50.7306347Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=8cc7d4da-0e2b-453a-9ec4-2f7757e9b0c2;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dbb5eee-b9f0-40ab-3278-08d85f21baf1
x-ms-traffictypediagnostic: DM6PR19MB3802:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB3802669E39E2D8495A0E4A66FA3B0@DM6PR19MB3802.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ek0J50PhVhyIRQ54T48kCqD/kdhILE+ymBEgSkZjjBLiMbtPahcEEAWMPAN1S5yQ8jOiky5ac64OLCWbmw1Eb356XhHE2FQD9LYZravsM9IrGxRZf6Wg9TixBl/zI2WXt+6fZcFGoR2gx7DQFCI/mTe8SjnZ7X2U1j7nxyKtMN2s6lVOFclKQ3OMPiWoAa2BFklZJJb5rmpaLTVZ8bmpCJg1t5rl+hzr3J6WP6IwepgRRCn2aoj9Cj38xvlNomY3l6eHVRP+i9LEAseeS68MesgWS881d2m6c+id+oeOtuXuChfZUoKtVxhViOuxJIhX+G1zWtncOCAGpVFzqRDroQdvb1OqiP6kdvwurQiJNTgLl2/8YXUCa+5Juf9ZrlIR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(52536014)(8676002)(4326008)(6506007)(71200400001)(7696005)(26005)(54906003)(478600001)(186003)(786003)(316002)(110136005)(33656002)(2906002)(86362001)(5660300002)(83380400001)(9686003)(66946007)(8936002)(66446008)(64756008)(66556008)(55016002)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YkNQ8qEAMl1XpO0kvRK8CgLHBAqAtYlWSQju1C5w9E+LvLJMoAUyUPQnWuRB6IDEk7qcKaGE44uZYV4r5NvO8FTiBXzVrunLbdprT2o/Dcx0rTkSXEFZBwMTW0Z1DZofHGcVkvgHTLB3RsVvSqCTOo/jg7F+0/Xe97cKMUlv9jdB6s9cBtsJwZKro28a3/XR/EuOU+VCFbYInJBt4+gMu8Sq4wew3hsi5eWcOn5a6eRAXqzKX44ujhBWTqPJxeh19hqjOJNT4Wsi0SDXsYhxBkhQesQgEj8s/to575ZrQdxl0v7XNJLpPpV4SPR2ybbnSURQua2bvkgknf/ukwnYjcsA0w4iyMM6muA5XVut1aEFtPYQfPeYHBR3z/5PaaS/ceAj6TzzIm9ssFO2agnwNqSQY2No80Yzwhlf8yHVadUSvTMtNXK2poSalFqLtfv0At72L9I236kwC7MB1H4RaE+rrOCcYEnJSmi3z3nHoLlnpgMWoXDAejaM0c+zYW+W1EaDEKwjvLaM6DK99bycaB99mQ29hmsp9Wj1YwnhQS0gPr1+gVDNStZ3y8Egc4DeRVWz1S/J5xOQ6c+a4nzPM76bCH/PgVtuF/1HUPhlzR8avWhieA+gWbL2KSpXUl1Zkk+3N+kxvaCL4cRj37AX4Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbb5eee-b9f0-40ab-3278-08d85f21baf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 18:02:54.6814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nPEqtbuBfB066S5oCECNzjce8iEhZEWQi9ypmKRlAD/E5cRiHsj8SHPPgZ9+zZlx/+PZ5kqke45ltta932SZEDcgBatUzsQS9Rb0Z55Va0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3802
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_17:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220141
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTbyBJJ3ZlIGJlZW4gdGhpbmtpbmcgbW9yZSBhYm91dCB0aGlzIGFuZCB0byBtZSB0aGlzIHdo
b2xlIGFyZ3VtZW50DQo+IHNvdW5kcyBhIGxvdCBsaWtlIHdlIGp1c3Qgd2FudCB0byBoYXZlIG91
ciBvd24gbGl0dGxlIGNvcm5lciB0bw0KPiBwbGF5IGluLCB3aXRob3V0IG5lZWRpbmcgdG8gd29y
cnkgYWJvdXQgd2hhdCBvdGhlciB2ZW5kb3JzIGRvLg0KPiANCj4gQW5kIHRoZW4gTGVub3ZvLCBh
bmQgSFAgYW5kIHdobyBrbm93cyBlbHNlIHdpbGwgYWxsIHdhbnQgdGhlIHNhbWUNCj4gYW5kIHdl
IGFuZCB1cCB3aXRoIGF0IGxlYXN0IDUgZGlmZmVyZW50IGludGVyZmFjZXMuDQo+IA0KPiBJdCBp
cyBiYWQgZW5vdWdoIHRoYXQgd2UgYWxyZWFkeSBoYXZlIHRvIGRlYWwgd2l0aCBoYXZpbmcgNSsN
Cj4gZGlmZmVyZW50IGZpcm13YXJlIGludGVyZmFjZXMgZm9yIHRoaXMgYW5kIHdvcnNlIGV2ZW4g
Zm9yIHNpbGx5DQo+IHRoaW5ncyBsaWtlIHNldHRpbmcgdGhlIGJyaWdodG5lc3MgbGV2ZWwgZm9y
IHRoZSBrYmQgYmFja2xpZ2h0LA0KPiB3aGljaCBpcyBzdWNoIGEgdHJpdmlhbCB0aGluZyB0aGF0
IHlvdSB3b3VsZCB0aGluayBQQyB2ZW5kb3JzDQo+IHNob3VsZCBiZSBhYmxlIHRvIHNpdCBkb3du
IGFuZCBhZ3JlZSBvbiBhIHNpbmdsZSBBQ1BJIEFQSSBmb3IgaXQuDQo+IA0KPiBXZSBhcmUgTk9U
IGdvaW5nIHRvIHRha2UgdGhpcyBsZXRzIGFsbCBkbyBvdXIgb3duIHRoaW5nIGFwcHJvYWNoIGFu
ZA0KPiBhbHNvIGxldCB0aGlzIHRyaWNrbGUgdXAgaW4gdGhlIHN0YWNrIHRvIHRoZSBrZXJuZWwg
PC0+IHVzZXJzcGFjZSBBUEkhDQo+IA0KPiBPbmUgb2YgdGhlIHRhc2tzIG9mIHRoZSBrZXJuZWwg
aXMgdG8gYWN0IGFzIGEgSEFMIGFuZCB0aGlzIGNsZWFybHkNCj4gZmFsbHMgdW5kZXIgdGhhdC4g
SW1hZ2luZSBpZiB1c2Vyc3BhY2UgY29kZSB3b3VsZCBuZWVkIHRvIHVzZSBkaWZmZXJlbnQNCj4g
a2VybmVsIEFQSXMgZm9yIHN0b3JhZ2UvZmlsZXN5c3RlbSBhY2Nlc3NlcyBkZXBlbmRpbmcgb24g
aWYgdGhleSB3ZXJlDQo+IHJ1bm5pbmcgb24gYSBEZWxsIG9yIGEgTGVub3ZvIG1hY2hpbmVzLiBP
ciBoYXZpbmcgZGlmZmVyZW50IEFQSXMgdG8NCj4gYWNjZXNzIHRoZSBuZXR3b3JrIGRlcGVuZGlu
ZyBvbiB0aGUgbWFjaGluZSB2ZW5kb3IuLi4NCj4gDQo+IFNvIEknbSBzb3JyeSwgYnV0IEknbSBk
cmF3aW5nIGEgbGluZSBpbiB0aGUgc2FuZCBoZXJlLCB1bmxlc3MgeW91IGNhbg0KPiBjb21lIHVw
IHdpdGggc29tZSByZWFsbHkgY29udmluY2luZyBORVcgYXJndW1lbnRzIHdoeSB0aGlzIG5lZWRz
IHRvDQo+IGJlIGEgRGVsbCBzcGVjaWZpYyBpbnRlcmZhY2UsIHRoZSBEZWxsIGZpcm13YXJlLWF0
dHJpYnV0ZXMgY29kZSBtdXN0DQo+IHVzZSBhIGdlbmVyaWMgc3lzZnMtQUJJL2NsYXNzIHRvIGdl
dCBhY2NlcHRlZCB1cHN0cmVhbS4NCj4gDQo+IE5vdGUgdGhhdCBJIHRoaW5rIHRoZSBjdXJyZW50
bHkgc3VnZ2VzdGVkIHByaXZhdGUgRGVsbCBBQkkgaXMgYWN0dWFsbHkNCj4gcHJldHR5IHN1aXRh
YmxlIGZvciBzdWNoIGEgZ2VuZXJpYyBzeXNmcy1BQkkvY2xhc3MsIHNvIEknbSBub3QgYXNraW5n
DQo+IHlvdSB0byBtYWtlIGEgbG90IG9mIGNoYW5nZXMgaGVyZS4NCj4gDQo+IFJlZ2FyZHMsDQo+
IA0KPiBIYW5zDQoNCldlJ2xsIHRyeSB0aGlzIGZvciB0aGUgdjQgcGF0Y2ggc2VyaWVzLiANCg0K

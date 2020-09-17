Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C334C26E804
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIQWPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:15:40 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:18064 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbgIQWPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:15:40 -0400
X-Greylist: delayed 21409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 18:15:38 EDT
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HGF4mp010694;
        Thu, 17 Sep 2020 12:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=d3eiDrteY+iZ3tWpsYY2LygDD+qqyVKAGWpY/yQUU5c=;
 b=wIHmzHeMLo904r+XDr22kOE8ZO0v0NY698CpuBdN5Zu51ekXj/9aHtMmtsH5tmjtUctV
 rPO4Y14y5bHzBMwepu6Q68OjSBRfA1Y7FYAFTpuQFz/ASo8mjub3wb6JWDSWszQj92oW
 Sl0slv0eUkMwEmlRrbqWezxq3QlReUcW9HcXcbcN+QqOroQHRmgtMIiMwKoUTtygmpmF
 PiKYjtAqe+CkorlSqfEa3W6Au3QnI2bPjiEOj1ywe9MNiYt4Y8PfmWKtOKT81GcRz4py
 A+oniytt2XeXQ0BQwqiIbN3/xMh002j7jZ0miW5t4yEi6jPGrFeSA0bPIMiG2iPEbHzW Xw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 33k5rhs3c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 12:18:38 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HGGDkQ031890;
        Thu, 17 Sep 2020 12:18:37 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00154901.pphosted.com with ESMTP id 33khedp7p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 12:18:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZskFNEKaNHYEsVtYbDpKbWkrwpZJd1VS5SYdfIIhgt2DoAD/vp5mqlRSp1iHU6LBcNAJ0SoHRZ91KznAdcTAOXC9RTJ+bwo8RJTQNAM6ma31ZEADaNbFxXDdsfzXH0Egn4Tfz7VNuwZrHekZxOw8QSPMrVCaZ0yXH565jze0RIM6TPKtURsz36Z7AZs64ax2xl3CXip5y4fQjFTch3/JaZ2soFJ79mAVuxIXQuZF5KOS0sezfWO/9xvA5mIgMNsO3SzyXwrBzNT7xX2Yfox9dGMw7xA8mPePRSYNPzliGGauBqFzLRMxAFnZ/iwx65QD6oZ1Ibi6lbZ+OY2VyoThEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3eiDrteY+iZ3tWpsYY2LygDD+qqyVKAGWpY/yQUU5c=;
 b=QgLOo4iTCD/0n6lzlEuyQjjlIZqB3nhRL6PddPwBhfRBlZ2wsm32cjq7Q9SbKdqk5L7kBhtLkuZuUbOnZGo5SiE0GX755swMeLanYW3SiB13VcdIMcgfSr82xmRH04I+EEtHbbsf9A58P9ZGeVyPunXYIKGB20NJfi1/4bryCj2dWhTHV0t3yH4iTz4pPXa7T1yrpJKZQgKe24jI9LxWqsgxuV7qOI9b3l7+ZtfLqIVMF6cX1NJf31vJ3cb+9UTfg64Jt0yfMwY3lLfzJwj++/0svrlg92OldLju4Kd+MQk0viFmRTXj/b+2lmrbI6/BJQL4kQ8KguJaFcBEh4/tUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3eiDrteY+iZ3tWpsYY2LygDD+qqyVKAGWpY/yQUU5c=;
 b=BnAsEQ+EneyQ3HYtgq8PtBumx/Sj9hvlVSe50jOcvN0SQjcdFywrGbK+BW13IdTqsqmpeGanHIcgad4vJ71z/YTGubYV/oi7y4jX0BgGQPbACig0tJW2PM/57zLY7/+YKq5b3E8xeeXhqKa4iUMBP9BA9shI1xwbcGtBuo5fc8A=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DS7PR19MB4502.namprd19.prod.outlook.com (2603:10b6:5:2c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 16:18:21 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 16:18:21 +0000
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
Thread-Index: AQHWZn4rqCTeVrGp2k+MCJMiO1QTGalTvXYAgBRkaN2AAGzIkIAEWlCAgABEH2A=
Date:   Thu, 17 Sep 2020 16:18:21 +0000
Message-ID: <DM6PR19MB2636626A94385EDC7C0CACF9FA3E0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <d3de1d27-25ac-be43-54d8-dcbfffa31e1d@redhat.com>
 <DM6PR19MB26364970D0981212E811E1B0FA2E0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <67ca316a-227f-80f6-ad22-7d08112b2584@redhat.com>
 <DM6PR19MB26368BB2B8C4D7CE58DF7C31FA230@DM6PR19MB2636.namprd19.prod.outlook.com>
 <5847917c-2c34-5d74-b5db-f33bb8fc9e13@redhat.com>
In-Reply-To: <5847917c-2c34-5d74-b5db-f33bb8fc9e13@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-17T16:18:19.4127817Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=d74dec9e-5493-40bf-bbe7-07edcaced075;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [2600:1700:70:f700:1d62:b3d8:75c:d49b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 713651fb-c220-4f58-9dfa-08d85b254baa
x-ms-traffictypediagnostic: DS7PR19MB4502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR19MB45026ECDCB3813A28DDF9AA3FA3E0@DS7PR19MB4502.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zat1HNEAISVfmS9uCCF5ViyvHWKDJUASN+KZQ/RazBedDFzEwQKMNn6VYL1dr5KAfx3dFNro0UDcbp3n7ymUD6BRXq3g3jzJ/qMYsnijm5vBG0drzwIgrJI7g7VtZwvISOvLBWdzLX854CrqI+4uZ+F/GORwZW1/sPK5wPtko5zqJDYihPa1FYKumQFqmM8TnAtmC7n5W06hVRzQ+4CkSABKfhuYdVPj7BOg9bVgwO1wOiCyPSDLTU7Gajhg8ISEddbhg+4THM8eYV3pPsO4HtdUNHXF888uJNf8UtB2OCqXhHmDYwwafwNT5vx0CwI5kQHdI8SxDLAKREgzcacdGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(136003)(39860400002)(83380400001)(8676002)(33656002)(4326008)(9686003)(8936002)(86362001)(55016002)(6506007)(66946007)(66446008)(64756008)(478600001)(786003)(2906002)(110136005)(66556008)(76116006)(66476007)(52536014)(7696005)(5660300002)(186003)(71200400001)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 94lIYrKDnJfwD7vfhW0QCQT2v66VT1Gxg4GzcpzQDy/J/nVnJe05UnenfPJZ7t+/blsfWUmC/ppWkx9Rf4stEDXboElkVjR4nj/QRkrBDmiRcbcwTFD9tC0p5faVDlsp23mJ0zgYYuZja55AW0fvMdv6LCGTEUQA2MWCVcpPo+4eGVDH097F8YrLkXzMhieGac9aMnUW4x9NiKopphHFlGGYZN2g5Xs/Ye2momVL9GlHkh1DtDI6aEo58Tu5G6An+gznMRZk+tFMzfwuk5skyAaBwMdDIFrI0jNG/EQy+zL8QJwTfjlhaKfTXl8a2Bst9DQBddfQAPNWIGI5Jv4qIBYa0ve8aN0dvE3fw8+u9XEOxq/+VrCCgGm8p7kCiPL22OcNuZhK1SW5R3QQ8DP4+qYvhHJyKbjngFzzlrUV0bOsX09mLq41Dm5T2l4xeY/aCWOhStzKle5RSx/hp7ZMo26r2g0qGVqL2MM1LgPZhiDwyIkFnUf3hIFNFyUUKbRFVlz/CEgpwo9N5heqNgUmO7jTmNCSlRvgwM3v/PwhRwPH8EBNGqU36EEUtHDi0cvJ/7lOejTweyeqy4JuJ1nfXPGQwrr5KKdotQ0fc3Ite8AKWffJwE6H+802gouA+r1mDznhVtmGZuDVYYVvrgDjdxTkrvhbjjZ6/qO4An0gINSDIu6AuqD55Q7cDh77sm2FCcIeDW3i525BFPqyT41OaA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713651fb-c220-4f58-9dfa-08d85b254baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 16:18:21.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sI8FlqVXnRSCgI6NJXEqkvEfEoXFDVhDZS915eV+BU0Rfs/g6fmyuw6VHyN+X+z1Ti/8wpJ5yq3uZXoxqd6F0yVbgoYxjd75XGkn5gqdL0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_11:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170122
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRob3NlIGFyZSB2ZXJ5IGRpZmZlcmVudCBmbG93cyB0byBnZXQgdG8gYW5kIGNoYW5nZSB0
aGUgc2FtZSAidHlwZXMiIG9mDQo+IGRhdGEuICBCeSBEZWxsJ3MgaW50ZXJmYWNlDQo+ID4gYmVp
bmcgRGVsbCBzcGVjaWZpYyB3ZSBjYW4gZ3VhcmFudGVlIHRoYXQgdGhlIGRvY3VtZW50ZWQgZmxv
dyB3b3JrcyBob3cgaXQNCj4gc2hvdWxkLg0KPiANCj4gRG9jdW1lbnRpbmcgdGhlIGZsb3cgY291
bGQgYmUgcGFydCBvZiB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgdGhlDQo+IGRpZmZlcmVudCBwYXNz
d2QgdHlwZXMuIA0KDQpJbiB0aGUgY29uY2VwdCBvZiBhICJnZW5lcmljIiBBUEkgSSBkb24ndCB0
aGluayB0aGUgd29yZCAicGFzc3dvcmQiIGlzIGZ1dHVyZXByb29mDQphbmQgaXQgd291bGQgbmVl
ZCB0byBiZSBhdm9pZGVkLiAgSSB0aGluayBhIGJldHRlciB0ZXJtIHdvdWxkIGJlICJhdXRoZW50
aWNhdGlvbiIuDQoNCj4gRm9yIGhvdyB0aGluZ3MgY3VycmVudGx5IHdvcmsgdGhlIFVzZXIgYW5k
DQo+IEFkbWluIHBhc3N3b3JkIGF0dHJpYnV0ZWQgd291bGQgaGF2ZSBhIHR5cGUgb2YgInBhc3N3
b3JkIiwgdGhlIGhhc2gNCj4gZXhhbXBsZSB5b3UgZ2F2ZSB3aWxsIGhhdmUgYSBkaWZmZXJlbnQg
dHlwZSBmb3IgaXRzIHBhc3N3b3JkIGF0dHJpYnV0ZSwNCj4gZS5nLiAiaG90cCIgYW5kIG5vdCBv
bmx5IHRoZSB0eXBlIGNvdWxkIGJlIGRpZmZlcmVudCBidXQgYWxzbw0KPiB0aGUgc3lzZnMtYXR0
cmlidXRlcywgZS5nLiB0aGUgIkFkbWluIiBwYXNzd29yZC1kaXIgd2hpY2ggaGFzIGEgInR5cGUi
DQo+IHN5c2ZzLWF0cnJpYnV0ZSB3aGljaCByZXR1cm5zICJodG9wIiBtYXkgbm90IGhhdmUgYSBj
dXJyZW50X3Bhc3N3b3JkDQo+IGF0dHJpYnV0ZSBhdCBhbGwsIGluc3RlYWQgaXQgbWF5IHdvdWxk
IGhhdmUgYSBoYXNoIGF0dHJpYnV0ZSwgbWFraW5nDQo+IGl0IChtb3JlKSBjbGVhciB0aGF0IHRo
aXMgb25lIHdvcmtzIGRpZmZlcmVudGx5Lg0KDQpJbiBvdXIgZGVmaW5pdGlvbiBgY3VycmVudF9w
YXNzd29yZGAgaXMgaW50ZW50aW9uYWxseSBub3QgcmVhZGFibGUgYnkgdXNlcnNwYWNlLg0KT25l
IHByb2Nlc3MgY291bGQgYmUgd3JpdGluZyBpdCAodGhpbmsgb2J0YWluaW5nIGl0IGZyb20gYW4g
ZXNjcm93IHNlcnZpY2UpIGFuZA0KYW5vdGhlciBpbnRlcmFjdGluZyB3aXRoIGF0dHJpYnV0ZXMs
IGFuZCB0aGVpciB0aHJlYXQgbW9kZWxzIG1pZ2h0IG5vdCBtYXRjaC4NCg0KRnVydGhlcm1vcmUg
LSB3aGF0J3MgdG8gc2F5IG11bHRpcGxlIGF1dGhlbnRpY2F0aW9uIHNjaGVtZXMgbWlnaHQgbm90
IGJlDQpzaW11bHRhbmVvdXNseSBzdXBwb3J0ZWQgYW5kIHRoaXMgbmVlZHMgdG8gYmUgZXhwcmVz
c2VkPyAgVGhpcyBjYW4gYmUgYSBkaWZmZXJlbmNlDQpiZXR3ZWVuIE9FTSBpbXBsZW1lbnRhdGlv
bnMuDQoNCj4gDQo+IFRoaXMgd291bGQgbWVhbiB0aGF0IGV4aXN0aW5nIHVzZXJzcGFjZSBzb2Z0
d2FyZSBjYW4gbm90IHdvcmsgd2l0aA0KPiBzeXN0ZW1zIHVzaW5nIHRoZSBuZXcgImhvdHAiIHBh
c3N3b3JkIGF0cnJpYnV0ZXMsIGJ1dCB0aGF0IGlzDQo+IHVuYXZvaWRhYmxlLg0KDQo+IA0KPiBJ
IHRoaW5rIHRoYXQgdGhlIGN1cnJlbnQgZ2VuZXJpYyBwYXNzd29yZCBmbG93IHdpbGwgd29yayB3
ZWxsDQo+IGZvciBvdGhlciB2ZW5kb3JzIHRvbywgdGhleSBtYXkgbmVlZCB0byBub3QgY2FjaGUg
aXQgaW4gdGhlDQo+IGtlcm5lbCAoaW5zdGVhZCBzZW5kaW5nIGl0IGRpcmVjdGx5IHRvIHRoZSBm
aXJtd2FyZSBvbmNlKSwgYnV0IHRoZSBiYXNpYw0KPiBjb25jZXB0IG9mIGhhdmluZyB0byB3cml0
ZSB0aGUgcGxhaW4tdGV4dCBiaW9zIEFkbWluIHBhc3N3b3JkIGJlZm9yZQ0KPiBiZWluZyBhYmxl
IHRvIGNoYW5nZSBwcm90ZWN0ZWQgc2V0dGluZ3Mgc2VlbXMgbGlrZSBpdCBpcyBzb21ldGhpbmcg
d2hpY2gNCj4gbWF0Y2hlcyBob3cgbW9zdCBjdXJyZW50IEJJT1MtZXMgd29yay4gIEFuZCBuZWVk
aW5nIGEgd2F5IHRvIHJlLWxvY2sgdGhlDQo+IHNldHRpbmdzIGFsc28gc291bmRzIGxpa2Ugc29t
ZXRoaW5nIHdoaWNoIHdpbGwgYmUgcHJldHR5IGNvbW1vbiBmb3IgbW9zdA0KPiBpbXBsZW1lbnRh
dGlvbnMuDQo+IA0KDQpPSyBzbyBoZXJlIGlzIGFub3RoZXIgcGxhY2UgdGhhdCBJIHRoaW5rIHZl
bmRvcnMgbWlnaHQgaGF2ZSBhIGRpZmZlcmVudA0KaW1wbGVtZW50YXRpb24uICBXaGVuIHlvdSBo
YXZlIGEgQklPUyBhZG1pbiBwYXNzd29yZCBzZXQsIERlbGwgcmVxdWlyZXMgdGhhdA0KcGFzc3dv
cmQgdG8gaW50ZXJhY3Qgd2l0aCBhbnkgb2YgdGhlc2UgYXR0cmlidXRlcy4gIEFub3RoZXIgdmVu
ZG9yIG1pZ2h0DQpvbmx5IHJlcXVpcmUgaXQgb25seSBmb3IgY2VydGFpbiBhdHRyaWJ1dGVzIHRo
ZXkgZGVlbWVkIHByb3RlY3RlZC4NCg0KU28gYWdhaW4sIERlbGwncyBmbG93IG1pZ2h0IG5vdCBz
Y2FsZSB0byBldmVyeW9uZSBlbHNlLg0KDQpJIGRvIGFja25vd2xlZGdlIHRoaXMgbWlnaHQgYmUg
bWl0aWdhdGFibGUgYnkgYWRkaW5nIGEgc3lzZnMgZmlsZSB0byBldmVyeQ0KYXR0cmlidXRlIGZv
ciBEZWxsJ3MgaW1wbGVtZW50YXRpb24gImlzX2F1dGhlbnRpY2F0aW9uX3JlcXVpcmVkIiB0aGF0
IGlzIGFsd2F5cw0KMSB3aGVuIGFkbWluIHBhc3N3b3JkIHJlcXVpcmVkIGFuZCBpbiBhbm90aGVy
IGltcGxlbWVudGF0aW9uIGFuIE9FTSBtaWdodCBjaG9vc2UNCnRvIHNldCB0aGF0IG9uIGEgY2Fz
ZSBieSBjYXNlIGJhc2lzLg0KDQo+ID4+IFdlIGNvdWxkIGV2ZW4gZG8gc29tZXRoaW5nIGxpa2Ug
d2UgaGF2ZSBmb3IgLmRlc2t0b3AgZmlsZXMNCj4gPj4gZmllbGRzLCB3aGVyZSB3ZSBhZGQgc29t
ZXRoaW5nIHRvIHRoZSBzeXNmcyBBQkkgZG9jdW1lbnRhdGlvbg0KPiA+PiB0aGF0IHZlbmRvcnMg
bWF5IGFkZCB2ZW5kb3Igc3BlY2lmaWMgdHlwZXMgcHJlZml4ZWQgd2l0aCBYLTx2ZW5kb3JuYW1l
Pi4NCj4gPj4NCj4gPj4gU28gYWxsIGluIGFsbCBJIGJlbGlldmUgdGhhdCB3ZSBjYW4gbWFrZSB1
c2luZyB0aGUgcHJvcG9zZWQgc3lzZnMgQUJJDQo+ID4+IGEgZ2VuZXJpYyBvbmUgd29yaywgYW5k
IHRoYXQgdGhpcyB3aWxsIGJlIHdvcnRoIGl0IHRvIGF2b2lkIGhhdmluZyB0aGUNCj4gPj4gaXNz
dWUgb2YgZXZlbnR1YWxseSBoYXZpbmcgYm90aCBhIGNvdXBsZSBvZiB2ZW5kb3Igc3BlY2lmaWMg
QVBJcyArDQo+ID4+IG9uZSBncmFudCB1bmlmaWVkIGdlbmVyaWMgQVBJIHJlcGxhY2luZyB0aG9z
ZSB2ZW5kb3ItQVBJcw0KPiA+PiAod2hlcmUgd2UgY2FuIG5ldmVyIGRyb3AgdGhlIHZlbmRvciBz
cGVjaWZpYyBBUElzIGJlY2F1c2Ugb2YNCj4gPj4gYmFja3dhcmQgY29tcGF0LiBndWFyYW50ZWVz
KS4NCj4gPg0KPiA+IEknbSBwZXJzb25hbGx5IGxlYW5pbmcgb24gdGhlIHJpZ2h0IHBsYWNlIHRv
IGhhdmUgYSB2ZW5kb3IgYWdub3N0aWMgdmlldyBpcw0KPiAib3V0c2lkZSINCj4gPiBvZiB0aGUg
a2VybmVsIGluIGFuIHVzZXJsYW5kIGxpYnJhcnkuICBBbGwgdGhlIHZlbmRvciBkcml2ZXJzIHRo
YXQgY2hhbmdlDQo+IHNldHRpbmdzIGNhbg0KPiA+IGJlaGF2ZSB2ZXJ5IHNpbWlsYXJseSBmb3Ig
dGhlIG1vc3QgcGFydCwgYnV0IGRpZmZlcmVuY2VzIGJldHdlZW4gdmVuZG9yDQo+IGltcGxlbWVu
dGF0aW9ucw0KPiA+IGNhbiBiZSBiZXR0ZXIgZXhwcmVzc2VkIHRoZXJlLg0KPiANCj4gV2UgaGF2
ZSB0cmllZCB0aGF0IGJlZm9yZSBpbiBzZXZlcmFsIGNhc2VzICh0aGF0IEknbSBhd2FyZSBvZikg
YW5kIHRoaXMgbmV2ZXINCj4gd29ya3Mgb3V0LiBFc3AuIG5vdCB3aGVuIHRoZSBiYXNpYyBrZXJu
ZWwgaW50ZXJmYWNlIGlzIHJlYXNvbmFibGUgc2FuZSwNCj4gdGhlbiBhIGxvdCBvZiBwZW9wbGUg
LyBwcm9qZWN0cyBhdm9pZCB0aGUgbGliIGFuZCBqdXN0IHBva2UgdGhlIGtlcm5lbCBBUEkNCj4g
ZGlyZWN0bHkuIFdlIGhhdmUgc2VlbiB0aGlzIGUuZy4gd2l0aCBod21vbi1jbGFzcyBkZXZpY2Vz
IGFuZCB3aXRoIHY0bCBkZXZpY2VzDQo+IGFuZCB3aXRoIGJhY2tsaWdodC1jbGFzcyBkZXZpY2Vz
LiBTaW5jZSBJJ3ZlIHNlZW4gdGhpcyBoYXBwZW4gMyB0aW1lcyBhbHJlYWR5DQo+IEknbSBub3Qg
YSBiaWcgYmVsaWV2ZXIgaW4gYWRkaW5nIGEgdXNlcnNwYWNlIGxpYnJhcnkgdG8gaGlkZSB0aGUg
dmVuZG9yDQo+IGRpZmZlcmVuY2VzLg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCg0KQW5v
dGhlciBhcmVhIHRoYXQgY29tZXMgdG8gbWluZCBpcyBEZWxsJ3MgdmFsdWVfbW9kaWZpZXIgYW5k
IG1vZGlmaWVyIHJ1bGVzLiAgVGhpcw0KZGVwZW5kZW5jeSBsb2dpYyBpcyBoYW5kbGVkIGFuZCBl
eHByZXNzZWQgYnkgdGhlIGZpcm13YXJlLiAgWW91J2xsIG5vdGljZSB0aGUgRGVsbA0KZHJpdmVy
IG9ubHkgZGlzcGxheXMgdGhlIGluZm9ybWF0aW9uIHRoYXQgY2FtZSBvdXQgb2YgdGhlIGZpcm13
YXJlIGluIHN5c2ZzIGFuZCBkb2Vzbid0DQpkbyBhbnkgcHJvY2Vzc2luZyBpbiBkcml2ZXIuDQoN
ClNvIGJ5IHVzaW5nIERlbGwncyBmb3JtYXQsIGFub3RoZXIgdmVuZG9yJ3MgZHJpdmVyIHdpbGwg
bmVlZCB0byBmb2xsb3cgRGVsbCdzDQpmb3JtYXR0aW5nIGFuZCBydWxlIHZhbGlkYXRpb24vZ2Vu
ZXJhdGlvbiB3aGljaCB0aGVpciBmaXJtd2FyZSBtaWdodCBub3Qgc3VwcG9ydCBhbmQNCnRoZXkg
d2lsbCBiZSBmb3JjZWQgdG8gaW1wbGVtZW50IERlbGwncyBzY2hlbWEgaW4gdGhlaXIga2VybmVs
IGRyaXZlci4NCg0KTGFzdGx5IEkgd2FudCB0byBjYXV0aW9uIHRoYXQgaW5kaXZpZHVhbCBmaXJt
d2FyZSBpdGVtcyB3aXRoIHRoZSBzYW1lIG5hbWUgbWlnaHQgaGF2ZQ0KYSBkaWZmZXJlbnQgbWVh
bmluZyBhY3Jvc3MgdmVuZG9ycy4gIEhlcmUgaXMgbXkgaHlwb3RoZXRpY2FsIGV4YW1wbGU6DQoN
CkRlbGwgaGFzIGFuIGF0dHJpYnV0ZSBjYWxsZWQgIkNhbWVyYSIgIFdpdGggVjMgaXQgcG9wdWxh
dGVzIHVuZGVyOg0KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2RlbGwtd21pLXN5c21hbi9hdHRyaWJ1
dGVzL0NhbWVyYQ0KDQpUaGUgZGVzY3JpcHRpb24gc3lzZnMgZm9yIGl0IHJlYWRzIGFzICJFbmFi
bGUgQ2FtZXJhIiBhbmQgaXQncyBwb3NzaWJsZSB2YWx1ZXMgYXJlDQoiRGlzYWJsZWQ7RW5hYmxl
ZDsiLiAgRm9yIERlbGwgdGhpcyBpcyBwcmV0dHkgb2J2aW91c2x5IGl0IHR1cm5zIG9uIGFuZCBv
ZmYgdGhlIGNhbWVyYQ0KZnVuY3Rpb25hbGl0eS4NCg0KRm9yIGFub3RoZXIgdmVuZG9yIHRoZXkg
bWlnaHQgYWN0dWFsbHkgbm90IG9mZmVyIHRvIGVuYWJsZS9kaXNhYmxlIHRoZSBjYW1lcmEgYnV0
IGluc3RlYWQNClRvIGVuYWJsZSB0aGUgY29udHJvbCBvZiBhbiBlbGVjdHJvbWFnbmV0aWMgY2Ft
ZXJhIHNodXR0ZXIgZnJvbSBzdWNoIGFuIGF0dHJpYnV0ZS4gDQpUaGVpciBhdHRyaWJ1dGUgY291
bGQgc3RpbGwgYmUgY2FsbGVkICJDYW1lcmEiIGJ1dCB0aGUgZGVzY3JpcHRpb24gbWlnaHQgcmVh
ZCBhcw0KIkVuYWJsZSBjYW1lcmEgc2h1dHRlciBjb250cm9sIi4gIEZvciB0aGVtIGl0IHdvdWxk
IHN0aWxsIHJlYWQgYXMgIkRpc2FibGVkO0VuYWJsZWQ7Ig0KZm9yIHBvc3NpYmxlIHZhbHVlcyBi
dXQgaGF2ZSBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IG1lYW5pbmchDQoNClRoZXJlIGlzIG5vIHN0
YW5kYXJkIGZvciB0aGlzLCBhbmQgYWdhaW4gdXNlcnNwYWNlIHdpbGwgbmVlZCB0byBiYXNpY2Fs
bHkgbG9vayBhdA0KdGhlIGRpcmVjdG9yeSBhbmQgc3RydWN0dXJlIHRvIGZpZ3VyZSBvdXQgd2hh
dCB0aGUgbWVhbmluZyBhY3R1YWxseSBpcy4NCiANCg==

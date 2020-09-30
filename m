Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293ED27EE28
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgI3QCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:02:38 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:54414 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbgI3QCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:02:37 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UFsLQj004856;
        Wed, 30 Sep 2020 12:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=4KypyEC71WsTEXAscdZ0FarJdySx/cikJA47zdD2pFk=;
 b=h50fhSIqG9qX7oM0IEmGDdW+f2mkPhxKUvhztpZUXecXqk4vrip0XArga3b/LbbV/OS7
 X/RaB6t+JXpyO+5RgJiIFr7dTmMmunUn2S0LL2eZ7zT8++OYl7c9sTjavPIGYoqjDlmY
 OLeEEvaDGTST2FH2F5CqXMM8WvXQpuSp5BZWcCAnoGxSDnbr3h8KfCqqzxjrT42FXZH0
 FaYFBL25W9yVcy9YNwinrCu6eYaytlKxHUyrqZqEdzfyYlCDLce0scHVFfESA6rJSxQA
 XOO4EIOgFv6dNS2n+6dkE1Itjx9EXESTgcM8hLQTbPt4su7TPX9N11WB8zsVUgDR65Z9 Fw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 33t0teecjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 12:02:28 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UFtXCV037562;
        Wed, 30 Sep 2020 12:02:27 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00154901.pphosted.com with ESMTP id 33vvqr0f8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 12:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGy71VIk2FT5zSswoSSAUCVzzTX87kT2RSbsilwPUZWB84e+k2pEBt5nV0ZYqffYcxWSQ0RKfIyDFWFWivG3cnEX8Re/yhZMsgFsjBxDc3b6/3QZWwxHb0qOqTphkAGU2vcapjhXXqO3b0YbMjT40VkjAIf8te8AGVza9zMkQLPHljSvqjXrXzGQmvCCyLchbeoziI8LIhHeO4P6vg2R3Wy1cCDWDxXOqRdInxmqZ7HFcoo3Odfmtp3XwJ4PId5G/SrBA7DjQ5noCt3Q1AWb5M4XTTag6coxML7F1NUXUhahlSBHGTp8o9dc16RcfoCfDYNp46WaeZ04wkV7XaCn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KypyEC71WsTEXAscdZ0FarJdySx/cikJA47zdD2pFk=;
 b=mClLdwRMcBezEMJscV4ou5PeVxXXHyI35Qgxnqcj7QKqpSbVmsPRvrM/PP4nNJpXG9AgqVek/gFNu8YPDNcod8XRgXTSEM/EerZiMu1fuQW+w/v1ktgaVEwiqVlvhTgfWQ+WbwhNSP3Knd9kJG8raqndqcZUe4ZE0tSAo0nL7UBMHl75rvdMo9HsMv4GtMlNxP4SNJ1bBDcpRirzPclqf722KkWEOCCC2kJ1/lzRa2ABnh5EvekwDCEfpF8rrrhKrBDwjRFUoNbnbL24IsXVq4D1Cr53F4CG6LZz3nSJaDJVEzgd055dX6Nhg5Iuwun9s+uNDu3BaFJbyzxLp0KXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KypyEC71WsTEXAscdZ0FarJdySx/cikJA47zdD2pFk=;
 b=dnMrZ8qW6Dl9qt/mMxxUTIvqwhVtRwBR+M5RJEBrVjYh0AfOHUY4oPy6pkxMzebifU8h5eos/9mNWpLsPHkomnSzIQPzwVHs6bXAYq7dMuYIG1VGuqDq7ZtQmNsiYnf9sZXo3j+JWpaUAWk3wIwesOyUu3TtxzFOGNc+CLNMagI=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB4713.namprd19.prod.outlook.com (2603:10b6:5:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 16:02:24 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 16:02:24 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: RE: Keyboard regression by intel-vbtn
Thread-Topic: Keyboard regression by intel-vbtn
Thread-Index: AQHWlj1nM3jkeRr7qUSqdoVr/WDD66l/V1WAgAACMACAAAiVgIAABMgAgAAjUpSAAAiigIAAGG+wgABpVeCAARoOgIAAG6aggAAIOQCAAAbNMA==
Date:   Wed, 30 Sep 2020 16:02:23 +0000
Message-ID: <DM6PR19MB263659AFAAE3B865B65AC2A5FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
 <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <DM6PR19MB2636BD25C7C828D28CF27CC8FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <fce9f346-5c02-0997-216a-14ab6c8b336d@redhat.com>
 <DM6PR19MB2636919AD0E9FD06F05AC8A8FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
 <a5e05458-a61f-a523-a48b-5c5c821eb053@redhat.com>
In-Reply-To: <a5e05458-a61f-a523-a48b-5c5c821eb053@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-30T16:02:21.1886625Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=ff336803-ced8-4fd6-965a-d06c75604abe;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f33fbe4-1a89-405e-cbad-08d8655a3862
x-ms-traffictypediagnostic: DM6PR19MB4713:
x-microsoft-antispam-prvs: <DM6PR19MB471341B7CB043E1C0758008CFA330@DM6PR19MB4713.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3r5SLKYpBgKrD+8CQYpuyKIQlF0t0rdy3vulWtcsuM9PBsI5PfFCkUN5KaysXwC8EfOA/Sw9yuTSkn8Ns21lkiWBa0hzMWkQxL1wN867ayihMJ6bL/hWo64pi8rzHrzUNtX7Dx8ijoIjY6tlIaeWl5O+234n6XtnaouT93Kyx0GEqsB88amh+ENSCawcaqqlLNJn+uAPRHMy4L5H+EQzp78bzX3SU5r3Fx9QegcjX1KkW6StKRlgCsSq143HaB9s94ec7fATkrZBcybFUr6d52apoa0CweqlQB+7V6UMykJt8OTbwRR01piewuPVqY0oFt2Qvr3pcioLdTtVG56sGMHEQ13te/fwvmfUKx4AoGoU/N1t0lC3/Dj2FBmTTjrV1dMyiiuy1thU5nal6GWB/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(966005)(52536014)(54906003)(110136005)(33656002)(76116006)(66556008)(64756008)(66446008)(2906002)(66476007)(66946007)(4326008)(8676002)(71200400001)(8936002)(786003)(316002)(478600001)(53546011)(45080400002)(83080400001)(86362001)(6506007)(5660300002)(55016002)(9686003)(7696005)(186003)(83380400001)(66574015)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8nmuIp7k2PsUpGWT+KYzMhPSbtztmT7YNBTY4tOoaxozf0x4rA9KhiOxnroAH8t8JpD97oESGRyePs6Fp0I6Ad7hM4oGhNJRZ1mA8lJolabIlFFyASNKGlTPhLSwccrrH2ypUE5ht5U67pLiEOxHINsqg7iwWEe4bs6Pg7SWWtxlyPubqcmevuZjdLSelkyE25Iw0eMPOmaLHc76/EfjhnDeaix5nL1z5a1ZnJLXbf4LZEideUQd/HCAJdRX5Aqv6Tp9NmcU/qKdidMtl/AiCTcqb9DvuXVig20uddL7BJBRKyFluta/oosHxu+lKDOw6QgDA56oMefjZOEfSk4WZjIxUZLqXJ9WecIEFze9UuARFG17ou16XX+VPqoZwS/jQVlpXzGNNgPvC1DhqlIIqV5IJhyai8RgSnFQg2EaMGiDIhwvcSAsXuzj+ZZlOcZPPa4GUXDvqul371lztVLxbZWYSjOlTeSfiK5Oh+0SVnBXgUpjoW1JYa6k43RkZFloadC7Erl40u2G6eF0nCi4Gt6VXK6DztTUUdWaz0SIIrqhnR8Wp335DNeZrWcfd9REt3JY1nKEzh5sWtN+rKuD4C7+Kgl7Dl9LNuNEZtuZi3Y+MpBSVUQ13LTs5q80XdUSTG4sXn7MB9FyLbW2RFxpMw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f33fbe4-1a89-405e-cbad-08d8655a3862
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 16:02:23.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34zRWQiIj6WD5gKN/FF1dN65A3Es9dCGZ1jivQAkqbDovPom+dSTSXT/7VomrolRFRjkSs7/DUc8wK2Fw8gQQ2ncONuWFHOH5/tuqFWX570=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4713
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_08:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300126
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVn
b2VkZUByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAzMCwgMjAyMCAx
MDozNw0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvOyBCYXJuYWLDoXMgUMWRY3plOyBBbmR5IFNo
ZXZjaGVua28NCj4gQ2M6IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYWthc2hpDQo+IEl3YWkNCj4gU3ViamVjdDogUmU6
IEtleWJvYXJkIHJlZ3Jlc3Npb24gYnkgaW50ZWwtdmJ0bg0KPiANCj4gDQo+IFtFWFRFUk5BTCBF
TUFJTF0NCj4gDQo+IEhpLA0KPiANCj4gT24gOS8zMC8yMCA1OjEyIFBNLCBMaW1vbmNpZWxsbywg
TWFyaW8gd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206
IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2Rh
eSwgU2VwdGVtYmVyIDMwLCAyMDIwIDg6MjgNCj4gPj4gVG86IExpbW9uY2llbGxvLCBNYXJpbzsg
QmFybmFiw6FzIFDFkWN6ZTsgQW5keSBTaGV2Y2hlbmtvDQo+ID4+IENjOiBwbGF0Zm9ybS1kcml2
ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
VGFrYXNoaQ0KPiA+PiBJd2FpDQo+ID4+IFN1YmplY3Q6IFJlOiBLZXlib2FyZCByZWdyZXNzaW9u
IGJ5IGludGVsLXZidG4NCj4gPj4NCj4gPj4NCj4gPj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiA+Pg0K
PiA+PiBIaSwNCj4gPj4NCj4gPj4gT24gOS8yOS8yMCAxMDo0NyBQTSwgTGltb25jaWVsbG8sIE1h
cmlvIHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4gSSByZXF1ZXN0ZWQgb24gdGhlIFVidW50dSBidWcg
Zm9yIHNvbWVvbmUgdG8gcHJvdmlkZSB0aGVzZS4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEpvZSBC
YXJuZXR0IHdhcyBraW5kIGVub3VnaCB0byBzaGFyZSB0d28gQUNQSSBkdW1wcyB0byBjb21wYXJl
Lg0KPiA+Pj4gTm90IGFmZmVjdGVkOg0KPiA+Pj4NCj4gPj4NCj4gaHR0cHM6Ly9idWdzLmxhdW5j
aHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvbGludXgvK2J1Zy8xODIyMzk0LythdHRhY2htZW50LzU0
MTUzDQo+ID4+IDE4LytmaWxlcy8xLjIuMC5hY3BpZHVtcA0KPiA+Pj4NCj4gPj4+IEFmZmVjdGVk
Og0KPiA+Pj4NCj4gPj4NCj4gaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3Vy
Y2UvbGludXgvK2J1Zy8xODIyMzk0LythdHRhY2htZW50LzU0MTU0DQo+ID4+IDA1LytmaWxlcy8x
LjEzLjAuYWNwaWR1bXANCj4gPj4NCj4gPj4gVGhhbmsgeW91LCBJIHRvb2sgYSBsb29rIGF0IHRo
ZXNlIChiZWZvcmUgY29tcGxldGluZyBteSBhbGxvdy1saXN0IGZpeCksDQo+ID4+IGJ1dCB0aGVy
ZSBpcyBub3QgcmVhbGx5IG11Y2ggd2hpY2ggc3RhbmRzIG91dC4gVGhlIG9ubHkgcmVsYXRlZCB0
aGluZyB3aGljaA0KPiA+PiBzdGFuZHMgb3V0IGlzIHRoYXQgdGhlIDEuMTMuMCBkc2R0LmRzbCBo
YXMgdGhpcyBuZXcgYml0Og0KPiA+Pg0KPiA+Pg0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBDYXNlICgweDA4KQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7
DQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXR1cm4gKF5eUENJMC5M
UENCLkhfRUMuVkdCSS5WR0JTICgpKQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB9DQo+ID4+DQo+ID4+IEluc2lkZSB0aGUgX0RTTSBvZiB0aGUgSElERCAvIElOVDMzRDUgZGV2
aWNlLg0KPiA+Pg0KPiA+PiAgICAgICAgICAgICAgIE1ldGhvZCAoX0RTTSwgNCwgU2VyaWFsaXpl
ZCkgIC8vIF9EU006IERldmljZS1TcGVjaWZpYyBNZXRob2QNCj4gPj4gICAgICAgICAgICAgICB7
DQo+ID4+ICAgICAgICAgICAgICAgICAgIElmICgoQXJnMCA9PSBUb1VVSUQgKCJlZWVjNTZiMy00
NDQyLTQwOGYtYTc5Mi0NCj4gPj4gNGVkZDRkNzU4MDU0IikpKQ0KPiA+Pg0KPiA+Pg0KPiA+PiBX
aGF0IGlzIGludGVyZXN0aW5nIGhlcmUgaXMgdGhhdCB0aGUgUENJMC5MUENCLkhfRUMuVkdCSS5W
R0JTIG9iamVjdC9tZXRob2QNCj4gPj4gZG9lcyBub3QgYWN0dWFsbHkgZXhpc3QgdGhlIGNvcnJl
Y3QgcGF0aCBpczoNCj4gPj4NCj4gPj4gXl5QQ0kwLkxQQ0IuRUNEVi5WR0JJLlZHQlMNCj4gPj4N
Cj4gPj4gU28gdGhpcyBkb2VzIHN1Z2dlc3QgdGhhdCBzb21ldGhpbmcgYXJvdW5kIHRoZSBWR0JT
IGhhbmRsaW5nIGNoYW5nZWQNCj4gPj4gKGFuZCBzaW5jZSBpdCBwb2ludHMgdG8gYSBub24gZXhp
c3RpbmcgQUNQSSBvYmplY3QsIHBvc3NpYmx5IGJyb2tlKQ0KPiA+PiBpbiB0aGUgbmV3ZXIgQklP
UyB2ZXJzaW9uLiBCdXQgd2hhdCBleGFjdGx5IGlzIGdvaW5nIG9uIG9uIHRoaXMgWFBTIDItaW4t
MQ0KPiA+PiBjYW5ub3QgcmVhbGx5IGJlIGRlcml2ZWQgZnJvbSB0aGUgYWNwaWR1bXBzLg0KPiA+
Pg0KPiA+PiBSZWdhcmRzLA0KPiA+Pg0KPiA+PiBIYW5zDQo+ID4NCj4gPiBMb29raW5nIHRocm91
Z2ggc29tZSBwdWJsaWNseSBmb3VuZCBjb250ZW50IEkgdGhpbmsgSSBtaWdodCBoYXZlIGZpZ3Vy
ZWQgb3V0DQo+IHdoYXQNCj4gPiBiaWdodCBiZSB0aGUgbWlzc2luZyBsaW5rLg0KPiA+DQo+ID4g
aHR0cHM6Ly9zb2Z0d2FyZS5pbnRlbC5jb20vc2l0ZXMvZGVmYXVsdC9maWxlcy9kZXRlY3Rpbmct
c2xhdGUtY2xhbXNoZWxsLQ0KPiBtb2RlLWFuZC1zY3JlZW4tb3JpZW50YXRpb24taW4tY29udmVy
dGlibGUtcGMtMS5wZGYNCj4gPg0KPiA+IFlvdSBjYW4gc2VlIHRoYXQgdGhlIGRldmljZSB3aXRo
IENJRCBQTlAwQzYwIGlzIHN1cHBvc2VkIHRvIGluZGljYXRlIHRoZQ0KPiBwcmVzZW5jZQ0KPiA+
IG9mIGEgY29udmVydGlibGUgaGluZ2UuICBXZSBkb24ndCBjdXJyZW50bHkgaGF2ZSBhbnl0aGlu
ZyB0aGF0IG1hdGNoZXMgdGhhdA0KPiBfQ0lEIG9yIF9ISUQNCj4gPiBpbiBpbnRlbC12YnRuLg0K
PiA+DQo+ID4gSW4gdGhlIERTRFQgZHVtcCB5b3UgY2FuIHNlZSB0aGF0IHRoZSBzdGF0dXMgbWV0
aG9kIGZvciB0aGUgSU5UMzNEMyBkZXZpY2UNCj4gcmV0dXJucw0KPiA+IDB4MEYgb24gMi1pbi0x
LnMNCj4gPg0KPiA+ICAgICAgICAgIERldmljZSAoQ0lORCkNCj4gPiAgICAgICAgICB7DQo+ID4g
ICAgICAgICAgICAgIE5hbWUgKF9ISUQsICJJTlQzM0QzIiAvKiBJbnRlbCBHUElPIEJ1dHRvbnMg
Ki8pICAvLyBfSElEOg0KPiBIYXJkd2FyZSBJRA0KPiA+ICAgICAgICAgICAgICBOYW1lIChfQ0lE
LCAiUE5QMEM2MCIgLyogRGlzcGxheSBTZW5zb3IgRGV2aWNlICovKSAgLy8gX0NJRDoNCj4gQ29t
cGF0aWJsZSBJRA0KPiA+ICAgICAgICAgICAgICBNZXRob2QgKF9TVEEsIDAsIFNlcmlhbGl6ZWQp
ICAvLyBfU1RBOiBTdGF0dXMNCj4gPiAgICAgICAgICAgICAgew0KPiA+ICAgICAgICAgICAgICAg
ICAgSWYgKChPU1lTID49IDB4MDdEQykpDQo+ID4gICAgICAgICAgICAgICAgICB7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgUmV0dXJuICgweDBGKQ0KPiA+ICAgICAgICAgICAgICAgICAgfQ0K
PiA+DQo+ID4gICAgICAgICAgICAgICAgICBSZXR1cm4gKFplcm8pDQo+ID4gICAgICAgICAgICAg
IH0NCj4gPiAgICAgICAgICB9DQo+ID4NCj4gPiBPbiBhIG5vbiAyLWluLTEgZGV2aWNlIEkgZG9u
J3Qgc2VlIHRoaXMgcHJlc2VudC4gIFNvIEkgdGhpbmsgd2Ugc2hvdWxkIGhhdmUNCj4gaW50ZWwt
dmJ0bg0KPiA+IGxvb2sgZm9yIHRoYXQgSU5UMzNEMy9QTlAwQzYwIGRldmljZSB0byBkZWNpZGUg
d2hldGhlciB0byBvZmZlciB0aGUgc3dpdGNoLg0KPiA+DQo+ID4gU2ltaWxhcmx5IGFzIG1lbnRp
b25lZCBpbiB0aGF0IGRvY3VtZW50IEkgdGhpbmsgdGhhdCB3ZSBzaG91bGQgbm90IGJlDQo+IHNo
b3dpbmcgdGhlDQo+ID4gZG9ja2luZyBzd2l0Y2ggb25seSB3aGVuIElOVDMzRDQvUE5QMEM3MCBp
cyBwcmVzZW50IGFuZCByZXR1cm5zIDB4Ri4NCj4gDQo+IFRoYXQgaXMgYSBnb29kIGZpbmQsIHRo
YW5rIHlvdSBmb3IgZGlnZ2luZyBpbnRvIHRoaXMgYW5kIGZpbmRpbmcgdGhpcy4NCj4gDQo+IEJ1
dCBpdCBzZWVtcyB3ZSBoYXZlIGEgdHlwaWNhbCBjYXNlIG9mIHRoZSBtaWNyb3NvZnQvaW50ZWwg
ZXhhbXBsZSBEU0RUIGNvZGUNCj4gYmVpbmcNCj4gYmxpbmRseSBjb3BpZWQgZXZlcnl3aGVyZSBo
ZXJlIHRvbzoNCj4gDQo+IFRoZSBjaGFzc2lzLXR5cGUgY2hlY2sgd2FzIG9yaWdpbmFsbHkgaW50
cm9kdWNlZCBieSB5b3UgaW46DQo+IGNvbW1pdCBkZTk2NDdlZmVhYTkgKCJwbGF0Zm9ybS94ODY6
IGludGVsLXZidG46IE9ubHkgYWN0aXZhdGUgdGFibGV0IG1vZGUNCj4gc3dpdGNoIG9uIDItaW4t
MSdzIikNCj4gDQo+ICAgICAgU29tZSBsYXB0b3BzIHN1Y2ggYXMgdGhlIFhQUyA5MzYwIHN1cHBv
cnQgdGhlIGludGVsLXZidG4gSU5UMzNENg0KPiAgICAgIGludGVyZmFjZSBidXQgZG9uJ3QgaW5p
dGlhbGl6ZSB0aGUgYml0IHRoYXQgaW50ZWwtdmJ0biB1c2VzIHRvDQo+ICAgICAgcmVwcmVzZW50
IHN3aXRjaGluZyB0YWJsZXQgbW9kZS4NCj4gDQo+ICAgICAgQnkgcnVubmluZyB0aGlzIG9ubHkg
b24gcmVhbCAyLWluLTEncyBpdCBzaG91bGRuJ3QgY2F1c2UgZmFsc2UNCj4gICAgICBwb3NpdGl2
ZXMuDQo+IA0KPiAgICAgIEZpeGVzOiAzMDMyM2ZiNmQ1ICgiU3VwcG9ydCB0YWJsZXQgbW9kZSBz
d2l0Y2giKQ0KPiANCj4gSSBoYXZlIGEgWFBTIDkzNjAgKHdoaWNoIGlzIG5vdCAyLWluLTEpIGFj
cGlkdW1wIGFuZCB0aGF0IGhhczoNCj4gDQo+ICAgICAgICAgIERldmljZSAoQ0lORCkNCj4gICAg
ICAgICAgew0KPiAgICAgICAgICAgICAgTmFtZSAoX0hJRCwgIklOVDMzRDMiIC8qIEludGVsIEdQ
SU8gQnV0dG9ucyAqLykgIC8vIF9ISUQ6DQo+IEhhcmR3YXJlIElEDQo+ICAgICAgICAgICAgICBO
YW1lIChfQ0lELCAiUE5QMEM2MCIgLyogRGlzcGxheSBTZW5zb3IgRGV2aWNlICovKSAgLy8gX0NJ
RDoNCj4gQ29tcGF0aWJsZSBJRA0KPiAgICAgICAgICAgICAgTWV0aG9kIChfU1RBLCAwLCBTZXJp
YWxpemVkKSAgLy8gX1NUQTogU3RhdHVzDQo+ICAgICAgICAgICAgICB7DQo+ICAgICAgICAgICAg
ICAgICAgSWYgKChPU1lTID49IDB4MDdEQykpDQo+ICAgICAgICAgICAgICAgICAgew0KPiAgICAg
ICAgICAgICAgICAgICAgICBSZXR1cm4gKDB4MEYpDQo+ICAgICAgICAgICAgICAgICAgfQ0KPiAN
Cj4gICAgICAgICAgICAgICAgICBSZXR1cm4gKFplcm8pDQo+ICAgICAgICAgICAgICB9DQo+ICAg
ICAgICAgIH0NCj4gDQo+IEFuZCBvbiBhbiBhc3VzIGUyMDBoYSAoYWxzbyBub3QgYSAyLWluLTEp
LCB3aGVyZSB3ZSB3ZXJlIHNlZWluZw0KPiBzaW1pbGFyIHByb2JsZW1zLCBidXQgdGhlbiB1c2lu
ZyBhc3VzIGN1c3RvbSBXTUkgaW50ZXJmYWNlIGZvcg0KPiBnZXR0aW5nIFNXX1RBQkxFVF9NT0RF
IEkgc2VlOg0KPiANCj4gICAgICAgICAgRGV2aWNlIChDSU5EKQ0KPiAgICAgICAgICB7DQo+ICAg
ICAgICAgICAgICBOYW1lIChfSElELCAiSU5UMzNEMyIgLyogSW50ZWwgR1BJTyBCdXR0b25zICov
KSAgLy8gX0hJRDoNCj4gSGFyZHdhcmUgSUQNCj4gICAgICAgICAgICAgIE5hbWUgKF9DSUQsICJQ
TlAwQzYwIiAvKiBEaXNwbGF5IFNlbnNvciBEZXZpY2UgKi8pICAvLyBfQ0lEOg0KPiBDb21wYXRp
YmxlIElEDQo+ICAgICAgICAgICAgICBNZXRob2QgKF9TVEEsIDAsIFNlcmlhbGl6ZWQpICAvLyBf
U1RBOiBTdGF0dXMNCj4gICAgICAgICAgICAgIHsNCj4gICAgICAgICAgICAgICAgICBSZXR1cm4g
KDB4MEYpDQo+ICAgICAgICAgICAgICB9DQo+ICAgICAgICAgIH0NCj4gDQo+IEkgaGF2ZSBxdWl0
ZSBhIGZldyBEU0RUcyAobW9zdGx5IGJ5dC9jaHQgdGFibGV0cyBvciAyLWluLTFzIHRob3VnaCkg
YW5kDQo+IDY1IG9mIHRoZW0gZGVmaW5lIGEgIlBOUDBDNjAiIGRldmljZSBhbmQgb25seSAxIHVu
Y29uZGl0aW9uYWxseQ0KPiByZXR1cm5zIDAgZnJvbSB0aGUgX1NUQSBtZXRob2QgZm9yIHRoaXMg
ZGV2aWNlLiBNb3N0IG90aGVycyBoYXZlDQo+IGFuIE9TWVMgY2hlY2suIFNvbWUgYWxzbyBjaGVj
ayBmb3Igc29tZSBvdGhlciwgcHJlc3VtYWJseSBCSU9TDQo+IGNvbmZpZ3VyZWQgdmFyaWFibGUs
IGJ1dCBieSBmYXIgbW9zdCBhbHdheXMgcmV0dXJuIDB4MEYsIG9yIGRvDQo+IHNvIGFmdGVyIGFu
IE9TWVMgY2hlY2sgd2hpY2ggd2lsbCBiZSB0cnVlIGluIG91ciBjYXNlLg0KPiANCj4gU28gSSdt
IGFmcmFpZCB0aGF0IGFsbW9zdCBhbGwgZGV2aWNlcyB3aGljaCBoYXZlIHRoZSBpbnRlbC12YnRu
IChJTlQzM0Q2KQ0KPiBBQ1BJIGRldmljZSB3aWxsIGFsc28gaGF2ZSBhIFBOUDBDNjAgZGV2aWNl
IHdpdGggdGhlIGV4YWN0IHNhbWUNCj4gX1NUQSBtZXRob2QgYXMgZm91bmQgb24gdGhlIFhQUyA5
MzYwIGFuZCB0aGF0IHRoaXMgdGh1cyBpcyBub3QNCj4gaGVscGZ1bC4NCj4gDQo+IFJlZ2FyZHMs
DQo+IA0KPiBIYW5zDQoNCldlbGwgZGFuZywgdGhhdCdzIHVuZm9ydHVuYXRlLiAgSSBndWVzcyBm
b3Igbm93IHRoZSBhbGxvd2xpc3QgaXMgdGhlDQpiZXN0IHNvbHV0aW9uIHRoZW4uDQoNClRoYW5r
cywNCg==

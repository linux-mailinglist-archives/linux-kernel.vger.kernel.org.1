Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF16C2D130A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgLGOCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:02:54 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13042 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLGOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:02:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce35e50001>; Mon, 07 Dec 2020 06:02:13 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 14:02:08 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 14:02:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9QDaW7OmTgH34G6Qwa52ePheounEl/Me4sQ260VYmFn3QkUGC6OfkU7pRr+zxT8l49kpocNnUktMAD5Wod+lGAdyMxYB48H18YC8lA2s7+ideStz127+F8isRcQzmT7TdVCF5IJkJ9mEwExDoIQuRauN8NBwUK+hZgUAHC9iU/Namx3rO+gXf+iifTm0kh6Kg+lcV8NpRWdhcjgeYZT7csIlkpGZmoXjZ2ih/H5A3oOJgPOJcPfBReFbh5cUz98A2haWJ5UafAlWhULR6qxYKNI611fW4otS+FVK5WbVFdl8my0bD3P05RoPXosHKZrf1ID/U/2AnpjYzhBVR53qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMz74d6hnklfIbToT8zpBfQjFAnr/VPXQ3je5FztQHU=;
 b=Hy7fA1KMeMZMJh3G8f/apDgA2Wxht7cZXdKN/ybZW/BsTUQvG5es65InSnVjlTj5bg76ImArJ4UBJ1aA74sO81Aj9RiF0XstvndKdDZv7CykNFzT664OKnBZVka64B4LgdDD9vyG1y5x3Wg5W9caHQi+6WSkss8AAnR9BDaaxnCFLiIFjndkPh83W8QxEAxOz2yFDn2RPpzOI7G3HvRTCkyNRseGtCyWdloQcZmWnwFp2pccZDrNVBNaxjVN5pg7+cBbwn7Ujiwu8tRLEhc21+s2wHZYF0UhaOFhi5Rhu6GXrP+Ksbtip6QjogTwWrX+XG4wCzCwIO6MzdIdyTYC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3898.namprd12.prod.outlook.com (2603:10b6:5:1c6::18)
 by DM5PR12MB1930.namprd12.prod.outlook.com (2603:10b6:3:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 14:02:07 +0000
Received: from DM6PR12MB3898.namprd12.prod.outlook.com
 ([fe80::80c1:3479:15b6:a7a2]) by DM6PR12MB3898.namprd12.prod.outlook.com
 ([fe80::80c1:3479:15b6:a7a2%6]) with mapi id 15.20.3632.022; Mon, 7 Dec 2020
 14:02:07 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Mark Gross" <mgross@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Shych <michaelsh@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] platform/x86: mlx-platform: remove an unused variable
Thread-Topic: [PATCH] platform/x86: mlx-platform: remove an unused variable
Thread-Index: AQHWycQJ+tzIskPouEih6zwvYYhQc6nrrTCAgAACKgA=
Date:   Mon, 7 Dec 2020 14:02:07 +0000
Message-ID: <DM6PR12MB3898268DE033A52828D7297DAFCE0@DM6PR12MB3898.namprd12.prod.outlook.com>
References: <20201203223105.1195709-1-arnd@kernel.org>
 <64393b7e-ba81-1545-dfe8-bc3567dd534b@redhat.com>
In-Reply-To: <64393b7e-ba81-1545-dfe8-bc3567dd534b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [46.117.169.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f80cfdcd-002c-47e1-5b20-08d89ab8af00
x-ms-traffictypediagnostic: DM5PR12MB1930:
x-microsoft-antispam-prvs: <DM5PR12MB1930E81D68BA81BA91CB8FF5AFCE0@DM5PR12MB1930.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKi5Ow/Zx0I3thPRFb9jKjbJgerg9Zc+mqEmzjnI8Mi88pIyK9JBqx92S4HgDtiBefvXT0XUeM2NDBS5u4ixHO1TGH4iWxD6QNFSm6wUUU6O1yHYHsOY3r5WA7lI9f/2Zsc3roKGyO9/enKth5PWUuongg/mAW/nuVTZYJyiGXBecSpZ+5tcHJxBUCTTMHAt/2j1tyBzGOtwoy6QqeUiHk8Lqb4HhWYeYtbB3ZnDyj6ALp7DWkkt8ZNuiSelHifavOf8SfXGwbDUTLHXKi6ioF+RGnxHb0RuMTWhy+OsUVkfigPS+wYrs2VPKH9rvX693DF1tVI9bU6VopTCD+0+JLgqc3FnWkyisC3K5vtUXx+AjP391azZ/CI9ObrcTkaP/1nNurJrtALktZPkVOGNrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(8936002)(2906002)(966005)(55016002)(9686003)(316002)(7696005)(26005)(53546011)(54906003)(64756008)(110136005)(66476007)(76116006)(66446008)(6506007)(66946007)(66556008)(8676002)(7416002)(71200400001)(52536014)(186003)(5660300002)(33656002)(478600001)(86362001)(83380400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OXd3VHVpdjBUM1dVT2ViNTZVWFJOeUZudC96cDZ2Y3BEYm5Na3N5K1RCbUNj?=
 =?utf-8?B?a0YwRFM5SHRweEFkY0ZZbGhIUmJmS29lWkJBankraGNJZHpoVWp1eW1kYjdy?=
 =?utf-8?B?UnkzYjN1QmUvM3FSMnpmaTBRR3NtNXUwQ0N2YnhCQU9yejhRWnUwVHJFZmtn?=
 =?utf-8?B?eGNncDNxa3VBYm9XbFhHUmwyRG1IbTM1YjR1Z1FjUHovcklHZm5KZit2T1Qz?=
 =?utf-8?B?YzZ0QzVMZm12Y1Fnam9ibW5zL1N3VVlyVE52UFVsR0xrY2hIVGRxeDRHSzdG?=
 =?utf-8?B?YVNTRlNrcmk5T1dBbGM5UnlSQTZUWDg2OU8xMGZwZ1VxRWtQVUp2M1hhK1l6?=
 =?utf-8?B?VCtaaGlGK2RSNm82UXRZN3h5dHhaL0pzNEMwY0xFTEV1OXAzejFqVFA4Y2g3?=
 =?utf-8?B?Mnpxb3BYQW9WSnJiMXZkTk13VGNLbXZDYmZoZVNTalgwVlNCSHdrVEh2OEYw?=
 =?utf-8?B?RkVRR3Frb0huRGkxWnpGZCtidFdFYkRiYXhwbHlvTUg2UllKSHh6djJiUlNI?=
 =?utf-8?B?YTZISndTWWprSWdqYXBSVFBhUVlvR3hES2p4L2tNUGZnZ2RRS29lSllMdEh0?=
 =?utf-8?B?cVBCWnQ2dUY2N1czNUlqbXBML2UyUnFEWVEyMElSOStUTjlBVG55ZzVSODBl?=
 =?utf-8?B?b2ZEMkNWMnlNcVRQT2ZRYUNpcDQzczQ3V0tuT3FSOCtlOWRGdEI4eXk1MVEw?=
 =?utf-8?B?b1lHOVFKN0pmQ2d2S3d5KzM1UU5TYVpoMFZhZFZRVlpvd05WL05oMzZDbzdI?=
 =?utf-8?B?RXd6Y0cyRHU5ZWZKQlZ5TGNEMDlEOWpHejZpQnp4ZThLaXJNQ0swM0tkeDBH?=
 =?utf-8?B?ZmxJN1BqdWt6VmpvL0JQNnRTOHBXNU85MGhjcUFaelJDQ3lycjIxbGNIRmZU?=
 =?utf-8?B?NXllcTFQNlhsQzF6U2RqbGYxMFp1YUFtUlA3bTVmVzBvTkc0UURiUUM4S0kr?=
 =?utf-8?B?cTZUMmdvUDNQU2lpOWlrWTRoSXZ1MkN4L0xUK0JhRFRHMzlIYUFEUTljS0Ix?=
 =?utf-8?B?MS92K2ZuL056U2FMenA0L0s4bldFUE4vck1kcFRudi9QOHFnYzV6OFpwbitJ?=
 =?utf-8?B?VkgxWlIwYXpXc21pQnlsWUNkOEtVcXFoOEJlK3BLTWpBZHpOaEhCTHlkbHlr?=
 =?utf-8?B?K29lSWtycWFGNUh4anlaVEhhVDVKUUFwTzcwNHg1eWszWmkvMlVwL0pGVmRI?=
 =?utf-8?B?YktJeVBsQ2RORFRXcDl3ZWNMeU9iMjkrdno0MTZyYnhxZnB3OVJHTCtiVUda?=
 =?utf-8?B?aWo4TUxsNmVlTUlBcjZWSVI5N0dlSkVQT0orYkhkMU1TYkRjMGc1VVdVRERV?=
 =?utf-8?Q?0x63HBoS3EKtM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80cfdcd-002c-47e1-5b20-08d89ab8af00
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 14:02:07.2461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+JIZNRzm31wKhHa5T6BL6CPrL9s5nT6n8TqiP3lEb4uGWAwgUZhjV0BckIe8dRkMqAPpNIq4VkgafXQuGj8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1930
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607349733; bh=JMz74d6hnklfIbToT8zpBfQjFAnr/VPXQ3je5FztQHU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-exchange-transport-forked:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=LqTmzS5eahOOVUU0weEupd2JwYHxG90UmV2VP7pgFWuk9kvOMQiR3TFpr1bqauiDw
         o18fVbfTKOC54cBRyiWrOtVpR/Mm1HvakIqSBs33EL8tKvN3H5AMkYuYI0+7pQaBv6
         GBE36OhHmBJ7+4ayr4tc3xH/S8tpceAte5SLra2wXLcMbcVOoREHWijIkxwb4Xbk5m
         GoMVXRyGEIwttkAzUGob1Ae6DKazeEA81T415P+nFSn8W1fq+R3qVYk4tn9KO6igt9
         0UKfW29HJKJy/n647jwICdEsBwqV6VdbzSQnMf3xPfjekpXpVkYR9dJ1PTM+uMtSoK
         bLMfwFimW3RqQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAwNywgMjAyMCAz
OjU0IFBNDQo+IFRvOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+OyBWYWRpbSBQYXN0
ZXJuYWsNCj4gPHZhZGltcEBudmlkaWEuY29tPjsgTWFyayBHcm9zcyA8bWdyb3NzQGxpbnV4Lmlu
dGVsLmNvbT47IE5hdGhhbg0KPiBDaGFuY2VsbG9yIDxuYXRlY2hhbmNlbGxvckBnbWFpbC5jb20+
OyBOaWNrIERlc2F1bG5pZXJzDQo+IDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NCj4gQ2M6IEFy
bmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJpeS5z
aGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IE1pY2hhZWwgU2h5Y2gNCj4gPG1pY2hhZWxzaEBt
ZWxsYW5veC5jb20+OyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGNsYW5nLWJ1aWx0LWxpbnV4QGdvb2dsZWdyb3Vw
cy5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGxhdGZvcm0veDg2OiBtbHgtcGxhdGZvcm06
IHJlbW92ZSBhbiB1bnVzZWQgdmFyaWFibGUNCj4gDQo+IEhpLA0KPiANCj4gT24gMTIvMy8yMCAx
MTozMCBQTSwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxh
cm5kQGFybmRiLmRlPg0KPiA+DQo+ID4gVGhlIG9ubHkgcmVmZXJlbmNlIHRvIHRoZSBtbHhwbGF0
X21seGNwbGRfcHN1W10gYXJyYXkgZ290IHJlbW92ZWQsIHNvDQo+ID4gdGhlcmUgaXMgbm93IGEg
d2FybmluZyBmcm9tIGNsYW5nOg0KPiA+DQo+ID4gZHJpdmVycy9wbGF0Zm9ybS94ODYvbWx4LXBs
YXRmb3JtLmM6MzIyOjMwOiBlcnJvcjogdmFyaWFibGUNCj4gPiAnbWx4cGxhdF9tbHhjcGxkX3Bz
dScgaXMgbm90IG5lZWRlZCBhbmQgd2lsbCBub3QgYmUgZW1pdHRlZA0KPiA+IFstV2Vycm9yLC1X
dW5uZWVkZWQtaW50ZXJuYWwtZGVjbGFyYXRpb25dDQo+ID4gc3RhdGljIHN0cnVjdCBpMmNfYm9h
cmRfaW5mbyBtbHhwbGF0X21seGNwbGRfcHN1W10gPSB7DQo+ID4NCj4gPiBSZW1vdmUgdGhlIGFy
cmF5IGFzIHdlbGwgYW5kIGFkYXB0IHRoZSBBUlJBWV9TSVpFKCkgY2FsbCBhY2NvcmRpbmdseS4N
Cj4gPg0KPiA+IEZpeGVzOiA5MTJiMzQxNTg1ZTMgKCJwbGF0Zm9ybS94ODY6IG1seC1wbGF0Zm9y
bTogUmVtb3ZlIFBTVSBFRVBST00NCj4gPiBmcm9tIE1TTjI3NHggcGxhdGZvcm0gY29uZmlndXJh
dGlvbiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4N
Cj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4NCj4gDQo+IE5vdGUgdGhhdCB0aGVyZSBh
cmUgNCBtb3JlIGNhc2VzIHdoZXJlIHRoZSBmb28xIGFuZCBmb28yIGluOg0KPiAuZGF0YSA9IGZv
bzEgYW5kIC5jb3VudCA9IEFSUkFZX1NJWkUoZm9vMikgYXJlIG5vdCB0aGUgc2FtZS4NCj4gDQo+
IFRoZXJlIGFyZSAyIGNhc2VzIHdoZXJlIC5jb3VudCBpcyBzZXQgdG8gQVJSQVlfU0laRShtbHhw
bGF0X21seGNwbGRfcHdyKQ0KPiBpbnN0ZWFkIG9mIHRvIEFSUkFZX1NJWkUobWx4cGxhdF9tbHhj
cGxkX2RlZmF1bHRfcHdyX2l0ZW1zX2RhdGEpDQo+IA0KPiBhbmQgdGhlcmUgYXJlIDIgY2FzZXMg
d2hlcmUgLmNvdW50IGlzIHNldCB0byBBUlJBWV9TSVpFKG1seHBsYXRfbWx4Y3BsZF9mYW4pDQo+
IGluc3RlYWQgb2YgdG8gQVJSQVlfU0laRShtbHhwbGF0X21seGNwbGRfZGVmYXVsdF9mYW5faXRl
bXNfZGF0YSkNCj4gDQo+IElmIG9uZSBvZiB0aGUgTUxYIHBlb3BsZSBjYW4gcHJvdmlkZSBhIHBh
dGNoIGZpeGluZyB0aGlzIHRoZW4gdGhhdCB3b3VsZCBiZQ0KPiBncmVhdC4NCg0KSGksDQoNCkkn
bGwgcHJvdmlkZSBhIHBhdGNoLg0KDQpUaGFua3MsDQpWYWRpbS4NCg0KPiANCj4gIyMjDQo+IA0K
PiBJJ3ZlIGFwcGxpZWQgdGhpcyBwYXRjaCB0byBteSByZXZpZXctaGFucyAgYnJhbmNoOg0KPiBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZHg4Ni9wbGF0
Zm9ybS1kcml2ZXJzLQ0KPiB4ODYuZ2l0L2xvZy8/aD1yZXZpZXctaGFucw0KPiANCj4gTm90ZSBp
dCB3aWxsIHNob3cgdXAgaW4gbXkgcmV2aWV3LWhhbnMgYnJhbmNoIG9uY2UgSSd2ZSBwdXNoZWQg
bXkgbG9jYWwNCj4gYnJhbmNoIHRoZXJlLCB3aGljaCBtaWdodCB0YWtlIGEgd2hpbGUuDQo+IA0K
PiBPbmNlIEkndmUgcnVuIHNvbWUgdGVzdHMgb24gdGhpcyBicmFuY2ggdGhlIHBhdGNoZXMgdGhl
cmUgd2lsbCBiZSBhZGRlZCB0byB0aGUNCj4gcGxhdGZvcm0tZHJpdmVycy14ODYvZm9yLW5leHQg
YnJhbmNoIGFuZCBldmVudHVhbGx5IHdpbGwgYmUgaW5jbHVkZWQgaW4gdGhlDQo+IHBkeDg2IHB1
bGwtcmVxdWVzdCB0byBMaW51cyBmb3IgdGhlIG5leHQgbWVyZ2Utd2luZG93Lg0KPiANCj4gUmVn
YXJkcywNCj4gDQo+IEhhbnMNCj4gDQo+IA0KPiANCj4gDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL3BsYXRmb3JtL3g4Ni9tbHgtcGxhdGZvcm0uYyB8IDEzICsrLS0tLS0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvbWx4LXBsYXRmb3JtLmMNCj4gPiBi
L2RyaXZlcnMvcGxhdGZvcm0veDg2L21seC1wbGF0Zm9ybS5jDQo+ID4gaW5kZXggNTk4ZjQ0NTU4
NzY0Li42YTYzNGI3MmJmYzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYv
bWx4LXBsYXRmb3JtLmMNCj4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9tbHgtcGxhdGZv
cm0uYw0KPiA+IEBAIC0zMTksMTUgKzMxOSw2IEBAIHN0YXRpYyBzdHJ1Y3QgaTJjX211eF9yZWdf
cGxhdGZvcm1fZGF0YQ0KPiA+IG1seHBsYXRfZXh0ZW5kZWRfbXV4X2RhdGFbXSA9IHsgIH07DQo+
ID4NCj4gPiAgLyogUGxhdGZvcm0gaG90cGx1ZyBkZXZpY2VzICovDQo+ID4gLXN0YXRpYyBzdHJ1
Y3QgaTJjX2JvYXJkX2luZm8gbWx4cGxhdF9tbHhjcGxkX3BzdVtdID0gew0KPiA+IC0Jew0KPiA+
IC0JCUkyQ19CT0FSRF9JTkZPKCIyNGMwMiIsIDB4NTEpLA0KPiA+IC0JfSwNCj4gPiAtCXsNCj4g
PiAtCQlJMkNfQk9BUkRfSU5GTygiMjRjMDIiLCAweDUwKSwNCj4gPiAtCX0sDQo+ID4gLX07DQo+
ID4gLQ0KPiA+ICBzdGF0aWMgc3RydWN0IGkyY19ib2FyZF9pbmZvIG1seHBsYXRfbWx4Y3BsZF9w
d3JbXSA9IHsNCj4gPiAgCXsNCj4gPiAgCQlJMkNfQk9BUkRfSU5GTygiZHBzNDYwIiwgMHg1OSks
DQo+ID4gQEAgLTQ1Niw3ICs0NDcsNyBAQCBzdGF0aWMgc3RydWN0IG1seHJlZ19jb3JlX2l0ZW0N
Cj4gbWx4cGxhdF9tbHhjcGxkX2RlZmF1bHRfaXRlbXNbXSA9IHsNCj4gPiAgCQkuYWdncl9tYXNr
ID0gTUxYUExBVF9DUExEX0FHR1JfUFNVX01BU0tfREVGLA0KPiA+ICAJCS5yZWcgPSBNTFhQTEFU
X0NQTERfTFBDX1JFR19QU1VfT0ZGU0VULA0KPiA+ICAJCS5tYXNrID0gTUxYUExBVF9DUExEX1BT
VV9NQVNLLA0KPiA+IC0JCS5jb3VudCA9IEFSUkFZX1NJWkUobWx4cGxhdF9tbHhjcGxkX3BzdSks
DQo+ID4gKwkJLmNvdW50ID0NCj4gQVJSQVlfU0laRShtbHhwbGF0X21seGNwbGRfZGVmYXVsdF9w
c3VfaXRlbXNfZGF0YSksDQo+ID4gIAkJLmludmVyc2VkID0gMSwNCj4gPiAgCQkuaGVhbHRoID0g
ZmFsc2UsDQo+ID4gIAl9LA0KPiA+IEBAIC00OTUsNyArNDg2LDcgQEAgc3RhdGljIHN0cnVjdCBt
bHhyZWdfY29yZV9pdGVtDQo+IG1seHBsYXRfbWx4Y3BsZF9jb21leF9pdGVtc1tdID0gew0KPiA+
ICAJCS5hZ2dyX21hc2sgPSBNTFhQTEFUX0NQTERfQUdHUl9NQVNLX0NBUlJJRVIsDQo+ID4gIAkJ
LnJlZyA9IE1MWFBMQVRfQ1BMRF9MUENfUkVHX1BTVV9PRkZTRVQsDQo+ID4gIAkJLm1hc2sgPSBN
TFhQTEFUX0NQTERfUFNVX01BU0ssDQo+ID4gLQkJLmNvdW50ID0gQVJSQVlfU0laRShtbHhwbGF0
X21seGNwbGRfcHN1KSwNCj4gPiArCQkuY291bnQgPQ0KPiBBUlJBWV9TSVpFKG1seHBsYXRfbWx4
Y3BsZF9kZWZhdWx0X3BzdV9pdGVtc19kYXRhKSwNCj4gPiAgCQkuaW52ZXJzZWQgPSAxLA0KPiA+
ICAJCS5oZWFsdGggPSBmYWxzZSwNCj4gPiAgCX0sDQo+ID4NCg0K

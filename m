Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF732F8E81
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbhAPSBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 13:01:46 -0500
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:59360
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbhAPSBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 13:01:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKezYiRWbR/aGzdopjwVkMEhU4W7vW5swOb/idbDEzcvABS9KTwjhXyFpemAyKhOW+qwDZtvsT1Ffxa0rITa6Ufn1/6AomqrlEet1Y4RyVBT86qWAtD5uhR0Un8Dx7ofMRHBobG+MKohSrl7Bq2zUxec8fcu4ZHabJctPNnEoc3q9li6dpe2TzXhVlFfnlnGSiR0Ed193S/mQO/c1jVxwMJSl1HoRNWpgqbyTNBEMSjSo9N8ygacwelDcbRzXZmwQyJersUiq1d1Uaf+yHgpUzM0DImZlM12vPkqdxV87ySP+R1OFMn0wI314k8P7EIkGBpLOqXcqmpFOQhCL4zjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTNFYFJWBh2VTIDmCmvs2k7cn9qNyJSUvjZuM2iG4wQ=;
 b=Avo0PCeRi3/n35om2CrZQYPAMfs+fAXa75Ksmw4YaHGVO7uxQ9oBwJY6jyC9Xtm1gmWaCks3zh1RSUZ0a/Ar3XkWWhaGPFb03O5rE3DzNBaXMqPWl3O7VTUOu/AyG5RhAwXsq7zlPBfD7Tw3hwn9VJBRR5/SBgdHhEI7ICbxkOf7X2Xf7feuSn/35GEfzABN3VfsPnHxPCAMq0wBnmFJRP6JDFtgUMhjpCcI05iFsmIC8WCsPLU6C9JGfOHb3pPKzj/6UD7xaarluylBbtWQ3RuMn7Df5z9XkJ/BwddIPwjiKkCAktbHWvwpWjV40jsTqHdW4Ex/ouueZDYen73Wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTNFYFJWBh2VTIDmCmvs2k7cn9qNyJSUvjZuM2iG4wQ=;
 b=F01NL4mXeHaunmEh9xwd909zXtVQ3v+QUgROEs6r3jo3619O2jnH2cvLGjRsGl9bjDJBaRLplGmum8S27HxHxVwKz4xSkW9C8t+5//QibfdqAhiF/3VnMOhv0wkZ6/B7HbAJDLBEW8GUMjlumFVHuhZhmy0hT92vh/M5UkkBcvo=
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) by CY4PR10MB2023.namprd10.prod.outlook.com
 (2603:10b6:903:127::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Sat, 16 Jan
 2021 15:23:26 +0000
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7]) by CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7%7]) with mapi id 15.20.3742.012; Sat, 16 Jan 2021
 15:23:25 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: loadkeys --mktable fi >
 /usr/src/linux/drivers/tty/vt/defkeymap.c_shipped OOPSes the kernel 5.4.89
Thread-Topic: loadkeys --mktable fi >
 /usr/src/linux/drivers/tty/vt/defkeymap.c_shipped OOPSes the kernel 5.4.89
Thread-Index: AQHW7BuIgaO8dxc0RkmaNZ8xN1Ya6A==
Date:   Sat, 16 Jan 2021 15:23:25 +0000
Message-ID: <8176b7a170604460aa5e695370c821364390dd6f.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bde83a37-838d-4acf-7407-08d8ba32ab65
x-ms-traffictypediagnostic: CY4PR10MB2023:
x-microsoft-antispam-prvs: <CY4PR10MB2023C09081CEE9EFC24FB91AF4A60@CY4PR10MB2023.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4yenZcPK+hUXl+64v/RkYeaRQ1Zl5Z6WVIARfcUOy0vVlREmMaEJIoABaU0uWIPmHcVny9GiDFKMAEiWtWMurSxssyxLDSWEYdVA1YsCqmWxFxiRB/Z6dBucVGBN9cJmy875QnNvAHuQ39JgcTbApjeg5xiMj9M1N77FKDZNeOc/IYxm5/JyqOaAbvdEPYLOAlylmNwRjg/tAU36N+xon+KcSfnunImV8MfTuXjVaGpwWRAz6wA6KOA6vmbrM2Ap2QgWv2VwPDFeYX+1KFvo8bPhMR9IoBdIJHcBagBfpniB6nzmOkoXzRupIKBY4oaxlbuzgGUgza5lCKWssaFDP0/j5Ze02VC+mDyyuRHr6iKY9WgYZMmpwrG9gYEHV8opBJAG+UPzgaEeMPCGhXmxPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39850400004)(136003)(6512007)(36756003)(66946007)(76116006)(66556008)(6506007)(66476007)(478600001)(71200400001)(91956017)(64756008)(66446008)(2616005)(6486002)(8936002)(86362001)(316002)(186003)(5660300002)(6916009)(2906002)(4744005)(26005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?L204Yld3ZEFZVTFic0FrcDEzbmR4RDlrb01LM2JXNlR5YmxHTW01eHpjVFNT?=
 =?utf-8?B?YjNIVzFJeGxOMWcrWFRWWFU5N3JsZ2dnSnJ1Y1J2emhKMk5KN2JHcE50M2hV?=
 =?utf-8?B?SXhGa081Wm9vdU1SU0o3NXNJOVZ1ZDY5bCtsbzZ6U0VkRTllVGY1RkFRemt6?=
 =?utf-8?B?ZmU2dngzTUtJbWtzUUd0b1dpeGxJa2ZwR0hjakhSN3M3Z2dxTUVOcUI5Qjdl?=
 =?utf-8?B?endqdUJCQ2gzSEREK3RMVGZEcGJER1dpcW9qNTVaREY0bFh0aWRjNVMzTFpp?=
 =?utf-8?B?OUJvOHNVSzMyTStwU0hoR0hyRFlPdkdjTW8zRlNIbmVGdmdENHZuWUJEcnN0?=
 =?utf-8?B?RXZUbXFNcDVkVDRkYURKWC9HaThyVTdQbXNVS1lyQnkzbE81bFFDNG1GeDFq?=
 =?utf-8?B?QmEyRS8yZWVUTVV5RXRkelBHOE5Ba1VOeG9Vakl3eTFLcDBEcGhEUVhzbU1T?=
 =?utf-8?B?bDVaVEpXbE9pdE1MNjJOM3dpZlViVU9JM292TU1vdDYzdHRtYyttd1lNNnBH?=
 =?utf-8?B?UTVBTWFNZmVSai9oWGk2SmR5VXgwdGlwaEM1bzlrRkdIRTdyaEQ4eHRMUXBG?=
 =?utf-8?B?alZyNHlwLzlPcVdwckl2eEpjREVqMXdqdUcxaXFHbXlVUCtXb1ZwWUpxRFhw?=
 =?utf-8?B?bm02UG1ZOGhKUGNIZHNXNTIyZ1BtR0V3aER6TjZtUlhOTG1jV2VUaEZBZWVs?=
 =?utf-8?B?TU1PcjNJeG5HVVFFem5kSDNmVXR5YnFqZjBGYnlzY1JvUU5oUUtwbmRBenJ4?=
 =?utf-8?B?VlJpZFNrcVU1dkxQR2xIR2VjcU1jMkR6aUw2M3RGd2pnbEdjMi9iNjVaWVhH?=
 =?utf-8?B?QzNjTkQ2RmxzaHBvdC9RcE9BZXVjU1lXR3VwQ2M2MytJblZyVnNGOWltWWpE?=
 =?utf-8?B?d2Z6N2FpNFpDSlNoSEpHTE5LU1BHQXUwS0hBVmhzR05QekQ3NWZNT2VTNisx?=
 =?utf-8?B?bEhRSHlkTVFhTUd6VFJTWmw0VklWU1B5VWJHLzUwbXNJTFdneXpHQW9MaVcw?=
 =?utf-8?B?ZktIRkEvQzJSKzh4UDE5ZVczdEVUa0IrTkdaVTRaQjl0WUNENXRRUDM0Qmd5?=
 =?utf-8?B?aDdFcnU3NHF4K1VTYko3OHJ2ck9Oa1UzeUlDUm5EOC9tL0I5NmQ3QksxUndE?=
 =?utf-8?B?TTVoeFR6VWZwK1NhbktYejBHV2pLUlVqQ2krSGZCNHBob0hFR1lpZ2p4YWNn?=
 =?utf-8?B?QkRHV0VzM3hNaFcrMkRnYnhFUnoydDBFK2FHbE5kaWdHZlVsMDYybDlsMkZT?=
 =?utf-8?B?NVovekdENUp3U3J4OWN3SnZMeEh6dXV5QTZaNCtYaWcyMklTbVQrRUpibnNL?=
 =?utf-8?Q?CM7ujZ0wOkR19yNIWxiAmHQEct/1Zkmppx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <29617DF2002A5B458DC1E66BF8876EFF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde83a37-838d-4acf-7407-08d8ba32ab65
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2021 15:23:25.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMveN2rTSkrVEqj2KHCHGo5YPYrcekkcExbdxnLU3iVWHZsDlRLU8WnN6nUrYQ53mPDQGymCphvdu6MGwF53iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QnVpbGRpbmcgYSBrZXJuZWwgYW5kIGhhdmluZyB0aGUgZGVmYXVsdCBrZXltYXAgcmVwbGFjZWQg
d2l0aA0KICBsb2Fka2V5cyAtLW1rdGFibGUgZmkgPiAvdXNyL3NyYy9saW51eC9kcml2ZXJzL3R0
eS92dC9kZWZrZXltYXAuY19zaGlwcGVkDQptYWtlcyB0aGUga2VybmVsIE9PUFMgZHVyaW5nIHN0
YXJ0dXAuDQpUaGUgT09QUyBzY3JvbGxzIGF3YXkgYW5kIEkgY2FuIG9ubHkgc2VlIGEgZmV3IHJl
Z2lzdGVycy4NCg0KVGhlIE9PUFMgc2VlbXMgdG8gaGFwcGVuIHdoZW4gcnVubmluZyB0aGUgbG9h
ZGtleXMgY29tbWFuZC4NCldvcmtpbmcga2VybmVsIGlzIDUuNC44MA0KDQogSm9ja2UNCg==

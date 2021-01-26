Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBF3045F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403930AbhAZSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:05:43 -0500
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:63808
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389396AbhAZJYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:24:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ2wN3LZOeyL1tdlqROl1ti2QuC8rpWM9sAPOzbHnxRc2AC2yHYEWssQcEeZ/JR+RIWUpBlMzRPLi4wWibkjVkYadhKsfd78FchkmIMJIP5I8VVwZDnUZveCmU3nJ/2DVmRV/fDrgVOhARetKODE35VvWIf3k9rpGBpVzV5iHwXEJV7Y3IZWeXAWPHRwHIvnkTd8kNgWaTtoRwwFjZKWkPxQ6JUU46B59mtscif1cOWR5o9tGotcxf6h5pHP3aRLuguDuDZwI0vr3WWnrWAEyEHv8BtNlu4qea53SLX/ud8iM7QVSbnaeIQA834fj8dj2cNSful6FXhiJZaHyPfTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWkBWW24pKYj5uuM6vMM7ux1CqH2NbeqbrXEyUlPhfE=;
 b=YDxh6QqUpC6bWlJY2CbUeSrh+AA4bkY+PpksMb3dV0R7cF0E3SkBOgIDHAtCwOh1g0xHWlBs1BeQ7JlpmVrDfNBysi6xk1ar+F7ca5q+iHzCxbucg1/GFp5ios4sphF9SknCFuen/SUO6VDOVqLu6GRNp+Cyyin8SLO1H6XspsG7e8dhjO48JewGFit6eP5jS8uyN5GDVfC8YmKB/G/Ci1KFoyr4iCTQQyRl1FxNE64xSQ2tEC2ecFutyhGTi/gQY+7LF3LlJuEvmQjRGy9GBL7Hllh7YeK2iedFdOct530XNr0hNMhiLzNduYYLg4HCByKgH85xP1c6rcVgEUm/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWkBWW24pKYj5uuM6vMM7ux1CqH2NbeqbrXEyUlPhfE=;
 b=kM93sMfoxnCp2OIjXiRqQRV7vUfgRQ4UwXRgZJgEGuKYcwrYPo0Qux+I+knQRnhlc0XbMQYbUXDHhKdg46IjoWNbyxj2COb6ndl76eWwDRf+yGfdOX8Bw3vZK3l9v2F4+6HdkgE4MvakaUH26M9tiu2zpvTTR6MVmet4uexmYPc=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4242.namprd11.prod.outlook.com (2603:10b6:a03:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 09:23:11 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 09:23:11 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBzY2hlZC9jb3JlOiBhZGQgcmN1X3JlYWRfbG9jay91?=
 =?gb2312?Q?nlock()_protection?=
Thread-Topic: [PATCH] sched/core: add rcu_read_lock/unlock() protection
Thread-Index: AQHW871OhRtkc+UkqUuCtofT48UgT6o5n3+1
Date:   Tue, 26 Jan 2021 09:23:11 +0000
Message-ID: <BYAPR11MB263266B77CE79F2B9780817FFFBC9@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210126084651.32277-1-qiang.zhang@windriver.com>
In-Reply-To: <20210126084651.32277-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5a7c575-37f5-4f34-3521-08d8c1dc0015
x-ms-traffictypediagnostic: BY5PR11MB4242:
x-microsoft-antispam-prvs: <BY5PR11MB42427B9502E41000CE09AE3EFFBC9@BY5PR11MB4242.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5nkL+Lyif42xgonBgz+Drulamc8moSIGL6QOWtkFFB/5eu0fePAleMQDVUMPy0GGmOfNUOlXoK2V2bdMPja739ujjaOiKlcIbkvjUItgeLgBn1v2MsyQMEIWDX9UF/UYETVV0AEZZWb2m4fsszZOKlu/WhGDl2C3nWfVdCsUCc7CEeXtMSj4daAeYQxaWYzcvk0G6NStbwKcYXcmw2RNWS32cKjwCOD79pVQbHMpySJAE9quPfdemHR3TdULNgGlSpivgEKUSlZM4qkTwb8YtwqWSkrpeVwbzdAd5b3ojXGWXBe6huCcilhClOOhK2KlAvwC86pbCdtH/98DdzL2xTcccRjbG7nX44LYgH7jPcrctOWuW0GhMyXRlWs9i11mhC1SGtLqREll0ZpuFf4Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39850400004)(9686003)(5660300002)(55016002)(52536014)(8936002)(478600001)(7696005)(316002)(224303003)(71200400001)(91956017)(64756008)(26005)(66556008)(54906003)(66476007)(4326008)(76116006)(66446008)(33656002)(83380400001)(2906002)(6916009)(186003)(66946007)(86362001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?UjFidms5Lzc5RzczcnM5d1ZhNGNSTXVVc1M4ZlM0M01nY3pMeEswZS9paGZS?=
 =?gb2312?B?TG53TmwybzdWTFBMbWU5cHRsamZZQ0hiWmNxQ0tJQ1ZiczR4bVBtRG5UMkY3?=
 =?gb2312?B?QlF1a3JaQXpvQVlha2taT3dzNnplRkFKZnAxeTdpS2hJQXNQUnRxZFozK3Rn?=
 =?gb2312?B?YkF2T3RpK1Z0bElpWGZIaXdBd3M2T3pUeHlPSUNvQlY3cXlpM1YzMGRpZng0?=
 =?gb2312?B?ci8zSmY3aVhEd2dDOU8yY2lBSjJnemFHK1lQVGhrMTU3V2hjUGZ1YVljM2lr?=
 =?gb2312?B?Y3dqaHFtMXVoZDlFTjRXNVEwRExvckVGNm92bE1RK21rTnJPNlVkWVZ4YUlH?=
 =?gb2312?B?UHFvT3MyKzdLblVkTjdYU013dm9uUFlVOHBsZ0NVcGc4RTFQNW51Sk0zdHRS?=
 =?gb2312?B?YXVITUhoL1F4MEhxNXpabmdWVVJzd2NkN3FjY2E4YnVyOUMwcWNqNC85Z21Z?=
 =?gb2312?B?MUlBTUptNEpxQzBGb2lOTUZvUTJzczd5UHh3ZTNMWXBMdjUzWWpSaVl0cEx1?=
 =?gb2312?B?dldMWUJQVzNjNU1CdmRQejRiWTNCL0wvV2dlaGR4OEhhZ053bmJabG52SzZz?=
 =?gb2312?B?YWxTNVp3eG1tVmVlbURGT25TQzRiOEpzWWJ6YmpxRGtaV3d3Tnkwa1BsUERv?=
 =?gb2312?B?QTJZSzJ3NnZpSi95WGpvQk5jSWo5TU5HMTJJZE5DU3QwdWJJbUQrZHhLM1Vh?=
 =?gb2312?B?ZWhDRzV5S0VmTG05Y0Z2N0NLeWdQaVIxZk45UWlRZGJuQkc2d2dXNUYrVXRz?=
 =?gb2312?B?aUJCb1JWR1h0dnlEdG92Y1AybDBXWExGd0Y3eC83M0hkOE10SEtNZmx0THRO?=
 =?gb2312?B?YlBZNTI1c3JlVXdBU2YveHE2UlJOWXNSTU5QUCtkMW85TkxZY0plNGdpR1lV?=
 =?gb2312?B?eXkrbTd1VmhQL216Y3JPQ05sblhxSkliSWgyckdYTTFUaE5mOFl2Z0tkSTVK?=
 =?gb2312?B?NlM5S3Y3NUZkdEt5Z1RzTDlHWmZ3dDd2MEUvbXBMazB6Qyt6VjlOWU1mdnJq?=
 =?gb2312?B?WnV4cURsdnVIYmFJSkM4ZGtucFYrdHF3VGZYQnh4dE96NWFtSUFoS2w0a0xr?=
 =?gb2312?B?OGE1WWpSaHJ2WU42SmQvSThldzR4VTVya2k2b1ZtT0pkL0U2emVhZmF1N0Vs?=
 =?gb2312?B?a29OQ2JqNHhXeXJtQlVzZEhYNzFSaUt2L3QwNlEzd0RmbXl2cm4rU3ZLTnV0?=
 =?gb2312?B?V2RYVjB1TmU0ZHFQdG5zSldZbVlUV081a2FZcFA5aFFTSzRDS0hBenJiVTRo?=
 =?gb2312?B?OWFwaVlTRmFzN21zYUpzcjBTYUFaUjBmdHFTcFdOZnVTYzh3WFZLYUlyV05J?=
 =?gb2312?B?SWcvZWN2SGdzdmkrSkY5YVdyUFE5eWdiQmlFSWcyRllHS2tMNU1WTjRUa1ZZ?=
 =?gb2312?Q?gPcByEnJI5ZmBiJsxsfVMe5qAFev28Qk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a7c575-37f5-4f34-3521-08d8c1dc0015
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 09:23:11.0641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVYwMY9lqei2IR411y6mTeLvdz5wAaq7XFVKTh0Uezl3/lTdkj7/A2S4AkQbwLcbdwAuEhmSjhnXbDLODzdlJzOzOEbo+8q7ub7ANUyemmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogWmhhbmcs
IFFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgq3osvNyrG85DogMjAyMcTqMdTCMjbI
1SAxNjoyOQrK1bz+yMs6IHZhbGVudGluLnNjaG5laWRlckBhcm0uY29tCrOty806IHBldGVyekBp
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCtb3zOI6IFtQQVRDSF0g
c2NoZWQvY29yZTogYWRkIHJjdV9yZWFkX2xvY2svdW5sb2NrKCkgcHJvdGVjdGlvbgoKPkZyb206
IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KCj5EdWUgdG8gZm9yX2VhY2hfcHJv
Y2Vzc190aHJlYWQgYmVsb25ncyB0byBSQ1UgcmVhZCBvcGVyYXRpb24sCj5uZWVkIHRvIGFkZCBy
Y3VfcmVhZF9sb2NrL3VubG9jaygpIHByb3RlY3Rpb24uCgogIFNvcnJ5IHRvIGRpc3R1cmIgeW91
CiAgSSBmaW5kIGl0J3MgYWxyZWFkeSBpbiB0aGUgUkNVIGNyaXRpY2FsIHpvbmUKICBQbGVhc2Ug
aWdub3JlIHRoaXMgY2hhbmdlCgoKPlNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdA
d2luZHJpdmVyLmNvbT4KPi0tLQo+IGtlcm5lbC9zY2hlZC9jb3JlLmMgfCAyICsrCj4gMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj5kaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2Nv
cmUuYyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMKPmluZGV4IDhjNTQ4MTA3N2M5Yy4uYzNmMDEwM2Zk
ZjUzIDEwMDY0NAo+LS0tIGEva2VybmVsL3NjaGVkL2NvcmUuYwo+KysrIGIva2VybmVsL3NjaGVk
L2NvcmUuYwo+QEAgLTc3MzgsNiArNzczOCw3IEBAIHN0YXRpYyB2b2lkIGR1bXBfcnFfdGFza3Mo
c3RydWN0IHJxICpycSwgY29uc3QgY2hhciAqbG9nbHZsKQo+ICAgICAgICBsb2NrZGVwX2Fzc2Vy
dF9oZWxkKCZycS0+bG9jayk7Cj4KPiAgICAgICAgcHJpbnRrKCIlc0NQVSVkIGVucXVldWVkIHRh
c2tzICgldSB0b3RhbCk6XG4iLCBsb2dsdmwsIGNwdSwgcnEtPm5yX3J1bm5pbmcpOwo+KyAgICAg
ICByY3VfcmVhZF9sb2NrKCk7Cj4gICAgICAgIGZvcl9lYWNoX3Byb2Nlc3NfdGhyZWFkKGcsIHAp
IHsKPiAgICAgICAgICAgICAgICBpZiAodGFza19jcHUocCkgIT0gY3B1KQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7Cj5AQCAtNzc0Nyw2ICs3NzQ4LDcgQEAgc3RhdGljIHZvaWQg
ZHVtcF9ycV90YXNrcyhzdHJ1Y3QgcnEgKnJxLCBjb25zdCBjaGFyICpsb2dsdmwpCj4KPiAgICAg
ICAgICAgICAgICBwcmludGsoIiVzXHRwaWQ6ICVkLCBuYW1lOiAlc1xuIiwgbG9nbHZsLCBwLT5w
aWQsIHAtPmNvbW0pOwo+ICAgICAgICB9Cj4rICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+IH0K
Pgo+IGludCBzY2hlZF9jcHVfZHlpbmcodW5zaWduZWQgaW50IGNwdSkKLS0KMi4xNy4xCgo=

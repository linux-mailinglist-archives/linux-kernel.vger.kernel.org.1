Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6442848C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJFIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:45:59 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:64102 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgJFIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:45:58 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0968atiY014770;
        Tue, 6 Oct 2020 04:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=WE2aB0L1662f2eZtgyt4XR2LOyxm/pg8BntZWnGNZjg=;
 b=ngguuK1PTZZ0QZmOz/+xaW7hY8xNNu4d2IolH/3JzErR2Isc+hDRJ3Kh3NEVLuNDdf7p
 tP1r6A5/RLgtmuNgZAVOxcfumc6eF9PNBUWF26WpOzQgzAgV63D4zxmYTz5sIHYCbs8a
 inbgfJtG7LiYDlhouTxr/5/ZSNRUTadGZ7iInsIwEKZNmId1R+Oq03rJyVQYEGOr6ZqV
 lMcRcSsI1JAzG2QZaO/li0vPlRyVz906Qqh7jjMum9j5hHF9WJGMN8AdgErbFP6rtOD3
 AKLWrRqLghu9/IGxXSqgKd5bwh/chJO2qrXHQ7/SOLekPSwCSpzlTaDCK1XJMFJ7me2D iQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 33xmewr2dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 04:46:07 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0968gVVH080014;
        Tue, 6 Oct 2020 04:46:07 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00154901.pphosted.com with ESMTP id 340mg7gpfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 04:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhO+WJ3IauXCo+Jz4CiekM1B/2IlbmeigHagnaZYP2ySgk9mRxOdVVEE0QJ8hJFw3z1zUY53g/QWgJamRIl7XIJ2rEewJNgtUAhLGmdgTtoyx9pZNbUh5xuzfeVg2DMgpm5XnVVC8teY1ZqtvhEYPMmGwv6cSkwM5h5Eztb5NOcG9hokXJfi7it7N32mh2AweqKPs7Rj7gE2pK2//6sRJZD1f8d17+taKGBPFxOCrdwU/WKk/SptBOBba6WbylsEBK+W9mvtFu8spWzdIrO76tKERLDbyzEarLjewX5bMNBt5Xay3IJ6XevvaMwdF/56YcPFu+NC+y8pi4dLXWm/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE2aB0L1662f2eZtgyt4XR2LOyxm/pg8BntZWnGNZjg=;
 b=LXeIcOMe1XIhw1DirF6Azvl1VdaIH7gO4z2FV1Y9kvRtsORw9MTSg70XpkM1My2WzhKfiBpjWNgTfJRKkqHBReBze4arw/H5qPXfNE+NqtRpeVDK3bO/3yikiUXxmHHeSr21oSJKw/KASDf6xXCJFWo6BkMFtAtjnK7DFusnFJfdAKSIZNa0AEZBA668L+9RW+9gaRpBFM3kxx4mJUB7DxDpEqCeZLBaSU+9Ryz/8yIGAilQDRCqToqAtF0cr1bsf72SSCFYdmjp+B6jNA9bWOUV4bUmPcOU3/cdrZW7AXzRE/x3Tpa8EyBrMW3rtbvn+4YRQKlWwLVq31cUEiU9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE2aB0L1662f2eZtgyt4XR2LOyxm/pg8BntZWnGNZjg=;
 b=OdsiVvKeeStPwd+O9MWiw8mMjRvzRQkZWwt7JXfTdG66DP2I0hXUzvSxZUHODSuXYEJtPlPyhqY9Rb2cGV5F1IwlJYbf0XsRUKevq53IP7iGiVZkyFVllXqBN1lf6r1egEj38WOQSXK5742HH/LQniFJjJK36qXcyp9JgUwEfxw=
Received: from CY4PR19MB1254.namprd19.prod.outlook.com (2603:10b6:903:109::19)
 by CY4PR19MB1557.namprd19.prod.outlook.com (2603:10b6:903:14d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Tue, 6 Oct
 2020 08:46:05 +0000
Received: from CY4PR19MB1254.namprd19.prod.outlook.com
 ([fe80::28f2:1ae1:8ba:4bfc]) by CY4PR19MB1254.namprd19.prod.outlook.com
 ([fe80::28f2:1ae1:8ba:4bfc%11]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 08:46:05 +0000
From:   "Bharathi, Divya" <Divya.Bharathi@Dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Topic: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Index: AQHWlgw8iScoxjhp9kO1Bw1J0X/FTKmDEwiAgAc4+8A=
Date:   Tue, 6 Oct 2020 08:46:05 +0000
Message-ID: <CY4PR19MB125486920AE0C6CA105B973A850D0@CY4PR19MB1254.namprd19.prod.outlook.com>
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <7015e6d5-3c1e-e07e-572f-d5d47a9b0191@redhat.com>
In-Reply-To: <7015e6d5-3c1e-e07e-572f-d5d47a9b0191@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [223.226.93.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e66531d-6794-4ec3-b815-08d869d4430f
x-ms-traffictypediagnostic: CY4PR19MB1557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR19MB155787EBAB1E5B1C36B08945850D0@CY4PR19MB1557.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fqMulSX7krHMQ/EiD5DI9lGY/ScLrLSkYVMsew37IWHfPLEXDwQy59RloFPbe9xH5liGDcncmFT26jc1e9SNBTWGcqZGXql21REI/CdLPd4bLkIL9H2k6fwFXRe2dL6lO2cTz5ePL+jb9on/4vNz5xUBZFI+17JC1XnpdG/VocVbJwio8d1vCNKqQCn+s2Z9nymPF9jD0eboEVJXXVt7aNsJPYwdkK0hYpXmiJOpDISdHAMiNI+5y/3nttN/o39ZnJBpDkWMUZVqOLJSP52K4FWbs7/wu2LJy4dZ1RzDbwGyh4Qmv7HOKMj+HugAMYr/Js3PWnOVS+JhvMCtkrgksA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR19MB1254.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(33656002)(4326008)(316002)(52536014)(786003)(66946007)(5660300002)(8936002)(55016002)(26005)(107886003)(6506007)(86362001)(9686003)(55236004)(478600001)(66556008)(66476007)(71200400001)(8676002)(7696005)(76116006)(186003)(66446008)(110136005)(64756008)(83380400001)(54906003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tBXHaMmbmu7uF0mCRpsnNGQvjadOutDSF7XH5fp+bw/SnMNaLHoNuZyXJYNGl8OR3Fe7dfOO1/h/MQMKO8E/XcwqoXl5DS9OYdlRchFCDauKy+Jp7JMMquDlvKodt+/5FeJDQYQteniQTPa1uPPUKiiUxCA5t7Vuqvd5QsegnsLslOsdGrx1JPCGl47wAe22hmKxn8ewvvDq+W5E6WCqYUV+5f78hncwyFM0HniKCNkJk+u3zLSDi5M7GbRaee6XegM63C9iU2kD7yOrqEp3iVxmc6hweuHUzUYxkb8kpKJPMtYJUuOcqxkqrovMq2uAMMo2z2ZwSu0HX2Yh9QrqeRhNITie4y0kfhhO3gY+G0sfpuCvOrGehJKzxeDOYxRr3l6hJ5pOYS2PpA0dh9oOpeoXZi2Yy36b67ZJ0Y94odrCqxI1I9+mKeapWLFfWT842R+JhUYQsk73M5xfeAN6cvuP8zmwuMrjIcsCUP03pWh03klYWlEQNH4dIl2csruUGmFdselofaDp+RNPp53feaoQSNhxu3+WHjsPP7n55pO3MMlvR0/5JbBc59lCZoMconNfl+pk+b8cCDDcsk9EAxpociP8LfZwfjUDp9m3IgN2mN0NBoPDVFhHe+EmrI4ndEtqBzLjXKWJav3i8+gXUQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR19MB1254.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e66531d-6794-4ec3-b815-08d869d4430f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 08:46:05.1162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cR2CzBEDXfs1EHKQaYwB8zSjacOBL/6g/FIzEgYTt2XTOeRIYRi9bBWRiPrYE9Wfkh+CPSIQ0qFiL3HlcnZl3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR19MB1557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_03:2020-10-06,2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060054
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIGFub3RoZXIgbWFpbCBvbiBzYW1lIHBhdGNoLiBJIG1pc3NlZCB0byBhZGQgb25l
IHJlc3BvbnNlIG9uDQpwcmV2aW91cyBjb21tZW50cyANCg0KPHNuaXA+DQoNCj4gPiArLyoqDQo+
ID4gKyAqIGluaXRfYmlvc19hdHRyaWJ1dGVzKCkgLSBJbml0aWFsaXplIGFsbCBhdHRyaWJ1dGVz
IGZvciBhIHR5cGUNCj4gPiArICogQGF0dHJfdHlwZTogVGhlIGF0dHJpYnV0ZSB0eXBlIHRvIGlu
aXRpYWxpemUNCj4gPiArICogQGd1aWQ6IFRoZSBXTUkgR1VJRCBhc3NvY2lhdGVkIHdpdGggdGhp
cyB0eXBlIHRvIGluaXRpYWxpemUNCj4gPiArICoNCj4gPiArICogSW5pdGlhbGlhemUgYWxsIDQg
dHlwZXMgb2YgYXR0cmlidXRlcyBlbnVtZXJhdGlvbiwgaW50ZWdlciwgc3RyaW5nIGFuZA0KPiBw
YXNzd29yZCBvYmplY3QuDQo+ID4gKyAqIFBvcHVsYXRlcyBlYWNoIGF0dHJidXRlIHR5cCdzIHJl
c3BlY3RpdmUgcHJvcGVydGllcyB1bmRlciBzeXNmcyBmaWxlcw0KPiA+ICsgKiovDQo+ID4gK3N0
YXRpYyBpbnQgaW5pdF9iaW9zX2F0dHJpYnV0ZXMoaW50IGF0dHJfdHlwZSwgY29uc3QgY2hhciAq
Z3VpZCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGtvYmplY3QgKmF0dHJfbmFtZV9rb2JqOyAvL2lu
ZGl2aWR1YWwgYXR0cmlidXRlIG5hbWVzDQo+ID4gKwl1bmlvbiBhY3BpX29iamVjdCAqb2JqID0g
TlVMTDsNCj4gPiArCXVuaW9uIGFjcGlfb2JqZWN0ICplbGVtZW50czsNCj4gPiArCXN0cnVjdCBr
c2V0ICp0bXBfc2V0Ow0KPiA+ICsNCj4gPiArCS8qIGluc3RhbmNlX2lkIG5lZWRzIHRvIGJlIHJl
c2V0IGZvciBlYWNoIHR5cGUgR1VJRA0KPiA+ICsJICogYWxzbywgaW5zdGFuY2UgSURzIGFyZSB1
bmlxdWUgd2l0aGluIEdVSUQgYnV0IG5vdCBhY3Jvc3MNCj4gPiArCSAqLw0KPiA+ICsJaW50IGlu
c3RhbmNlX2lkID0gMDsNCj4gPiArCWludCByZXR2YWwgPSAwOw0KPiA+ICsNCj4gPiArCXJldHZh
bCA9IGFsbG9jX2F0dHJpYnV0ZXNfZGF0YShhdHRyX3R5cGUpOw0KPiA+ICsJaWYgKHJldHZhbCkN
Cj4gPiArCQlyZXR1cm4gcmV0dmFsOw0KPiA+ICsJLyogbmVlZCB0byB1c2Ugc3BlY2lmaWMgaW5z
dGFuY2VfaWQgYW5kIGd1aWQgY29tYmluYXRpb24gdG8gZ2V0IHJpZ2h0DQo+IGRhdGEgKi8NCj4g
PiArCW9iaiA9IGdldF93bWlvYmpfcG9pbnRlcihpbnN0YW5jZV9pZCwgZ3VpZCk7DQo+ID4gKwlp
ZiAoIW9iaikNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArCWVsZW1lbnRzID0gb2JqLT5w
YWNrYWdlLmVsZW1lbnRzOw0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJndtaV9wcml2Lm11dGV4
KTsNCj4gPiArCXdoaWxlIChlbGVtZW50cykgew0KPiA+ICsJCS8qIHNhbml0eSBjaGVja2luZyAq
Lw0KPiA+ICsJCWlmIChzdHJsZW4oZWxlbWVudHNbQVRUUl9OQU1FXS5zdHJpbmcucG9pbnRlcikg
PT0gMCkgew0KPiA+ICsJCQlwcl9kZWJ1ZygiZW1wdHkgYXR0cmlidXRlIGZvdW5kXG4iKTsNCj4g
PiArCQkJZ290byBuZXh0b2JqOw0KPiA+ICsJCX0NCj4gPiArCQlpZiAoYXR0cl90eXBlID09IFBP
KQ0KPiA+ICsJCQl0bXBfc2V0ID0gd21pX3ByaXYuYXV0aGVudGljYXRpb25fZGlyX2tzZXQ7DQo+
ID4gKwkJZWxzZQ0KPiA+ICsJCQl0bXBfc2V0ID0gd21pX3ByaXYubWFpbl9kaXJfa3NldDsNCj4g
PiArDQo+ID4gKwkJaWYgKGtzZXRfZmluZF9vYmoodG1wX3NldCwNCj4gZWxlbWVudHNbQVRUUl9O
QU1FXS5zdHJpbmcucG9pbnRlcikpIHsNCj4gPiArCQkJcHJfZGVidWcoImR1cGxpY2F0ZSBhdHRy
aWJ1dGUgbmFtZSBmb3VuZCAtICVzXG4iLA0KPiA+ICsJCQkJZWxlbWVudHNbQVRUUl9OQU1FXS5z
dHJpbmcucG9pbnRlcik7DQo+ID4gKwkJCWdvdG8gbmV4dG9iajsNCj4gPiArCQl9DQo+ID4gKw0K
PiA+ICsJCS8qIGJ1aWxkIGF0dHJpYnV0ZSAqLw0KPiA+ICsJCWF0dHJfbmFtZV9rb2JqID0ga3ph
bGxvYyhzaXplb2YoKmF0dHJfbmFtZV9rb2JqKSwNCj4gR0ZQX0tFUk5FTCk7DQo+ID4gKwkJaWYg
KCFhdHRyX25hbWVfa29iaikNCj4gPiArCQkJZ290byBlcnJfYXR0cl9pbml0Ow0KPiA+ICsNCj4g
PiArCQlhdHRyX25hbWVfa29iai0+a3NldCA9IHRtcF9zZXQ7DQo+ID4gKw0KPiA+ICsJCXJldHZh
bCA9IGtvYmplY3RfaW5pdF9hbmRfYWRkKGF0dHJfbmFtZV9rb2JqLA0KPiAmYXR0cl9uYW1lX2t0
eXBlLCBOVUxMLCAiJXMiLA0KPiA+ICsNCj4gCWVsZW1lbnRzW0FUVFJfTkFNRV0uc3RyaW5nLnBv
aW50ZXIpOw0KPiA+ICsJCWlmIChyZXR2YWwpIHsNCj4gPiArCQkJa29iamVjdF9wdXQoYXR0cl9u
YW1lX2tvYmopOw0KPiA+ICsJCQlnb3RvIGVycl9hdHRyX2luaXQ7DQo+ID4gKwkJfQ0KPiA+ICsN
Cj4gPiArCQkvKiBlbnVtZXJhdGUgYWxsIG9mIHRoaXMgYXR0cmlidXRlICovDQo+ID4gKwkJc3dp
dGNoIChhdHRyX3R5cGUpIHsNCj4gPiArCQljYXNlIEVOVU06DQo+ID4gKwkJCXJldHZhbCA9IHBv
cHVsYXRlX2VudW1fZGF0YShlbGVtZW50cywgaW5zdGFuY2VfaWQsDQo+IGF0dHJfbmFtZV9rb2Jq
KTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJY2FzZSBJTlQ6DQo+ID4gKwkJCXJldHZhbCA9IHBv
cHVsYXRlX2ludF9kYXRhKGVsZW1lbnRzLCBpbnN0YW5jZV9pZCwNCj4gYXR0cl9uYW1lX2tvYmop
Ow0KPiA+ICsJCQlicmVhazsNCj4gPiArCQljYXNlIFNUUjoNCj4gPiArCQkJcmV0dmFsID0gcG9w
dWxhdGVfc3RyX2RhdGEoZWxlbWVudHMsIGluc3RhbmNlX2lkLA0KPiBhdHRyX25hbWVfa29iaik7
DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCWNhc2UgUE86DQo+ID4gKwkJCXJldHZhbCA9IHBvcHVs
YXRlX3BvX2RhdGEoZWxlbWVudHMsIGluc3RhbmNlX2lkLA0KPiBhdHRyX25hbWVfa29iaik7DQo+
ID4gKwkJCWJyZWFrOw0KPiA+ICsJCWRlZmF1bHQ6DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0N
Cj4gDQo+IFRoZSBzaG93IGZ1bmN0aW9ucyBkb24ndCB0YWtlIHRoZSBtdXRleCBhbmQgY2FuIGJl
IGNhbGxlZCBhcyBzb29uIGFzDQo+IGtvYmplY3RfaW5pdF9hbmRfYWRkKCkgaXMgY2FsbGVkLCBz
byBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZmlyc3QgcG9wdWxhdGUgdGhlDQo+IGRhdGEgZm9yIHRo
ZSBjdXJyZW50IGluc3RhbmNlX2lkIGFuZCBvbmx5IHRoZW4gY2FsbCBrb2JqZWN0X2luaXRfYW5k
X2FkZCgpDQo+IA0KDQpQb3B1bGF0ZSBmdW5jdGlvbnMgY2FsbGVkIGhlcmUgZm9yIGVhY2ggdHlw
ZSBvZiBhdHRyaWJ1dGUgdXNlcw0KYXR0cmlidXRlX2tvamVjdCB3aGljaCBoZWxwcyBpbiBhdHRy
aWJ1dGUgZ3JvdXAgY2xlYW51cC4NCg0KUmVnYXJkcywNCkRpdnlhIA0K

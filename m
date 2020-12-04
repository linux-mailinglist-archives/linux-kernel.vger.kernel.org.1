Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08982CE6F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgLDEIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:08:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8582 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727522AbgLDEIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:08:46 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B444GPq029179;
        Thu, 3 Dec 2020 20:07:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=B2JQ/DR8cv7Ga3W7p/REvYDs0ttzHZw+y9Cp00vR4+k=;
 b=c30648YivYacG31GXG+rqD/20ebZ9XRbvGyw6NlB48JR36g42Hr0Sp0p8POWeb8/Czow
 6juOAkgLiqco1QLZEfiGFPXz7AO2r1NBV31HAuTN0xkTBreY2UWXFPg2TdxCvxcN5wym
 XCSlEBzr7M5oWGO0qlJJ26h3LHjeEdIQpxw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3562ma8pkb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 20:07:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 20:07:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw9WA5TBhOQmR0tbQwAgcpM+eR0LoeMR2eeXGZbA7I75z+21kzWLJT+aQfSDU4tkhqESXyXtqlNUdfL7pFTV12yIC2I0fiz3Pxrfj+9bHQRGmDsphyUQnV/oycZSW/udDshULMoinHEb94e56nFKVPGHQqdkK8bbVfVeZftITEC9Rvx1pp4KhXWxlQLP5gL9e1dhbcpXcuCDXMSYeF1+ANSO+pnZrkirBwCJYVhWmIi/N70PFHhDWxVrhE3wC0OPI/An2n9St8dawMK490/2OmcDM5w6z71kvpBkKXPUmT5OJPUrJeXP3taFBiKIuvtzGgcA7UKQ45+vNW99OVdtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2JQ/DR8cv7Ga3W7p/REvYDs0ttzHZw+y9Cp00vR4+k=;
 b=kjZ4Be2wu19/UCCNFnve6bUU0lpEQzQoT0c0+D58BU3sVPujptWo8HIAnIRQ3vWeMtE9nu0tBi09dgJK+LZZ9p707mN0IZ7UEg9HJJlUQLyeBrLmyL+GRUtmDhfSR+uVh967gYtCOE//nZXTeXUONxA/IHwjaMWMSC//PmXW7TCxpWXS+gAT+Oh3dAn3BsmY+FGX7yqSFaS2LNXAQpmfv9+o152g5gCNPNWc8yyaW1JPXCo0wjpid6BdHSZiScZQPrkzWsTd2gMuEzYX8xx+TTJ2VIArBNNDoVmdSwCDOa6l3tMh1+DIzDKek4a49DmZoDOJKoWjPKuIuk3mBMhHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2JQ/DR8cv7Ga3W7p/REvYDs0ttzHZw+y9Cp00vR4+k=;
 b=J+RdeuBG+x+4l9e0f1K6tL2sx8MXJA9SCtjRf/Sfx7P/nwmWuV028z5UPjUSLb7wtyOlQdcspqoV3cmGbzAeZfKMiblyWbuxbRcaXPu6nxKNyX769yV4X5gAaNHISPWUZuC2u/I8iAHqXzupg075kF04WUfUFJyHMlZgIAtRR/Y=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3206.namprd15.prod.outlook.com (2603:10b6:a03:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 04:07:44 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3611.034; Fri, 4 Dec 2020
 04:07:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v1 2/2] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v1 2/2] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHWyI7GNKnhJbT46UiaOkZ9Hecf1anmB8qAgABNIQA=
Date:   Fri, 4 Dec 2020 04:07:44 +0000
Message-ID: <41603856-ADE3-4765-A578-8AEBAB2301DD@fb.com>
References: <20201202093709.3374099-1-songliubraving@fb.com>
 <20201202093709.3374099-3-songliubraving@fb.com>
 <20201203233141.GE3613628@krava>
In-Reply-To: <20201203233141.GE3613628@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:2c22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdaac8f4-0716-43f7-dc03-08d8980a2725
x-ms-traffictypediagnostic: BYAPR15MB3206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB32064E9FBA8C5849ADEA7BD7B3F10@BYAPR15MB3206.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taIMzXVQix2TuXgJXqQggRoWHC6x7uslDRDMOY7/ryqMGxp3dRAbh2qY65VHmzjuKNgn0K5zevicjMA0BdbMCZ20cRfsL9yjlR84hwd1xqhFftDb1JKzr+alB4xpcexiEjDomATDTeF+5FOItpsOiSaxAHT7i2+d91WwixDaJ0XwDMIJSPuvjnYvUhIZHxRq6Vn371PmmwGDlcKf28SAV74kthoE21jEDwBKpV2IJwWQpgNLsQkdnazEY0VKApHG40VOOu9HQ2Pin7CR3i/7gvG1VwEFF7Z8SK8+M/CniKOk4r1VERoLv3LS/NucJIJxTMC1DjoLW/dN3RqxIFnLFoo3dgYGTuoBm59M3RBL8ima/CH6LtGjoMOtZGZiGlPa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(136003)(366004)(76116006)(66946007)(2616005)(6506007)(53546011)(36756003)(6916009)(64756008)(66446008)(66556008)(4326008)(86362001)(2906002)(5660300002)(66476007)(8676002)(478600001)(6486002)(8936002)(71200400001)(54906003)(33656002)(316002)(91956017)(6512007)(4744005)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkFTOFBhZk04dzVMK3RxbWwrVnB3c2k1d3VDV2hIQjFJMW13U01oNHhFaUt1?=
 =?utf-8?B?bytmanFKeTBTN01qd0xXd3I0TzFYcFRpUGtRK0pEaEk5ZXRwaSs2eFFhSFU3?=
 =?utf-8?B?ZnFEY0d6dHlBL0pOM1NnaXhkeVFSdmkrZ1JNVEpaYVQwOGZpcU9IQ0lwUUc3?=
 =?utf-8?B?aTJnKzNXVDFLQktpZEwwUEc4WFM1Q3VRa1pLMHRxbmx4TVFTY2pqWnZDY1NQ?=
 =?utf-8?B?eG5vWHZQWGZiZXlYajFYdGFkeXRxNysxWjJZcXo5eDQwalJySlpIT1FQUFRm?=
 =?utf-8?B?NVBqOWlYdDkyd3IrZUlzTFZGSzdQVGg1RWhUdXhCcngwVmVISFQ5eU1pOHJC?=
 =?utf-8?B?NFR5SFpCcjl2ekNlWlRrVEZrVVNGRFk0ekZTZFhCb1lwK09qSWg3c0R6RUlv?=
 =?utf-8?B?Ujlqb2Nid3lDV1dsK2w3VzliZFpXL1dZMWx5VC9tNzVZYnVVejhzYmJ1bkJh?=
 =?utf-8?B?VGtQVUFmOUNUcEZ1Y1dqSXhvazltNGt5UzJnRExkNUFMRFZ1K0tsS0JGVEc0?=
 =?utf-8?B?anZMdWhaQWpSejhJYlp1RzlTbUdFUWlLSmw1WElPdTlSN0hoUnZIdVRGNFY2?=
 =?utf-8?B?TzNlVlJMSDFFY2ZwZ3VmeEVtT1dNSW13VjdCMm03L3p2djlTL2lXNTM2aDIr?=
 =?utf-8?B?YWFscVlDUFdIU2JycWdqMDlSOXViZThDYnV2Y2lNUkl2RFAxYURBbjA1bVRH?=
 =?utf-8?B?TVg1RURMbUptUzZFRTlKbXViMVJ0dXZYbGNKUVhOVkZxUFlyWVVBMGlvRlJL?=
 =?utf-8?B?ZCtqNm1VVUxHeEZqcjZiZG82VHpPaWR2RDRNdDdvRld2a1BPRXRYRWpacTJU?=
 =?utf-8?B?YUMrSDAyaWJXN2hNSXVtVEJpOHd5OVNBdGFuM3NXU0Rzd0xaakNSYWthUmlO?=
 =?utf-8?B?ZmR0ZS83R25kem9oN3FCZ2YrVkozUkZCSzMvT3ZHQ1AzWmZrVnlsK3FEYmxv?=
 =?utf-8?B?MlNIVlFEU0pDZ1FJWG9mRUQwMEg1aGE1SnFtUmt2b1Ewdjc4ZFF3NVZJSG85?=
 =?utf-8?B?UndXL3VQSWlXa0JNdXN5cHoxdU1USUVMYUlTd05pQ3FSNWxuc2RFdHc5azVy?=
 =?utf-8?B?V3pEeEhBdFA2SVk2UzcwMU5KUWRSdWxvbzdxa05vbi80TzNSR1NNM3haWDZB?=
 =?utf-8?B?UzBIOWhrYVVwRlVEVnhFU216U1Z6RjhlUUZtVGpJT2poUDRUeU1wMjJScEd3?=
 =?utf-8?B?bmR1OTRBSTg1Y3NqaC9iaksybll2N1FlQi9zdWtpY01mRUpFSmVEcDhGTERQ?=
 =?utf-8?B?Sno5WWhQdC9DRDN0KzRqakNJVmI0NVh6aStQUGhPdzF0VUJNdHFYRzRYbitJ?=
 =?utf-8?B?MUJxQ1R4SVdaMklQZ2RPTFNwNE9NVlR2aGxQMmEvQUdVY3ZlU2J3dU5Vcis3?=
 =?utf-8?Q?5rzV6jMLiyhpX4BczCD5HJkYA6QArl3M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B94CCA9F2FF10347AEA0944B47A61A8C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaac8f4-0716-43f7-dc03-08d8980a2725
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 04:07:44.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3t4CfYgK7qSiB1Uqc6s1e0WX3mQNFNRz4kmkT4KI+eUWhku5JSZrh+JpvJWGOwGFJqNGXlCHlSUxuLDaxdGrYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3206
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-03,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRGVjIDMsIDIwMjAsIGF0IDM6MzEgUE0sIEppcmkgT2xzYSA8am9sc2FAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIERlYyAwMiwgMjAyMCBhdCAwMTozNzowOUFNIC0w
ODAwLCBTb25nIExpdSB3cm90ZToNCj4+IEludHJvZHVjZSBwZXJmLXN0YXQgLWIgb3B0aW9uLCB3
aGljaCBjb3VudHMgZXZlbnRzIGZvciBCUEYgcHJvZ3JhbXMsIGxpa2U6DQo+PiANCj4+IFtyb290
QGxvY2FsaG9zdCB+XSMgfi9wZXJmIHN0YXQgLWUgcmVmLWN5Y2xlcyxjeWNsZXMgLWIgMjU0IC1J
IDEwMDANCj4+ICAgICAxLjQ4NzkwMzgyMiAgICAgICAgICAgIDExNSwyMDAgICAgICByZWYtY3lj
bGVzDQo+PiAgICAgMS40ODc5MDM4MjIgICAgICAgICAgICAgODYsMDEyICAgICAgY3ljbGVzDQo+
PiAgICAgMi40ODkxNDcwMjkgICAgICAgICAgICAgODAsNTYwICAgICAgcmVmLWN5Y2xlcw0KPj4g
ICAgIDIuNDg5MTQ3MDI5ICAgICAgICAgICAgIDczLDc4NCAgICAgIGN5Y2xlcw0KPj4gICAgIDMu
NDkwMzQxODI1ICAgICAgICAgICAgIDYwLDcyMCAgICAgIHJlZi1jeWNsZXMNCj4+ICAgICAzLjQ5
MDM0MTgyNSAgICAgICAgICAgICAzNyw3OTcgICAgICBjeWNsZXMNCj4+ICAgICA0LjQ5MTU0MDg4
NyAgICAgICAgICAgICAzNywxMjAgICAgICByZWYtY3ljbGVzDQo+PiAgICAgNC40OTE1NDA4ODcg
ICAgICAgICAgICAgMzEsOTYzICAgICAgY3ljbGVzDQo+IA0KPiBoaSwNCj4gSSdtIGdldHRpbmcg
Y29tcGlsZSBmYWlsIHdpdGggZ2NjIDEwOg0KPiANCj4gCWJ1aWx0aW4tc3RhdC5jOiBJbiBmdW5j
dGlvbiDigJhjbWRfc3RhdOKAmToNCj4gCWJ1aWx0aW4tc3RhdC5jOjI0Mjk6NzogZXJyb3I6IGRl
Y2xhcmF0aW9uIG9mIOKAmGVycuKAmSBzaGFkb3dzIGEgcHJldmlvdXMgbG9jYWwgWy1XZXJyb3I9
c2hhZG93XQ0KPiAJIDI0MjkgfCAgIGludCBlcnIgPSBwZXJmX2V2ZW50X19zeW50aGVzaXplX2tl
cm5lbF9tbWFwKCh2b2lkICopJnBlcmZfc3RhdCwNCj4gCSAgICAgIHwgICAgICAgXn5+DQo+IAli
dWlsdGluLXN0YXQuYzoyMTA0OjMzOiBub3RlOiBzaGFkb3dlZCBkZWNsYXJhdGlvbiBpcyBoZXJl
DQo+IAkgMjEwNCB8ICBpbnQgc3RhdHVzID0gLUVJTlZBTCwgcnVuX2lkeCwgZXJyOw0KPiAJICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fg0KDQpnY2MgOSBkaWRuJ3Qg
Y29tcGxhaW4gYWJvdXQgaXQuIExldCBtZSBmaXggaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4gDQoN
ClRoYW5rcywNClNvbmcNCg0K

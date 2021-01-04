Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504E02E9E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbhADTgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:36:00 -0500
Received: from mail-dm6nam08on2048.outbound.protection.outlook.com ([40.107.102.48]:14464
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbhADTf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:35:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP7KA96B3dLn56W4vc/ytfOL9qYtLoLEbx2gut3tva48Zo6QsNt6qGgbVF06qYAN915w6Q33QA+J78VMYCa2LBfEvdTen0ai36oQtU4yA2rxk+XIc2SeiztM0dpUWAjvIjyGv7JSDz4E1dsboE3lLT740aVI/XKiLR4A2PNSofzCPgRs2jwxoSM8/ctAoUKYkRAV4xqRpMpTySEO8KQTCAG5dD9tunWNuWxaKSdAG/ULV2tUzIFkmBL4gXvz8nR3rbIqf7R0QS1IFvIh4D1XbRvgn1UpOIso8hesLLmXSU4hVM7+e4c+OrANJd1DdIHnO+iDEaVKknusaYE2zPhVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd8lktESJccvb6OXSjleA4X5XaarjEwI0xr5YCjYxnc=;
 b=kbNOFJMB9JJXHhTHKNHpwgHDjBT8AOrRgInN+8R0Ghyr0BBTzBYsJ+u5GUxbyCunr3/CIPiqdcv57gq15V5Wkw6oCyNG1uO9KCU28bG6GbbRvfyEbSB4q0TIKA5srQlxmFfoEMsgfvZiSUuEf3lMnLsxnSUOBQcR6FjWBFwgVdwu6BA3I77vIDMSSILUd+uJ1TIe9YRQvJFr1We5y2MEcJmbeU6FrmGUbw9QVYy1DiVtsByfa6GnyUZeM2QcMUjybk/+Aqj1oZgmJsDX5I4BsfBkJMDAcEyg85ad7Y09qVOSpR+b2pepFHh/eFN2XdPSb1KzfcnpOwQDSzaLnjMH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd8lktESJccvb6OXSjleA4X5XaarjEwI0xr5YCjYxnc=;
 b=v1EkeF7vfAT2OfS2uGSg1hbk4UAkzHLGZHltlXzbEdT0XcCRbraYVq5yw8HfRRTFiHLCmMuAYxZeoSCrL9itg+0e2Sdn/ANd5Ph/SKnT5CWUzBcgiQZjPzwY5qtiEW9wACh7M2mbTEpD55K8EfvIrbghWm/CDXEnW6wdzta3r2A=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by SJ0PR05MB7232.namprd05.prod.outlook.com (2603:10b6:a03:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4; Mon, 4 Jan
 2021 19:35:06 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Mon, 4 Jan 2021
 19:35:06 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Topic: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Index: AQHW4pRwZnSKvT4iE02cPjpfTbkFJKoX2VMAgAAC64A=
Date:   Mon, 4 Jan 2021 19:35:06 +0000
Message-ID: <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
In-Reply-To: <X/NrdnoDHgFd0Ku1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24571425-27aa-417b-cae0-08d8b0e7d703
x-ms-traffictypediagnostic: SJ0PR05MB7232:
x-microsoft-antispam-prvs: <SJ0PR05MB72327B563DAC3BFC0407A3A1D0D20@SJ0PR05MB7232.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:283;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMKt/Fja2LNn23d/UGN+mfrPUM8GUw8szy2jkd1RrZ1msOcxaTH2tpuRvb/7+s+jbkjtWSq1w8TqPSplG/MvmsMlbcdTu5sjiUPk72uj/qeHqj2FYBZVmJYoMZ+Da6+RvObhlsRmMbSaznnSEWrDEOUicNRcuHG+JAbJAlwY2H0ephNDmHpFBZICIKsHsdH1i21HLSXVlFbS7unsIOwj6tuHVzOSHxKHH/zO/Ci2JkCDadJhxRWekiE5xJ8m9fE+4U1JfyaTaTLEMMDMsPQtgj9aRX4TsOg57o9UyHYjvMeUR6JaJUNddGYnymA45ycdaCLefXA6f3qf5XKwdV6VPeoq8NQlI8oZXnj5BvLPUpVovHkWtJyo7hTjGTSvf3CFjxFFEvnkMvz7ALbXBAEBT4q4Zwo/fgqWEXzcfodSL42AU37q/zYIod7g31jMr1xg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(66446008)(66556008)(66476007)(64756008)(66946007)(4326008)(316002)(7416002)(6512007)(6486002)(76116006)(8936002)(8676002)(86362001)(71200400001)(2906002)(54906003)(6916009)(5660300002)(36756003)(2616005)(186003)(6506007)(53546011)(26005)(33656002)(478600001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2NkRElpdVhmYTIwUi9OYjE4TktBMUNVc2RJS0ZrL25SK1FVR2JpS0thZklm?=
 =?utf-8?B?cTRsaXJzenMycEJ6L1VHdmFiZXpmK0pMS1l1Sm5OZ3p5Z2dXRVhkWmNYZ3BE?=
 =?utf-8?B?RjhjWWJyQ0VUaEZNdmFtNjVTVCtjMnNBSnF6aEl4Z2hFUWFxeGRTaUNQVkc4?=
 =?utf-8?B?NVV6Z3NSTnlTQ1NVbm1YZHFPb2FQRDY2QWdFTFR6ZVdiQUQ4VkZjTzdLYjZE?=
 =?utf-8?B?bUhFMi9wVFMveDJ0aERtWHhpQ1JNVFEzLzBNTk0yeGVEbVhBV3Q5VnoxRXBi?=
 =?utf-8?B?clU4dGh1cVF0ekJuQzQwZmcvbm95NnM4TmpxUnFGRnlXOWRiK0VNRkNJdHQ1?=
 =?utf-8?B?WmxDaUtxNXNaMXh5R0pENGF3UFZqcW5ldlBYck5aM1Eza082ci8vMzVCN3Vr?=
 =?utf-8?B?cGdXUzNTS2JqWWRCL29ibDlJbGZHUUUxNEVMNjA0RkhoZzZ6RWlTYloxNDVx?=
 =?utf-8?B?RWVaVDVidHoyK2FLNFJpOTRTMXN2cUtjMHZRbmVkclZiQUFvZXJteEZMczdW?=
 =?utf-8?B?N2hYd0s0Z3Bha00ydlA1YzgxaVNQaVM4THlBZ2x3bTRRQXBESzNiOFBiMXlH?=
 =?utf-8?B?bFk0UlRkTExQdjZGMzFkbkRsTDUyZzhhM2pZaFF6MkgyRDJ6RGpydFBCSVAw?=
 =?utf-8?B?T1RWSU94R0R5SHRZbnk4aVUrR2k1Y0Nlb0V1WlNyTkZucVA4N0gzTm1UNkZR?=
 =?utf-8?B?YzR5K0tNU2tRYlFIWHh6R2R2ZWUvaDNtdmJhMndqcFhoOWlhZDRVM2JYSytM?=
 =?utf-8?B?enFEbndSNXB2aUIzZUp2OUtxU2hwMDNuZEQwNjMzSUgyTWllUHp5bldEaE1v?=
 =?utf-8?B?NFU2Rk53a3VrWllTT1JnNDlYL0tNMGtNdjR0aHl3MXd6VTNQT3dHbHErbDFH?=
 =?utf-8?B?VmlINTN2VXBBaEo1WkZrdWptLzFlMmozUUk3V3IwaVBXeUFTclN0S1FESnZ0?=
 =?utf-8?B?aUV5WkNWRWtoS054NXhjd0N1RmpuVFhtb29Vbi9Wek90QjNzbUFMaGMzSlRa?=
 =?utf-8?B?VU5VWi9HQmhSMTdlTjFkc3hzaCtkc3JBMW9iTGdCMWpIZVJVcVpuMm1ZYmo3?=
 =?utf-8?B?ZmdTZ0JDODlsK1l6YWs5alJCM1dDdXlycmlSTVlhT3VCS1lFcUlzcU95ZVRP?=
 =?utf-8?B?bTRXM0pFWkZEZUs4ZCtvd25hTEozQ0NRcGtBZEtwR0ZpVFp6OFQ2d2NHU3Zj?=
 =?utf-8?B?aXpic3QyQWxCSmptMlpadjJObVRhdjE3Zi9kT2pwbitzaFJVbDY5Y3dZUndM?=
 =?utf-8?B?bFpYQmdBTWkzRWw0VEJERm1zbVlKYlZJVVI3bjdBSTUvS2p6cCtySFVaY0k2?=
 =?utf-8?Q?F2+2Dx/h56cxbnwZYHvajsCjjxeVyI6nx5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E21D0EAEB6697A46BF4950C59F7378F4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24571425-27aa-417b-cae0-08d8b0e7d703
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 19:35:06.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Jj/m23GkYwmDLg6rtv+r6BWK0G9GeuO7vjgv5qUKdYGGw1RJVo+jGdlUTqKBkLVLxs8TAUaDo5mK3R63XrdDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7232
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gNCwgMjAyMSwgYXQgMTE6MjQgQU0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiBNb24sIEphbiAwNCwg
MjAyMSBhdCAwMToyMjoyN1BNICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+IE9uIEZy
aSwgRGVjIDI1LCAyMDIwIGF0IDAxOjI1OjI4QU0gLTA4MDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+
PiANCj4+PiBUaGUgc2NlbmFyaW8gdGhhdCBoYXBwZW5zIGluIHNlbGZ0ZXN0cy92bS91c2VyZmF1
bHRmZCBpcyBhcyBmb2xsb3dzOg0KPj4+IA0KPj4+IGNwdTAJCQkJY3B1MQkJCWNwdTINCj4+PiAt
LS0tCQkJCS0tLS0JCQktLS0tDQo+Pj4gCQkJCQkJCVsgV3JpdGFibGUgUFRFDQo+Pj4gCQkJCQkJ
CSAgY2FjaGVkIGluIFRMQiBdDQo+Pj4gdXNlcmZhdWx0ZmRfd3JpdGVwcm90ZWN0KCkNCj4+PiBb
IHdyaXRlLSp1bnByb3RlY3QqIF0NCj4+PiBtd3JpdGVwcm90ZWN0X3JhbmdlKCkNCj4+PiBtbWFw
X3JlYWRfbG9jaygpDQo+Pj4gY2hhbmdlX3Byb3RlY3Rpb24oKQ0KPj4+IA0KPj4+IGNoYW5nZV9w
cm90ZWN0aW9uX3JhbmdlKCkNCj4+PiAuLi4NCj4+PiBjaGFuZ2VfcHRlX3JhbmdlKCkNCj4+PiBb
ICpjbGVhciog4oCcd3JpdGXigJ0tYml0IF0NCj4+PiBbIGRlZmVyIFRMQiBmbHVzaGVzIF0NCj4+
PiAJCQkJWyBwYWdlLWZhdWx0IF0NCj4+PiAJCQkJLi4uDQo+Pj4gCQkJCXdwX3BhZ2VfY29weSgp
DQo+Pj4gCQkJCSBjb3dfdXNlcl9wYWdlKCkNCj4+PiAJCQkJICBbIGNvcHkgcGFnZSBdDQo+Pj4g
CQkJCQkJCVsgd3JpdGUgdG8gb2xkDQo+Pj4gCQkJCQkJCSAgcGFnZSBdDQo+Pj4gCQkJCS4uLg0K
Pj4+IAkJCQkgc2V0X3B0ZV9hdF9ub3RpZnkoKQ0KPj4gDQo+PiBZdWNrIQ0KPiANCj4gTm90ZSwg
dGhlIGFib3ZlIHdhcyBwb3N0ZWQgYmVmb3JlIHdlIGZpZ3VyZWQgb3V0IHRoZSBkZXRhaWxzIHNv
IGl0DQo+IHdhc24ndCBzaG93aW5nIHRoZSByZWFsIGRlZmVycmVkIHRsYiBmbHVzaCB0aGF0IGNh
dXNlZCBwcm9ibGVtcyAodGhlDQo+IG9uZSBzaG93ZWQgb24gdGhlIGxlZnQgY2F1c2VzIHplcm8g
aXNzdWVzKS4NCg0KQWN0dWFsbHkgaXQgd2FzIHBvc3RlZCBhZnRlciAobm90ZSB0aGF0IHRoaXMg
aXMgdjIpLiBUaGUgYWZvcmVtZW50aW9uZWQNCnNjZW5hcmlvIHRoYXQgUGV0ZXIgcmVnYXJkcyB0
byBpcyB0aGUgb25lIHRoYXQgSSBhY3R1YWxseSBlbmNvdW50ZXJlZCAobm90DQp0aGUgc2Vjb25k
IHNjZW5hcmlvIHRoYXQgaXMg4oCcdGhlb3JldGljYWzigJ0pLiBUaGlzIHNjZW5hcmlvIHRoYXQg
UGV0ZXIgcmVnYXJkcw0KaXMgaW5kZWVkIG1vcmUg4oCcc3R1cGlk4oCdIGluIHRoZSBzZW5zZSB0
aGF0IHdlIHNob3VsZCBqdXN0IG5vdCB3cml0ZS1wcm90ZWN0DQp0aGUgUFRFIG9uIHVzZXJmYXVs
dGZkIHdyaXRlLXVucHJvdGVjdC4NCg0KTGV0IG1lIGtub3cgaWYgSSBtYWRlIGFueSBtaXN0YWtl
IGluIHRoZSBkZXNjcmlwdGlvbi4NCg0KPiBUaGUgcHJvYmxlbWF0aWMgb25lIG5vdCBwaWN0dXJl
ZCBpcyB0aGUgb25lIG9mIHRoZSB3cnByb3RlY3QgdGhhdCBoYXMNCj4gdG8gYmUgcnVubmluZyBp
biBhbm90aGVyIENQVSB3aGljaCBpcyBhbHNvIGlzbid0IHBpY3R1cmUgYWJvdmUuIE1vcmUNCj4g
YWNjdXJhdGUgdHJhY2VzIGFyZSBwb3N0ZWQgbGF0ZXIgaW4gdGhlIHRocmVhZC4NCg0KSSB0aGlu
ayBJIGluY2x1ZGVkIHRoaXMgc2NlbmFyaW8gYXMgd2VsbCBpbiB0aGUgY29tbWl0IGxvZyAob2Yg
djIpLiBMZXQgbWUNCmtub3cgaWYgSSBzY3Jld2VkIHVwIGFuZCB0aGUgZGVzY3JpcHRpb24gaXMg
bm90IGNsZWFyLg0KDQo=

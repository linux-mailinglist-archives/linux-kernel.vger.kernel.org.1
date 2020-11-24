Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296682C1A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKXAm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:42:57 -0500
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:54753
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKXAmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:42:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHwq7kAewyZuCzc0CAMT6uLj7L4PbpKmNFBvTVZe4+0me0AS2GPYOSkKdBfs6XgEIytjESn+xO9vELLYVSsoM2oZ0+1JBkX44KQgUG4vJ5LbPQdNXVSDskQ0TG8rajc4pPUcVUMbJx9xv5DGxhbU4ctxxsrY1CVnbO1eoem35JMWtHU5U2LvwfQ77Y9joIJ2nlcy0UkDNGszOnptbULNwKKMyuuIxdbAleT8iUrQ4gteYCdgfMK2beEkUPHll+f9Az+nA2LmDHWJlfET8eg65+UFx8AJpgC85dby4qUOHLpfuUG0IvFLcFisGejHKclnrlfN9ire6Aap8U0kpyzb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeMfEUMNIlGhdLn7PS6D1YTJ/Kqg3Y/zwYuvYJ5MDXw=;
 b=WsagQT9tEsXhgUb1kj+oUVAN0iG8OU40qxRDuXRREKXWPV/6scaC8K3QzpbE/tAdww0LdOPcdQQQxrexUsjEpzo+RS6MF3tNIS6yH4ZpbuLazEeNdwMx3y3dhUu6jU9hSUK/krQSJZpQRKiNvehZf2gdi2MUpJyDYvsPqW168z291Al///W81i6J+FCeMIOpDn7zEY1tq88F1KMsBgWqzmvoEIe1l23u3GwcF1qqA9HM0/uPIBQNyQ6j1kK/b0mW32VUVT1x4uFWtXNYbgSpOzxm+0Jw9kpzq0QLs2E7d0irVTUFScdrr7vP4Cmmk6DfwFXKd/lbFdkOft40cuISKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeMfEUMNIlGhdLn7PS6D1YTJ/Kqg3Y/zwYuvYJ5MDXw=;
 b=cp4qubYIk3N9rcfcRILDqNhSjLC8hB/S5+it7AxoKgW1ms9Jrq4uhVDxT+FFNX8qDFxFIWLfnv1thsyJaB1ESAPGd8+5StNtidEuf9U/wSehTdSfW4CjGbir1Acl/GLPlWyTF0QK+yf7Dy4KyiiPDEOV+JNgc1ST+qpfrFsUzbs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Tue, 24 Nov 2020 00:42:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 00:42:51 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Colin King <colin.king@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
        "Gui, Jack" <Jack.Gui@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/powerplay: fix spelling mistake
 "smu_state_memroy_block" -> "smu_state_memory_block"
Thread-Topic: [PATCH] drm/amd/powerplay: fix spelling mistake
 "smu_state_memroy_block" -> "smu_state_memory_block"
Thread-Index: AQHWwYb/QG3R3a5QL024dYjMdI9elanWckgQ
Date:   Tue, 24 Nov 2020 00:42:51 +0000
Message-ID: <DM6PR12MB26197807564F833B9A2E18E8E4FB0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201123105417.198314-1-colin.king@canonical.com>
In-Reply-To: <20201123105417.198314-1-colin.king@canonical.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f32d5e88-8f5d-4a47-bd4c-d72c443bef13;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only -
 Unrestricted;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-24T00:42:23Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c045ddce-e8cf-4f82-be4f-08d89011dfb0
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23585D8AF6BDBDB0BFBBEB7AE4FB0@DM5PR12MB2358.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZlWHmH20f+n9uRJ6UqDUuAnpZgwCE+C2w+lhl7aNHo5IHf2vdkBl+XUnzttyM534c8uLEOMZnzfQj9mv6yvOLhGPkvPPEcU5wzaab9wVmBcBmqDIM4Q7mPJqsB6vF+ssH4GWRK0Q8YN5fcAoXjY8sYIkcUdnpFR/hXLa+p9bSLrh3KaJWnDA6SRR2Esb+ok+VFzpErs+BdZ7UFvVuNDNRlVufGKFtOln+iaI1CWUoB1wdMdm9prYvddxxIKJLCsku6G+V8eZjJxVMUiOFABiQ0UlCN0mSbny43tUwcZuDvgN/EmpTtIh7OVoFWK6/8nRvYs6dVgqTSxsdA57qmSkwUWFoWu87NCJMY0w2zylnp94J3GHxJvZqi28cyOwhOGQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(8676002)(26005)(478600001)(186003)(66556008)(76116006)(66446008)(4326008)(64756008)(33656002)(66946007)(2906002)(66476007)(5660300002)(71200400001)(7696005)(52536014)(53546011)(6506007)(86362001)(8936002)(55016002)(9686003)(83380400001)(316002)(54906003)(921005)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tUhLQX6BP181GW+ZJWO44XWJp4pErCeGd047x/HgKXoCdyPv2LISo1cOJjLOs1Y8nS4ElFEVBP7JzMSqEPPJgDK8Dq7mWzWeO1X4FNDDPIIypwxCMhF7oUdQEx1bO35rAp4EvEP62RKKJ2jnexxTvt5Bk/B1Ye0jscW4h518Jl7D91P+O6Ci9tDv9nloaxNF3F6zfwNWo+93FhCxFHmO1sZCMGdEfb70OxLMqlqjKjvIJgUGBPj0nN7EPGP66oJYk95HUn/2z35ShMDjGcK6IXc+ntkfrAHfnxoM2O4FnAG7USqkKCUOqpNrR/Bx0mF7zY6EH0YYKN0p45z/4qEJp6gXBAnMSgaQX3RmF+sRUjdxO66lJ2AYSBHnRy8fxdStVH0MtzGXwxN32rYAVdqddKkTPE8IAyhjgA/C0MOXNWyGgl199Ifj7sqNU0oA17LWvO2wqOWE1wQ6CvLQbtneHpJzw7V1f1LrVCoFyjjrnZ6fULsSRGc3HR9/r1SEADAynBoqrcdktORfLStqFv0HxH//rlrgHCCvNO2dT6iRGaYQdSVwyYmJqhzCOvrYC5g68+17hLEjKck6RZW8X3NxvbuxN69dgSrwUmBurnYAdOKTdmTlnB5OBWS39XW07Wi43/AUto3inZhAtVV+8ljC0qysiU7bL2JNx0cbfYDXKrMNcMUR5nZTO0HHKlc0lJJGgjdGJLg3I4MUHAzaesnRZN7BncyOTBpAslokK8fI5Lf7PuGTe/wFlzcx/Z7TrMxLM5UFAVBDzoqJ98pwEc1uR+k2Pg12KmkBInJhyhgLR39vikolLOktctxFYMOWjFcxxXMFR+KRo9QfUr8oVXUt02RmWCDCPJxd3Rh/mYSxfIDT/Typ4H/cq+FTPEqdQICLEnTRIm4V8WmLLS+axFsxpA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c045ddce-e8cf-4f82-be4f-08d89011dfb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 00:42:51.3343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gyl3B0f3QWzaA0a7DbVI/wTHLhjLp5Z24qUFPyrrdD/FPZS8JlmAiPNAgfe1r0pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IENvbGluIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNv
bT4NClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjMsIDIwMjAgNjo1NCBQTQ0KVG86IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+OyBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+OyBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IFdhbmcsIEtldmluKFlhbmcpIDxLZXZpbjEuV2FuZ0BhbWQuY29tPjsgR3Vp
LCBKYWNrIDxKYWNrLkd1aUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBrZXJuZWwtamFuaXRvcnNAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvcG93ZXJwbGF5OiBmaXggc3BlbGxpbmcgbWlzdGFrZSAic211X3N0YXRlX21l
bXJveV9ibG9jayIgLT4gInNtdV9zdGF0ZV9tZW1vcnlfYmxvY2siDQoNCkZyb206IENvbGluIElh
biBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQoNClRoZSBzdHJ1Y3QgbmFtZSBzbXVf
c3RhdGVfbWVtcm95X2Jsb2NrIGNvbnRhaW5zIGEgc3BlbGxpbmcgbWlzdGFrZSwgcmVuYW1lIGl0
IHRvIHNtdV9zdGF0ZV9tZW1vcnlfYmxvY2sNCg0KRml4ZXM6IDg1NTRlNjdkNmUyMiAoImRybS9h
bWQvcG93ZXJwbGF5OiBpbXBsZW1lbnQgcG93ZXJfZHBtX3N0YXRlIHN5cyBpbnRlcmZhY2UgZm9y
IFNNVTExIikNClNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9u
aWNhbC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211Lmgg
fCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5oDQppbmRleCA3NTUwNzU3
Y2MwNTkuLmE1NTllYTIyMDRjMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
aW5jL2FtZGdwdV9zbXUuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1
X3NtdS5oDQpAQCAtOTksNyArOTksNyBAQCBzdHJ1Y3Qgc211X3N0YXRlX2Rpc3BsYXlfYmxvY2sg
ew0KIGJvb2wgICAgICAgICAgICAgIGVuYWJsZV92YXJpX2JyaWdodDsNCiB9Ow0KDQotc3RydWN0
IHNtdV9zdGF0ZV9tZW1yb3lfYmxvY2sgew0KK3N0cnVjdCBzbXVfc3RhdGVfbWVtb3J5X2Jsb2Nr
IHsNCiBib29sICAgICAgICAgICAgICBkbGxfb2ZmOw0KIHVpbnQ4X3QgICAgICAgICAgICAgICAg
IG0zYXJiOw0KIHVpbnQ4X3QgICAgICAgICAgICAgICAgIHVudXNlZFszXTsNCkBAIC0xNDYsNyAr
MTQ2LDcgQEAgc3RydWN0IHNtdV9wb3dlcl9zdGF0ZSB7DQogc3RydWN0IHNtdV9zdGF0ZV92YWxp
ZGF0aW9uX2Jsb2NrICAgICAgICAgICAgIHZhbGlkYXRpb247DQogc3RydWN0IHNtdV9zdGF0ZV9w
Y2llX2Jsb2NrICAgICAgICAgICAgICAgICAgIHBjaWU7DQogc3RydWN0IHNtdV9zdGF0ZV9kaXNw
bGF5X2Jsb2NrICAgICAgICAgICAgICAgIGRpc3BsYXk7DQotc3RydWN0IHNtdV9zdGF0ZV9tZW1y
b3lfYmxvY2sgICAgICAgICAgICAgICAgIG1lbW9yeTsNCitzdHJ1Y3Qgc211X3N0YXRlX21lbW9y
eV9ibG9jayAgICAgICAgICAgICAgICAgbWVtb3J5Ow0KIHN0cnVjdCBzbXVfc3RhdGVfc29mdHdh
cmVfYWxnb3JpdGhtX2Jsb2NrICAgICBzb2Z0d2FyZTsNCiBzdHJ1Y3Qgc211X3V2ZF9jbG9ja3Mg
ICAgICAgICAgICAgICAgICAgICAgICAgdXZkX2Nsb2NrczsNCiBzdHJ1Y3Qgc211X2h3X3Bvd2Vy
X3N0YXRlICAgICAgICAgICAgICAgICAgICAgaGFyZHdhcmU7DQotLQ0KMi4yOC4wDQoNCg==

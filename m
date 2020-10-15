Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2828FA85
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgJOVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:15:55 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:19744 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgJOVPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5716; q=dns/txt; s=iport;
  t=1602796553; x=1604006153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=PbgYZnFiflXsgbQJvmtrIyWxN49J4RbsO3+JsEcbzvA=;
  b=AB4ADpGpb040v4Eii8rLo78Zn/mMhWGP9e83XkIJ/l3unSMpQKZbw4GI
   ski9O2BGjGcllGCSz7hGTgrwk/pBEi7Vd521YETLUzVHBkNIfh922ZZlD
   MlCVqdEjjKgjnfs2r/ngJpjAk8dq0sglx5FqYcKhPOrGuiuxPo9sGT5RB
   U=;
X-Files: pEpkey.asc : 1813
IronPort-PHdr: =?us-ascii?q?9a23=3AoQlyQBGHBcg7trgtD2q1GZ1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401wGbWYTd9uJKjPfQv6n8WGsGp5GbvyNKfJ9NUk?=
 =?us-ascii?q?oDjsMb10wlDdWeAEL2ZPjtc2QhHctEWVMkmhPzMUVcFMvkIVGHpHq04G0WGx?=
 =?us-ascii?q?PiJQRyO+L5E5LTiMLx0Pq9qNXfZgxSj2+7ZrV/ZBy9sQTWsJwQho1vT8R5yh?=
 =?us-ascii?q?bArnZSPepMwmY9LlOIlBG67cC1r5M=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CSCQC8uohf/40NJK1gHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQGCD4FSUQeBSS8sCoQzg0YDjSIIJph7glMDVQQHAQEBCgMBAS0?=
 =?us-ascii?q?CBAEBhEoCF4FxAiU4EwIDAQELAQEFAQEBAgEGBG2FXAyFcgEBAQEDEhEdAQE?=
 =?us-ascii?q?3AQ8CAQgVAyoCAgIwJQIEDQEFAgEBChSDBAGCSwMuAQOiLgKBOYhhdoEygwE?=
 =?us-ascii?q?BAQWFIhiCCQcJgTiBU4Efg26GVhuBQT+BOAyBX34+hFSDAIJgk1CHD4FMiji?=
 =?us-ascii?q?RGQqCaoRNgl+TNgUHAx+DFooIlCwtsywCBAIEBQIOAQEFgWsjgVdwFYMkUBc?=
 =?us-ascii?q?CDY4fN4M6ilZ0AjYCBgoBAQMJfIw7AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.77,380,1596499200"; 
   d="asc'?scan'208";a="598853486"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Oct 2020 21:15:52 +0000
Received: from XCH-RCD-004.cisco.com (xch-rcd-004.cisco.com [173.37.102.14])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 09FLFqNV010811
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 15 Oct 2020 21:15:52 GMT
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by XCH-RCD-004.cisco.com
 (173.37.102.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Oct
 2020 16:15:51 -0500
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by xhs-rtp-001.cisco.com
 (64.101.210.228) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Oct
 2020 17:15:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-001.cisco.com (64.101.210.228) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 15 Oct 2020 17:15:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+nFmd+kFk9Md8OfNunJef0XHVHjLpDnvFzDlMoBq28xx00cwuMtwmXOe5wJ0dMd5zL9idPkgdi7EdOuzOLWj4bzfm837qYx4yZf76fCfAJRMerMIvVarSyHEsd1rp+Xx1F95lyNm8HxB9lNXt3m77ArpiU9wK0N31p7/P1XjtSB1G3RhyIawKv88Yetmtvud6r1qTd+ghPUXXBPDB2HVWV1/zHtCuooNqgNPPToUb2ntLryZwjApNWNRun5cMOIn3wJ2tE/3LjKla9THka/tjcx/X6p4YMD0wfyRAeWnw6egsSMoqBa2Qdh6tKUBsiSJ5e8GHpNyVTmfu/09+JHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqhv6s+j6Ap2/byA/Yq8pIACgOqXXns+lgpkRG1UeOY=;
 b=R/FCPFtKzKSgwkyb5Grakb1XzhTuRyeLcJJUQMa0NnsLZoQdjDO++b/B7/O0uhHPxyUlHAWqXWv3/N/XJpLtINjxonOTX6CetvMCgnliBrpKbwRQce/xRRxjxhJ/mMe4mszBVfM8W1AgNiwSw8h3AAhumSXAit1HU0dsCZRLh2j7P80UtoPmBUCp1KKTFyLDYL2j0n19iwgEPP5QcTjYCISXFDKmAEKaF3cVBXqMKFgC0xEErWzLkmWJb/ecUBlrTNEDbtQcqeIcEW7TNxixoIsaCZEDFdhl95aPs3xn3SHl8XfEQ5CRqSry2cy1szfkVPaVhMP8Q9nzgsvuZlDsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqhv6s+j6Ap2/byA/Yq8pIACgOqXXns+lgpkRG1UeOY=;
 b=g3kqbWcN3fYcdJlHhMbKPOKyuwvM0YYPs6ZGLp3cKSqlp9bbYoiA1CdoeSOFR0Y3dk+MPj9oTv6p4paai1fIXjnR7dxk6sGtVljVJJRbJmckjtxAH9Z4UlUCfKDIchPY3Bk7IxdS7X0HbN4hwhpn8fBHsXg8luRstqvDBq48rzE=
Received: from DM6PR11MB3866.namprd11.prod.outlook.com (2603:10b6:5:199::33)
 by DM5PR11MB1932.namprd11.prod.outlook.com (2603:10b6:3:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Thu, 15 Oct
 2020 21:15:48 +0000
Received: from DM6PR11MB3866.namprd11.prod.outlook.com
 ([fe80::c943:b491:e40e:4f02]) by DM6PR11MB3866.namprd11.prod.outlook.com
 ([fe80::c943:b491:e40e:4f02%7]) with mapi id 15.20.3455.032; Thu, 15 Oct 2020
 21:15:48 +0000
From:   "Hans-Christian Egtvedt (hegtvedt)" <hegtvedt@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption
 handling in hci_encrypt_cfm
Thread-Topic: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption
 handling in hci_encrypt_cfm
Thread-Index: AQHWotmplfjLfEEHCEydFw1RNBP3KKmYhCmAgAAMXQCAAAu7gIAAjr6A
Date:   Thu, 15 Oct 2020 21:15:48 +0000
Message-ID: <9db443a8-e87f-95f1-3009-07886288674a@cisco.com>
References: <20201015074333.445510-1-hegtvedt@cisco.com>
 <20201015095750.GA3935178@kroah.com>
 <0804be81-ebbf-8132-a619-c0c740a71f51@cisco.com>
 <20201015120254.GA3958402@kroah.com>
 <23d41fa2-ed12-911e-42ef-09db96c95e0f@cisco.com>
In-Reply-To: <23d41fa2-ed12-911e-42ef-09db96c95e0f@cisco.com>
Accept-Language: en-DK, en-US
Content-Language: aa
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cisco.com;
x-originating-ip: [31.45.31.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 594adba1-4998-42ce-e3c8-08d8714f7d2d
x-ms-traffictypediagnostic: DM5PR11MB1932:
x-microsoft-antispam-prvs: <DM5PR11MB1932364AAE6B7C07819A7049DD020@DM5PR11MB1932.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwdi8/dxdy2Con0Uoy8zLjf/PTSG6hNzyX8kkSDDTxTlNc2A54VaPDiVEEKW2Gfomo3l8RWdOolBPubCvAJcs2VHg3Wy7LhTTrkJsFlJvLi37umk9w40RJG7hv0HFV/R27r8+1SHfH3SVyuZmeiRVBPr9dEc4HUu9Jgrc22omyJxDVHKespiR1/7T4eAhBXg5GYh8ZDiRJGDVePNrY8QcmXZ7S8g49sIwt+uO35f2TTeoquWYxJ51VsYJgeX0ffiS6dCtWaJOqvXQhS1SL807YeVlx9fQrnk3cQo6o+O/jjSGoF7Wknyaz1RM70Fy+r9vrVLJX9cec8GIUYGLfeGUuOkS27Ja2eDqxWKaeQJCp/MTyKWbvY6s/irDJejeW2l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(83380400001)(478600001)(316002)(86362001)(66946007)(66616009)(76116006)(54906003)(8936002)(6916009)(8676002)(91956017)(71200400001)(66556008)(64756008)(99936003)(66476007)(66446008)(2906002)(6512007)(31686004)(2616005)(4326008)(5660300002)(26005)(186003)(6506007)(6486002)(36756003)(53546011)(31696002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: k4uigJDLsT5CH3uqC268I3Lfc+iQMMqwRQD/jAsi0s0bJ1EF/XQtYj2jp4++tIW8kz6/l+wbNCYjVu7bGCkMuxzxW39cQOmuLsrgUD7JVUlqObvqk+nz2qBrYlgumIY2tbJcc/GLlxj+ahnKxaIrDNoY1AnOFYSPzarY+KFQMUC597Xlj+QpidKJkr81qJFWl+1Qsn7GP7c7hw/g4MszPiWsX/NQ9xI/Q9lvKw/v3iuOpr5sqRZX5a+zEdvzz3W6RnefXyVzJ/suH/fO45g7Na+tLQyWGEczUvI9L/YOkeSQ7Xccyhr2Cz/ZsXRj9TJnMxtF1o/rScToHk3Pjr4BvsWKikdxVLyRzS0d7cXUjugec4r8Jq3D3xJ8F1kchs4GnUzuUsVKLowsRP/dYGFMr48bo8c/JYSF6GMHnqt4SLjqeI1nvWpQwhZaxsJ3m2Y+EZcUwDzwm8r/rX+JQO8ao8upLDnpcImIRzeKyjv3nraKreYYRBTXjtt0ed53p9M6dW6vDZwun9XjufG05TiUtcU1wYj/JULuduibCEYokpg5v76ZiZJetUNSb+rSdWLEg+9EvifvbW6/E9Pg5PcaqzhQsir3qnXmyjB0WaMcUSdGJNse4rqhvPSMb5tV3r0fR3L4XcJjjgvWgM6twq0g+w==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_9db443a8e87f95f1300907886288674aciscocom_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594adba1-4998-42ce-e3c8-08d8714f7d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 21:15:48.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SarZ1OUYEbUek9T2CFJT/KK4WdRxhntgCR3YYe9GM4Q5wLuQt99EtBcrOrw0aRlIqRNG7hk6F/fqlbtPMZ5gZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1932
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.14, xch-rcd-004.cisco.com
X-Outbound-Node: alln-core-8.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_9db443a8e87f95f1300907886288674aciscocom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFF48DDCCE801D42AAE9409CDF8AF1DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gMTUvMTAvMjAyMCAxNDo0NCwgSGFucy1DaHJpc3RpYW4gRWd0dmVkdCAoaGVndHZlZHQpIHdy
b3RlOg0KPiBPbiAxNS8xMC8yMDIwIDE0OjAyLCBHcmVnIEtIIHdyb3RlOg0KPj4gT24gVGh1LCBP
Y3QgMTUsIDIwMjAgYXQgMTE6MTg6MzlBTSArMDAwMCwgSGFucy1DaHJpc3RpYW4gRWd0dmVkdCAo
aGVndHZlZHQpIHdyb3RlOg0KPj4+IE9uIDE1LzEwLzIwMjAgMTE6NTcsIEdyZWcgS0ggd3JvdGU6
DQo+Pj4+IE9uIFRodSwgT2N0IDE1LCAyMDIwIGF0IDA5OjQzOjMyQU0gKzAyMDAsIEhhbnMtQ2hy
aXN0aWFuIE5vcmVuIEVndHZlZHQgd3JvdGU6DQo+Pj4+PiBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9u
IERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+DQoNCjxzbmlwcCBlbWJhcnJhc3Npbmcg
cmVmZXJlbmNlIHRvIGxvY2FsIGNvbW1pdD4NCg0KPj4+Pj4gLS0tDQo+Pj4+PiBBRkFJQ1QsIGZp
eGluZyBDVkUgMjAyMC0xMDEzNSBCbHVldG9vdGggaW1wZXJzb25hdGlvbiBhdHRhY2tzIGhhdmUg
YmVlbg0KPj4+Pj4gbGVmdCBvdXQgZm9yIHRoZSA0LjQgc3RhYmxlIGtlcm5lbC4gSSBjaGVycnkg
cGlja2VkIHdoYXQgSSBhc3N1bWUgYXJlDQo+Pj4+PiB0aGUgYXBwcm9wcmlhdGUgdHdvIHBhdGNo
ZXMgbWlzc2luZyBmcm9tIHRoZSA0Ljkgc3RhYmxlIGtlcm5lbC4gUGxlYXNlDQo+Pj4+PiBhZGQg
dGhlbSB0byB1cGNvbWluZyA0LjQgc3RhYmxlIHJlbGVhc2VzLg0KPj4+Pg0KPj4+PiBXaHkgYXJl
IHlvdSBtZXJnaW5nIDIgY29tbWl0cyB0b2dldGhlcj8gIFBsZWFzZSBwcm92aWRlIGJhY2twb3J0
cyBmb3INCj4+Pj4gYWxsIHN0YWJsZSBrZXJuZWxzLCBpZiB5b3Ugd2FudCB0byBzZWUgdGhpcyBp
biB0aGUgNC40LnkgdHJlZS4gIFdlIGNhbg0KPj4+PiBub3QgaGF2ZSBzb21lb25lIG1vdmUgZnJv
bSBhbiBvbGRlciB0cmVlIHRvIGEgbmV3ZXIgb25lIGFuZCBoYXZlIGENCj4+Pj4gcmVncmVzc2lv
bi4NCj4+Pg0KPj4+IEFncmVlZCwgSSBoYXZlIG1hbmFnZWQgdG8gdHJpY2sgbXlzZWxmIGludG8g
dGhpbmtpbmcgdGhlIDQuNC55IGJyYW5jaA0KPj4+IHdhcyBsZWZ0IG91dCwgYnV0IEkgYXNzdW1l
IHRoZXNlIHBhdGNoZXMgYXJlIHJlcXVpcmVkIGZvciBhbGwgTFRTIGJyYW5jaGVzLg0KPj4NCj4+
IFRoZXkgYXJlLCBidXQgaWYgeW91IGhhdmUgY29waWVzIG9mIHRoZW0sIHBsZWFzZSBmZWVsIGZy
ZWUgdG8gc2hhcmUNCj4+IHRoZW0uDQo+IA0KPiBJIHdpbGwgcmVwZWF0IGNoZXJyeS1waWNraW5n
IGZyb20gYSBjbGVhbiBsaW51eC1zdGFibGUgZ2l0IHRyZWUgYW5kIHNlbmQNCj4gcGF0Y2hlcywg
c29ycnkgZm9yIHRoaXMgbm9pc2UuDQo+IA0KPiBJIHNlZSBsaW51eC01LjgueSBoYXMgcGFydGlh
bCBwYXRjaGVzLCB3aGlsZSB0aGUgb2xkZXIgYnJhbmNoZXMgbmVlZCB0aGUNCj4gZnVsbCBzZXJp
ZXMgb2YgdGhyZWUgY29tbWl0cy4gSSBqdXN0IGRpc2NvdmVyZWQgYW4gYWRkaXRpb25hbCBmaXgu
DQoNCkkgc2VudCB0aHJlZSBpdGVyYXRpb25zLg0KDQo1LjgueSBvbmx5IHJlcXVpcmVzIGEgc2lu
Z2xlIGNoZXJyeS1waWNrLg0KDQo0LjkueSB0byA1LjQueSBoYXMgbm9uLWNvbmZsaWN0aW5nIGNo
ZXJyeS1waWNrIGZyb20gdXBzdHJlYW0gY29tbWl0cy4NCg0KNC40LnkgbmVlZHMgdG8gcmVzb2x2
ZSBhIGNvbmZsaWN0IHdoZW4gY2hlcnJ5LXBpY2tpbmcuDQoNCkkgd291bGQgc3RpbGwgd2FudCBM
dWl6IHRvIGFjayB0aGF0IHRoaXMgY29tcGxldGVzIHRoZSBtaXRpZ2F0aW9uIGZvcg0KdGhpcyBC
bHVldG9vdGggdnVsbmVyYWJpbGl0eSBpbiB0aGUgc3RhYmxlIGtlcm5lbHMuDQoNCi0tIA0KQmVz
dCByZWdhcmRzLCBIYW5zLUNocmlzdGlhbiBOb3JlbiBFZ3R2ZWR0DQo=

--_002_9db443a8e87f95f1300907886288674aciscocom_
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Description: pEpkey.asc
Content-Disposition: attachment; filename="pEpkey.asc"; size=1813;
	creation-date="Thu, 15 Oct 2020 21:15:48 GMT";
	modification-date="Thu, 15 Oct 2020 21:15:48 GMT"
Content-ID: <2FF1CEBC7C9B9F4B86AB0877F87DEBE2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQoNCm1RRU5CRjkyUTYwQkNBRERq
dUxjNDlMSEQ2WmVsNW5xekxnclVWczRiSE94M3hlTkxRSVpGNXBIemxXa2VqMzYNCmtyRjltcFN1
TGdUamtsd2dkN2ZzNE44NHlEVllZbXZIR0l0NVpzZVRqTW53aFVodUNNY2FHNERVUEFsMk9CNHkN
CkxIUUFVY0QxdktKU2pEM21GWDYzR1hzajJTSzluTWthYmxCVDcxVXBCcUdSVVVyY2c3OVRreGg5
b3VjblU3UnQNCnUzWTZzTWhDancvU1gwWmVJb2VxU1NaZWlDS3l4OXlSZ3JiNkJGSXFWMm16QUZB
YWcyK1BZYVQ5dWs1NWlnUzgNCklhM2M0aVVxbllHeWNnQ2hYZ1NuVk91eGJwWC9LeEVsM3pmVTA3
RzZVSTRMejcwR3lDOXRKMU1kUE1tWnhwTUMNCldZYWMwQSt5SEcrTGIrQ1lNVDBvQS9yK3dZZXgz
RXBBODI1YkFCRUJBQUcwTVVoaGJuTXRRMmh5YVhOMGFXRnUNCklFNXZjbVZ1SUVWbmRIWmxaSFFn
UEdobFozUjJaV1IwUUdOcGMyTnZMbU52YlQ2SkFWUUVFd0VJQUQ0V0lRUTgNClJJdmZkUXpWN3FB
dmRvY3BqV0VUWUhyRE9RVUNYM1pEcmdJYkF3VUpBZUV6Z0FVTENRZ0hBZ1lWQ2drSUN3SUUNCkZn
SURBUUllQVFJWGdBQUtDUkFwaldFVFlIckRPWklIQ0FDQjdncXMvSVdwTkU2TlNsS2l1eSs3SkR1
ZEJaRkENCklMMVJFUlBsSU9uWkRTQm5TMkcyakkvQ25IL0NWYlAyaVdHSy9WdUx6ZUdVM2QrNy9R
VkN4U2xXd0NHUmw5SnENCnYyaXFlemxpeHNrUVJRSVdGL2t2MWxKNVJXUzRFMzRLVUxiak44WTF2
WGhwOExjRnA2WGtmMDEzSWZodHJRZlENCllLaW1zWjlvNzd6VDZJVHhiOTZsK0xabVZlWTdrNGd3
MExQbEdFZkh1N25hNFNWS05xSTd3cHMzWEZhWGVJN00NCnp6MVlvZ2oxL0l2d1ZpczM2dmtickNV
b2lVeWprSC9zRVhVdUI1amNXeXFaOGpYY2daZUN1dHlEQVNRVFJHSFgNClFPdkRoV3JFbUlZTzNl
OE9hYjg3R1ZmVXNwd1pRWnY0STdCQnVCbkZySFFFL2RTcHFzOWtFdXhxdVFFTkJGOTINClE2NEJD
QUMrd1JZZ1IxcEtuZDZWWGhRdWg1b3hqbXlLTkQ4Uy91SE9SOVVXeUZnUnBpSzhlWmFUMUdOc2ow
c1UNCnZ1ZytZcVZMekZHWG04djg4STBWVEgydU1USmw5VHUzeEo0THhuYjJsdnFiaE1wQ2UzOG1O
em1UOFh3cXJ4WjkNCms3cmx0a24vWjVBV1JoRHVoZFJORHVHWENmL0Zua1FFczIyVmpxN0JQTkZn
Z0RCakliU3VGOVRWbnMvL0FVSkUNCk9GOE1uWFhuSWdEK3dKc25maDcwcTVRbFFjRURzMkhCMEFD
R0g4NHovc3lWeGdpRGFlYklELy9SMXVzNDJyWEENCktETHZQZ2tmRDdRbUNlQ1JrRUt1SmorQWRM
U3ZFRE5jUXhZSE13eTRBTC9qd0hNM0RwYjI5WFFRdnVMcm5RckwNClpGQzE5WXVpSTFMY2RkWUFi
STM3UFV0cnhvZ0xBQkVCQUFHSkFUd0VHQUVJQUNZV0lRUThSSXZmZFF6VjdxQXYNCmRvY3BqV0VU
WUhyRE9RVUNYM1pEcmdJYkRBVUpBZUV6Z0FBS0NSQXBqV0VUWUhyRE9TbzBCLzl3RDVTYVYxQWIN
CnAvNVVuMHJvYy9nRGhteGsrT3dDcWpPKytMaEZNOVovK2grVVZYeEw1Y25MTE05NUZuQ0RWSngr
dTIyQ1dkTnQNCnNlVDFWejVHLzVlaXZ6SXA2cSt5a3pOUFpPVUxaRVNoSmpQYnRDa1FyRDFIY3NO
MTJNNXdKcm1TVFlOTXN1MC8NCkI4dDBxaVJ4WFpybi9uRlVaTXVsL2FLTmI4d0dDcVpUbWFEL1hQ
b3Z5d2c0QW5DcDRRR2JFQlJFTjJMcis3NWwNClJmSlJSMkU2MENHaUpxdEZOUjZwUG5GSmg4ajR2
dUVZS0MvY3QvRmxpRk1lTVVQWEl4YnYrUTdVUnI1all5SHUNCjVwVldrVWRvSU9ZcVc4THVsL2dZ
RUY0MTgrdGJ1Qk13TG5maDhraFBGVGhmYjlUditGY0llZmR6Uk9KTzJOTncNClJuUFNJTzBYWkll
Sw0KPU8vR1UNCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0NCg==

--_002_9db443a8e87f95f1300907886288674aciscocom_--

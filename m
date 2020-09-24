Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B51277167
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIXMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:35 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49006 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgIXMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:46:33 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 08:46:31 EDT
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7748D402EF;
        Thu, 24 Sep 2020 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600951000; bh=nlNnctHXi5ssUL5SDvkFE5qnzNDwYtwe2UH5xiazPsA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iscuhaRowARjs5iPx/Yy/NY8JbXBYJsymMCZK2MwQ8I/BoLwQNk/uqMYWWd71xIcl
         YEmQ4/mhn92N0FsgbNZiXWOcTmgaayUHT7LvaJv3X8oP8vqKett8CLOdW/cytBOGXy
         JA12lDDZyaV4vVxN4C/hbF+KQbXish8Zkf6gKKGBNn6enKpqZBdEK+uB7YP32Ieg9M
         4qQ3rU5bMkCl2E+i94V27Z1n41JqYcRooBLiHPGBtqTRRIXU3o+b2H7t4pQ4ZgxHz/
         wMKCZjlsqyHRGeJIZmrOv9JRaKpvbV8A8sh+bREMvGNC5ytq6t42nXN77H3C8Ywgfc
         LIQj9WsUjN27Q==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 37A46A0060;
        Thu, 24 Sep 2020 12:36:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B0A21400B3;
        Thu, 24 Sep 2020 12:36:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="LLech6yq";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+QUxOcyCP4URsPPEVYEKduFOcfvl4/XUtNve6wnHcjnPvkqJzDdctxmdeBhgycfVoTCgyYF689vxV1eRPHxnQ9dujglP0WqVeuLujOWTNXRLLQJgEe8Ys+dh3575V+YcHoQv1rVNhRcHDQXNDME7ACivbX7SNjb9evMU4rXb1xgkn4tY5l0hTxPcfVj4MIy0WK2OYgTlRqiD5IPIkzu4J/LY/yvhOQW2WXD8vC9y4dDJ5iCSgKDaxPFYrZeqfhKcw8l5IcadSsU1N1YMrC4ohkyPgAk1F2huhCKRgfAV7Fx4GSf5QTACcSnj/9hab6nmaHqUUq2OekzyyVS2Soe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlNnctHXi5ssUL5SDvkFE5qnzNDwYtwe2UH5xiazPsA=;
 b=nDlxTlaUKWwBXbe1Se49/ft4N3bab2ajdsdWrQIdreZolJwVTaPi0ldtFjoeUUds4WlRwIN2SJd7D0IdndCRFYCqRR7KtGe3Y14+IB7paXmCqf8JYXLa8Z2ybFynyuvhpk5aj0kF7YE2I9ZWQSnhvGJ4Hxv1eoIDeHdWolYWLv48jeS2bNO4xtdw7i6Br6qdGzXejjaZPb2Ea3QXymoVKKKYzImS8uZzaZtxHep69Y+YdugfITPodFfXB64Nm1yDRzSaYxyK69f/Yh6ixABYjbTpJlAAi89EYmO5jZ9HQHNhVv/H7wqbMRNE9dUNaGBRLLRZDU1xDPkdNK9bQlrxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlNnctHXi5ssUL5SDvkFE5qnzNDwYtwe2UH5xiazPsA=;
 b=LLech6yq4jaYkkcEC80NtwRRH7MXI8/pkgR+sl2CWashABd+tEGqWFUSSuCBRWmvRJJzVUHGl+FLkEy8EeGRVFnTFZEXiO/K2D4G/Vswx7cIgodJcZTCeV6FNgkO8E5LQFKXi3goHZKzSdocbwVcrMNHeL3PL2BS67HyfnLzTGY=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR1201MB0165.namprd12.prod.outlook.com (2603:10b6:910:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.17; Thu, 24 Sep
 2020 12:36:36 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::a11c:8b4f:39e6:803a]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::a11c:8b4f:39e6:803a%9]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 12:36:35 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v6 0/3] Add USB role switch support to DWC2
Thread-Topic: [PATCH v6 0/3] Add USB role switch support to DWC2
Thread-Index: AQHWhoyU+vDQm+EjPUiRYOkTWSRR/Kl3zx0AgAACdgA=
Date:   Thu, 24 Sep 2020 12:36:35 +0000
Message-ID: <591f30b5-3d37-a077-957c-ea0ca7ae4fcb@synopsys.com>
References: <20200909093511.4728-1-amelie.delaunay@st.com>
 <542ec140-fd49-04a1-bc66-e473858caa67@st.com>
In-Reply-To: <542ec140-fd49-04a1-bc66-e473858caa67@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
authentication-results: st.com; dkim=none (message not signed)
 header.d=none;st.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.82.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 314e8441-332a-40c0-739b-08d8608679d4
x-ms-traffictypediagnostic: CY4PR1201MB0165:
x-microsoft-antispam-prvs: <CY4PR1201MB0165F4A9EADBA4C3E794C349A7390@CY4PR1201MB0165.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKbvPN4ySzg4aGz/iOJ3CxOxtet7uGFr7u0UwSnqhO1rx4uBtMZc9TxynwMidsmCPLjEHWM6wRPP0mu2VT/SFSl5Ihz2BCIiaoI4p6hefz1OmRAtI15cGZG49z0pSpmiSbkyuvNWK+uMCqGCPfIyIVIAll+5POIzp1vciU8qQQhX84bv0EZXt/oPJONMlptq96m7OKEA9bRS2QjIPLoeo6rENfjrrtoeS58i1YF1NQFISMPQ5PrJ0ztpPFLlbd4PTrL3SN/cDPAG6rxh/kCNMnEoeUEm5dhbPbwwlrkvOqG36mhoCzcl02FEFJZ33aBrD6fyi5sG13nPwC5eSZuPe130VEScoAWJNPdzwUFdHiW1J1Z0FCFFwRAEH1NZkBgVjOAePT39axq3Wh165zXgwRu7C9pXr1oq81rWyfA2x+dGGeZcjQAPhQ5mzFpQH1cPHOR7SnjQOs+NeYo4faMVuuMbbAHnkuR9dshwGisMg0Lnvf9K7OzHpWqWjvfrdLke
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(66446008)(8936002)(66556008)(31696002)(6512007)(91956017)(5660300002)(36756003)(2616005)(316002)(71200400001)(83380400001)(64756008)(66946007)(110136005)(86362001)(7416002)(76116006)(4326008)(54906003)(2906002)(478600001)(66476007)(6486002)(53546011)(26005)(31686004)(966005)(8676002)(186003)(6506007)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iE2UeK6Zj29Yy2s6uqYKqKzGSImI1An8D2Jyu1lhLPeK7fb/ODFxCnDEIcb7EpbIyt34fubLJIPLhpJOGv/LpwdO5BPPdmNSKB8NrkW7sBghEZr0rDZJH+buDS0i48SuDc8sH7VMuc8WFnlaImDjFvt7VowOmsCzaBLB/xddx4nQY3cZrDxCHWbzBGo0lqbR7NP9G9eIQGPB9ryrwwYl4vzafXmHTmoXFg/+unLHVAAzbl8laASLMgcKjNPTGCSkNp9EZyKvFR7Rx5IU/P7sEa4teuylG9YH+pLWQQvuKNl0kEkJnDpu39S/vRdLrYo0iflTUId0TuaLIlG/iYMnROASFVH31VmFNJh3mqtGdGitAZ4oaocs1ZhOe6JC9gvpdhc5Cdweeh2rx4/13veEUb5SBpstG7/oGaioPjqAMX1JjfTL0yxrSXSC7TMd/wuk+gLIcURbsaQhU3wvtHRtfbeNtXSBE1basGPN1s3RbCQOIzIwAoQdBCHqZdzIEQgJlJFzN/CpGpGEAGxfD8+MIPX+0lLwNcaYBGxCPsV40pS9H2nMBrX8FGsW9ioWqKbJmMbQBqn9Tsdqdx2hNH4OKQxGR5/pUzKwYLiZXkWp1ksvEAcnqneVf0ZGFsiUrggE+mlFJ1JE296A3I26NbrNzA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B67B96D188E09349966CB33D9D0A8450@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314e8441-332a-40c0-739b-08d8608679d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 12:36:35.6486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6vXGQ5xes23K9M17U0mPiVVI+4wctkCW50k9uCcW3s257q+l1BtIIX88cbuXNdbr9fPIH/si0BwT0MaCoxKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yNC8yMDIwIDQ6MjcgUE0sIEFtZWxpZSBERUxBVU5BWSB3cm90ZToNCj4gR2VudGxlIHJl
bWluZGVyIG9uIHRoZSB3aG9sZSBzZXJpZXMgaW5zdGVhZC4NCj4NCj4gVGhhbmtzLA0KPiBBbWVs
aWUNCj4NCj4gT24gOS85LzIwIDExOjM1IEFNLCBBbWVsaWUgREVMQVVOQVkgd3JvdGU6DQo+PiBX
aGVuIHVzaW5nIHVzYi1jIGNvbm5lY3RvciAoYnV0IGl0IGNhbiBhbHNvIGJlIHRoZSBjYXNlIHdp
dGggYSBtaWNyby1iDQo+PiBjb25uZWN0b3IpLCBpZGRpZywgYXZhbGlkLCBidmFsaWQsIHZidXN2
YWxpZCBpbnB1dCBzaWduYWxzIG1heSBub3QgYmUNCj4+IGNvbm5lY3RlZCB0byB0aGUgRFdDMiBP
VEcgY29udHJvbGxlci4NCj4+IERXQzIgT1RHIGNvbnRyb2xsZXIgZmVhdHVyZXMgYW4gb3ZlcnJp
ZGluZyBjb250cm9sIG9mIHRoZSBQSFkgdm9sdGFnZSANCj4+IHZhbGlkDQo+PiBhbmQgSUQgaW5w
dXQgc2lnbmFscy4NCj4+IFNvLCBtaXNzaW5nIHNpZ25hbHMgY2FuIGJlIGZvcmNlZCB1c2luZyB1
c2Igcm9sZSBmcm9tIHVzYiByb2xlIHN3aXRjaCANCj4+IGFuZA0KPj4gdGhpcyBvdmVycmlkZSBm
ZWF0dXJlLg0KPj4NCj4+IFRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdXNiIHJvbGUgc3dp
dGNoIHRvIGR3YzIsIGJ5IHVzaW5nIA0KPj4gb3ZlcnJpZGluZw0KPj4gY29udHJvbCBvZiB0aGUg
UEhZIHZvbHRhZ2UgdmFsaWQgYW5kIElEIGlucHV0IHNpZ25hbHMuDQo+Pg0KPj4gSXQgaGFzIGJl
ZW4gdGVzdGVkIG9uIHN0bTMybXAxNTdjLWRrMiBbMV0sIHdoaWNoIGhhcyBhIFR5cGUtQyBjb25u
ZWN0b3INCj4+IG1hbmFnZWQgYnkgYSBUeXBlLUMgcG9ydCBjb250cm9sbGVyLCBhbmQgY29ubmVj
dGVkIHRvIFVTQiBPVEcgDQo+PiBjb250cm9sbGVyLg0KPj4NCj4+IFsxXSANCj4+IGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5zdC5jb20vZW4vZXZhbHVhdGlvbi10b29s
cy9zdG0zMm1wMTU3Yy1kazIuaHRtbF9fOyEhQTRGMlI5R19wZyFMQXJaOG0yckFnNXIxZ2pJVWdN
ZTNZTnRGZVJCOGxpOHlLTmtVMG4zVXFiZ05aQUREOTZWWFJUSFQ3QkxUNG8kIA0KPj4NCj4+IEFt
ZWxpZSBEZWxhdW5heSAoMyk6DQo+PiDCoMKgIGR0LWJpbmRpbmdzOiB1c2I6IGR3YzI6IGFkZCBv
cHRpb25hbCB1c2Itcm9sZS1zd2l0Y2ggcHJvcGVydHkNCj4+IMKgwqAgdXNiOiBkd2MyOiBvdmVy
cmlkZSBQSFkgaW5wdXQgc2lnbmFscyB3aXRoIHVzYiByb2xlIHN3aXRjaCBzdXBwb3J0DQo+PiDC
oMKgIHVzYjogZHdjMjogZG9uJ3QgdXNlIElEL1ZidXMgZGV0ZWN0aW9uIGlmIHVzYi1yb2xlLXN3
aXRjaCBvbiANCj4+IFNUTTMyTVAxNQ0KPj4gwqDCoMKgwqAgU29Dcw0KPj4gLS0tDQo+PiBDaGFu
Z2VzIGluIHY2Og0KPj4gLSBTZWxlY3QgVVNCX1JPTEVfU1dJVENIIGlmIFVTQl9EV0MyLCBhbmQg
bm90IG9ubHkgaWYgDQo+PiBVU0JfRFdDMl9EVUFMX1JPTEU6DQo+PiDCoMKgIGRyZC5jIGlzIGJ1
aWx0IHdoYXRldmVyIERXQzIgbW9kZSAoRFVBTCwgSE9TVCwgUEVSSVBIRVJBTCkgYXMgaXQgDQo+
PiBpcyB1c2VkIGFsc28NCj4+IMKgwqAgdG8gZGV0ZWN0IGF0dGFjaC9kZXRhY2ggKHNvIGEtdmFs
aWQvYi12YWxpZCBzZXNzaW9ucykuDQo+PiBDaGFuZ2VzIGluIHY1Og0KPj4gLSBVc2UgZGV2aWNl
X3Byb3BlcnR5X3JlYWRfYm9vbCBpbnN0ZWFkIG9mIG9mX3JlYWRfcHJvcGVydHlfYm9vbCBpbiAN
Cj4+IHBhcmFtcy5jDQo+PiBDaGFuZ2VzIGluIHY0Og0KPj4gLSBTaW1wbGlmeSBjYWxsIHRvIGR3
YzJfZm9yY2VfbW9kZSBpbiBkcmQuYw0KPj4gLSBBZGQgZXJyb3JfZHJkIGxhYmVsIGluIHByb2Jl
IGVycm9yIHBhdGggaW4gcGxhdGZvcm0uYw0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+IC0gRml4IGJ1
aWxkIGlzc3VlIHJlcG9ydGVkIGJ5IGtlcm5lbCB0ZXN0IHJvYm90IGluIGRyZC5jDQo+PiBDaGFu
Z2VzIGluIHYyOg0KPj4gLSBQcmV2aW91cyBEVCBwYXRjaCBhbHJlYWR5IGluIHN0bTMyLW5leHQg
YnJhbmNoIHNvIHJlbW92ZWQgZnJvbSB2MiANCj4+IHBhdGNoc2V0DQo+PiDCoMKgICJBUk06IGR0
czogc3RtMzI6IGVuYWJsZSB1c2Itcm9sZS1zd2l0Y2ggb24gVVNCIE9URyBvbiANCj4+IHN0bTMy
bXAxNXh4LWRreCINCj4+IC0gRFdDMiBEVCBiaW5kaW5ncyB1cGRhdGUgYWRkZWQNCj4+IC0gQnVp
bGQgaXNzdWUgcmVwb3J0ZWQgYnkga2VybmVsIHRlc3Qgcm9ib3QgZml4ZWQNCj4+IC0gTWFydGlu
J3MgY29tbWVudHMgdGFrZW4gaW50byBhY2NvdW50DQo+PiAtLS0NCj4+IMKgIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9kd2MyLnlhbWzCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKw0KPj4g
wqAgZHJpdmVycy91c2IvZHdjMi9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4gwqAgZHJpdmVycy91c2IvZHdjMi9NYWtlZmlsZcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQ0KPj4gwqAg
ZHJpdmVycy91c2IvZHdjMi9jb3JlLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCA5ICsNCj4+IMKgIGRyaXZlcnMvdXNiL2R3YzIvZHJkLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTgwICsrKysrKysrKysr
KysrKysrKw0KPj4gwqAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQ0KPj4gwqAgZHJpdmVycy91c2IvZHdj
Mi9wYXJhbXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MiArLQ0KPj4gwqAgZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyMCArLQ0KPj4gwqAgOCBmaWxlcyBjaGFuZ2VkLCAyMTUg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3VzYi9kd2MyL2RyZC5jDQo+Pg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxo
bWluYXNAc3lub3BzeXMuY29tPiBmb3IgZHdjMg0KDQo=

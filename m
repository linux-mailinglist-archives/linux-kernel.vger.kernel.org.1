Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B029DDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391042AbgJ2AoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:44:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43690 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731268AbgJ2An3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:43:29 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8935140515;
        Thu, 29 Oct 2020 00:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603932207; bh=+tnL0mLGSlDpBM5Lz24liFEVWYLm7lrTSGa1d/oXBMg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hCC7WJ0ytDJhX+og48y+8Zxt3DRTPJJWgqyDhUgjansX8zk82Zkp3PvCnLUnFBsoK
         Wh1r84PdnHYVWdj6hQ0tYZ8IorAdWgxwDj/yfWUn52J+Et7EiT4zQQfYIlPSOwHheI
         hyzbtyaDs63hgRtDOgWLrntNAQZC97WKObcc2NDbWqH49E/oOgSqDCtLi4QbF1vdmY
         fTwZZxkIo00s85xJTnZAbnMIQhKKGtWjlX7tM75DOjO8Xk/GcpLN1KeGviBPOzBuup
         bcImYXq/lL7Cfqr0JV5eaoIBrU22ocl4Q/t+c0vZ8C2YlIAsCqA6BxpcyRlhGf7LkN
         loXg5SjiZhWOg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3B773A007C;
        Thu, 29 Oct 2020 00:43:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id F06AA400A0;
        Thu, 29 Oct 2020 00:43:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="b5C2jNeS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG/jqCl4BLUegs1yHq8iU3J0pLW+SgCXz16Tj532UJd9GVSHqfWASV7Ui60xCiXzCZpchV3Z2M1IlXJnlwiqxJDggyuWMSXT2dnTWBgk5xaaAWhUEsvJr67m2xwCG3Fp/T/hd4VL9WAJr8lmse3qQm2/KqrPcm491/fmsh2IthI8PLxRc/9Fp86Drds/C06C93qWZiJAdnXn4dF+diDpSwjprWtmjA+IOBUNfKP0FkiDz36x0xYGksslEmgWvTgS3QeuHQMhIEb/rRGgGiRmZKXUxozioplGJGg6ZV5cVLoo/Qq48DSY6sIlT2uGoHffsz1XgoXIF3+IQvxw8m1CBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tnL0mLGSlDpBM5Lz24liFEVWYLm7lrTSGa1d/oXBMg=;
 b=gfrUU5YBpxt3e8b4kITSCzut7xDw6kA5xeUxuT/iB50Gr+FyCVzx7sxcXeFBZTcu7qxt5SY6h9UNHvH75+tIpO1yEy1G8V9iXuI/xv4ZW93O4HvdIqQIwRMLOkbBY2zrxwsKVJ3Zh3X4wMBYvqpPcpXNbrM5UH04c3qxqPQbr6Xw9/F8nipmfYok4M7QSgrfEhZHCiQEA/bGV6k47siar1o5t3fgSvUHMwe8bIK63z9ir7laMKQGFgU5fPHgdcLcLkSEbGce0ztzubr8R+iihUF1zG87DYVNPLIjtqzog0ec5jD1XOuiXakuLiOfIwq/IGZ/Z2JEdyOf6jvAOhXYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tnL0mLGSlDpBM5Lz24liFEVWYLm7lrTSGa1d/oXBMg=;
 b=b5C2jNeSnh5TfnDxDdd5mPBHRHKPt7VhFgdjacuOn02J1isEYZNpcQI2yArb9EJPri3yBcoL17O3UD5EOn1AoudoN6SetsbOAcg1ds5EaejjuMRx7aaS7c/6t3OkLWEsBInilT+GWMppZA6XG6ooSpi3DI8tRM3BB1j25kBDPd8=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3607.namprd12.prod.outlook.com (2603:10b6:a03:dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 00:43:21 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc%4]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 00:43:21 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Preserve UDC max speed setting
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: Preserve UDC max speed setting
Thread-Index: AQHWrYQp6E6V+/WtykWb6sC7DY3jqamtvfeA
Date:   Thu, 29 Oct 2020 00:43:21 +0000
Message-ID: <e6faade6-7c4c-5966-3afd-63be2deefa01@synopsys.com>
References: <20201028234311.6464-1-wcheng@codeaurora.org>
 <20201028234311.6464-3-wcheng@codeaurora.org>
In-Reply-To: <20201028234311.6464-3-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55aaf6b7-5d48-4bc0-789b-08d87ba3a2f7
x-ms-traffictypediagnostic: BYAPR12MB3607:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3607F3146D8EA35CBE30CC4FAA140@BYAPR12MB3607.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JOiHWm5jymzoBTtXzIi/SQPurJEmse37N4Zq1hOJWQJPGyRB14htwfJ/wIqqMq7m4GONDsGjf0BCYCfZd/Qc+igKMkgnI0CwbX5s5DKMwtPu+8FuFbXQFgOxVK0STdVGvIiJcC1PuNqoXHfPedpDIVImghRNR2ybM11ezmqESML55htMM2/urnQgfW8XuOii267bndCwYAVbb0gGEKIxwL20SS/8JSEQEnFPg7OSroxB1sHM1GKNo2rIi4l79RxUE1L27GoXcPLQCrJTVRtvpapGCmtLEjXRzHEAQXsxL/S7L6cpDkFZNKVjpswMDOjGa1VL0jWDSlBl+Bu4DhXrtf+unqRjiuMTugX0xfpJmu9uMn106D4PxBpyL8Ha3QhZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(5660300002)(8676002)(8936002)(71200400001)(66946007)(76116006)(31696002)(64756008)(83380400001)(66446008)(66476007)(86362001)(66556008)(54906003)(36756003)(2616005)(110136005)(316002)(31686004)(2906002)(478600001)(6512007)(6506007)(6486002)(26005)(186003)(4326008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UsjLgATg84Ul8R625qBpLnWCfSSMX0LO1Q1t0MyU/O7IwTDOX6FcFvfu8UXR8E1o2haRiIqtCLEJAq77pO83eaJrxQv6nh68PfmeYGcZH8lv9NuJpAKYfwUaMCjmhgg0IcldJzAJXJFoWCjOfzfsfQhL8yNU9MNFsAYcOT1MhsVA4CS43nJuvD9ua/bIj4IjnZnkM5MGXwnNdGVP5NpURyMkWh98oRdq8jj1gGOiXkY2eg6CoPefhmKL8hNWN7/+Jy4HaZ2zl8ThhInNOda8w0zAkzWf7F2WReX5eW6+Pt87IIAdix7auruBci2PGv4Ot37zBCrYHhBMyyq2N+IzKaqlRklm15LYZTwnEJb4x2i5jSq511X2i5xGsNU7Lff4Tf8GEI7ilNkEADOScFvUucgTap7wbMWMtHLqAAJzSbpTibUmospmY7eu2PuDWcct10Weh47R9kcOAKYjBqjqBHQRZmOnavluy7Ore78/spZi3mSRZwQK4PahCZ+/66PWeZ24QPSw0AxeCvy/Uv9PhWBMksTj2dV4Gh18pgxoejr2kRd9n3brmhVrch5/zKVKGYh7SauKORVFxWNjlh2H3/6W6V54e40W5fCotwyBoZprZalkJr85UHaWiP+4tslqVIqRCTF+pMJIRXSsqxF7aQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D91BD4D9D454644B69EA4EE2E2C14D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aaf6b7-5d48-4bc0-789b-08d87ba3a2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 00:43:21.5558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3GRIUYvyDbPwtkIhApskmOAH7vpUnMIpctXRijvUnKfyhbjW8zglLO/J4V45BoaniiplKDXJ/75D23gScdO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3607
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCldlc2xleSBDaGVuZyB3cm90ZToNCj4gVGhlIFVTQiBnYWRnZXQvVURDIGRyaXZlciBj
YW4gcmVzdHJpY3QgdGhlIERXQzMgY29udHJvbGxlciBzcGVlZCB1c2luZw0KPiBkd2MzX2dhZGdl
dF9zZXRfc3BlZWQoKS4gIFN0b3JlIHRoaXMgc2V0dGluZyBpbnRvIGEgdmFyaWFibGUsIGluIG9y
ZGVyIGZvcg0KPiB0aGlzIHNldHRpbmcgdG8gcGVyc2lzdCBhY3Jvc3MgY29udHJvbGxlciByZXNl
dHMgZHVlIHRvIHJ1bnRpbWUgUE0uDQoNCldoeSBkbyB3ZSBuZWVkIHRvIGRvIHRoaXM/IERDRkcg
c2hvdWxkIHBlcnNpc3QgdW5sZXNzIHdlIG92ZXJ3cml0ZSBpdC4NClRoZSBjdXJyZW50IFBNIHNo
b3VsZG4ndCB1cGRhdGUgdGhlIGN1cnJlbnQgc3BlZWQgc2V0dGluZy4NCg0KQlIsDQpUaGluaA0K
DQo+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8d2NoZW5nQGNvZGVhdXJvcmEub3JnPg0K
PiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oICAgfCAgIDEgKw0KPiAgZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyB8IDEwOCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggMmYwNGIzZTQyYmYxLi4zOTBkM2RlZWYwYmEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+IEBAIC0xMTE5LDYgKzExMTksNyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJdTMy
CQkJbnJfc2NyYXRjaDsNCj4gIAl1MzIJCQl1MXUyOw0KPiAgCXUzMgkJCW1heGltdW1fc3BlZWQ7
DQo+ICsJdTMyCQkJZ2FkZ2V0X21heF9zcGVlZDsNCj4gIA0KPiAgCXUzMgkJCWlwOw0KPiAgDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiBpbmRleCA2MzY0NDI5YjIxMjIuLjFhOTNiOTJhNWU2ZiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+IEBAIC0xOTQxLDYgKzE5NDEsNjEgQEAgc3RhdGljIHZvaWQgZHdjM19zdG9w
X2FjdGl2ZV90cmFuc2ZlcnMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAl9DQo+ICB9DQo+ICANCj4g
K3N0YXRpYyB2b2lkIF9fZHdjM19nYWRnZXRfc2V0X3NwZWVkKHN0cnVjdCBkd2MzICpkd2MpDQo+
ICt7DQo+ICsJdTMyCQkJcmVnOw0KPiArDQo+ICsJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3Ms
IERXQzNfRENGRyk7DQo+ICsJcmVnICY9IH4oRFdDM19EQ0ZHX1NQRUVEX01BU0spOw0KPiArDQo+
ICsJLyoNCj4gKwkgKiBXT1JLQVJPVU5EOiBEV0MzIHJldmlzaW9uIDwgMi4yMGEgaGF2ZSBhbiBp
c3N1ZQ0KPiArCSAqIHdoaWNoIHdvdWxkIGNhdXNlIG1ldGFzdGFiaWxpdHkgc3RhdGUgb24gUnVu
L1N0b3ANCj4gKwkgKiBiaXQgaWYgd2UgdHJ5IHRvIGZvcmNlIHRoZSBJUCB0byBVU0IyLW9ubHkg
bW9kZS4NCj4gKwkgKg0KPiArCSAqIEJlY2F1c2Ugb2YgdGhhdCwgd2UgY2Fubm90IGNvbmZpZ3Vy
ZSB0aGUgSVAgdG8gYW55DQo+ICsJICogc3BlZWQgb3RoZXIgdGhhbiB0aGUgU3VwZXJTcGVlZA0K
PiArCSAqDQo+ICsJICogUmVmZXJzIHRvOg0KPiArCSAqDQo+ICsJICogU1RBUiM5MDAwNTI1NjU5
OiBDbG9jayBEb21haW4gQ3Jvc3Npbmcgb24gRENUTCBpbg0KPiArCSAqIFVTQiAyLjAgTW9kZQ0K
PiArCSAqLw0KPiArCWlmIChEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAyMjBBKSAmJg0KPiArCSAg
ICAhZHdjLT5kaXNfbWV0YXN0YWJpbGl0eV9xdWlyaykgew0KPiArCQlyZWcgfD0gRFdDM19EQ0ZH
X1NVUEVSU1BFRUQ7DQo+ICsJfSBlbHNlIHsNCj4gKwkJc3dpdGNoIChkd2MtPmdhZGdldF9tYXhf
c3BlZWQpIHsNCj4gKwkJY2FzZSBVU0JfU1BFRURfTE9XOg0KPiArCQkJcmVnIHw9IERXQzNfRENG
R19MT1dTUEVFRDsNCj4gKwkJCWJyZWFrOw0KPiArCQljYXNlIFVTQl9TUEVFRF9GVUxMOg0KPiAr
CQkJcmVnIHw9IERXQzNfRENGR19GVUxMU1BFRUQ7DQo+ICsJCQlicmVhazsNCj4gKwkJY2FzZSBV
U0JfU1BFRURfSElHSDoNCj4gKwkJCXJlZyB8PSBEV0MzX0RDRkdfSElHSFNQRUVEOw0KPiArCQkJ
YnJlYWs7DQo+ICsJCWNhc2UgVVNCX1NQRUVEX1NVUEVSOg0KPiArCQkJcmVnIHw9IERXQzNfRENG
R19TVVBFUlNQRUVEOw0KPiArCQkJYnJlYWs7DQo+ICsJCWNhc2UgVVNCX1NQRUVEX1NVUEVSX1BM
VVM6DQo+ICsJCQlpZiAoRFdDM19JUF9JUyhEV0MzKSkNCj4gKwkJCQlyZWcgfD0gRFdDM19EQ0ZH
X1NVUEVSU1BFRUQ7DQo+ICsJCQllbHNlDQo+ICsJCQkJcmVnIHw9IERXQzNfRENGR19TVVBFUlNQ
RUVEX1BMVVM7DQo+ICsJCQlicmVhazsNCj4gKwkJZGVmYXVsdDoNCj4gKwkJCWRldl9lcnIoZHdj
LT5kZXYsICJpbnZhbGlkIHNwZWVkICglZClcbiIsIGR3Yy0+Z2FkZ2V0X21heF9zcGVlZCk7DQo+
ICsNCj4gKwkJCWlmIChEV0MzX0lQX0lTKERXQzMpKQ0KPiArCQkJCXJlZyB8PSBEV0MzX0RDRkdf
U1VQRVJTUEVFRDsNCj4gKwkJCWVsc2UNCj4gKwkJCQlyZWcgfD0gRFdDM19EQ0ZHX1NVUEVSU1BF
RURfUExVUzsNCj4gKwkJfQ0KPiArCX0NCj4gKwlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNf
RENGRywgcmVnKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX2dhZGdldF9ydW5fc3Rv
cChzdHJ1Y3QgZHdjMyAqZHdjLCBpbnQgaXNfb24sIGludCBzdXNwZW5kKQ0KPiAgew0KPiAgCXUz
MgkJCXJlZzsNCj4gQEAgLTE5NjMsNiArMjAxOCw3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRf
cnVuX3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29uLCBpbnQgc3VzcGVuZCkNCj4gIAkJ
aWYgKGR3Yy0+aGFzX2hpYmVybmF0aW9uKQ0KPiAgCQkJcmVnIHw9IERXQzNfRENUTF9LRUVQX0NP
Tk5FQ1Q7DQo+ICANCj4gKwkJX19kd2MzX2dhZGdldF9zZXRfc3BlZWQoZHdjKTsNCj4gIAkJZHdj
LT5wdWxsdXBzX2Nvbm5lY3RlZCA9IHRydWU7DQo+ICAJfSBlbHNlIHsNCj4gIAkJcmVnICY9IH5E
V0MzX0RDVExfUlVOX1NUT1A7DQo+IEBAIC0yMzE4LDU5ICsyMzc0LDkgQEAgc3RhdGljIHZvaWQg
ZHdjM19nYWRnZXRfc2V0X3NwZWVkKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLA0KPiAgew0KPiAgCXN0
cnVjdCBkd2MzCQkqZHdjID0gZ2FkZ2V0X3RvX2R3YyhnKTsNCj4gIAl1bnNpZ25lZCBsb25nCQlm
bGFnczsNCj4gLQl1MzIJCQlyZWc7DQo+ICANCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5s
b2NrLCBmbGFncyk7DQo+IC0JcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfRENGRyk7
DQo+IC0JcmVnICY9IH4oRFdDM19EQ0ZHX1NQRUVEX01BU0spOw0KPiAtDQo+IC0JLyoNCj4gLQkg
KiBXT1JLQVJPVU5EOiBEV0MzIHJldmlzaW9uIDwgMi4yMGEgaGF2ZSBhbiBpc3N1ZQ0KPiAtCSAq
IHdoaWNoIHdvdWxkIGNhdXNlIG1ldGFzdGFiaWxpdHkgc3RhdGUgb24gUnVuL1N0b3ANCj4gLQkg
KiBiaXQgaWYgd2UgdHJ5IHRvIGZvcmNlIHRoZSBJUCB0byBVU0IyLW9ubHkgbW9kZS4NCj4gLQkg
Kg0KPiAtCSAqIEJlY2F1c2Ugb2YgdGhhdCwgd2UgY2Fubm90IGNvbmZpZ3VyZSB0aGUgSVAgdG8g
YW55DQo+IC0JICogc3BlZWQgb3RoZXIgdGhhbiB0aGUgU3VwZXJTcGVlZA0KPiAtCSAqDQo+IC0J
ICogUmVmZXJzIHRvOg0KPiAtCSAqDQo+IC0JICogU1RBUiM5MDAwNTI1NjU5OiBDbG9jayBEb21h
aW4gQ3Jvc3Npbmcgb24gRENUTCBpbg0KPiAtCSAqIFVTQiAyLjAgTW9kZQ0KPiAtCSAqLw0KPiAt
CWlmIChEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAyMjBBKSAmJg0KPiAtCSAgICAhZHdjLT5kaXNf
bWV0YXN0YWJpbGl0eV9xdWlyaykgew0KPiAtCQlyZWcgfD0gRFdDM19EQ0ZHX1NVUEVSU1BFRUQ7
DQo+IC0JfSBlbHNlIHsNCj4gLQkJc3dpdGNoIChzcGVlZCkgew0KPiAtCQljYXNlIFVTQl9TUEVF
RF9MT1c6DQo+IC0JCQlyZWcgfD0gRFdDM19EQ0ZHX0xPV1NQRUVEOw0KPiAtCQkJYnJlYWs7DQo+
IC0JCWNhc2UgVVNCX1NQRUVEX0ZVTEw6DQo+IC0JCQlyZWcgfD0gRFdDM19EQ0ZHX0ZVTExTUEVF
RDsNCj4gLQkJCWJyZWFrOw0KPiAtCQljYXNlIFVTQl9TUEVFRF9ISUdIOg0KPiAtCQkJcmVnIHw9
IERXQzNfRENGR19ISUdIU1BFRUQ7DQo+IC0JCQlicmVhazsNCj4gLQkJY2FzZSBVU0JfU1BFRURf
U1VQRVI6DQo+IC0JCQlyZWcgfD0gRFdDM19EQ0ZHX1NVUEVSU1BFRUQ7DQo+IC0JCQlicmVhazsN
Cj4gLQkJY2FzZSBVU0JfU1BFRURfU1VQRVJfUExVUzoNCj4gLQkJCWlmIChEV0MzX0lQX0lTKERX
QzMpKQ0KPiAtCQkJCXJlZyB8PSBEV0MzX0RDRkdfU1VQRVJTUEVFRDsNCj4gLQkJCWVsc2UNCj4g
LQkJCQlyZWcgfD0gRFdDM19EQ0ZHX1NVUEVSU1BFRURfUExVUzsNCj4gLQkJCWJyZWFrOw0KPiAt
CQlkZWZhdWx0Og0KPiAtCQkJZGV2X2Vycihkd2MtPmRldiwgImludmFsaWQgc3BlZWQgKCVkKVxu
Iiwgc3BlZWQpOw0KPiAtDQo+IC0JCQlpZiAoRFdDM19JUF9JUyhEV0MzKSkNCj4gLQkJCQlyZWcg
fD0gRFdDM19EQ0ZHX1NVUEVSU1BFRUQ7DQo+IC0JCQllbHNlDQo+IC0JCQkJcmVnIHw9IERXQzNf
RENGR19TVVBFUlNQRUVEX1BMVVM7DQo+IC0JCX0NCj4gLQl9DQo+IC0JZHdjM193cml0ZWwoZHdj
LT5yZWdzLCBEV0MzX0RDRkcsIHJlZyk7DQo+IC0NCj4gKwlkd2MtPmdhZGdldF9tYXhfc3BlZWQg
PSBzcGVlZDsNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsN
Cj4gIH0NCj4gIA0KDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B632AE48A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbgKJX73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:59:29 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:51366 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbgKJX73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:59:29 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C995D400D5;
        Tue, 10 Nov 2020 23:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605052768; bh=LSwcfk+BMOaGz2P1w7NsHNOOOD1t+HTNND8plASdb2Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NxH38x5nbQGMUQnpEY5PfrOaYA8bJrigKGVRL4NbW4Gn6QJeWwvSrmX9qEcXE21+F
         vI3XupiyCwIbKqtuzJOJFSrd+XxmH9gRS1vIEv6z23yvYsq/fGC/FP72p0gsorQpNi
         kvRiL6OO+jrcdxdmmr/5kQ0keI1EFqP740P3xyYEkBvnDNngS6dsWH+FK141GzqM4K
         glHCQU703WWMe8NDBtl55eS1NbXzBbFola8GeQ83aEJC/AQaTeaOvr2i7BguSY9dBF
         WwaO1HBoLmrKjItGooH7q29IXMS+J9TaPp3mHJDEddmTeDo/4B61iBby6ZPIn2jbP2
         5n0hvoO9V1jCg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9EF3FA0084;
        Tue, 10 Nov 2020 23:59:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A7DAA80256;
        Tue, 10 Nov 2020 23:59:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HoYAtdr7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtJvkCjDAhI/QLgVHKq0ra2EIhLdJP5Y0jE0lHgq7cJ8kYMFp3AVrRR6F6IrxIlCWvw/BskMAcwU1bFFt9QOVWJMPCdd3pLsesBGqouvHvtcFPzJ/0x/OkehvIlghCQzm/5zNnvnCrzjeFpGFaGjmwRGeiwdUc32gSPSxCGJ+dN4B3qVNyaNHlpmUVM/2xsH3YOkznEYdxka0rU22eNXS7ZXaCym40GGTQ7oiULaxItKkrPGFjITBVOYk52o/1niWGFAFhFJIEHj+TlkrCDC8IDiliX+ts8t417NLi2nHdx3DEnnOy+fhyvNb7UzNX+v+blrQTd4adHQaMPpAPtvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSwcfk+BMOaGz2P1w7NsHNOOOD1t+HTNND8plASdb2Y=;
 b=bA/H3hNRZ2vFTKcqXbuUGgHC9A0nLDmrd4gH/xC7CGYsxmhKbhFOjOuTQ4c2rMz1NkL0gXqzKgWvpMjIp4LeKGsB3EJtzkAz4WhJtCdQ1Zr9nPrf91alysWKyx8Be5ehTGxzQqgHW9QtmHEa9gY0lVtAFIzTvCkhVNBGR1lhmKMcFzoHuOflI6VMVnqNxgN7ElSPBxVwmNUKvCCWsLsovVRbSu+rWJ2dU1BAF9/2ytVwfSJdE/n436IuXw+12sCPQhPFL93SvH24M0vuUo4d7gT+taoMptMcz3XuHh6qgaO4w4dDnOeZ5uo6e1xauddBS1Q2rJbec9umK+/quVBN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSwcfk+BMOaGz2P1w7NsHNOOOD1t+HTNND8plASdb2Y=;
 b=HoYAtdr76t5rck9UdbORxv2SqJeAGt+AUqBDVZI4n++z/pYQDMCTt7HTQLh9ZKP6v3iOMXlnfFL1PX+AUZin1gZARYgMN5UZmJNwvieTkAuKkc72h1nrZ2GO8tktpPpegeMWptMZk9G9uEAOGC6i+U073xiSWtY2D3v6rAu+yH8=
Received: from BYAPR12MB3303.namprd12.prod.outlook.com (2603:10b6:a03:131::28)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Tue, 10 Nov
 2020 23:59:24 +0000
Received: from BYAPR12MB3303.namprd12.prod.outlook.com
 ([fe80::f1dc:e903:bcfb:d79b]) by BYAPR12MB3303.namprd12.prod.outlook.com
 ([fe80::f1dc:e903:bcfb:d79b%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 23:59:24 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching
 modes in DRD
Thread-Topic: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching
 modes in DRD
Thread-Index: AQHWp/wCBx/WzG0lD0G/6zZaqZHYK6mi0lqAgABv5ACAHujRAA==
Date:   Tue, 10 Nov 2020 23:59:24 +0000
Message-ID: <8a5dde42-df12-535a-07a0-7e7b18b816f7@synopsys.com>
References: <20201021224619.20796-1-john.stultz@linaro.org>
 <d9c241a5-f31b-b044-bc15-1c5e4d445a69@synopsys.com>
 <87tuumelpf.fsf@kernel.org>
In-Reply-To: <87tuumelpf.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d646110d-e33f-487c-7ddb-08d885d4a69b
x-ms-traffictypediagnostic: BYAPR12MB2952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29527E32808C3B4D1B7E724DAAE90@BYAPR12MB2952.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsamlIi1io7/veTmIFLPYUi/vrvu5/P8VQHvxitEkFK+jNfx12Get+BCTEjZIm7PhRu2zYBq/ytNR6dkAA5QzAumcMdXEab6jKlhfG0o/IQgW9VeqKN7CL/vE2ziFd2JCXyEg4CgjxqVgz01ih+il73zhByh9xc8hxAuQCxQxWaa2T4yejQGW6aXrrnDA1mU6VKNxCz75AZVlxVZuOq/CZQeo5OHG8tQ1AyD6dJYRekPInc1FQqkC5Lv5uC6AcYP+tD4Bvk4wgSkAFrggf2ytMdTtG8j3zWMPIl9mMQzzi1BYuxwSlKz79TJsrUGO7+yJ5Sl2BGvXguV+GNI8lcEgf8QoTQVVQVWsaqG3laa/r3NrAqYjH7GcKs5gglsoFpd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3303.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(4326008)(316002)(31686004)(66946007)(31696002)(66556008)(76116006)(66476007)(8676002)(64756008)(26005)(86362001)(5660300002)(54906003)(8936002)(2616005)(110136005)(2906002)(66446008)(6486002)(6506007)(36756003)(71200400001)(83380400001)(6512007)(7416002)(478600001)(186003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sFkNV0yR77q++Og60jAhi0Knr2ejmjcpIi44qL9cRm5FUWijy1iqGxa/QZhxNVqXApvSQTkLLZJ6VAgby5lRXimg7aRttEw5/aVcLNoa4uUToNm1wkNpK3syOj169b7rcC2nVoMko+zRTYVBA2lgiRYwzUDiAfTAwSA+pDVG5HGaQNQEOWy46EwJKV37KlWtXBGUOkzloSf4CSYpMefnvwY8ZMf4HmXO2l1Rk4G4rvbSl6bv2BdkoLpetzc9Dbyr6Mt5nZkewtORHjwFKxlt2ti4E60sd2pdcMw5aAPmbi8LdgrzxZQ3rHrp9Ze5/nsczLgtgKrZDYVB/yZMCWXBCSOsBe/jmSrkvzPfMPwtGvUxNPdmpSAbRmmC2s0eNcxh3I+ioRptj1vRakpJe84L5c+loBEbxXNK/949perTkLRdBzy+nkKEqlT91L9T0lwChuvPdvFMcZu/aLt03wO48oAnGS60VQQKyXCv6gPIsiC6Rr2ojLNlnAOU5oGBRGcuDgAHkEIdJjGo7APIfmKYlSrT660/OUZ8NAMeQheaqfQxgP7z3xMuMHkfGWRsKNVzhg8bq1F4u1BFH8VrLNToHg/GcFoBN0vpyuGx3kC7pBoAcHViUeaKPqH68MP1DVb+kkvbcRT2a24u/jiCN5JzqA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB2EAB10C79558439DC98204ACD71A84@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3303.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d646110d-e33f-487c-7ddb-08d885d4a69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 23:59:24.6784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lsykgaVuX4NbNMGMwuFqR3BLZQqkbq34/BGBChZgMNCr6zXlBwzuZC4EKBw/QpgD3rkxuloaJrJSBXfNemzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkZlbGlwZSBCYWxiaSB3cm90ZToNCj4gSGksDQo+DQo+IFRoaW5oIE5ndXllbiA8VGhp
bmguTmd1eWVuQHN5bm9wc3lzLmNvbT4gd3JpdGVzOg0KPj4gSm9obiBTdHVsdHogd3JvdGU6DQo+
Pj4gIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsp
DQo+Pj4gIHsNCj4+PiAgCXN0cnVjdCBkd2MzICpkd2MgPSB3b3JrX3RvX2R3Yyh3b3JrKTsNCj4+
PiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+Pj4gKwlpbnQgaHdfbW9kZTsNCj4+PiAgCWludCBy
ZXQ7DQo+Pj4gIAl1MzIgcmVnOw0KPj4+ICANCj4+PiBAQCAtMTU0LDYgKzE2OCwxMSBAQCBzdGF0
aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPj4+ICAJ
CWJyZWFrOw0KPj4+ICAJfQ0KPj4+ICANCj4+PiArCS8qIEV4ZWN1dGUgYSBHQ1RMIENvcmUgU29m
dCBSZXNldCB3aGVuIHN3aXRjaCBtb2RlIGluIERSRCovDQo+Pj4gKwlod19tb2RlID0gRFdDM19H
SFdQQVJBTVMwX01PREUoZHdjLT5od3BhcmFtcy5od3BhcmFtczApOw0KPj4+ICsJaWYgKGh3X21v
ZGUgPT0gRFdDM19HSFdQQVJBTVMwX01PREVfRFJEKQ0KPj4+ICsJCWR3YzNfZ2N0bF9jb3JlX3Nv
ZnRfcmVzZXQoZHdjKTsNCj4+PiArDQo+PiBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIGRvbmUgaW5z
aWRlIHRoZSBzcGluX2xvY2suDQo+Pg0KPj4+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9j
aywgZmxhZ3MpOw0KPj4+ICANCj4+PiAgCWR3YzNfc2V0X3BydGNhcChkd2MsIGR3Yy0+ZGVzaXJl
ZF9kcl9yb2xlKTsNCj4+IFRoZSBEUkQgbW9kZSBjaGFuZ2Ugc2VxdWVuY2Ugc2hvdWxkIGJlIGxp
a2UgdGhpcyBpZiB3ZSB3YW50IHRvIHN3aXRjaA0KPj4gZnJvbSBob3N0IC0+IGRldmljZSBhY2Nv
cmRpbmcgdG8gdGhlIHByb2dyYW1taW5nIGd1aWRlIChmb3IgYWxsIERSRCBJUHMpOg0KPj4gMS4g
UmVzZXQgY29udHJvbGxlciB3aXRoIEdDVEwuQ29yZVNvZnRSZXNldA0KPj4gMi4gU2V0IEdDVEwu
UHJ0Q2FwRGlyKGRldmljZSkNCj4+IDMuIFNvZnQgcmVzZXQgd2l0aCBEQ1RMLkNTZnRSc3QNCj4+
IDQuIFRoZW4gZm9sbG93IHVwIHdpdGggdGhlIGluaXRpYWxpemluZyByZWdpc3RlcnMgc2VxdWVu
Y2UNCj4+DQo+PiBIb3dldmVyLCBmcm9tIGNvZGUgcmV2aWV3LCB3aXRoIHRoaXMgcGF0Y2gsIGl0
IGZvbGxvd3MgdGhpcyBzZXF1ZW5jZToNCj4+IGEuIFNvZnQgcmVzZXQgd2l0aCBEQ1RMLkNTZnRS
c3Qgb24gZHJpdmVyIHByb2JlDQo+PiBiLiBSZXNldCBjb250cm9sbGVyIHdpdGggR0NUTC5Db3Jl
U29mdFJlc2V0DQo+PiBjLiBTZXQgR0NUTC5QcnRDYXBEaXIoZGV2aWNlKQ0KPj4gZC4gPCBtaXNz
aW5nIERDVEwuQ1NmdFJzdCA+DQo+PiBlLiBUaGVuIGZvbGxvdyB1cCB3aXRoIGluaXRpYWxpemlu
ZyByZWdpc3RlcnMgc2VxdWVuY2UNCj4+DQo+PiBJdCBtYXkgd29yaywgYnV0IGl0IGRvZXNuJ3Qg
Zm9sbG93IHRoZSBwcm9ncmFtbWluZyBndWlkZS4NCj4+DQo+PiBGb3IgZGV2aWNlIC0+IGhvc3Qs
IGl0IHNob3VsZCBiZSBmaW5lIGJlY2F1c2UgdGhlIHhIQ0kgZHJpdmVyIHdpbGwgZG8NCj4+IFVT
QkNNRC5IQ1JTVCBkdXJpbmcgaW5pdGlhbGl6YXRpb24uDQo+IFRoZSBvbmx5IHJlYXNvbiB3aHkg
dGhpcyBpcyBuZWVkZWQgaXMgYmVjYXVzZSBTTlBTIHNhdmVzIHNvbWUgZGllIGFyZWENCj4gYnkg
bWFwcGluZyBzb21lIGhvc3QgYW5kIHBlcmlwaGVyYWwgcmVnaXN0ZXIgdG8gdGhlIHNhbWUgcGh5
c2ljYWwgYXJlYQ0KPiBpbiB0aGUgZGllLiBJIHN0aWxsIHRoaW5rIGEgZnVsbCBzb2Z0IHJlc2V0
IGlzIHVubmVjZXNzYXJ5IGFzIHdlIGhhdmUNCj4gYmVlbiBydW5uaW5nIHRoaXMgZHJpdmVyIHdp
dGhvdXQgdGhhdCBzb2Z0IHJlc2V0IGZvciBzZXZlcmFsIHllYXJzIG5vdy4NCj4NCg0KVGhpcyBp
c24ndCBhYm91dCB3aGV0aGVyIHRvIHVzZSBHQ1RMIG9yIERDVEwgZm9yIENvcmUgU29mdCBSZXNl
dCAoUGxlYXNlDQpjb3JyZWN0IG1lIGlmIEknbSB3cm9uZyBiZWNhdXNlIEkgdGhpbmsgdGhpcyBp
cyB3aGF0IHlvdSdyZSByZWZlcnJpbmcNCnRvKS4gSXQncyBhYm91dCB0aGUgcHJvZ3JhbW1pbmcg
ZmxvdyB3aGVuIHN3aXRjaGluZyBtb2Rlcy4NCg0KQm90aCBzdGVwIDEgYW5kIDMgYXJlIHJlcXVp
cmVkLiBCZWNhdXNlIGJlZm9yZSBzdGVwIDEsIGlmIHRoZSBob3N0IHdhcw0KaW4gbm9ybWFsIHdv
cmtpbmcgbW9kZSAoZS5nLiBhdHRhY2hlZCB0byBhIGRldmljZSksIHRoZW4gY2hhbmdpbmcgdGhl
DQpQcnRDYXBEaXIgZGlyZWN0bHkgdG8gZGV2aWNlIG1vZGUgaXMgbm90IGFkdmlzYWJsZSBhbmQg
SFcgbWF5IGV4aGliaXQNCnVua25vd24gYmVoYXZpb3IuIFRoZSBwcm9wZXIgd2F5IGlzIHRvIGhh
dmUgc3RlcCAxIHRocm91Z2ggNCBpbg0Kc2VxdWVuY2UuIFN0ZXAgMyBpcyByZXF1aXJlZCBiZWNh
dXNlIHNvbWUgb2YgdGhlIEhXIGZ1bmN0aW9uYWxpdHkgaXMNCmRlcGVuZGVudCBvbiB0aGUgUHJ0
Q2FwRGlyIHNldHRpbmcgYmVmb3JlIHRoZSBkcml2ZXIgaW50ZXJ2ZW50aW9uIGlzDQpyZXF1aXJl
ZCBmb3IgcHJvcGVyIGNvbW11bmljYXRpb24gd2l0aCB0aGUgZGV2aWNlLiBUaGUgSFcgbWF5IGJl
IGluIHNvbWUNCmludGVybWVkaWF0ZSBzdGF0ZSB3aGlsZSBjaGFuZ2luZyB0aGUgUHJ0Q2FwRGly
LiBTbywgaXQgaXMgcmVxdWlyZWQgdG8NCnJlc2V0IGl0IHRvIGhhdmUgYSBmcmVzaCBzdGFydCBp
biBkZXZpY2UgbW9kZS4NCg0KVGhvdWdoIHdlIG1heSBub3Qgc2VlIGlzc3VlcyBldmVuIGlmIHdl
IGVsaW1pbmF0ZSB0aGUgc3RlcHMgMSBhbmQgMywgaXQNCmlzIG5vdCBhZHZpc2FibGUgYW5kIHdl
IG1heSBoYXZlIHNvbWUgaW1wYWN0IHVuZGVyIGNlcnRhaW4gY29uZGl0aW9ucy4NCg0KT25lIGNo
YW5nZSBuZWVkcyB0byBtYWRlIGZvciB0aGlzIHBhdGNoIGlzIHRoZSBkcml2ZXIgbmVlZHMgdG8g
d2FpdCBhDQpjZXJ0YWluIGFtb3VudCBvZiB0aW1lIGJlZm9yZSBjbGVhcmluZyB0aGUgR0NUTC5D
b3JlU29mdFJlc2V0IGZvciB0aGUNClBIWSBjbG9jayB0byBzdGFydCBhbmQgc3RhYmlsaXplLg0K
DQpCUiwNClRoaW5oDQoNCg==

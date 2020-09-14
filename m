Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792932695DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:50:55 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35740 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgINTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:50:52 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 421BE400FE;
        Mon, 14 Sep 2020 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600113051; bh=wHHEKQXkw5FpzxP6voYYFcsv4zjZAmU2eY0S35MmlOg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IfTSkm9Ho/dXRmO4DjTDmC1Uok2Zs8oF8LOEfV1s7ybf8wuygfcZG/9BmQGAFrB59
         KYPz+jyAKl1UYCguyaF18pXDYiQGcvrq0A0KLqLBtvuTIGmr8oif7ARdYITxJi6xIr
         Ewe0QOO9sjcLfjFC1ELnhtF8YxwLnePjbf5lORIgJfDo68bdXWR48CxEGyL4Cid8uj
         zMfVsyJOK6LgXYSFj1wW6N9ks8JRwFDh2BvuQd2vhVc0kI9nQ8Y0FsxZ2h2GwmGUUO
         Ni/Ffl/oQtcTASxxBQuIxna4k40IlbTvdU2dCwQ/DlqQF492XlX40P0GMufv3Py68D
         /X2O+oAL4APAA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E08C5A0063;
        Mon, 14 Sep 2020 19:50:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 76E5640032;
        Mon, 14 Sep 2020 19:50:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="VynItc/X";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH5FP2lljI1o4wMQ658Z1hPvmtNpsKIBhznuC7os+VmgCtBuvgZ/A4IB3WrkPM+0zXl+0BbuQ9bmW228qJ2OXFQNLBSjSgILHW1zMCtxNoF8H5CAnX0D4kPDef/X0i8/Is4k8Qenv9s9GXIvAASdQ5FUvhiOsjoDZbuJffW+kWBwbmJuTmRBaHVatzDOC+owoMv9MPfzJ346qv6zsryVqytYGB528SHaQdmfoACCpwEBk18Qsockv5e3NihVKup/fmHq3dGrBjX7NJkyXQ8DSuimMjuk1S9f2kTIgvqQ9YCVXtB9oc+sJ1XmwSvP2eYEb6oAI/5/XFIp7HYgxGEZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHHEKQXkw5FpzxP6voYYFcsv4zjZAmU2eY0S35MmlOg=;
 b=aYM71KauUtGV+cq4slywpWOjmT12Jg2ZvDasGuKj1OpyMdrAjjI3LD6qKZgqM1SumtD0uf+WoS93AYoyOpCqbydAYxwRT74wjdYuWFVsjM1b1jxv+M3vf1W6q+lUwjOjJrcLjOQn7oVGokieoPwRAI/329rf+0E4vgXCAhXMUVdV6uXWJ9NCP935opS1tCgk3gV2AipAvuw11g2X373ACqN4a7LcatTJu0j3jHOhAoWG06+jsS37yV8py8AhSm9NZaJGHem11GzaaV4vqnr/hhSctirh8EBpug7byMW/I81VT4196bbXljm6onYzXbkzXkgicnlTPpviorQ+0tmo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHHEKQXkw5FpzxP6voYYFcsv4zjZAmU2eY0S35MmlOg=;
 b=VynItc/XQIIQ+/pdYetj3O54/zi+0Nz0Q/ZPTOeJ+v6ikCiic7dzvDip+wI0BHvj+9lG7O+YPiH9cH/IJyvV7sQpBAYZcUhj7MZ+dwb0jhHA/r09WDaTV+s1YOfWGGrYOlAZIoCHrAraCPrJ2zqa85ajMs+rhkAJzz4fnd3Weps=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3699.namprd12.prod.outlook.com (2603:10b6:a03:195::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 19:50:43 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::19e1:33b2:5f25:5c5e]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::19e1:33b2:5f25:5c5e%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 19:50:43 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul@pgazz.com" <paul@pgazz.com>,
        "jeho@cs.utexas.edu" <jeho@cs.utexas.edu>
Subject: Re: [PATCH] arc: plat-hsdk: fix kconfig dependency warning when
 !RESET_CONTROLLER
Thread-Topic: [PATCH] arc: plat-hsdk: fix kconfig dependency warning when
 !RESET_CONTROLLER
Thread-Index: AQHWioz6KLpe6Ti1AEuQK+kdobnWxKloi40A
Date:   Mon, 14 Sep 2020 19:50:43 +0000
Message-ID: <9ba22ab1-560e-3c1b-dfdc-77ebc609d41b@synopsys.com>
References: <20200914114651.105219-1-fazilyildiran@gmail.com>
In-Reply-To: <20200914114651.105219-1-fazilyildiran@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [2601:641:c100:b9:9593:5cb1:ebc3:8ee9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0906184-8f63-48b6-44d5-08d858e77774
x-ms-traffictypediagnostic: BY5PR12MB3699:
x-microsoft-antispam-prvs: <BY5PR12MB3699091878377E2A6773E15CB6230@BY5PR12MB3699.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FJ/L52yMscMGoxinEYOU36QCN3QzTl5Geqc/4tIVXRRGBUD1t1Wy1DzyQBjGHarYeAw8U7O7BlUS7aKw+SEFChCpVryyjQ9ZkOeppuUKiRJekfteRrLljOjjpwPPaybKODhrNnNsrdcqhdWZLZNuILNI+lvvdgW38jWgZvPZTvvrNRVu3yTajYV4/pGPRelhl+Re52V04F6p/Vw//qq1iV8jxkeNNRkCT7KOEQCMQUlfhs85XR7+BzAsWVpbLKETKbAFHf4Y1kqrocVZhGaW/1UxO+2XBQC/+bwvYYZu8WKsvKhYc84dw1JWNVaBEKY7iyqPdLwIeOytrzMhBjM3rx5PHGJ+eWIjLgz07c1/0viXtWj7mGUITK6KiHW00vl2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(2616005)(478600001)(6486002)(86362001)(53546011)(71200400001)(36756003)(6916009)(316002)(6512007)(4326008)(83380400001)(31696002)(54906003)(8676002)(186003)(6506007)(2906002)(76116006)(31686004)(66446008)(64756008)(66556008)(5660300002)(66476007)(66946007)(8936002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vlJ3kdJjrDXWQtAkjJnMvq9Nzz+I+EBrdEbZLa/FfmVYQmzsx1rAwGwh9mdyvAi0dL5Wnb+tqHVvuxfpE/XliUzKJIlacNtLa5bCKsXEWgOIouISr6Sx+s+2aG5KyL5zgqApeKtVeXAuNyuAy97p2CJzZHEivXYeyQNy81wmtRQN6lV1nNJTzlSQ5F6RfLeg6+GWK52kaHoPgP/d8MtHeBAqy17LP6y3SZGTzbFokC2opYxxHOgVl+v6bJPnAPDR/Vu0qeD4Z8I3D1up+efgrZNcNat00BGlJlfOqa4Si6Ss9O5nwYTSugDenWEdKV9Mr+sxVQOKJF0Gnw7t1jFkMF8I2mWsql+TzixGXAs25YoBOYV2GJrm9Gf2cGVgeT+3/jQOKhL2F4zyd6q90c6Y0o6W+SEUk45gUSZUOJZ8ds2Mn7/FuAzyOWxu+3cRLHe8IhM3MBn7CmpMJquWZngI3QgM+aox0IWkoHG38S60IwnuqhXEYNaa2QlJgWG0tFQtbOkY6PCD0sSXrn1gxpLARPt/arfYW4+BE0RLNQSyde1jEJnqUDlANh3D5ywpo4JBHo/BJp1ICnsFwtxFdDjbrYkqjBvUYwE7GXghehFQdLoVmw3X105nhmLC6TNWzRGW8N9TsfV0DMszwOFqpIRccb0qQNSCpXeQN8+vVxzN/6J/HWGvnVDHgkkZEjZp3gBdYdsB2L6oC0VLN/uONbpXig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <01FB78103ED1DC42B5BCACA7BAFB6EE2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0906184-8f63-48b6-44d5-08d858e77774
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 19:50:43.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtupoLWcKyABhM3E935U7RjiS9B2MNsqlenGvYQRD12U88ngWnDHSidsCFMDiTKo26vQbfDd4RllDRsZ42SeCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3699
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNC8yMCA0OjQ2IEFNLCBOZWNpcCBGYXppbCBZaWxkaXJhbiB3cm90ZToNCj4gV2hlbiBB
UkNfU09DX0hTREsgaXMgZW5hYmxlZCBhbmQgUkVTRVRfQ09OVFJPTExFUiBpcyBkaXNhYmxlZCwg
aXQgcmVzdWx0cw0KPiBpbiB0aGUgZm9sbG93aW5nIEtidWlsZCB3YXJuaW5nOg0KPg0KPiBXQVJO
SU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRldGVjdGVkIGZvciBSRVNFVF9IU0RLDQo+
ICAgRGVwZW5kcyBvbiBbbl06IFJFU0VUX0NPTlRST0xMRVIgWz1uXSAmJiBIQVNfSU9NRU0gWz15
XSAmJiAoQVJDX1NPQ19IU0RLIFs9eV0gfHwgQ09NUElMRV9URVNUIFs9bl0pDQo+ICAgU2VsZWN0
ZWQgYnkgW3ldOg0KPiAgIC0gQVJDX1NPQ19IU0RLIFs9eV0gJiYgSVNBX0FSQ1YyIFs9eV0NCj4N
Cj4gVGhlIHJlYXNvbiBpcyB0aGF0IEFSQ19TT0NfSFNESyBzZWxlY3RzIFJFU0VUX0hTREsgd2l0
aG91dCBkZXBlbmRpbmcgb24gb3INCj4gc2VsZWN0aW5nIFJFU0VUX0NPTlRST0xMRVIgd2hpbGUg
UkVTRVRfSFNESyBpcyBzdWJvcmRpbmF0ZSB0bw0KPiBSRVNFVF9DT05UUk9MTEVSLg0KPg0KPiBI
b25vciB0aGUga2NvbmZpZyBtZW51IGhpZXJhcmNoeSB0byByZW1vdmUga2NvbmZpZyBkZXBlbmRl
bmN5IHdhcm5pbmdzLg0KPg0KPiBGaXhlczogYTUyODYyOWRmZDNiICgiQVJDOiBbcGxhdC1oc2Rr
XSBzZWxlY3QgQ09ORklHX1JFU0VUX0hTREsgZnJvbSBLY29uZmlnIikNCj4gU2lnbmVkLW9mZi1i
eTogTmVjaXAgRmF6aWwgWWlsZGlyYW4gPGZhemlseWlsZGlyYW5AZ21haWwuY29tPg0KDQoNCkFw
cGxpZWQgdG8gZm9yLWN1cnINCg0KVGh4LA0KLVZpbmVldA0KDQo+IC0tLQ0KPiAgYXJjaC9hcmMv
cGxhdC1oc2RrL0tjb25maWcgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvcGxhdC1oc2RrL0tjb25maWcgYi9hcmNoL2Fy
Yy9wbGF0LWhzZGsvS2NvbmZpZw0KPiBpbmRleCBjZTgxMDE4MzQ1MTguLjZiNWM1NDU3NmY1NCAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcmMvcGxhdC1oc2RrL0tjb25maWcNCj4gKysrIGIvYXJjaC9h
cmMvcGxhdC1oc2RrL0tjb25maWcNCj4gQEAgLTgsNSArOCw2IEBAIG1lbnVjb25maWcgQVJDX1NP
Q19IU0RLDQo+ICAJc2VsZWN0IEFSQ19IQVNfQUNDTF9SRUdTDQo+ICAJc2VsZWN0IEFSQ19JUlFf
Tk9fQVVUT1NBVkUNCj4gIAlzZWxlY3QgQ0xLX0hTREsNCj4gKwlzZWxlY3QgUkVTRVRfQ09OVFJP
TExFUg0KPiAgCXNlbGVjdCBSRVNFVF9IU0RLDQo+ICAJc2VsZWN0IEhBVkVfUENJDQoNCg==

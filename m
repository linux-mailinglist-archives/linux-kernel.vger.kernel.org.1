Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46832A8A89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgKEXQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:16:49 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50964 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731965AbgKEXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:16:49 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4FB2FC0004;
        Thu,  5 Nov 2020 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604618208; bh=mxsNSlk2iHdnOgBAlPr8nNWO+ug/+gKmSLD7uzw/jbw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=H7U08ZdSrvWbZZ29ANVHuQFG/fDdbZzAFKg+D9YWbktHXmfR4Y6+LhpIuXDaMvFBv
         mRR+KFiaePMRq06IurEk649VW3sW43N/16ejBZs3Ff7Qw+NHFH24TQ29fA1JBEqn2j
         S5/ga6UcXjIWswAhctD/xXnzG8MldwZsUGmugGhJ6g/y/eAPvjx+xpkY7pYZCBEu0k
         05q43I9liYqrGPC9pl5PcbYTXBrPjU4jOzIvkzfQSfFoJ4G4L4RZscwNQKUDZ2/f5N
         RVdGkeESto91NvfMwj6v5ercbhMpcYSxtGAOAFVuyZR4CzUKjngfHbu60q0X+2N4W8
         jQ9UWFOXnOaAQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B430BA0063;
        Thu,  5 Nov 2020 23:16:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CD094400CB;
        Thu,  5 Nov 2020 23:16:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wibj9UVq";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCfASv3Oqb/EsJnvlZ0DxgXUnJEroqmDcPtIfud3zHXWjfH0B3M9y5s+n/ny+Zk2YMDbUlq2LW8h90tzSBQLhzHW0tvOZ4YGDGG1IwO/lY7lb4jO6A+c73+r1i0NQR3TpvmKCXvXgzey/7RZ6PgAUqKQgflUgiZnueNukpj5Z5Cq+6LKArw2N9HF4+p9/Fd9sMmmNw1tjInCn0IFu1FRuyKkCmeGrFNzyTk7S/YimdVRI39crtDh/ReAIrrleUqNoGDL1nVUDVSBHFoNogYhtYuFNfPmUGbhBfilREzxQ8DcJQnHlp+TjXa95MOLEuMEp3JY3GkaBQvwBDp7p9sdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxsNSlk2iHdnOgBAlPr8nNWO+ug/+gKmSLD7uzw/jbw=;
 b=EN5rjkEpcY2ctYemrdEcsioVGAqWHYgn4rdJmP0VgiGhskuTGIGlrMHciIxB0Ggf+rOe98ir0TDiNABjaht7fYLS+/TAf6/tcCRXlBbDSPRcIepUGAS+NW3m1kppNUnQAAAOMFd3eMQ6zao6OGwWxJKrjEzjUT09sj1WXCEfOE59fEy86d+vDhIm9cnLXddHu8xDA6Yh4DXawFSm4696NYXXIqj23unQa4nK0WI/csOThiP3owc8Nn7Ue3pEl82leeW5c2G/6ftHRLP7vMhTfkeCPFO9abbARCwj9EUvemRR1kR5fGUlS0OLaR1EOUZ3NuMlE2xa0LbO/UFHTFNQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxsNSlk2iHdnOgBAlPr8nNWO+ug/+gKmSLD7uzw/jbw=;
 b=wibj9UVqYoc0kU/jV/VMGby0cN5sh6y3NS/r8FxBUJroCFN+ivjQXpOyY4k3xXzGMDdZ7azeXvMKLswPXrZT8s9q9YaxsRHo45cVqB03sxOF8Y0bklc1NVO8vJ64G64YsJX6Ed/LhlZAuB5gpmUfSKjCVGIOZHoN1FOxmugKEuw=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3748.namprd12.prod.outlook.com (2603:10b6:a03:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Thu, 5 Nov
 2020 23:16:42 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3541.021; Thu, 5 Nov 2020
 23:16:42 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
CC:     Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: bitops: Remove unecessary operation and value
Thread-Topic: [PATCH] ARC: bitops: Remove unecessary operation and value
Thread-Index: AQHWp+7k4lh/dGb60EipqqFMJundjqm6Q4wA
Date:   Thu, 5 Nov 2020 23:16:42 +0000
Message-ID: <d1851511-51aa-de74-cdfd-d1bfc510b5a3@synopsys.com>
References: <21124fbdd2ebfe150cc750f673a31e89d6fe5752.1603314740.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <21124fbdd2ebfe150cc750f673a31e89d6fe5752.1603314740.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6554af5d-51f1-41d2-fdf5-08d881e0db5e
x-ms-traffictypediagnostic: BY5PR12MB3748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB37486F63DC6810BB5657D995B6EE0@BY5PR12MB3748.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZBmwEPWpz9tk09L4h5dUAxyVegGQug7ay46Kv0Dm/D2f6p2KjWLQ2ZU66/6cOSNF6xM3RuhPCiYNNPWesDt2eWShWzWhGRRaFXCwSbpvCNID1be2kDm5m4GGuBHxyM1WiD2/k9x0alevqFJf4lpBx2XgXlgskobSEz44w6uq9YgsnuS8juiZP7IiXpRdTLq8RZvxobDqIqoGiRBjEGxdcwNoLLl+8uVjFJWixDYWJwZxMmux0euqUf0VZMMnoz/jh17geQnUF4vI0tQds71ENpmQ/keZty86HWIoKWegUClLubymHBj7RiaVb0uUqKGOSx9/gO4HhW+EZ5/y+d/HL7Fu0gBVsOrHbx6m2HSNLouJNGkwGmeJ7Ngl0Sd5kde
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(31686004)(37006003)(26005)(6862004)(36756003)(54906003)(316002)(4326008)(6512007)(478600001)(6486002)(53546011)(31696002)(2616005)(86362001)(6506007)(71200400001)(2906002)(6636002)(8676002)(66946007)(5660300002)(8936002)(4744005)(83380400001)(186003)(76116006)(66446008)(66476007)(64756008)(66556008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: F9swpaDOvoK+yo1nCfwiG/FnXJ89KXUCFqk2ATFsHVnsWVICA+sDohM+1WBjXj/5AbeXzZ55On7SYrWWzfHE/jiwpi3W6KlZFIDpBr9W7V6APaRGf1aJcobmcZ85q1j50hudLwvDBEPmCQbcoaQino8GIefoLXZl+hs+D4J4C0fiJoTAb7H1/kcvA4BeyFflkzIUMRZ3WpG4r5sdbJMpMKDorNkruQZMR6fr2JpnkdavWArDgaSo8jUupoi6QO8R7NWC6aCMCxgeX8ZV4bzV+nh3vQTFdpQt34h0/n6g/XcLfoO2b2jnqtHIMtKnY3rx7thUEc33AP+1YTHfSAHK25hETirrvi48h1llcF2VCaqo9NGnsys1z3Maz7XsauSgbqAXyUxj0o2L9soQYR0DA3dZLA7re9sEUOdtlZsYITL2nHC5caM/jfL4jf/n7l/KiSj7rm4zPDuJASX++SWQcedzOLCd3CH+js1VWEo4gnXLDnfK0Mw0SxpDUDpGJNuiXqJB+3UN9sGumrQAYOPWT1yX6tAEWP/PYqNk/Eu8F+Qo1oeXmNSpaDyltXwvQa+d2zXv2AzA54rnczvMMNw1TT98+cRIKzJGGpmoaUrGdSU5+KlD+naKIQZKn+bYNShvTL6he/oja5mq1umQFar8TA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B29CF89278C14280529EC920333014@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6554af5d-51f1-41d2-fdf5-08d881e0db5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 23:16:42.4988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxVvxc0p0bEwI4jkGL+dTSI7ZyhxC0Pg2bJaLUJIJA5l6ydZeIj2co9bcR9FvjAv2DI7M+v0fJm+cFMsJsSi4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3748
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjEvMjAgMjoxMiBQTSwgR3VzdGF2byBQaW1lbnRlbCB3cm90ZToNCj4gVGhlIDEtYml0
IHNoaWZ0IHJvdGF0aW9uIHRvIHRoZSBsZWZ0IG9uIHggdmFyaWFibGUgbG9jYXRlZCBvbg0KPiA0
ICAgbGFzdCBpZiBzdGF0ZW1lbnQgY2FuIGJlIHJlbW92ZWQgYmVjYXVzZSB0aGUgY29tcHV0ZWQg
dmFsdWUgaXMgd2lsbA0KPiBub3QgYmUgdXNlZCBhZnJvbnQuDQoNCkFsbCBvZiBjb25zdGFudF9m
bHMoKSBpcyBhbnlob3cgb3B0aW1pemVkIGF3YXkgYXQgY29tcGlsZSB0aW1lLCBzbyB0aGlzIA0K
d29uJ3QgYWZmZWN0IGFueSBjb2RlLWdlbiBhdCBhbGwsIHN0aWxsIHRoaXMgcGF0Y2ggaXMgbGVn
aXQuDQoNCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRl
bEBzeW5vcHN5cy5jb20+DQoNCkFkZGVkIHRvIGZvci1jdXJyICENCg0KVGh4LA0KLVZpbmVldA0K
DQo+IC0tLQ0KPiAgIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2JpdG9wcy5oIHwgNCArLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vYml0b3BzLmggYi9hcmNoL2FyYy9pbmNsdWRl
L2FzbS9iaXRvcHMuaA0KPiBpbmRleCA1MGViM2Y2Li44Y2RkZGRjIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FyYy9pbmNsdWRlL2FzbS9iaXRvcHMuaA0KPiArKysgYi9hcmNoL2FyYy9pbmNsdWRlL2Fz
bS9iaXRvcHMuaA0KPiBAQCAtMjk3LDEwICsyOTcsOCBAQCBzdGF0aWMgaW5saW5lIGludCBjb25z
dGFudF9mbHModW5zaWduZWQgaW50IHgpDQo+ICAgCQl4IDw8PSAyOw0KPiAgIAkJciAtPSAyOw0K
PiAgIAl9DQo+IC0JaWYgKCEoeCAmIDB4ODAwMDAwMDB1KSkgew0KPiAtCQl4IDw8PSAxOw0KPiAr
CWlmICghKHggJiAweDgwMDAwMDAwdSkpDQo+ICAgCQlyIC09IDE7DQo+IC0JfQ0KPiAgIAlyZXR1
cm4gcjsNCj4gICB9DQo+ICAgDQoNCg==

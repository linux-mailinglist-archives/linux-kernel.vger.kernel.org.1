Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD13728F130
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgJOL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:26:42 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:2408 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgJOLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:25:49 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 07:25:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5676; q=dns/txt; s=iport;
  t=1602761147; x=1603970747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=AAOEQsWavkHKr1RoFuHXjW36bub0Ok04SKvD9COc2jM=;
  b=bG9ihIdychPYbbo6uRlOfu4XBHroXwJUY7zOwIJtVNiNu06rzzUWzPmZ
   yKuKekykS5XDgBpKwW+ShjErjwIEh67ZRViuP0r9FSAkxr0NxogQMqaRZ
   dp4GNL6IPDlopQtmywob0NVvDKuY2j+45tohECH/MUib1Sw/SWfQcK5R3
   E=;
X-Files: pEpkey.asc : 1813
IronPort-PHdr: =?us-ascii?q?9a23=3ACbmKlhGujWCHBzxqKspu8J1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401wGbWYTd9uJKjPfQv6n8WGsGp5GbvyNKfJ9NUk?=
 =?us-ascii?q?oDjsMb10wlDdWeAEL2ZPjtc2QhHctEWVMkmhPzMUVcFMvkIVGHpHq04G0WGx?=
 =?us-ascii?q?PiJQRyO+L5E5LTiMLx0Pq9qNXfZgxSj2+7ZrV/ZBy9sQTWsJwQho1vT8R5yh?=
 =?us-ascii?q?bArnZSPepMwmY9LlOIlBG67cC1r5M=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CaBgAbL4hf/40NJK1gHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQGCD4FSUQeBSS8sCoQzg0YDjSIIJph7glMDVQQHAQEBCgMBAS0?=
 =?us-ascii?q?CBAEBhEoCF4FxAiU4EwIDAQELAQEFAQEBAgEGBG2FXAyFcgEBAQQSER0BATc?=
 =?us-ascii?q?BDwIBCBUDKgICAjAlAgQNAQUCAQEKFIMEAYJLAy4BA6B3AoE5iGF2gTKDAQE?=
 =?us-ascii?q?BBYUWGIIJBwmBOIFTgR+DboZWG4FBP4E4DIJdPoRUgwCCYJNQhw+BTJtRCoJ?=
 =?us-ascii?q?qhE2CX5M2BQcDH4MWigiULC2zLAIEAgQFAg4BAQWBayM3gSBwFYMkUBcCDY4?=
 =?us-ascii?q?fN4M6ilZ0AjYCBgoBAQMJfIw7AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.77,378,1596499200"; 
   d="asc'?scan'208";a="563371490"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Oct 2020 11:18:41 +0000
Received: from XCH-RCD-002.cisco.com (xch-rcd-002.cisco.com [173.37.102.12])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 09FBIfaa020603
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 15 Oct 2020 11:18:41 GMT
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by XCH-RCD-002.cisco.com
 (173.37.102.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Oct
 2020 06:18:41 -0500
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by xhs-rcd-002.cisco.com
 (173.37.227.247) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Oct
 2020 06:18:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-002.cisco.com (173.37.227.247) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 15 Oct 2020 06:18:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odRaktBqyM2H/szO2DGs/2v0CVNPE9tyoQD5BMiqf+lzsASuNBHxTlM9zcAPGzr4UN7jdrmUxpuIwokeNqh7WIlN1kuqr+O7RlTK5xEmwQg+Rwca+Zyp5esXc6w2/H8TeIq038L3VxIEocBnVEDU7Pkv5eqElxUWGwnzV6BuYi2LxcY5Uou8prz+m8zTNobR0qr0yA588MXhFdOVqKO2XZMC7GeVgMSAFL66mFOED/bW+dVflEso6ESFPtLBUWnhJK45Qd2/lCTBTUDtCIYiRBL+4y9XRX1lZ+OfXR77kRAkyjeDxHx5SSXdBE8E+ckN44oBYfnKfCfUsX6xgggE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC69coRhzQoI6Rm73iUNmPxQHkjeIyPtX4pVXbzYdR4=;
 b=S02HsdjGyesblxzdHc4zD0xzbBZ1pqqCo9eOJygxRLzoRJld6UVTJTioZ2ZWuvFB/f52AUFAX+QyPt79Z/UKKClwbOZn0BProJMoDrCgk/WrtL+dOks+4awUKeG05vq2X1fbGxQb5PdhYSc/M0KdvFQMRSdg3UclNSTwApUIvQdhe5Owl+xGwD/+Y24qfZ3+3avWY76XSV3F/Tz8S4wV6mwtiQns6Kb5RcgMTS/8UGwgy+vCJMr05fL1u38gjqU7JukylVd9PhVP7sj4y4fOiYI0ZQqp55BrCGK6qSTZJs1rkODJSAFztSMfllaIA3NpqmMrOJW/u1BffJbypBOtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC69coRhzQoI6Rm73iUNmPxQHkjeIyPtX4pVXbzYdR4=;
 b=0nVq8UNIkGbWQu8jiREl3iN8zDYkVY9ohhuyqg18aVhI8gy3WtpOnefnWHacsTm90ImduOZMAaZpR0JvWzvPhfPAA0FcFkd+jMLHdznzGqnhzY+ZCzE8b0X/0z2mzkJsMvGTW723nLsciPf5IJ3kuXgUhqAYm60y8d1T7mQLxD8=
Received: from DM6PR11MB3866.namprd11.prod.outlook.com (2603:10b6:5:199::33)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 15 Oct
 2020 11:18:40 +0000
Received: from DM6PR11MB3866.namprd11.prod.outlook.com
 ([fe80::c943:b491:e40e:4f02]) by DM6PR11MB3866.namprd11.prod.outlook.com
 ([fe80::c943:b491:e40e:4f02%7]) with mapi id 15.20.3455.032; Thu, 15 Oct 2020
 11:18:40 +0000
From:   "Hans-Christian Egtvedt (hegtvedt)" <hegtvedt@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption
 handling in hci_encrypt_cfm
Thread-Topic: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption
 handling in hci_encrypt_cfm
Thread-Index: AQHWotmplfjLfEEHCEydFw1RNBP3KKmYhCmA
Date:   Thu, 15 Oct 2020 11:18:39 +0000
Message-ID: <0804be81-ebbf-8132-a619-c0c740a71f51@cisco.com>
References: <20201015074333.445510-1-hegtvedt@cisco.com>
 <20201015095750.GA3935178@kroah.com>
In-Reply-To: <20201015095750.GA3935178@kroah.com>
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
x-ms-office365-filtering-correlation-id: cf414203-0ea5-49c6-c8dd-08d870fc119d
x-ms-traffictypediagnostic: DM6PR11MB4530:
x-microsoft-antispam-prvs: <DM6PR11MB4530567EB8B63E996C753480DD020@DM6PR11MB4530.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9vw1ChOx+l/h7kivdQ97Nkvh6lPuou0UIRFGv+cwaqtdfPXNpGR2Q2y9HebjaexWso9K8j2bU/yLhpw2OPXJgl9k4E+7kk+6g+LI6yvLxhNja9q+W2AV+SjZo4WI+F5JOjiiS9a0QurEvim6W+sGqXeA3lc6wP8waJ/ahty4koy5RHmsDYMykpaU3aqVKoPhWLefqWLvkxHegQ54Mkqj9Vl0LRUueQYp9psVUw1r7PtVO8ECpS7ljYnwDyCZRU8ZLxjEKuHMY8FhRnWjSYed+72BJtDCvO7wKOPdyiKW0eAxnkX+Eqoq4MZbe5KAxxzZIZ8GUmdVPMWy0cJB1/HytaBdMR7IjjkntebC0go+X+OXYQPiv6vYKWRluGae+4V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39860400002)(6916009)(66556008)(8676002)(66476007)(66616009)(2616005)(64756008)(66446008)(99936003)(31696002)(66946007)(76116006)(91956017)(54906003)(86362001)(478600001)(2906002)(5660300002)(8936002)(31686004)(316002)(36756003)(6486002)(186003)(26005)(71200400001)(53546011)(6506007)(83380400001)(6512007)(4326008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lZJqm1L7YA2OUQKOnx4kWbkrD8hZot9QvfM15yyP+kkx15QBQHDItBu0dnFXLC0JVS+/s0IwvnizqFnHAMo9R/q0QK0usSIdefgeKfHaAMlJNVobfsLBae8xtRXZx3gv9PkDYa8x6zZ9ogJvLvkP2pf42LFO4mNPM9zqHCdDwvDTre9UPO16IH3WhPBHe4b8Q7dtspjhKioSYrtvCoEWa1EDM6YtLD/rVt5JzWvXOMmPlKEcZT9vlCngglQyiU9JTPQ2gDJkfY8eTiCKJeM/8so89Xir+2DhrYT6uecHxU3NPuL/8O1bpvFh1hiZJX9pI32Wmr1FfkG96WKRsPWmqTQ7Vcu+Ld2X/RbRO8pKFMSWWK3A4mhVVduX6Rxj3LK0WyPHsu9JxrpmBzB04tKNqwJP25NBRMR132YqFMDoXWlFVQmFDKgQeHHZfPUoAY8hpgWIED3uVQA8eEmSql1JPzcz0TvJkg4DUyxLLX3cyGDb6ndRQVceFV1r7fpWNF8voypccf88Y7FEfFoXyCshuzFwPrf+qQBfPWQzAB5SWVO5jU518f5XKGT4mKwyZVxgnkOQsFnhgCP0ShldzM/GCjQ+JEkTlQNgnLCoVmkDZ2TXr/ZuTpJtpj5qYuic669mPdLRmQHAu+QDtPeNHQLE3g==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_0804be81ebbf8132a619c0c740a71f51ciscocom_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf414203-0ea5-49c6-c8dd-08d870fc119d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 11:18:40.1048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yd6pB43EUtmXc/A64Y2TErX1TLaPrXxEVgF7JENIcKUKdhik4J/FFA4RQePVithRU44qPuXcaXtX7J46s5SlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.12, xch-rcd-002.cisco.com
X-Outbound-Node: alln-core-8.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_0804be81ebbf8132a619c0c740a71f51ciscocom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E3E8F26A831454BB85D081EC00CE046@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gMTUvMTAvMjAyMCAxMTo1NywgR3JlZyBLSCB3cm90ZToNCj4gT24gVGh1LCBPY3QgMTUsIDIw
MjAgYXQgMDk6NDM6MzJBTSArMDIwMCwgSGFucy1DaHJpc3RpYW4gTm9yZW4gRWd0dmVkdCB3cm90
ZToNCj4+IEZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGludGVs
LmNvbT4NCj4+DQo+PiBUaGlzIG1ha2VzIGhjaV9lbmNyeXB0X2NmbSBjYWxscyBoY2lfY29ubmVj
dF9jZm0gaW4gY2FzZSB0aGUgY29ubmVjdGlvbg0KPj4gc3RhdGUgaXMgQlRfQ09ORklHIHNvIGNh
bGxlcnMgZG9uJ3QgaGF2ZSB0byBjaGVjayB0aGUgc3RhdGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KPj4g
KGNoZXJyeSBwaWNrZWQgZnJvbSBjb21taXQgM2NhNDRjMTZiMGRjYzc2NGI2NDFlZTRhYzIyNjkw
OWY1YzQyMWFhMykNCj4gDQo+IFRoaXMgaXMgb25seSBpbiA1LjgsIHdoYXQgYWJvdXQgYWxsIHRo
ZSBvdGhlciBzdGFibGUga2VybmVscz8NCj4gDQo+PiAoY2hlcnJ5IHBpY2tlZCBmcm9tIGNvbW1p
dCAwYTYwOTk2YzdmYTcwMTBlYTAwZDliNjJmYjY5OTZkOTA4YTAxZWFkKQ0KPiANCj4gV2hlcmUg
aXMgdGhpcyBjb21taXQgZnJvbT8gIEkgZG9uJ3Qgc2VlIGl0IGluIExpbnVzJ3MgdHJlZS4NCg0K
T3BzLCBteSBiYWQsIEkgaGF2ZSBhIExpbnV4IDQuOSBicmFuY2gsIHdoaWNoIGFsc28gaW5jbHVk
ZXMgdGhlIEFuZHJvaWQNCjQuOSBrZXJuZWwgY2hhbmdlcyBmcm9tIEdvb2dsZS4gQW5kIHNpbmNl
IEkgbm90aWNlZCB0aGUgcGF0Y2hlcyBpbiBteQ0KKG1lcmdlZCBmcm9tIEFuZHJvaWQgbGF0ZXN0
KSBsaW51eC00LjkueSBicmFuY2gsIEkgdGhvdWdodCB0aGUgcGF0Y2hlcw0Kd2VyZSBhcHBsaWVk
IHRocm91Z2ggYWxsIHN0YWJsZSByZWxlYXNlcyA0LjkgYW5kIHVwLg0KDQo+PiAtLS0NCj4+IEFG
QUlDVCwgZml4aW5nIENWRSAyMDIwLTEwMTM1IEJsdWV0b290aCBpbXBlcnNvbmF0aW9uIGF0dGFj
a3MgaGF2ZSBiZWVuDQo+PiBsZWZ0IG91dCBmb3IgdGhlIDQuNCBzdGFibGUga2VybmVsLiBJIGNo
ZXJyeSBwaWNrZWQgd2hhdCBJIGFzc3VtZSBhcmUNCj4+IHRoZSBhcHByb3ByaWF0ZSB0d28gcGF0
Y2hlcyBtaXNzaW5nIGZyb20gdGhlIDQuOSBzdGFibGUga2VybmVsLiBQbGVhc2UNCj4+IGFkZCB0
aGVtIHRvIHVwY29taW5nIDQuNCBzdGFibGUgcmVsZWFzZXMuDQo+IA0KPiBXaHkgYXJlIHlvdSBt
ZXJnaW5nIDIgY29tbWl0cyB0b2dldGhlcj8gIFBsZWFzZSBwcm92aWRlIGJhY2twb3J0cyBmb3IN
Cj4gYWxsIHN0YWJsZSBrZXJuZWxzLCBpZiB5b3Ugd2FudCB0byBzZWUgdGhpcyBpbiB0aGUgNC40
LnkgdHJlZS4gIFdlIGNhbg0KPiBub3QgaGF2ZSBzb21lb25lIG1vdmUgZnJvbSBhbiBvbGRlciB0
cmVlIHRvIGEgbmV3ZXIgb25lIGFuZCBoYXZlIGENCj4gcmVncmVzc2lvbi4NCg0KQWdyZWVkLCBJ
IGhhdmUgbWFuYWdlZCB0byB0cmljayBteXNlbGYgaW50byB0aGlua2luZyB0aGUgNC40LnkgYnJh
bmNoDQp3YXMgbGVmdCBvdXQsIGJ1dCBJIGFzc3VtZSB0aGVzZSBwYXRjaGVzIGFyZSByZXF1aXJl
ZCBmb3IgYWxsIExUUyBicmFuY2hlcy4NCg0KVGhhdCBpcyBhIGJpZ2dlciBqb2IgQUZBSUssIHRo
ZSBuZXdlciBicmFuY2hlcyBtaWdodCBuZWVkIGFkZGl0aW9uYWwNCnBhdGNoZXMuIFBlcmhhcHMg
THVpeiBjYW4gYXNzaXN0Pw0KDQotLSANCkJlc3QgcmVnYXJkcywgSGFucy1DaHJpc3RpYW4gTm9y
ZW4gRWd0dmVkdA0K

--_002_0804be81ebbf8132a619c0c740a71f51ciscocom_
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Description: pEpkey.asc
Content-Disposition: attachment; filename="pEpkey.asc"; size=1813;
	creation-date="Thu, 15 Oct 2020 11:18:39 GMT";
	modification-date="Thu, 15 Oct 2020 11:18:39 GMT"
Content-ID: <B3D58AD9151CBC40A3772624AF1F6D95@namprd11.prod.outlook.com>
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

--_002_0804be81ebbf8132a619c0c740a71f51ciscocom_--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7ED2C7E14
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgK3GRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:17:17 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56032 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgK3GRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:17:16 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B32FCC0119;
        Mon, 30 Nov 2020 06:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1606716975; bh=a9e+XExR4neOd+D4KoRKJev1DhkT3kIGSHIap217VRM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QC1SZY5anQd4xzCbFQ3PNpAIjdd1wS8YqC3e61FN0rrKY5m5ZJuzonJkN2cKAc/T9
         j03wUGKhNilDndzpKAmTr1TThCoeNH8tNegnavtQaFwNovlEZCOrEQKcPb45jguSQu
         6TNVUrLHaYep/2CjGuuqryPd8ZE3MYCPHCv9XSJmjRzbo6kJjPLMwag9AGugUu6f5k
         iWehDE7oesbVWMK7nAh6KX5mzVipDnKPK/Fn3Gzc0x5o/xXWa1QtGQdi6KSKq6CEyS
         M/sUZ+gwU5jpdOOeulTrNFOG8LeaHO/TQZ7woZfrDcq55J1cNztEws3ugN+g5SoHhf
         BXeYaKgBGceUQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D0DC1A006F;
        Mon, 30 Nov 2020 06:16:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 44DAD80214;
        Mon, 30 Nov 2020 06:16:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="D/vdQuUr";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVY/hLh6ezwe8BrVyE2zfclSlaHgCFvfXhvJOPFss/IhMOMt/kCVOhqbYX+JLCnCNx6K+TSK7pYqN7JVj/eW36AeGVXSSGBEubR7keGhKkxFezSzi7q8pBq8hAt/WOY4J7/rYR1Ed3Dhp9xdmt/Al3ZiYQJY9E1lbtkSY3E2WVx3o3fyRDr5ntJncwPljsqUSxk6A36Own4a3roFoB6u6PDWxPTfDTjZ2TaOZpQsdw6XRdBUAjP82/QcxZaUSbugqmgkTBkOABncT8fXvhOcU+47YxApvLMkMcFYqu6Mzc1dNbLsx8nRXgWWB70ZK/UiCGSuRCtk+siqnoPTmcdjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9e+XExR4neOd+D4KoRKJev1DhkT3kIGSHIap217VRM=;
 b=F0GwNb5tTVkXaljeflY347WeSTGgBfNyrSZ7OK2YKnsyQN/I+/hyFBQbK8ElAh6p0G30pIpYzfYj7/76QRw4I6DfJP35voImy2jqn06rHYB87GsyhtkkSCTpf2NMv7CQx0OHxds+gkDG7JLwj6Kz0vHJXh1x7ZTi/lR//WbMm3sGF4OqZPo1PIMTn21wU5C6hGHmLYzDCsoneW2wRzWdgXQ0NxC3e9JGhgpH7EjE8uBkhUBRmSBV0314f2LozsMR6v/2FIygRtJuyBb6nvDTufCkDHObctmFQiIp1LIRqyZFLDwpq7T+kS3fiF5x5ahV7ZY0MgnWknJpdjwh7CwlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9e+XExR4neOd+D4KoRKJev1DhkT3kIGSHIap217VRM=;
 b=D/vdQuUrLEjmxB0UUkcr+PSeX7s7bIAV2gkbfLliKDGBpy2xEffx9rEcNTcdKYuXAjA4RpPfI0wb8ZhkgqQdqTpQ29vi/xasETkr5qfpyA3EOIfOvfbYUwMz1lEWA2akO1WSzwKuiPVTjZ0FO0JtxvYat/dc9FrxzEElKQouJ4g=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 06:16:09 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::f90b:950d:63c:37c2]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::f90b:950d:63c:37c2%7]) with mapi id 15.20.3611.023; Mon, 30 Nov 2020
 06:16:09 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 1/3] usb: dwc2: set ahbcfg parameter for STM32MP15 OTG HS
 and FS
Thread-Topic: [PATCH 1/3] usb: dwc2: set ahbcfg parameter for STM32MP15 OTG HS
 and FS
Thread-Index: AQHWwXdaFMe2+oRc70i5cWxSkuJD26ngPaWA
Date:   Mon, 30 Nov 2020 06:16:09 +0000
Message-ID: <6c67ae2f-a172-e82a-1891-ec8e3c548491@synopsys.com>
References: <20201123090114.12641-1-amelie.delaunay@st.com>
 <20201123090114.12641-2-amelie.delaunay@st.com>
In-Reply-To: <20201123090114.12641-2-amelie.delaunay@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
authentication-results: st.com; dkim=none (message not signed)
 header.d=none;st.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.92.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b66025a4-f256-44b9-def5-08d894f76dd6
x-ms-traffictypediagnostic: BY5PR12MB4997:
x-microsoft-antispam-prvs: <BY5PR12MB4997F08D40D8903384780198A7F50@BY5PR12MB4997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /BGaP5Qr/AX2xbiH+tut1dcdkOD4U8JE6HjYXCrRV3IeiF6/agNP+nMNcIHCB/R3f9iMm88/AQsH6Qzyr1UHlgwAFQqGkYh3soXzbc4gEUTIZS5ltdGyBveAB6loYrmkbcLtCkdKt60BSCiUSQlGwkOdWMSv6NodQZ91ZEER9zihAw3dwVGVFsRzt04ymMxB95XX47VWxFlpLUDbHOWp1l2TxTZcIFppq7COMtOR7iZgWMHaCbEouKUBSusnVd6cYne9l1Ei1VzYMKUcikkGMOHF6Y3hHMfP84Q/yAISF9jf/OWSIL9nFjWW3kk+4kT99EPSADVVubXi+gZoSgC1gSd+5VAE/2GACWbZyBF9j/5YZgSPTjRVizodge95JCeNMujycP3yfEvulrWk0JOisvbdvNH5uN0XE80ubhNQvQ9Ze9QdQIUakj1va1nySg1PlCdOgIeV4PeOw1nOwVgQJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(346002)(366004)(376002)(966005)(54906003)(76116006)(91956017)(86362001)(5660300002)(4326008)(66476007)(83380400001)(110136005)(316002)(66946007)(66556008)(478600001)(64756008)(66446008)(8676002)(71200400001)(8936002)(31686004)(26005)(53546011)(6512007)(2616005)(36756003)(186003)(2906002)(6506007)(31696002)(6486002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cjFXTHNsVndmTGYwSTdZK1N6ZDczRnRZZXphNmxrYWt0RGdzMmkyYzd6WDFV?=
 =?utf-8?B?WU5vNzZlSXNLSXlTMEZaNGFCUFhjSlJoNTFHTmg1TkVXeEdPb0F2Qyt6YWNH?=
 =?utf-8?B?RXViR0tSU051aWJMbGc1bERvTlVDWnZUMFZMYURSZmhYYmdNbEh0VWFnblhB?=
 =?utf-8?B?aWttbS90UXZOQjErdXo1dVlJT01wMWVuM1lSSlJIbFB5L2hyREJka2tQUkZw?=
 =?utf-8?B?VS9YdFFiMkU1eStOZG1GNkxlY0NVUXFFdTl3SXFIOWVlZ3czSTRscTM0S2hU?=
 =?utf-8?B?bUNKbDZGQ1NsTjYwSnNsRThUTUZ5SjZUVU85ai9wSStjRDJwMlgxSmFmNkNL?=
 =?utf-8?B?eDVjclBaK2hHWVZ4ZjVTN3hIaGtrbGRHQUh5K0xHUFA0N3VicGtLL0JWL2M2?=
 =?utf-8?B?dWFza2VlV2k0eHR3cllQL2RqSHVEQ3laaHhkTUthVGpCbzl6RHJSMHh4YW5r?=
 =?utf-8?B?dTRJVXVVUFhXWkJSYTMvSUJOaXkzT00vaE9wWEhFYnF6dmJ0NnNSL1lHNHFj?=
 =?utf-8?B?K0NDSzhPais0dGQ4SlFUUi9ZVkhIU2hCRE51UWYzdmhRMHJpZFh3LzladlNC?=
 =?utf-8?B?V3oybmJKQnRYTzZ2bGpSTVViU3cwL3BGN3JFZ3pGTElESzhMWWJmUTBvellG?=
 =?utf-8?B?LytKQWZOaXFVRVU4U1hKVmd0U0xKOTNSL0tWc3pIcUxxcVl6MTFCV3hzZ3Nv?=
 =?utf-8?B?NE1FSE9hL3d6ODNXK08xRC8rWTNIOGduK0U5UVRHbS9LZ1g0cUxPUkxHa2Ev?=
 =?utf-8?B?RVRQeUlRM0Jldm9jbU10VW53ekxObnVaaGUzdFZSWHFpQitHczB4Y3RzRE1Z?=
 =?utf-8?B?MWFZVU9ncWFZVzRIR1owdTdxS3dQbFJUQldyYVpnWkxHZ1JHODdjY3RaNERt?=
 =?utf-8?B?MDMrbUwwY1hFdzIrMVh5a3BLNW1VeXN5cVcyNzBnbWZxTlA0RU9kdWwvY2Vw?=
 =?utf-8?B?a0h5NlBmaUlyMGcwVEdGMWRuZTdwdWFIeng3Q1I5dlFBbnVZQzIzOWthRVNk?=
 =?utf-8?B?alQ2b1VhMDhMVWxmYzJqdldWVWRYMEFYN29JNDBObDdtaVoxMGRhMnh6Um1I?=
 =?utf-8?B?NnhKdEJUUk01RDU3ZmNDQmNWV096SHExSm5ueEZmSUcyVzcxNXRYTzlkZi9S?=
 =?utf-8?B?ZlJka2ZGZGY4b05LQlpqSUNNQmJjYzFUcVUvTWYwSWZwNW4xVlFJZ3ZEYzFM?=
 =?utf-8?B?VGFMaGZRR2RySXpENzZ6cTZzd0dReEZya1hjTEMwYWlaUTI1K1pHZ2JWeW42?=
 =?utf-8?B?VDE3OCt5QWVTRzJXVU1yU1Fxalh5Tyt2dDdFd08rSFpmNjFES0ZhTDdDNWJh?=
 =?utf-8?Q?pmp9CU9BBOuko=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <298AFD7379C3CC4BB61D735F2E447F15@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66025a4-f256-44b9-def5-08d894f76dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 06:16:09.2597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AH2K2GkDz8lcD+q6qnz1M9KWt4MtAXmq+3leBRUwU8OQD+rFXB0sVIMXaHWYqY0cLh7YvtUX3PjplZAsGlZ60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjMvMjAyMCAxOjAxIFBNLCBBbWVsaWUgRGVsYXVuYXkgd3JvdGU6DQo+IFNUTTMyTVAx
NSBhaGJjZmcgcmVnaXN0ZXIgZGVmYXVsdCB2YWx1ZSBzZXRzIEJ1cnN0IGxlbmd0aC90eXBlIChI
QlNUTEVOKQ0KPiB0byBTaW5nbGUgKDMyLWJpdCBhY2Nlc3NlcyBvbiBBSEIpLCB3aGljaCBpcyBu
b3QgcmVjb21tZW5kZWQsIGFjY29yZGluZw0KPiB0byBTVE0zMk1QMTU3IFJlZmVyZW5jZSBtYW51
YWwgWzFdLg0KPiBUaGlzIHBhdGNoIHNldHMgQnVyc3QgbGVuZ3RoL3R5cGUgKEhCU1RMRU4pIHNv
IHRoYXQgYnVzIHRyYW5zYWN0aW9ucw0KPiB0YXJnZXQgMTZ4MzIgYml0IGFjY2Vzc2VzLiBUaGlz
IGltcHJvdmVzIE9URyBjb250cm9sbGVyIHBlcmZvcm1hbmNlLg0KPiANCj4gWzFdIGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5zdC5jb20vcmVzb3VyY2UvZW4vcmVmZXJl
bmNlX21hbnVhbC9kbTAwMzI3NjU5LnBkZl9fOyEhQTRGMlI5R19wZyFKMUhUczNrb2J2WWZTNDUz
aHRvSWRueGhlajRfb3M1WTV4d01mUnRmaHB0RV9RU2VWdzNPMW1velktdjRBdkUkICwgcC4zMTQ5
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbWVsaWUgRGVsYXVuYXkgPGFtZWxpZS5kZWxhdW5heUBz
dC5jb20+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5A
c3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMgfCAy
ICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMgYi9kcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5j
DQo+IGluZGV4IDI2NzU0M2MzZGMzOC4uMGRmNjkzMzE5ZjBhIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MyL3BhcmFtcy5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMN
Cj4gQEAgLTE3Nyw2ICsxNzcsNyBAQCBzdGF0aWMgdm9pZCBkd2MyX3NldF9zdG0zMm1wMTVfZnNv
dGdfcGFyYW1zKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJcC0+aTJjX2VuYWJsZSA9
IGZhbHNlOw0KPiAgIAlwLT5hY3RpdmF0ZV9zdG1fZnNfdHJhbnNjZWl2ZXIgPSB0cnVlOw0KPiAg
IAlwLT5hY3RpdmF0ZV9zdG1faWRfdmJfZGV0ZWN0aW9uID0gdHJ1ZTsNCj4gKwlwLT5haGJjZmcg
PSBHQUhCQ0ZHX0hCU1RMRU5fSU5DUjE2IDw8IEdBSEJDRkdfSEJTVExFTl9TSElGVDsNCj4gICAJ
cC0+cG93ZXJfZG93biA9IERXQzJfUE9XRVJfRE9XTl9QQVJBTV9OT05FOw0KPiAgIH0NCj4gICAN
Cj4gQEAgLTE4OSw2ICsxOTAsNyBAQCBzdGF0aWMgdm9pZCBkd2MyX3NldF9zdG0zMm1wMTVfaHNv
dGdfcGFyYW1zKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJcC0+aG9zdF9yeF9maWZv
X3NpemUgPSA0NDA7DQo+ICAgCXAtPmhvc3RfbnBlcmlvX3R4X2ZpZm9fc2l6ZSA9IDI1NjsNCj4g
ICAJcC0+aG9zdF9wZXJpb190eF9maWZvX3NpemUgPSAyNTY7DQo+ICsJcC0+YWhiY2ZnID0gR0FI
QkNGR19IQlNUTEVOX0lOQ1IxNiA8PCBHQUhCQ0ZHX0hCU1RMRU5fU0hJRlQ7DQo+ICAgCXAtPnBv
d2VyX2Rvd24gPSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fTk9ORTsNCj4gICB9DQo+ICAgDQo+IA0K
DQo=

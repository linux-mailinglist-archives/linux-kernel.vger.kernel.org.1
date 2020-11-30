Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B7D2C7E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgK3GSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:18:41 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56098 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgK3GSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:18:41 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 56651C0119;
        Mon, 30 Nov 2020 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1606717060; bh=KTcHRH+eRv1sEbWAekRR9rmgdO/ooLtzFlAuGLX512I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Y8wc9Lu/DAjK6X1MZfPoolfFHhY5othVlSpBRAWnJJb1aznPvkvAd4NpIwmhMjlij
         zlzBs7UNfSvWUCtfUhG0QJBkHu27417UzOA0ZwShVW7nszNZkS0BDJV4E3sSwZdg4m
         /mAcEvOb29/wk/3cQDsX/YFDtzyDluIlillVd2QNez0/D3ceoETpCVy/TDenhGSDMW
         c9yIm/KE4om/Aa7n5QntpRNKdo3Q6A/FQRKFtEqFygZLk5NY8AQl4TAAdc4hT4QYTB
         Dpc9ro3ZyIMvxw4zz0pHRdfeoUYDKv+FVIpG0MjPK8K3FjN3ZGAl0LWDlQ4wA+ZIWZ
         SKC2l5at5k2pw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A4E7BA0063;
        Mon, 30 Nov 2020 06:17:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E5A0C80214;
        Mon, 30 Nov 2020 06:17:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vk1+1MPi";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX7elcPHmgmENxWzb39BD9EMGgIlTUJp7BRRm8vw8DLqeXkCQDRqI/Z89f9OG61y0vlyKnTYZIH4FEU+qQqi/bHcz9vUj83NQHAhBp08Vt++s7uHLGwoBGsYsK4Uws/zbEkMPmw8XUkmXfShAZTjC/eKuuNihlVFbpuArJc1IbwEBIhhIVR3PdjHiComVEsaIX79h1xZVR2ZDLQiNLfrpd/X/4kTwxY0hChbWzd7VokZBtitlMy8F3CLUd88T2uNl59xFRnaIbw030UyBdNXYAXv3RIT4ds06+msBPCpcoKLGP/IV+Yk5BFmx+F4DJ6eStnEf56QdMDSZWnYARqAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTcHRH+eRv1sEbWAekRR9rmgdO/ooLtzFlAuGLX512I=;
 b=CQXVP84MVge4Xq7M7DWK+jQeHRAU5+WYQmazMKnh310YxqXVfJfMlw7rnxjHVc3nxJRZaHkmVORroA4NZLIDZb4BgdZlQNWippEYMPWjCygpuPh5ryt2iR287zcQLxkFr04lsT3+jC2saFEwYV0TSTjphbky6Ny5FA8T+PltjMvvh+1F3H8HICWtZHHG4HFvkXLuTe0rJCe86SKirjtw5n+9Ek8lRq0xZLjK87ZZlE+swXQceYbCEG5NT+R231cR0Wk0SJd80tkD0vVCzQ/EmS3WExLzyh9Axx6ZEUIvmlgGvpLCNytbMtmqsDoZQF9HF0Hj9Pqh6IfIsPOnNBiUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTcHRH+eRv1sEbWAekRR9rmgdO/ooLtzFlAuGLX512I=;
 b=vk1+1MPiZ14p0HyBPkMLqWHNc1udZrIDb1xMbEAD14q5UcRj1aFolgpgWXCJE6C2lqG4veMS9p/07qo2fhpmbcThFV8K9kzShHY7nU6wXXMJ0nBs+TdGbeVd5RImhO3dXiYmfEEfUGZzdF7xK/VbBfVT0JVKFZJayUJYP6lMhIU=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 06:17:37 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::f90b:950d:63c:37c2]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::f90b:950d:63c:37c2%7]) with mapi id 15.20.3611.023; Mon, 30 Nov 2020
 06:17:37 +0000
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
Subject: Re: [PATCH 3/3] usb: dwc2: disable Link Power Management on STM32MP15
 HS OTG
Thread-Topic: [PATCH 3/3] usb: dwc2: disable Link Power Management on
 STM32MP15 HS OTG
Thread-Index: AQHWwXdaBcTjyhHZYUiQ55rlPlvUzqngPg8A
Date:   Mon, 30 Nov 2020 06:17:37 +0000
Message-ID: <f068f069-232c-7bef-3f1c-7fce95a2a401@synopsys.com>
References: <20201123090114.12641-1-amelie.delaunay@st.com>
 <20201123090114.12641-4-amelie.delaunay@st.com>
In-Reply-To: <20201123090114.12641-4-amelie.delaunay@st.com>
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
x-ms-office365-filtering-correlation-id: 992d3a10-543a-4377-55b4-08d894f7a277
x-ms-traffictypediagnostic: BY5PR12MB4997:
x-microsoft-antispam-prvs: <BY5PR12MB4997ECFA649F5B3470646E60A7F50@BY5PR12MB4997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vEhx2L1jvewrozv5iFLCR3EKxSVAMJS3eBd2uoIjlz+DvbbwMbp38DCJ7TXuVTn4cku3GPjVOuneFTVuUtWBi3DTbR+VzfFeLqAHddaIC2Ix+/uCfPSUsOmHjYHbEKMVxJipzSNcj2gk91OqUDqFa46fn1vV4sXyK9La2gfIR47lzAAZN9+PWORjklXQ5uS0wXqZqKx0SVDEUPeKDC9aW5cVUkADMve0YyKOL3KqNB3vZsksKLNM/irSZQFtJoAF7QqI9tSqnN4omH9VXtP/NEyONJHAV1hufVuhgfpEb2h9c8wVv8dqdhVnId0Sb+KKvao5IHJ0FoW9Tw3NyVhdOvYsVXoN2PsdmicR965qaila4eV2RIALbp3O9M43ILT/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(346002)(366004)(376002)(54906003)(76116006)(91956017)(86362001)(5660300002)(4326008)(66476007)(83380400001)(110136005)(316002)(66946007)(66556008)(478600001)(64756008)(66446008)(8676002)(71200400001)(8936002)(31686004)(26005)(53546011)(6512007)(2616005)(36756003)(186003)(2906002)(6506007)(31696002)(6486002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MUN0S05FWjJDOHdEeWpiRVdNSWpZZ1dUMmJjQUlVUGZLLzJKNVc3SWRmTS96?=
 =?utf-8?B?SGRTTDAwZ0hacXByUDd6c2pWbEpGaWY0TVp3SkpEcjVheWJGWjVaMjRSakhk?=
 =?utf-8?B?NkhrQW1UWGM2N2YycXRubmt1WXBLMllxbGtwWVdkcVkzV1VGQ3BBb29MbXor?=
 =?utf-8?B?Y21TdSs4a3FxSW9hUVNXM1lhcjVYd0l0YVBoSnN1YWZNNmVVc05iWmRUYWFY?=
 =?utf-8?B?SkdBbUZ3YnBRQ25rMWdhd3pLTkJDUWRWZ0duUUk1VVRVVmkySTY1dHAwVTho?=
 =?utf-8?B?eGlKNDRMM0hCS3RmR2VoZWFUK09YbXNMbENxaHcyMzJ6QSt6eU1rQmRwcXAz?=
 =?utf-8?B?OVVXa0U1SjN2N2tsaXFVQnpLYWV2YmsrbzlDYXAvN2I1bDNJeXp2WUUyOHZX?=
 =?utf-8?B?eDFndVlCdUVwL1RRTjVsYnZPbXBCQ01MY29sLy9GYXZYU1d1ekRvK045eUxE?=
 =?utf-8?B?SHEybnNSdDhhRVNRRDFER0xQeHJFZlcyL0d5T3Y5VWVibnZlY2hsdkkvMi9L?=
 =?utf-8?B?TERxTzZNeHVRY3dFREJOemZ2QmdRUERYRjRGSXQ2WTd2V1hBMTZwS1ZWeVVY?=
 =?utf-8?B?Z3V2dlhEak5OcXBNVHFtU1NGOXlBTEs1UFE3WGU0QnR5MEZJZ3lrTXJZYUtx?=
 =?utf-8?B?dk9wcDlBZ2Q4em9TcEhzVzEvWGNKQm1raTllc2VLNXdNZ3l2T25XVys4Sm02?=
 =?utf-8?B?bUFKV3M1ZVkzS0pDWTZ5ZFZLN1FSY2ZVYXJTbk5CVDhFV2V3WmhxYlUrTWNm?=
 =?utf-8?B?REFOcjYwcSs0Wlh2MVFTRi9yb055TmU3aWYwOEI0L0x3emxNcUl2RFdyV2hl?=
 =?utf-8?B?WC82MUdXRHd1U2dXQS82K1k4MW92RUZqYktzMnNzbWtVNlZmRkx2bXJzL0U2?=
 =?utf-8?B?SEVWSWljbk83YW1EdFI4ckdKMEQ5Z3Awb1N5SjJrVHB5ajdwUFA4R0Z1bUZM?=
 =?utf-8?B?TXptTk1wYVN3anAwaU1FWURUcVRJcm9pY0t2Y21LUkRyaXNMeGhnTFVJdmdO?=
 =?utf-8?B?MUd2djZoeEw1bVlUVGxKRWRiU1J0dXozZW1LRUJkV2VFTnZFNjA4TSt6TGtY?=
 =?utf-8?B?YWpLblB1Smc4cWRuWEloOElnWXkrMisxSFNFSWxLSFozMGFTTDh4S3Bxb3Vz?=
 =?utf-8?B?SlR0QlNDb3pwWmdwSnBmQ3lRU2VWYTdib0xlMDVQMjZJc3VNMnlxdTVnckpC?=
 =?utf-8?B?QWFSKzdUYTMybFQyWkJLSzFOMk0vZDRDZDVzcjFMRkdYUkRtL29KVmlHcHQy?=
 =?utf-8?B?Z2FNTmhKRzhzTjJTMHV5NENBZGtNL2lPdnkwZzRBbTE3US83TU1GUjQrQXNO?=
 =?utf-8?Q?zUbs4Ynb+j1k0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C4A53BAD06FB049BB0AE0E09AB19C2D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992d3a10-543a-4377-55b4-08d894f7a277
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 06:17:37.5558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: do983mwPCmnpUVTQ/uJ1LSg/SXLeKXmOgJg2dzPWKvKHRKIa+m9Zbn4//Y5ruYcIMcTmeiXhdiNp4Wxxfr2SLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjMvMjAyMCAxOjAxIFBNLCBBbWVsaWUgRGVsYXVuYXkgd3JvdGU6DQo+IExpbmsgUG93
ZXIgTWFuYWdlbWVudCAoTFBNKSBvbiBTVE0zMk1QMTUgT1RHIEhTIGVuY291bnRlcnMgaW5zdGFi
aWxpdGllcw0KPiB3aXRoIHNvbWUgSG9zdCBjb250cm9sbGVycy4gT1RHIGNvcmUgZmFpbHMgdG8g
ZXhpdCBMMSBzdGF0ZSBpbiAyMDB1czoNCj4gImR3YzIgNDkwMDAwMDAudXNiLW90ZzogRmFpbGVk
IHRvIGV4aXQgTDEgc2xlZXAgc3RhdGUgaW4gMjAwdXMuIg0KPiBUaGVuIHRoZSBkZXZpY2UgaXMg
c3RpbGwgbm90IGVudW1lcmF0ZWQuDQo+IA0KPiBUbyBhdm9pZCB0aGlzIGlzc3VlLCBkaXNhYmxl
IExpbmsgUG93ZXIgTWFuYWdlbWVudCBvbiBTVE0zMk1QMTUgSFMgT1RHLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQW1lbGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVuYXlAc3QuY29tPg0KDQpBY2tl
ZC1ieTogTWluYXMgSGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4N
Cg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jIHwgNCArKysrDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzIvcGFyYW1zLmMgYi9kcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jDQo+IGluZGV4IDll
NWRkN2YzZjJmNi4uOTJkZjNkNjIwZjdkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2My
L3BhcmFtcy5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4gQEAgLTE5NCw2
ICsxOTQsMTAgQEAgc3RhdGljIHZvaWQgZHdjMl9zZXRfc3RtMzJtcDE1X2hzb3RnX3BhcmFtcyhz
dHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgCXAtPmhvc3RfcGVyaW9fdHhfZmlmb19zaXpl
ID0gMjU2Ow0KPiAgIAlwLT5haGJjZmcgPSBHQUhCQ0ZHX0hCU1RMRU5fSU5DUjE2IDw8IEdBSEJD
RkdfSEJTVExFTl9TSElGVDsNCj4gICAJcC0+cG93ZXJfZG93biA9IERXQzJfUE9XRVJfRE9XTl9Q
QVJBTV9OT05FOw0KPiArCXAtPmxwbSA9IGZhbHNlOw0KPiArCXAtPmxwbV9jbG9ja19nYXRpbmcg
PSBmYWxzZTsNCj4gKwlwLT5iZXNsID0gZmFsc2U7DQo+ICsJcC0+aGlyZF90aHJlc2hvbGRfZW4g
PSBmYWxzZTsNCj4gICB9DQo+ICAgDQo+ICAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBkd2My
X29mX21hdGNoX3RhYmxlW10gPSB7DQo+IA0KDQo=

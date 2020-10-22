Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1DA296530
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370060AbgJVTVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 15:21:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:39689 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370050AbgJVTVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 15:21:08 -0400
IronPort-SDR: kvWHvuwh6Yz//Spn/qawHfyLNJZZLtHjt5RSgF0cnCcfpyhZTsoa9QfalEn9h4FpZeIc3vismQ
 c+osc58rehtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="155367396"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="155367396"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:21:06 -0700
IronPort-SDR: kM9fJpzWVuhHC6c7VjsR/D2/8IRJDayAdvDKl7GF6s1JBNmi3FDa7ee1aGpRyJ8FyjTfJdOVCx
 6QQM8EwZB88w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="359961094"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 22 Oct 2020 12:21:06 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 22 Oct 2020 12:21:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 22 Oct 2020 12:21:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 22 Oct 2020 12:21:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFbtDg0kyLrHKaWiWtvM0IxZRjioRAmLeiTZ9hBqaZY+mIEza9ncTEb63tHe2FXkxqdufCON3sQtzMlawTJ0RQtUBDHlzVwmmI/VU5PPwt6PDJtxq1CSOjgOcyGzRedPejA4fTNhdWaiQTAfP5LoEKR9IO1p+duB6DyXCvoVL2gWOsp6nP/RzkI9Pp5NeFzm7N/ohY4D6rp4cOrcKyXBgbIVBuT1zK4b2U5tbcXjPZl12NqFfK91HVPiVX6cXwO9toSTPcU4ag9Vps2t0TkcOV0Y6gGl8q6r9swExLSMsMTc0OYJ8/pVTZQapGcZH0JyjfNQx0rjgVDjanZZBslrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkovodQSCTNRj08VXVgBsn6m90YOME0Wk+Rvq/mzMUI=;
 b=P0dx3yFYT7UK6zQp1hQLyVP8tfPUVjkUl+2lqMbk690qs5zlPyboWmbKSkrdn4UCcJLtlRawPjh2J98apn0F4f5bDjbhwHBIsU4wRAWcQatfKOkKfSvWsRw3YmADFp0oZu0b6ppLdmyn5c6dmmjm0I91o4AvdhwHIR3/96i8jiG/IcrKTazgPwo+bf0gqIWX3Z08stWGLJME0bA4Zx5VsECUAprsvy9UuQP9QZzqsl0JOIKAI1sctevPBwjro3jteB21JociRfNdU9ijOGfWIFHtgWZTgAEEgNDuh/ttfZ6MJj016TUooOuvgrpxxXT5xT0ZMSlMjwtpfja3EvC9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkovodQSCTNRj08VXVgBsn6m90YOME0Wk+Rvq/mzMUI=;
 b=hKin1LvTQYnDs/q74MJ6PFN+WvKcsUpOz9p+SYvjT/40dk8fWLV3rufF0q2m+gJjKomqEWwOkQ7bFRF+0KMEBy40XnNRuaumpM/NbYmgAPX7mYqwc5hCMcc10V5tA6JWc64iUgHHrWPSEWc5htQvVnxIgDhEG0fiqyJ9e4oPYeI=
Received: from DM6PR11MB2890.namprd11.prod.outlook.com (2603:10b6:5:63::20) by
 DM6PR11MB4122.namprd11.prod.outlook.com (2603:10b6:5:195::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Thu, 22 Oct 2020 19:21:04 +0000
Received: from DM6PR11MB2890.namprd11.prod.outlook.com
 ([fe80::2472:44fe:8b1d:4c6c]) by DM6PR11MB2890.namprd11.prod.outlook.com
 ([fe80::2472:44fe:8b1d:4c6c%5]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 19:21:04 +0000
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "Perry.Yuan@dell.com" <Perry.Yuan@dell.com>,
        "Yijun.Shen@dell.com" <Yijun.Shen@dell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 1/3] e1000e: allow turning s0ix flows on
 for systems with ME
Thread-Topic: [Intel-wired-lan] [PATCH 1/3] e1000e: allow turning s0ix flows
 on for systems with ME
Thread-Index: AQHWlVGQmh2ksY0uRU2QEYcmlb6rAqmkJiBA
Date:   Thu, 22 Oct 2020 19:21:04 +0000
Message-ID: <DM6PR11MB2890B9B211E9F5F9A78EE978BC1D0@DM6PR11MB2890.namprd11.prod.outlook.com>
References: <20200928044024.7595-1-mario.limonciello@dell.com>
 <20200928044024.7595-2-mario.limonciello@dell.com>
In-Reply-To: <20200928044024.7595-2-mario.limonciello@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [97.120.164.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bb44693-1cc6-4adc-3b86-08d876bf9e82
x-ms-traffictypediagnostic: DM6PR11MB4122:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB412291B0639CB688640FAC16BC1D0@DM6PR11MB4122.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vplVNXC8OB3ccLnbHzZqmayrnU93u+E8PyqSuLQfGhbVwso+tMe1qplYkdiz5KoML0bVtV9uFZPcgNpe8Mj8ssbsl1AeoLv2o0OBmYSMT6Ovk/aPBkQzkHbEL4J5V+YPTPNs8e6ufi4m0cN3cYv+Ky/tnyXiacXTopsmHd29JaqXNrByCKKub9Lhf1Hwl6t6AXGd00m+doAjC2UnDKa/5iA8sW9f4pEgXnYkJG89wX4edxZkXgZJMNeyYFQJ9t243BfEVAWfvmW/yKsz5EKw8oaVwz44xRlWM5LJx/HbDoWx2P+ggUxVg/q8pKVHU0hysNxotT54JmYl0vepeRHcMikCCrg0eHtTBZ0tk+A7fJeeyndaBQ8dDhzNDJc9kCY5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2890.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(478600001)(8936002)(6506007)(26005)(86362001)(186003)(53546011)(83380400001)(9686003)(8676002)(7696005)(54906003)(33656002)(52536014)(55016002)(2906002)(110136005)(316002)(66446008)(4326008)(71200400001)(66476007)(66556008)(5660300002)(64756008)(66946007)(76116006)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +zdQSb7x2n52QQt6D/Bt3olVO1vatqHotN3POAYhAfj+TFEaQgbjNQ4TypgzEx3kL1pYt1xuZrWRlSUg1+S3Y4AWpqnFmk4/yVoIGXDQPmbfJckUDOHY3lSAGXQGnC7f3DV+I4cekL/H2x4QC+4nobpxaXyrsaR7R0OJpt/A8tqJmVNF/OVevd9ilCaPYWs61uyuRJ58wT1xUfn7AUA9z4sokiQ7kAeCS6MNJTA7i5fVW0ccCkwk1pid8qwCNLElNhL9wymA3uDXAQXr6fSSVX/u3AJ8Ke9UcFTjcNVLR/S9yX3h1z8OEl1aVYnvDfXpgFpK1D+4vWDoZg8wQYFew09ku/SuF4sYbZ91slU7HhV/YfEjTtmTBqUp02+hTg/CmLjFyMSAQ6Wn+2JhtwZ2nXbTxqVjkYA6oGfsTVREavbLJEO34WM2K3MbWm9mwXcpg78zzYH3MsxabRiKn7ny0VttMM9n3sHiGRSZp2fP00rCdIWaLuQmBhISF1ZLvktybwWnfIGJBHWaQ/QzhixDJvkTy2tb7EK4zPBhGqy5tDDMAoLkIC4iXF7wJDXzBAaRb66RNsry89Vaai9Juh74PLdPHnJG1Y7FaFkFiR3UXNB3SlunEjJUN5QTwMhSaOWEWhBf1nGZEYMQbsSM6l3jIQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2890.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb44693-1cc6-4adc-3b86-08d876bf9e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 19:21:04.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUojlb1q7NlzXBd+GriPMW6y0mOpq40Nb+AHQbAnhNz0WLzcH63g9rGgb7cEFLHbu4VnSMJRMr76sIc31P00lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4122
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mario Limonciello
> Sent: Sunday, September 27, 2020 9:40 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: Perry.Yuan@dell.com; Yijun.Shen@dell.com; linux-kernel@vger.kernel.or=
g;
> Mario Limonciello <mario.limonciello@dell.com>
> Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: allow turning s0ix flows o=
n for
> systems with ME
>=20
> S0ix for GBE flows are needed for allowing the system to get into deepest
> power state, but these require coordination of components outside of
> control of Linux kernel.  For systems that have confirmed to coordinate
> this properly, allow turning on the s0ix flows at load time or runtime.
>=20
> Fixes: e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME sy=
stems")
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  .../device_drivers/ethernet/intel/e1000e.rst  |  23 ++++
>  drivers/net/ethernet/intel/e1000e/e1000.h     |   7 ++
>  drivers/net/ethernet/intel/e1000e/netdev.c    |  64 +++++-----
>  drivers/net/ethernet/intel/e1000e/param.c     | 110 ++++++++++++++++++
>  4 files changed, 166 insertions(+), 38 deletions(-)
>=20

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

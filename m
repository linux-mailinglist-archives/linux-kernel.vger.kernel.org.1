Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF31A6427
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgDMIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 04:33:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:59705 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgDMIdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:33:07 -0400
IronPort-SDR: Okr+/2s4YasRqRw+GAlvfY77ai1P4hJLaEHVgdJHmK594egP6c0Q5NWyy0UVBggiMS/9qzrOWt
 pRi51Wtg2uuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 01:33:06 -0700
IronPort-SDR: 9HW/RAmN2Eeu4X3KoDa0Pfh4Y/7UB01QbTztN43JdS1tOQVQ5X6G8IC1Mo3I3H3PeMJdFSStcY
 yZ8RsPkIfOzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399549554"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 01:33:06 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Apr 2020 01:33:05 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Apr 2020 01:33:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 13 Apr 2020 01:33:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdofT3ka5H6XfkjTUN2h7LiwcQ/ktFHC6Sf24PtOXWuUy4pea9AwLcRqy8CmVCw4VsIjGcCvZlMOS7Kuc+vQaUJWHAnNTwBDuz44Oo1AfTI5mox2PGE5VU5ga3FJ2txjuPeoNvHNeFy5/TepQAdYBFl5MThR9bT7m0q1fD2BB4K5pIPu6XY3CCczzSZGMkEj2g2tlKRX4JL2FM7HgCLHBAk3L+e4M7RZ7+dIBmFr337Y+qGyL+B7Nc2s9CfaGgQ7b7k9HGV1i3ZNYgVNrJ7YxjzEffC+cV6emRc4PefcAwaa+0w4pYj3Jl4G9CGB4bMHUXRHTOX2kiIMrVzdcdAuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo5AaDlQPeobBTyiQmaQn/FxiiUgI/gcvDBty/GuPbs=;
 b=fEzOMH2w1WJJGadJKZL/Lb/Bp1WDGimSOBHU+d8V5CBUh7jJ5AByO9tyd8MAAQ4n3yG6AElR7k/WMu25jtpToHilyB0EsSxfZLigNNIfuu1keA8Hnp1F1fDICSFYZxBeKiEeTV0+KAqgL3PVqIPzDg/WleHDu9SFwnyG+qvwcc1wXXNG06ZHNkdRdzZTKVEW6HXkM4S6qMBsAhbg/caD5sqHAIz9OAJYDwvJO39UunxsZ020HUhtjc832/6iyZ4lywrtFfuCrshx47VawLXbxAi6l1GEjkIM5M8QqftfXdkzzH9r5T+Y+71LKByuCYQq0/CeoaP0UPMcZTqrAQb+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo5AaDlQPeobBTyiQmaQn/FxiiUgI/gcvDBty/GuPbs=;
 b=RK27UDycTLk4qQARp5MbxU9W+FNsc6IWmlDiDMSXtHc+SCs594Twi16EofSD4m3YR0dNFTTHdi97uulv0jmLzxFZ9CZiYfTx5BMlGoGaHoQQ6+nz7H1KoarU5HFDw0iSJYUCe30L45noQ1qizfLW82b9Znd95ihV22sRpPDs4UY=
Received: from BN6PR1101MB2132.namprd11.prod.outlook.com
 (2603:10b6:405:5b::22) by BN6PR1101MB2354.namprd11.prod.outlook.com
 (2603:10b6:404:9b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 08:32:40 +0000
Received: from BN6PR1101MB2132.namprd11.prod.outlook.com
 ([fe80::344b:59bc:1455:37a6]) by BN6PR1101MB2132.namprd11.prod.outlook.com
 ([fe80::344b:59bc:1455:37a6%11]) with mapi id 15.20.2900.028; Mon, 13 Apr
 2020 08:32:40 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Keyon Jie <yang.jie@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ben Zhang <benzh@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "Guennadi Liakhovetski" <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: bdw-rt5650: incorrect rate of PCM data
Thread-Topic: [PATCH] ASoC: bdw-rt5650: incorrect rate of PCM data
Thread-Index: AQHWEWvaw/xGfZkAh0ycwuOE4XkUB6h2uj0A///9SrA=
Date:   Mon, 13 Apr 2020 08:32:40 +0000
Message-ID: <BN6PR1101MB213296929CC4C10928F79C9A97DD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
References: <1586765358-18474-1-git-send-email-brent.lu@intel.com>
 <751b03e3-c4de-cbcb-e1b6-dc6f3f572aab@linux.intel.com>
In-Reply-To: <751b03e3-c4de-cbcb-e1b6-dc6f3f572aab@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brent.lu@intel.com; 
x-originating-ip: [192.55.52.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a121839e-c411-440a-b127-08d7df853ac6
x-ms-traffictypediagnostic: BN6PR1101MB2354:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB235404B178246B2C929AB13597DD0@BN6PR1101MB2354.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(396003)(39860400002)(376002)(136003)(346002)(8936002)(6506007)(110136005)(81156014)(5660300002)(76116006)(33656002)(9686003)(71200400001)(52536014)(8676002)(316002)(55016002)(54906003)(7416002)(4744005)(26005)(4326008)(66446008)(66556008)(66476007)(7696005)(478600001)(86362001)(64756008)(2906002)(186003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoQoRkotW/ti0j0LDRlYnqFEz+c/MF8Z1rlNa24SUaJEVxib5I6K5wRnR5lwCtuBL0R4rXz7ZNTmDsjrZAE+otZ8Yq3vVd2VZXfu0vScCw1oue/ZNcCZMs/VTk6wY3iOjkduQ8/xw/OVvEGeupdi/zxJop7vCzM0FcIbd2mC9cW7+LgIeQH8Jz4g43gmjdXHlQd5B2PPtkfgO6uXVKFJ8avKDUoChjqzn0VGCHXG4U6n8FbS3jxSt3Ty8SoeEs8ByuuMpY5+Y84C7K1CBvtGohnhozFEnb5AY63foiXCZ5STkLgJn2QvDnEpYFCFGvdncWDMeiU+8F0QOB0HBWpGkB/6dxLpgo4UMTYGtr7etF9KkQ5o9EJCWSJ+Du7q7fgvTGwSifR576BMVn2GRYwSMdYU6131mwmQEhnZwZA+vCGHtWl3Jmve6BI2ncFTQJAD
x-ms-exchange-antispam-messagedata: pgmyrfB7mi+27gl6d4Ai5n8fgLNtBJwyqR2zQTA/2eLLrX6fA3+zYG3Zbq/FaHDeLH+76AZmzP7SlOMeczd8P5Gfio+wzRDOlV/xzMUUjQ9JoXP0oloYueXCaAOIaK6wgK0NaqFrTWGR4FsCsU7Ang==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a121839e-c411-440a-b127-08d7df853ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 08:32:40.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcOPIl5GUiJ6isrLMXk496Yhc0SS5IulcxSNLlfQHcVoeCI+RNjv38V+D3LOsOKnVEegsrPEtTkzdvR2At4LUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2354
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gVGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUsIGV4Y2VwdCB0aGF0IHRoZSBzdWJqZWN0
IHNlZW1zIHVucmVsYXRlZD8geW91DQo+IGFyZSBjaGFuZ2luZyB0aGUgY2hhbm5lbCBudW1iZXIs
IG5vdCB0aGUgc2FtcGxlIHJhdGU/DQo+IA0KPiBUaGFua3MsDQo+IH5LZXlvbg0KPiANCg0KT29w
cy4gVGhlIHRpdGxlIGlzIG1pc2xlYWRpbmcuIEdvb2dsZSBpcyB1c2luZyBhIHByb2dyYW0gY2Fs
bGVkIGFsc2FfY29uZm9ybWFuY2VfdGVzdA0KdG8gbWVhc3VyZSB0aGUgZGF0YSByYXRlIG9mIGFs
bCBhdmFpbGFibGUgYXVkaW8gY29uZmlndXJhdGlvbi4gVGhlIHJhdGUgaXMgaW5jb3JyZWN0DQpm
b3IgMy1jaGFubmVsIGNhcHR1cmUgYmVjYXVzZSBCRFcgZG9lcyBub3Qgc3VwcG9ydCBpdC4gVGhl
cmVmb3JlLCBhIGNvbnN0cmFpbnQgaXMNCmltcGxlbWVudGVkIGhlcmUgdG8gcmVtb3ZlIHRoZSAz
LWNoYW5uZWwgY2FwdHVyZSBzdXBwb3J0LiBJIHdpbGwgdXBsb2FkIGEgcGF0Y2gNCndpdGggYSBt
b3JlIHByb3BlciB0aXRsZS4NCg0KDQpSZWdhcmRzLA0KQnJlbnQNCg==

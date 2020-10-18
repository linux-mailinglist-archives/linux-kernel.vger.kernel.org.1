Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F59291FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgJRUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:25:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:52214 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgJRUZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:25:24 -0400
IronPort-SDR: qZeZ9nLLyKwQjimYQyZHp3WvMCzoSCubLRZx2Yn0u8DwQOZGvolCfAr/krMQxhv/Xq/srbabMT
 QJTCmzdkaojQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="163448454"
X-IronPort-AV: E=Sophos;i="5.77,392,1596524400"; 
   d="scan'208";a="163448454"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 13:25:22 -0700
IronPort-SDR: RQ8+VhPvNxtKd2KVCP+o0vockfVF+a7Cr4flusHo46a0lA6dR0Ym8l3FL0yn8N43mA9/w1Dv6H
 KOAsv9mnS+sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,392,1596524400"; 
   d="scan'208";a="352790061"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2020 13:25:21 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 18 Oct 2020 13:25:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 18 Oct 2020 13:25:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 18 Oct 2020 13:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQfJYb1COcgtuqkCy6aH517skF7X3rLQx1fGvKgsWraoNXopAuQQLwfypQT1BOUE96SRgD22KCST9o67wtqLw9BQgpjPar7T28edVDu8eHnSeThgL98fOSTJkrbVS9CB98RTsRT6NOHIf0AcYXZ4GMCekgQ4yHuR+qNc9TwCqP1q3MjoCtxKrcWlMg5+wqco2JktN6pRd5C7KkvxJ5uYO19vUOgwPAbg9Iu5AM+pq9a8KuzUJcqBPLm/TC22F6NPT3JvoJD0AsLb8Myk/Gusnm3LHUWiXJJdxm0sL1TAX6NZF0n15PASmmjw2j8cv9T8icUUv+UjBwNH+Hkr2xmdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeBHN3AwUHm4nzAx1lDZDOm4s5R+f46TsFZxB6NhQ4o=;
 b=Y7I/9nFfGi7pvXSF1i5QxPdep6jd8eVQjvBOOsV9n4z6X18M0Jw9C4ENPVYssaSaypDXGjY0R9amyExivwLWT0SloHIFfN2kLFU/jnnTNvEYN/oHdRJHvMgwjT83Iuhx7CEbVgkDpHIesztbGfu8DfEVAbmuLovXgkQ8zuY6dMYS3sxN9G9EzqZnpatHL5bEKIAit8jF0u4ksQtsbZ2I5L9FW7np7MzFK1wgnDBCaTgpFMsvTJBa/msK84EA/PS+tH6hAQV0o0UM8WE6/I2jUmNqMZoMi51rDl3B8WUG9LeSVsFIbTyXMDJ8lRpifDZkUKkIFL0CwXdBKcjiXSq1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeBHN3AwUHm4nzAx1lDZDOm4s5R+f46TsFZxB6NhQ4o=;
 b=gjqg8eHtsxztM7z1mmRsHqEBKX4fR/nfecbCHMBz7FBxCdhbOBN1hODwnxGhiWR1PpcCn581qUPIsRh81IyGkB6hRK9btvQai9dYreIY6PbAp4w/EdXT4ubrrsB661ThBaJZqfAl0hN2dsKYWfn+tJNr5+8sFMWsEMOQbCyJnwU=
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by MWHPR11MB2046.namprd11.prod.outlook.com (2603:10b6:300:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Sun, 18 Oct
 2020 20:25:16 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::e5c5:3592:6465:4a03]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::e5c5:3592:6465:4a03%6]) with mapi id 15.20.3477.028; Sun, 18 Oct 2020
 20:25:16 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Zha, Qipeng" <qipeng.zha@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Intel PMC driver on Broadwell system to gather C-State statistics
Thread-Topic: Intel PMC driver on Broadwell system to gather C-State
 statistics
Thread-Index: AQHWpSisja2BUtvZLkmJzfkp3Br+Zqmdfb8YgABPqHc=
Date:   Sun, 18 Oct 2020 20:25:16 +0000
Message-ID: <MW3PR11MB4522AD6C91AE1E5CCFE46F7AA1010@MW3PR11MB4522.namprd11.prod.outlook.com>
References: <c0b7a8c4-6791-a5aa-b51e-61956a0928c1@molgen.mpg.de>,<MW3PR11MB45227983D95C8F0B3F611335A1010@MW3PR11MB4522.namprd11.prod.outlook.com>
In-Reply-To: <MW3PR11MB45227983D95C8F0B3F611335A1010@MW3PR11MB4522.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 429302dd-7397-4b72-12f4-08d873a3ed2e
x-ms-traffictypediagnostic: MWHPR11MB2046:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2046B33FEB4B88FB65C7313AA1010@MWHPR11MB2046.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: huwyJbCTy+Q6CSSiLDxDjbwwuheQcEmmryMHoWcEsxLWlbFeyqBAJCtI6jJ1ikFXIgpqL9yxOd2FKey5ZDzTr/IrE1mjqaaZIzmk1+R6cG9crkKMksW7r2jNvHDLltfj9jR1qjjaUlpDt0UjAwx1AKAS7hCwxjQGSLojHHLKhnSpf9aUAY0Ovhw3iWNF+UcpRu+f2vP0g1PPKlPnjDLamr0BRJTY1Ua8KEB+mTx82MgzVmpsRibqYp3CN1h3HxzzLShaT7i8aWLghgPVa1ueCWq89Xzk44dHhE8jRpUvBPV9+W9N/a0InxCeSPUHXLcPBGDUhgr7wet6oSDSK8uk3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(7696005)(9686003)(478600001)(2906002)(4326008)(5660300002)(54906003)(55016002)(33656002)(8676002)(316002)(83380400001)(110136005)(52536014)(76116006)(53546011)(66946007)(86362001)(66446008)(71200400001)(2940100002)(91956017)(8936002)(66476007)(66556008)(6506007)(64756008)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 55JSx/fYzE5uEghrB8HIc5ZaYQRXAPeWLuXhVltYwc9HV12TJ6NBa78l9N4A7GKu8sa04c4bBmlYBwBgsM78K4IqD5Ysaiyw4Ti1L7NPRGyckxkRVQC8yLzR12TDzlL5yB+5fppkyBo/zyrMSnCaari8ZBpGnDWZVtrebT1DwDm5NUmmKLc6D/WR7iDyj5ibPm0KQZgWnxB344YnQLS2aRo1Bnu89bSnznoPhumydy0/fX7missZh1X+d4AwHbduzo0ApZ+EmxNWbA9lwD7CMcBaEw1vbea0alyuq+jnlcnphg6DkDvDxQBU/L8V2H6RWdPGqcyBIVUyJIJkxtp3wW5LVDakjg2b9pg78cg9uiAFmk/Hx+FcO1L2Y6du5e0xakfzRemyS4ujptKkxCO9+QpfHUvirvmiR1o38tACN935eYWQ+/Hs2qv5lWK3elL834BiirePyD2Oud+8fQzYrEMn3klwCU0P7pw4tig7u99yLQiSjbgNVMHJwQu0qtafPyCiWBAeCvu8jDr5msvSK0++rlkrpJQT4BAwdciNdP4TN505Tcv+Qw4ut1zOI7PazgarUhszPMp2aA3h57AUSQzNJtKS1oaFYU9npthRjUerDdFOi5v3JREsAX/6zmLqM8dg/CoWCR+lLSo4LKBIJQ==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429302dd-7397-4b72-12f4-08d873a3ed2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2020 20:25:16.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbufLRL/MvnrcjQk2Y5MxFcpUYPRygjnrsg/uM2PP9GqVKG/ZrDDnSl6isFQgB+4bC0FtOueXIaHwxXscgaGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2046
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Box, David E <david.e.box@intel.com>=0A=
Sent: Sunday, October 18, 2020 11:11 AM=0A=
To: Paul Menzel <pmenzel@molgen.mpg.de>; Rajneesh Bhardwaj <irenic.rajneesh=
@gmail.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>=0A=
Cc: platform-driver-x86@vger.kernel.org <platform-driver-x86@vger.kernel.or=
g>; Mika Westerberg <mika.westerberg@linux.intel.com>; Zha, Qipeng <qipeng.=
zha@intel.com>; Mario Limonciello <mario.limonciello@dell.com>; LKML <linux=
-kernel@vger.kernel.org>=0A=
Subject: Re: Intel PMC driver on Broadwell system to gather C-State statist=
ics =0A=
=A0=0A=
+Rodrigo for DMC quesiton=0A=
=0A=
Hi,=0A=
=0A=
If you are getting Package C7, but not C8, I'd be suspicious of the graphic=
s display engine. However, in Skylake and beyond, this is managed by i915 D=
MC firmware. In the Broadwell timeframe I don't know what the requirement w=
as. Rodrigo?=0A=
=0A=
You can try turning off your display with xset for 20 seconds and then chec=
king the Package residencies with powertop or turbostat to see if you got d=
eeper than C7. This would at least point to graphics.=0A=
=0A=
As for the PMC=A0driver, it does not support Broadwell. I don't believe pro=
be is completing successfully. That's the init function.=0A=
=0A=
David=0A=
=0A=
=0A=
From: Paul Menzel <pmenzel@molgen.mpg.de>=0A=
Sent: Sunday, October 18, 2020 1:28:06 AM=0A=
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>; Box, David E <david.e.bo=
x@intel.com>=0A=
Cc: platform-driver-x86@vger.kernel.org <platform-driver-x86@vger.kernel.or=
g>; Mika Westerberg <mika.westerberg@linux.intel.com>; Zha, Qipeng <qipeng.=
zha@intel.com>; Mario Limonciello <mario.limonciello@dell.com>; LKML <linux=
-kernel@vger.kernel.org>=0A=
Subject: Intel PMC driver on Broadwell system to gather C-State statistics =
=0A=
=A0=0A=
Dear Linux folks,=0A=
=0A=
=0A=
The Intel Broadwell-U laptop Dell Latitude E7250 (BIOS A19 01/23/2018), =0A=
according to PowerTOP, only reaches package C-State C7 and not C8, C9, =0A=
C10, while the four CPUs itself do reach C-State C10 and CE.=0A=
=0A=
I was asked to look at:=0A=
=0A=
1.=A0 `/sys/kernel/debug/pmc_core/package_cstate_show`=0A=
2.=A0 `/sys/kernel/debug/pmc_core/ltr`=0A=
=0A=
Trying to gather statistics, after the Debian Linux kernel 5.9.1 is now =0A=
built with `INTEL_PMC_CORE=3Dy`, `/sys/kernel/debug/pmc_core/` is still =0A=
not created despite `sudo modprobe intel_pmc_core` being successful. =0A=
(It=92s not loaded automatically.)=0A=
=0A=
=A0=A0=A0=A0 [ 1063.644680] calling=A0 pmc_core_driver_init+0x0/0x1000 =0A=
[intel_pmc_core] @ 4252=0A=
=A0=A0=A0=A0 [ 1063.644721] initcall pmc_core_driver_init+0x0/0x1000 =0A=
[intel_pmc_core] returned 0 after 36 usecs=0A=
=0A=
The ACPI device `INT33A1` is there.=0A=
=0A=
>=A0=A0=A0=A0 Scope (_SB)=0A=
>=A0=A0=A0=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 Device (PEPD)=A0=A0=A0=A0=A0=A0=A0=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (_HID, "INT33A1" /* Intel Power =
Engine */)=A0 // _HID: Hardware ID=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (_CID, EisaId ("PNP0D80") /* Win=
dows-compatible System Power Management Controller */)=A0 // _CID: Compatib=
le ID=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (_UID, One)=A0 // _UID: Unique I=
D=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (PEPP, Zero)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (DEVS, Package (0x03)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x02, =0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Package (0x01)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "\\_SB.PCI0.G=
FX0"=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },=A0=A0=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Package (0x01)=A0=A0=A0=
=A0=A0=A0=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "\\_SB.PCI0.S=
AT0.PRT1"=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 })=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (DEVX, Package (0x08)=0A=
=0A=
The table `intel_pmc_core_ids` does not contain the Broadwell-U ID =0A=
though, so I guess it=92s not supported.=0A=
=0A=
> $ lspci -nn=0A=
> 00:00.0 Host bridge [0600]: Intel Corporation Broadwell-U Host Bridge -OP=
I [8086:1604] (rev 09)=0A=
> 00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 5=
500 [8086:1616] (rev 09)=0A=
> 00:03.0 Audio device [0403]: Intel Corporation Broadwell-U Audio Controll=
er [8086:160c] (rev 09)=0A=
> 00:04.0 Signal processing controller [1180]: Intel Corporation Broadwell-=
U Processor Thermal Subsystem [8086:1603] (rev 09)=0A=
> 00:14.0 USB controller [0c03]: Intel Corporation Wildcat Point-LP USB xHC=
I Controller [8086:9cb1] (rev 03)=0A=
> 00:16.0 Communication controller [0780]: Intel Corporation Wildcat Point-=
LP MEI Controller #1 [8086:9cba] (rev 03)=0A=
> 00:19.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection=
 (3) I218-LM [8086:15a2] (rev 03)=0A=
> 00:1b.0 Audio device [0403]: Intel Corporation Wildcat Point-LP High Defi=
nition Audio Controller [8086:9ca0] (rev 03)=0A=
> 00:1c.0 PCI bridge [0604]: Intel Corporation Wildcat Point-LP PCI Express=
 Root Port #1 [8086:9c90] (rev e3)=0A=
> 00:1c.3 PCI bridge [0604]: Intel Corporation Wildcat Point-LP PCI Express=
 Root Port #4 [8086:9c96] (rev e3)=0A=
> 00:1d.0 USB controller [0c03]: Intel Corporation Wildcat Point-LP USB EHC=
I Controller [8086:9ca6] (rev 03)=0A=
> 00:1f.0 ISA bridge [0601]: Intel Corporation Wildcat Point-LP LPC Control=
ler [8086:9cc3] (rev 03)=0A=
> 00:1f.2 SATA controller [0106]: Intel Corporation Wildcat Point-LP SATA C=
ontroller [AHCI Mode] [8086:9c83] (rev 03)=0A=
> 00:1f.3 SMBus [0c05]: Intel Corporation Wildcat Point-LP SMBus Controller=
 [8086:9ca2] (rev 03)=0A=
> 01:00.0 SD Host controller [0805]: O2 Micro, Inc. SD/MMC Card Reader Cont=
roller [1217:8520] (rev 01)=0A=
> 02:00.0 Network controller [0280]: Intel Corporation Wireless 7265 [8086:=
095a] (rev 59)=0A=
=0A=
Any idea, why the probe function `pmc_core_probe()` succeeds, despite =0A=
the code below?=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 cpu_id =3D x86_match_cpu(intel_pmc_core_ids);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!cpu_id)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
=0A=
The watchdog driver iTCO_wdt seems to load the module `pmc_core_bxt` =0A=
despite I am unable to find the ACPI device `INT34D2` in the dissembled =0A=
AML/ASL files.=0A=
=0A=
=0A=
Kind regards,=0A=
=0A=
Paul=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7272B3BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 04:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKPDR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 22:17:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:17271 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgKPDRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 22:17:24 -0500
IronPort-SDR: zrPmLbnE6wSMBNzzL4+7hkQwlXuTp3CAoOHHs0cB833ZWtkCC8GBfwaDEia0k0dAf0msDQDzru
 HDDWbsmYRpNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="167185636"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="167185636"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 19:17:22 -0800
IronPort-SDR: bS8AlRRf9ac3LaPMV5Zvnp2SBI9R3M1whg1mF6UsK5Fngg32avd1vUe+dTOH/g87M6P7hC5TEE
 buRq3BaE8sBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="361987797"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2020 19:17:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 15 Nov 2020 19:17:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 15 Nov 2020 19:17:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 15 Nov 2020 19:17:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/nZ6Wnt5xkiu/gOCeUnJ6IAnRtKEBrug7wI6bwqwONxHQBCC9BZJjT9gU8KGundwpfK1dqWdewI3w3q69Dm5CfL0N/UvGHB7J6qiqSmgjPlNqsAVxSceTRmQUZeUwBCe4z698wM8TQtlTqyKTQyjnVbf7E+YGrL85E3M/6a7Dm6cHH5XiC3SCg9cdEVokfFHt7+fpuYNYwN/4NKEBFznyuiO9rUMQPoZfW7LsqTAOjbMjlfDJ+XLc99aOTF6/yoy4iFvdqMCOG1pqNKSIIDzpbDMJ1sMMXoD5O+oo8gQQN9BAZMODuCSUrhPwR8jEMN9uEsmH0yeglOHDl8kfv9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHLzKfxOPNUwqbDm0DQPQuuGrJGYrRcQxALUUwSpYrs=;
 b=U6L5eIVcbzCghQGNqdJ0zEphzCyI6oTlE+AhAToSXcsfuwXscZYXghXLdK3bsTzxKgHdqDJvR0SVOqXP/o2MCP0tDDOHRJYX0+OwgSesBJEF8ETphmK4++3tQpNiFb/vk8RmuLVNV/rzrQGAJbh3E7jrvaTJK6dZyd9QG2Jb9kYaHU8iN/0fRToLTXQHvrLYDYbE7qC3VhmOxju8YehR59duKEVly7dwhPh+LkzjRUjhXkvFyvrv1m96G5E7mR+M0n9nGVg/vyJDBLGMPUReAwq+QmiQdaoqqNhrrBY3AO7vl0O6QeRr2xThuLzQvbzh0d+5lt701GzIBhCAM3QVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHLzKfxOPNUwqbDm0DQPQuuGrJGYrRcQxALUUwSpYrs=;
 b=FQUVj7pyJoZug8WQA0WlIDgLj5DVdnPxlImQQ/ow2lBm/7UcmmXSmFNRtTdvrdRu6Jc6w0TYiqfzVvvklXRrqvwwezaHi7A/e/iRJ9o2/Tb6WFIX6FL3UsL4ZV1tHXmk/AHx0mGutbiAsRQRiAjr56TGvmeOnrJCqcOzVCCIN18=
Received: from BN7PR11MB2609.namprd11.prod.outlook.com (2603:10b6:406:b1::26)
 by BN6PR11MB1571.namprd11.prod.outlook.com (2603:10b6:405:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 03:17:20 +0000
Received: from BN7PR11MB2609.namprd11.prod.outlook.com
 ([fe80::b51e:2341:8666:565e]) by BN7PR11MB2609.namprd11.prod.outlook.com
 ([fe80::b51e:2341:8666:565e%7]) with mapi id 15.20.3564.026; Mon, 16 Nov 2020
 03:17:20 +0000
From:   "Ma, Jianpeng" <jianpeng.ma@intel.com>
To:     "yury.norov@gmail.com" <yury.norov@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: bitmap: Remove unused function declaration
Thread-Topic: bitmap: Remove unused function declaration
Thread-Index: Ada7xunIpHUCpbdRQDqIRQrFgGx1Ng==
Date:   Mon, 16 Nov 2020 03:17:20 +0000
Message-ID: <BN7PR11MB26097166B6B46387D8A1ABA4FDE30@BN7PR11MB2609.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1490d0c6-0b40-4635-0e2d-08d889de2143
x-ms-traffictypediagnostic: BN6PR11MB1571:
x-microsoft-antispam-prvs: <BN6PR11MB1571E7ECD8A2141D7BF00A12FDE30@BN6PR11MB1571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: InKKXV3a1A+5Py/aVWGry8PJ6L29t6xxiDm2wef0mpi/ZPNNfcmwmkX99lvOKnpXz1CHJePkZ2P23k+mBU/7v1PSBhye53Fu/uKazYHactINYXLVx9QycuuaOMECxYFkcVTL2h78ZgcZdXI4FQeQqaS5KWyl2g5ypRSWfWoH3B3JeFjQJD0nBiu8Vw8HmCmcirWfnM+LVSoYFTfG6GcasR8WnqrZWDKl3vDc4EoaAeVy1G0wjv/JYrhdV4jA/4s4+Wln0Zlhjqs/ReGd/vwdcVwBURWoDeSN8PxN44gAol+RZRkrElFh+wzfVpW64QFDrzKrvsWrQU02UrkRvWWq7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2609.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(4326008)(71200400001)(5660300002)(66476007)(83380400001)(66556008)(33656002)(66946007)(52536014)(4744005)(66446008)(478600001)(64756008)(2906002)(76116006)(8676002)(186003)(86362001)(6916009)(7696005)(316002)(55016002)(8936002)(6506007)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LC4zz80CUQUePG0zKk8SeFm0z61oNGTMNbstfGYByvKGVvICrvXWQuq5Lami8pz/oU2OLkudtTek2O3Fq4Dzq+T0D+cGISUQK2qDR/pUGoNlUOthAxB6WJ7fY6mCcAUciHkZccLvEwUSb+p7GA8eFOFvQd05+1rAlLGhoaf4uGyYVQGirefYZY7yzvROAoFPg6x3grX5NwVMWieRWC5WdCKHVChiBFeGivb5p9CqS4OhepUQqLWMWUIX2oHF7PFrruysH+N/2B3uDphmaWGWfCntAtFo5vlbX1AneK9OfNXqqZwfEY2A7g1VXgGOpZkfd1NorpRSsoY3ZE4wZ5/+ZQxYuVOHYnJhQ/HsxSxsuewkw0tJ+pd85sy/ijijl59vvNthV6CkFYkj3ot0/k7411FYPBCtdhWfFUIdxqXq6VMzMOr9SkBL4ALMTRqAnfhbS1yrNFXHj3Zcw1BizWCWbjlMttaXX07GZqQwjp9xjz43o+438jZbGCQdUxWxv524czA+4k7cs/MGNneY8D7TCo25HoC4Gc9NryAzX76GrOwZjqbcikKkW/n8xI9u1PYVJTaRGgkMolBifrCMZTdcnyfTRmCPAXl4uKkKguiXmpdJSZtJ28kMvSssmnMG0KvEl3Nu4e64h0r6zvEPAbhKOv3FgQp2oxrmvv0/lcbPSTkrZhfLK84BcYc3FBHN31Z3IGap1ojXcuknmo39XSCh7DZbDnglGUh5WPGLAcrlUVJefaeaEo3b34Je4rP0h/HxpZdeAWe0rGiuQmK14AT4p71goMvA/+ZMjRVBZhMiMC4AdiJj+l0VKUfgrAHjuCuIf85zCb8Zm6skVzq+/4K7Mg7qgpjRMejPIaU/mSJcVI6OPX0yYA4golBALyyOf3veZvbV4kdzasYNfI7Fjm06Jw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1490d0c6-0b40-4635-0e2d-08d889de2143
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 03:17:20.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+xLq0p1jKsvz9Wl0ZzJCZnV3JRVrPdnuq6S9BOo2sUI6x1y5Hq5HpaUOR3JqDx18/n5SRp6rWZ9MdSGGaGKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1571
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 include/linux/bitmap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99058eb81042..6f08965c69a5 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -126,8 +126,6 @@ extern void bitmap_free(const unsigned long *bitmap);
  * lib/bitmap.c provides these functions:
  */
=20
-extern int __bitmap_empty(const unsigned long *bitmap, unsigned int nbits)=
;
-extern int __bitmap_full(const unsigned long *bitmap, unsigned int nbits);
 extern int __bitmap_equal(const unsigned long *bitmap1,
 			  const unsigned long *bitmap2, unsigned int nbits);
 extern bool __pure __bitmap_or_equal(const unsigned long *src1,
--=20
2.28.0

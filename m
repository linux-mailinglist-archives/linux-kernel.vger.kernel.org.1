Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9E7202EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 05:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgFVD0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 23:26:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:27980 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgFVD0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:26:11 -0400
IronPort-SDR: bmIk91UZWKys0JZx9As6hPVuUEOa/Hq08eB/ExH/tvV98oZ3xB8nfDwJ1Pk2Dwq4g4lRBTrHa9
 kBe1wbvlVFwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="123925620"
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; 
   d="scan'208";a="123925620"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 20:26:10 -0700
IronPort-SDR: dojuEtMcbp0timVzJaZRCgZEJlcpaKOeHV4s788drpl1snyuElalFqNRAcE8ST7sTco9O2P7v8
 zPkQwBvAngrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; 
   d="scan'208";a="300702596"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2020 20:26:09 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jun 2020 20:26:09 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX153.amr.corp.intel.com (10.22.226.247) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jun 2020 20:26:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jun 2020 20:26:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDXaN5XodQBEJoRzyznIyji1I3pVn4jfQDejzxOnyDXdG9aXCMktLRtPtMcquirWwo3insp/5v9BfMYW40ppIhW+OtKFbD+cHEzmkIW+y8pAIKTVvNzq7xc5i4Wo4QyHbnwdmIKiVBIdg4QHT95C94cto3kaK3xiFTq0LrHkp6VF8IPMlHKDx/Thiz9Yq+Mrjo4ckqamQffkMtsP7LIgTmyk2KodasJWcZrG56OOVjEOaprmfx8m58aUo7UN84di/WbM2+bIajnG/wP9nrXH71pqOgVyyodUxsg3DZwF3vlBITmqC7pJCu7fw4e6NMD6e2x3M0LwHS+aiK8qzkpbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH2VqMH0FqgtjEh7rUtdC/bZTexJu3eAM/P4WB/FOTE=;
 b=O+dTySjc9x3Yd0HGM+iFWxK+5p4WChEoYFlSlAxePFfYBHr/2om1gvHmChEP+nu+P9DLarClWb1J5Infeu9hInkdyJ2/E1Jdpk83aOwDuyhfj1vEcXn0FpRQRksSPYzJzZk6FVtMaQjPf3HIf42XGCLGEd3BpyupusbwMc6Mr464Lf2vtk7Y7ynS4DXz+3VCA2F+yF6dQ3eFrSi2QjJM2qT2OoCwC71dvlc70tUWcTvrf0wU6NfehS1f8nYqNnzsuYqPeFS549rGayPXOOnSH96Vvm4gvmu7G4Zc25uKSt/1ZNuIQnB3gdVKaU5dtqOj3wz845LK3aN5zyfdIiDycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH2VqMH0FqgtjEh7rUtdC/bZTexJu3eAM/P4WB/FOTE=;
 b=NLpefLTKnlASH8Kmgvd18859juB0vRNwJdBz0jqxvaUFMa2b44Ffkcg27BqY97YLA+edp6YSK59kkHR4shfOzUyjemYRebn9uqs3umWvOKKccSYD4F9Svz+3B/hhGp/BQ5pWIM5OChxcpVz+22g+ftYV5x3Xz4Ni1GOwZiqdLJ8=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR11MB1889.namprd11.prod.outlook.com (2603:10b6:404:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 03:26:07 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::55f9:3fed:cc3e:3855]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::55f9:3fed:cc3e:3855%12]) with mapi id 15.20.3109.026; Mon, 22 Jun
 2020 03:26:07 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] ASoC: Intel: KeemBay: Fix header guard
Thread-Topic: [PATCH] ASoC: Intel: KeemBay: Fix header guard
Thread-Index: AQHWREMIKPR/nB62fEmKfbmyAqTMIajkAQeQ
Date:   Mon, 22 Jun 2020 03:26:07 +0000
Message-ID: <BN6PR11MB1953F208A04F381A24B275D0DA970@BN6PR11MB1953.namprd11.prod.outlook.com>
References: <20200617010232.23222-1-natechancellor@gmail.com>
In-Reply-To: <20200617010232.23222-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0de18148-c12e-4f31-be6b-08d8165c0057
x-ms-traffictypediagnostic: BN6PR11MB1889:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB18897A1BD80F6F605B27F637DA970@BN6PR11MB1889.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:109;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: isVjIsIneuYhhcQ2tPyuRfv190vvA4sq/c7EGmVpR+x75pNaKUV/NR3FS11FwuFBEfSTZaaZApzk6op7KY2eCqhBWt6RocreQdZDD1ikMRjf2jGh3YXJqlSdS7HZPpCv9NRprogDJrTqOdBqSdI7zC1rztiXifjPpkp5oWyCSeW8F86/KKBw8cv3x9rtM9jjOh5kdmS2qR6xBks7vVCy2hejMOfRO4l/Wg3BrUGFwLnFH4Shxb/OcFc9th1h4YG8o7sR7DmQNAUlTcleRy/+R6Wxwp5OrpA54lJTnPmBnQnldiinEQXSHPMmLC/5xPFbZJV1lG/Zx5JGKC+MCFtM8QYrZ+MpXeDwpWJloeYCvILNhnx/hHNg4PxygJfg4ltCIPFvwdAgMET+EG4TtGHF5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(110136005)(5660300002)(55016002)(9686003)(54906003)(6506007)(53546011)(2906002)(7696005)(4326008)(52536014)(66476007)(8676002)(478600001)(26005)(83380400001)(186003)(66556008)(8936002)(66446008)(64756008)(86362001)(71200400001)(316002)(33656002)(76116006)(966005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: v4KsUMcTJPDrqoYrNbyGDFgVSPwR1CPlQ6Q4rJxHt2GnWVQ0mAehLC1ajoZPG1EXW6jOujacFTaxrXDhIGwWxCZIiic+tJrkRIH6EyX87Rwl5/UE4C5YLSXnh22CjjtbOZfV/OZCKUKJcGHMmYmpzNX7uftO6ERfuHbqoEbSe1dnitlqM7I72LQ70h5XvGw1Q9eeR5HDWDrN8j1moivv4oPJKe4TECZal+om+NLdnYrkDT255XWdeMsTibEjs35PYEuKfvgC755PnGFar37GkQecFocAwE+e19HG3MPcSoWOpgwHbKCcZHRTnbMj30YMwCb106QSOESDVG68Ce3eGfcQlS3yvCWmX0WPYUaQFhKYqXr9Z0ViGfrtJ7tXfy9F16tKwwHkKLAhpV/iAcJ9t0aR2NYr94BxgITdwknVy/Lb/0D8rqh4HoXl7o6NWrAwNttWTm0pDlpD4GDjgmoNMrQNnVpVTozuBUHBneZd6GI9Jgbl0b0EblX51BhrLKCe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de18148-c12e-4f31-be6b-08d8165c0057
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 03:26:07.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWPQ2H5OqL3SjpnaRI7DIHGB8L7c+KE+kSfmc2gD9O38NHVABb4t5t3rLh8WcJeOZxiBP/+6YnB+u3Iq/AmjKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1889
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Thanks
Regards
Jee Heng

-----Original Message-----
From: Nathan Chancellor <natechancellor@gmail.com>=20
Sent: Wednesday, June 17, 2020 9:03 AM
To: Rojewski, Cezary <cezary.rojewski@intel.com>; Pierre-Louis Bossart <pie=
rre-louis.bossart@linux.intel.com>; Liam Girdwood <liam.r.girdwood@linux.in=
tel.com>; Jie Yang <yang.jie@linux.intel.com>; Mark Brown <broonie@kernel.o=
rg>
Cc: Sia, Jee Heng <jee.heng.sia@intel.com>; alsa-devel@alsa-project.org; li=
nux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com; Nathan Chan=
cellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: Intel: KeemBay: Fix header guard

Clang warns:

 In file included from sound/soc/intel/keembay/kmb_platform.c:14:
 sound/soc/intel/keembay/kmb_platform.h:9:9: warning: 'KMB_PLATFORM_H_'
 is used as a header guard here, followed by #define of a different  macro =
[-Wheader-guard]  #ifndef KMB_PLATFORM_H_
         ^~~~~~~~~~~~~~~
 sound/soc/intel/keembay/kmb_platform.h:10:9: note: 'KMB_PLATFORMP_H_'
 is defined here; did you mean 'KMB_PLATFORM_H_'?
 #define KMB_PLATFORMP_H_
         ^~~~~~~~~~~~~~~~
         KMB_PLATFORM_H_
 1 warning generated.

Fix the typo so that the header guard works as intended.

Fixes: c5477e966728 ("ASoC: Intel: Add KeemBay platform driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1053
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/intel/keembay/kmb_platform.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/keembay/kmb_platform.h b/sound/soc/intel/keemb=
ay/kmb_platform.h
index 29600652d8f4..6bf221aa8fff 100644
--- a/sound/soc/intel/keembay/kmb_platform.h
+++ b/sound/soc/intel/keembay/kmb_platform.h
@@ -7,7 +7,7 @@
  */
=20
 #ifndef KMB_PLATFORM_H_
-#define KMB_PLATFORMP_H_
+#define KMB_PLATFORM_H_
=20
 #include <linux/bits.h>
 #include <linux/bitfield.h>

base-commit: 27f70ec4fa0e0f419031f1b8d61b1a788244e313
--
2.27.0


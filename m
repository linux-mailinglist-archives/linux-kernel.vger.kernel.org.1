Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D182C4DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbgKZDLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:11:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:65460 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732389AbgKZDLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:11:33 -0500
IronPort-SDR: 6F/wbp/uprXpJiy8X0aDHuzb7XCC7wKUvQDYuCxGxl/kf6PgVLt4rPlvLMvsAnbpAd9HLiliub
 phbLR5RwZvqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="190380836"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="190380836"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 19:11:33 -0800
IronPort-SDR: xmeFgofiFyYMMHxMoAW/0YzWk6bVhvSJhfwVlqqCRMbL1WTF+okdm4RmCOCaq0zYsdr8CT8nJt
 IBjzs2l7ddrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="537149340"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 25 Nov 2020 19:11:32 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Nov 2020 19:11:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Nov 2020 19:11:31 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 25 Nov 2020 19:11:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1AaJ4AzsAL/3/35gzZ72QgHaMz4JHaV+gpOEyI258/terZMsH3si/vxr+HJ7XlH6f1xjVFcpJvW6NqffihTEhJSbEoaQ5NnWUWOjKn2v+5ybA6lnEudiekcaouvaP3Elp4sdhKNqjcqVEaom+IzPvE00UJBrJGkamI+e2gqhhmD7O6pNCd0xkkbRnYBOCz6vbQbqj0VH0zhzX/Tx4S3dIpsCMDoCGlIA6pdgFcjD5ApA+/9O7ygMTUzR0kVbusp0U4lgq9IP2BCJVeQf4WZ2Dr6jOAJaOqQ11ny8uPuLS4b1ccsM9+cQqiT63z4DGi9umLo0hsU9a64759v9H8uLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7TxWldlxBlWN+icp3getWA2k+QyoJau780qYqpK2qE=;
 b=j6Hn/H350kUUYEyi4ZikLcJSyzRb8M10iIXnQ1MaN59kYju6J6FZrTOot2GKPO4Ck/uLkop1EbDaVg0ctJi/XTDUBymJpwFcRYUHiHmV5qOSj6nC4Sqv53bXfs4z7M1UnmvPbev9AQTY43LZ7Dzr8qB/a7KnXBLPcB0w3yOLONM+ke3i28EY+4vKqHU5b4YHoGXPpFKb5brqQOwghcVpvkwoIUvrS7NsENeNg85ILu5zeJQ9sZYDU4dxl4/Sr7Ib2nQyzzxPQZkKQjpMFVcm0nCAZkWsCJ3/4rD+Burau7jB/lMnGG4pED4sPISzRTdZ/sw6tct2Qr2DCQSFl6cEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7TxWldlxBlWN+icp3getWA2k+QyoJau780qYqpK2qE=;
 b=cFEBbaIcT+O8FMbWw8fBMej22yjY3lWnCa8I1sC9Ehx1df16vXCGBLEWU/b0O6JylTuU5y2bfWkXZ4rfuO3txnZwL1BxOJH3rCxxyiSHQskjfKqFfIzo57ywDGXwf7Vb0lyopYcMjMlLytELrm8O6SgECjN9lX84DSp0qRGQJXQ=
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 DM6PR11MB2539.namprd11.prod.outlook.com (2603:10b6:5:bf::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Thu, 26 Nov 2020 03:11:29 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::b554:409e:1838:bcdb]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::b554:409e:1838:bcdb%7]) with mapi id 15.20.3589.030; Thu, 26 Nov 2020
 03:11:28 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: RE: [PATCH] soundwire: master: use pm_runtime_set_active() on add
Thread-Topic: [PATCH] soundwire: master: use pm_runtime_set_active() on add
Thread-Index: AQHWwsZw+o5jrkJ/w0Obmf9CDIturKnYS6EAgAFrksA=
Date:   Thu, 26 Nov 2020 03:11:28 +0000
Message-ID: <DM6PR11MB4074BC35644527BA45C1CB3CFFF90@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20201124130742.10986-1-yung-chuan.liao@linux.intel.com>
 <20201125050528.GC8403@vkoul-mobl>
In-Reply-To: <20201125050528.GC8403@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [220.133.4.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb42419d-6768-412b-527d-08d891b8f7b6
x-ms-traffictypediagnostic: DM6PR11MB2539:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB253914FFEB74CC8845CE97E9FFF90@DM6PR11MB2539.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1dEe2CKuG+hMt+ASKTP12mObLalEgCh/aJLtXSNmwwlrSmj8w7uhlb/iPWANW9ciiDy/3AcMWb2h1Bje8bkQJyspuhQgrwKwJCVXNJv7kiPYHsR1rx2KINcLsJeCPsMth91HifNiSz8EHWE84UWufsQiUXAlB34OrvU+lHRHUw04k0Fq/OqG9JDWBMW7HVJsi3LvQAqZyyWLWWeUtE+cSoP4PxMwstE+h9sR3s4okiHIDaDB8alk6meeLSiCBKaboq73Ae2VpOrLnN583YxbxBAhvDqYzoVKnTrEptpTL8BjTsrEk+bZwfYKwgr88aRd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(76116006)(8936002)(110136005)(5660300002)(66476007)(54906003)(33656002)(71200400001)(9686003)(7696005)(2906002)(86362001)(55016002)(52536014)(66946007)(478600001)(8676002)(64756008)(316002)(66446008)(186003)(4326008)(83380400001)(53546011)(6506007)(26005)(7416002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Wq6/giSk3ScAkeLk8kzNgJoAX13YoyonLd6MN30nWkTxnOTH+2BA2Skb3/KJ?=
 =?us-ascii?Q?4QxNOY2/yxgOgjy/Lepsg9icp5K7g/jXBeFv4X4f5X31XJGGJNUelciyDo26?=
 =?us-ascii?Q?JFfI5vVwS/JJK7wtHgbbMReit63Na7GMOYdd01VKMDapbtAWMw1SfgZCnETl?=
 =?us-ascii?Q?v7GrRPHYF+jMOmZ3szohSVDBEk6Y0LoYG7t/PQCH9gY8bhk01+CKZ2jZlxVe?=
 =?us-ascii?Q?vS2oJ+bCz3OpSZEOR1h8UUlkymk1HUSseM9lipZzq3GFOZs0gdvTFuDtf4rA?=
 =?us-ascii?Q?JjzLwSUr6krfk5a8yKWRnGyUdhLi2vhOOOxraKA2XvQnB9Qpl7wOhYQhiHwT?=
 =?us-ascii?Q?M21kxURlYrlTbwT/zuSgsxbUdhV1jhrB0L56WVBLCq3ajN9XJiRu1HksuAdy?=
 =?us-ascii?Q?G7Q6X0UVLB8A0zpOETW1FqDtTYxW/Us3OKNecMEiwVh3mmv0ZbSfHHjlNQot?=
 =?us-ascii?Q?NWnkZ365dXS26k5fWDjA8Raisn4eXnmh9p5fEPqqd9pIAiUugs5BtFHkSvbr?=
 =?us-ascii?Q?wZohQ9bV5/cm+At4GLq1G5MpLB7IPWNnC/6giOKtVCXNJeDsEWkpk8K/ZiqG?=
 =?us-ascii?Q?u3iHwASVw0RUwVO5XaFb+ZNxtQXM/WGzsH0btXjbdGGtUJjVW/6+GAlUXQJH?=
 =?us-ascii?Q?ctA+uYt+zvM19pJHVawKHDo4HkyGekQgZ+JE30gqloQgN+oyTbhCZACez1Ei?=
 =?us-ascii?Q?6BiuY6BGp+7dvqO7Fbt0FgGf4XfnE4eb/ZJCMKn6LERhnKJpNU5kaxj+yLyc?=
 =?us-ascii?Q?qRa/OrfjzO1noJt7KN+F4uYB1bHgWbquGHqEvYjtjvblRKxWdYrfFv5vjVmR?=
 =?us-ascii?Q?5fd7rK4VlkWVsbKewzjMXYnxnCeoNyZwHdKhZxArxftizDwjKZeJA/3tua0A?=
 =?us-ascii?Q?DO3RPMcQnZhgl74hcAsNsM/i95XgMnSTzysAVc9aVTtzFqrNjmAOLdZSLv2y?=
 =?us-ascii?Q?RGAmEomlN5TcDGdBxGB5RCowknUC2FcdmJJSNrosisg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb42419d-6768-412b-527d-08d891b8f7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 03:11:28.7486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foL9KfhtvykAfr+ERu6z8vYfPznBKJVyi0p9D2Crf/WOSwR8xfbwwgBhKbnANkHHlHheRQTA5aFa55R2cHQRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2539
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, November 25, 2020 1:05 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> gregkh@linuxfoundation.org; jank@cadence.com;
> srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>; =
Lin,
> Mengdong <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH] soundwire: master: use pm_runtime_set_active() on
> add
>=20
> On 24-11-20, 21:07, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >
> > The 'master' device acts as a glue layer used during bus
> > initialization only, and it needs to be 'transparent' for pm_runtime
> > management. Its behavior should be that it becomes active when one of
> > its children becomes active, and suspends when all of its children are
> > suspended.
> >
> > In our tests on Intel platforms, we routinely see these sort of
> > warnings on the initial boot:
> >
> > [ 21.447345] rt715 sdw:3:25d:715:0: runtime PM trying to activate
> > child device sdw:3:25d:715:0 but parent (sdw-master-3) is not active
> >
> > This is root-caused to a missing setup to make the device 'active' on
> > probe. Since we don't want the device to remain active forever after
> > the probe, the autosuspend configuration is also enabled at the end of
> > the probe - the device will actually autosuspend only in the case
> > where there are no devices physically attached. In practice, the
> > master device will suspend when all its children are no longer active.
> >
> > Fixes: bd84256e86ecf ('soundwire: master: enable pm runtime')
> > Signed-off-by: Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > ---
> >  drivers/soundwire/master.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
> > index 3488bb824e84..9b05c9e25ebe 100644
> > --- a/drivers/soundwire/master.c
> > +++ b/drivers/soundwire/master.c
> > @@ -8,6 +8,15 @@
> >  #include <linux/soundwire/sdw_type.h>  #include "bus.h"
> >
> > +/*
> > + * The 3s value for autosuspend will only be used if there are no
> > + * devices physically attached on a bus segment. In practice enabling
> > + * the bus operation will result in children devices become active
> > +and
> > + * the master device will only suspend when all its children are no
> > + * longer active.
> > + */
> > +#define SDW_MASTER_SUSPEND_DELAY_MS 3000
> > +
> >  /*
> >   * The sysfs for properties reflects the MIPI description as given
> >   * in the MIPI DisCo spec
> > @@ -154,7 +163,12 @@ int sdw_master_device_add(struct sdw_bus *bus,
> struct device *parent,
> >  	bus->dev =3D &md->dev;
> >  	bus->md =3D md;
> >
> > +	pm_runtime_set_autosuspend_delay(&bus->md->dev,
> SDW_MASTER_SUSPEND_DELAY_MS);
> > +	pm_runtime_use_autosuspend(&bus->md->dev);
> > +	pm_runtime_mark_last_busy(&bus->md->dev);
> > +	pm_runtime_set_active(&bus->md->dev);
> >  	pm_runtime_enable(&bus->md->dev);
> > +	pm_runtime_idle(&bus->md->dev);
>=20
> I understand that this needs to be done somewhere but is the core the rig=
ht
> place. In intel case it maybe a dummy device but other controllers are re=
al
> devices and may not support pm.
>=20
> I think better idea would be to do this in respective driver.. that way i=
t
> would be an opt-in for device supporting pm.

Should it be put in the same place as pm_runtime_enable?
IMHO, pm_runtime_enable is in the core already and it seems to be harmless
for devices which don't support pm. And pm can still be optional on md's
parent device.


>=20
> Thanks
> --
> ~Vinod

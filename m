Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B56240206
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgHJGhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 02:37:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:60676 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgHJGhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:37:01 -0400
IronPort-SDR: jXcnSC8rdbQOKBQ3JInjrmlc0d0Wi9Pet8B9LV2+6xUdQS5VENkSbcjxNYXEv6+ojWRQ6XRFBa
 bJqL5wDl611w==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="171526513"
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="171526513"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 23:36:59 -0700
IronPort-SDR: ky81klgMQu9DY/wSeEWf7JCZeAJ/JIeMCfhMSwTYmkGjHDRIXp/NOn3AbwFYLdqlihJs+MJorf
 0k5bXjeudRXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="277201221"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2020 23:36:59 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 9 Aug 2020 23:36:58 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 9 Aug 2020 23:36:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 9 Aug 2020 23:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz8c4d6M46WdF92JQhyhoA6RwgtZhy+2qZ/ClL0MIvtkW9OcDm4exUD9Gs7axz+nzZWO3ziuf1kasUqOcJEL8Bd3YIGyEGYWCGJV7R/NV+bUcfaDbWfJIVEEI2mr+QCIlAGCRy4a515NECucYnRh7NAxVVJTZ7DZES7RiXNyx/bEhcx+H8PHF6lF0+QLlX7hmKjbs9DwSos1tDRWBeiHxPue8ZVKIUMPMKnvxYa5HbWNNljGNMMlA/drn8nyf7cv0Q5FY7VxLQo216+3+M39c8+h6cz2oKweRHYSlOUtoRk9oH/veBNc7/7WhREHXwdPLtIeXHfVkVtGW6JM2E/g6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5WWQbKvIPTz7Wooj8BQwO+ucLWpix6f+dY5NuDjw9Y=;
 b=aMYuWPLBjJe5lwK5SljXXdfWjUiHNPAkPhkkIsOD0ojaeqmTrQ1Z/Z1CHSFmV/JaO8RwW8m5pGdqH6TPVT7mEJpmR+/qtUX875gzEftCW4+xjSDiEM1dQ9qqT6+Maiphca2CDRRGNRAun8EBlpg/gr1O4P2NY3P9tdJmOQEM79sVWgnE6bVC+IcPDGuakMWHeQfaaq1JLDtzE0eh0s8WpIfWthIWrFiDx0gVCZAE96FhMu+x/P4rj4pQ1p3Oeic65CTdGxB6hWugba9Rn7/mnauwwnc2lIaEOXJ8iKkachCsw1e+q4LxazhdwWqu2n74xeNC6Qkvt0sNf5ClE8uIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5WWQbKvIPTz7Wooj8BQwO+ucLWpix6f+dY5NuDjw9Y=;
 b=OIY3iyJDnOx/HWARngcbOuVsOIFyYONmhV0hLGWWjqSUgLi4yv5RJ9rrbc6xQBGl7g5PZgeaZtjX7Vy5f4CzNlqMysdsSS6N5xzhkUM29KpoMz1evw9LyXicCc0nDUb7sZ7iz3eNU5wsNqM7cR972AR5gMEv+HMznArd1pcGFX4=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3913.namprd11.prod.outlook.com (2603:10b6:5:193::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Mon, 10 Aug
 2020 06:36:45 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 06:36:45 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v4 3/4] fpga: dfl: create a dfl bus type to support DFL
 devices
Thread-Topic: [PATCH v4 3/4] fpga: dfl: create a dfl bus type to support DFL
 devices
Thread-Index: AQHWbsBfCMkFdjAqdEmc0Wr7wZ+Ib6kw2iPQ
Date:   Mon, 10 Aug 2020 06:36:44 +0000
Message-ID: <DM6PR11MB3819E2036BA04CC8B89FDB0C85440@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-4-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1597027273-25288-4-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6202eba6-68fc-42e4-e4c8-08d83cf7c014
x-ms-traffictypediagnostic: DM6PR11MB3913:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB39130E1FBFB21EFBF5FD270185440@DM6PR11MB3913.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzVTuwBfGL+A4XVuRJRCTkUThi4h61ZgGkYA+7f5+ann4Nox/XrjczAQohBvEoSjGRRuqGEJzVfdb2LmcILJPlHK+wMGGUCgujzcX6pff+CkBu5P5YA46g+tKU9Au92RNsOaqR9PrpjBocuxqokZc/5DYa91qG/G7RyYpOt+4jPGlUUFksrPPFcUZDzRPadlzBKcKImkHDu6/06N1e3RZkXCQ7CLYPgWFzAIRcest6+JL6UMYLZHFHu7EQZL5YghnMuogGEUvvWE9D2gb6jfrirAiiCDnc8IUfrH6gjfRxyo5NKGXZmD/WfVv8sBH6ywk6MbIrrpES729KmE/OckFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(186003)(55016002)(9686003)(8936002)(33656002)(26005)(4326008)(52536014)(30864003)(110136005)(86362001)(5660300002)(54906003)(6506007)(7696005)(8676002)(316002)(66476007)(66556008)(64756008)(66446008)(71200400001)(478600001)(76116006)(66946007)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6zuebmNC9WjihndCF9T41WHxy2eCdIc4XoWGv4Xv/kwyTEqb3HgbZlE/I1zJGAV6V/OXNlyjxXskcLu4MeFldTnqRWnAXlBpNHHjo6saxTMmpqY+zv6HB5GxiPL6YS3+VYLREF0Vk8pkCn91UYa025Qichj1r+XaIUCTbQwunmEp0jZz7h3Me2VfP2EsRb/eBcg1nMSkYJjQ+YSIB5zewvfOapZ+xGFUPkVdm8hafvj63F3uaYjt9x91598oVxbwPu+XnfxRryDEhY166B4sVqCducY35kRvwJpYMXY8dPFBO1VNgzu3/Et3MikcqLor4zDsFmaPC3VW3T0khaTSIS+EgPaehnGK9jP98YiMIrrIweIbJTdBOldtEuFho48Qqxup1Iwu8ICihg9L7M8Pe8vZEAOgLa9ZWl/1IqzV6FLyzvtAcxGAD9X85Lj1wpPLwvHyzUxC+VBwdk+LSJB9ELBtvvrn/aKBZrVFLM8TQCiGoBQY7f8pQ46B8+0fYNbHcextF+jOthEMmRa4kJHwcSTV1TD/bZ42/fXg7EQ1lQtZOW++siXdvj0ic3HhL86W7kO7W0wKODj6kv0vqD5+x39kdHJnkAHa00zRArgNzm/zHJ1eQ+nXmitdHQwto0Z9RRmtlguAzoxryYgA3FlMFg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6202eba6-68fc-42e4-e4c8-08d83cf7c014
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 06:36:44.9269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8EAwoXBlQbRp+GdToTis0/bg23ZWiumL/6X+B8VZqqAXPZMufwFVraMtLWAkk6wuAEWHLxVMSgbf375pKnHxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3913
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> A new bus type "dfl" is introduced for private features which are not
> initialized by DFL feature drivers (dfl-fme & dfl-afu drivers). So these
> private features could be handled by separate driver modules.
>=20
> DFL feature drivers (dfl-fme, dfl-port) will create DFL devices on
> enumeration. DFL drivers could be registered on this bus to match these
> DFL devices. They are matched by dfl type & feature_id.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: change the bus uevent format.
>     change the dfl device's sysfs name format.
>     refactor dfl_dev_add().
>     minor fixes for comments from Hao and Tom.
> v3: no change.
> v4: improve the uevent format, 4 bits for type & 12 bits for id.
>     change dfl_device->type to u8.
>     A dedicate field in struct dfl_feature for dfl device instance.
>     error out if dfl_device already exist on dfl_devs_init().
> ---
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl.c                      | 263 ++++++++++++++++++++++++++=
+++++-
>  drivers/fpga/dfl.h                      |  85 +++++++++++
>  3 files changed, 355 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl
> b/Documentation/ABI/testing/sysfs-bus-dfl
> new file mode 100644
> index 0000000..4d74cc0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/dfl/devices/dfl_dev.X/type
> +Date:		July 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns type of DFL FIU of the device. Now DF=
L
> +		supports 2 FIU types, 0 for FME, 1 for PORT.
> +		Format: 0x%x
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> +Date:		July 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns feature identifier local to its DFL F=
IU
> +		type.
> +		Format: 0x%x
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b5257d7..51cef85 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -30,12 +30,6 @@ static DEFINE_MUTEX(dfl_id_mutex);
>   * index to dfl_chardevs table. If no chardev support just set devt_type
>   * as one invalid index (DFL_FPGA_DEVT_MAX).
>   */
> -enum dfl_id_type {
> -	FME_ID,		/* fme id allocation and mapping */
> -	PORT_ID,	/* port id allocation and mapping */
> -	DFL_ID_MAX,
> -};
> -
>  enum dfl_fpga_devt_type {
>  	DFL_FPGA_DEVT_FME,
>  	DFL_FPGA_DEVT_PORT,
> @@ -250,6 +244,245 @@ int dfl_fpga_check_port_id(struct platform_device
> *pdev, void *pport_id)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>=20
> +static DEFINE_IDA(dfl_device_ida);
> +
> +static const struct dfl_device_id *
> +dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device
> *ddev)
> +{
> +	if (id->type =3D=3D ddev->type && id->feature_id =3D=3D ddev->feature_i=
d)
> +		return id;
> +
> +	return NULL;
> +}
> +
> +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(drv);
> +	const struct dfl_device_id *id_entry =3D ddrv->id_table;
> +
> +	if (id_entry) {
> +		while (id_entry->feature_id) {
> +			if (dfl_match_one_device(id_entry, ddev)) {
> +				ddev->id_entry =3D id_entry;
> +				return 1;
> +			}
> +			id_entry++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_probe(struct device *dev)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(dev->driver);
> +
> +	return ddrv->probe(ddev);
> +}
> +
> +static int dfl_bus_remove(struct device *dev)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(dev->driver);
> +
> +	if (ddrv->remove)
> +		ddrv->remove(ddev);
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *en=
v)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +
> +	/* The type has 4 valid bits and feature_id has 12 valid bits */
> +	return add_uevent_var(env, "MODALIAS=3Ddfl:t%01Xf%03X",
> +			      ddev->type, ddev->feature_id);
> +}
> +
> +/* show dfl info fields */
> +#define dfl_info_attr(field, format_string)				\
> +static ssize_t								\
> +field##_show(struct device *dev, struct device_attribute *attr,
> 	\
> +	     char *buf)							\
> +{									\
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);			\
> +									\
> +	return sprintf(buf, format_string, ddev->field);		\
> +}									\
> +static DEVICE_ATTR_RO(field)
> +
> +dfl_info_attr(type, "0x%x\n");
> +dfl_info_attr(feature_id, "0x%x\n");
> +
> +static struct attribute *dfl_dev_attrs[] =3D {
> +	&dev_attr_type.attr,
> +	&dev_attr_feature_id.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(dfl_dev);
> +
> +static struct bus_type dfl_bus_type =3D {
> +	.name		=3D "dfl",
> +	.match		=3D dfl_bus_match,
> +	.probe		=3D dfl_bus_probe,
> +	.remove		=3D dfl_bus_remove,
> +	.uevent		=3D dfl_bus_uevent,
> +	.dev_groups	=3D dfl_dev_groups,
> +};
> +
> +static void release_dfl_dev(struct device *dev)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +
> +	if (ddev->mmio_res.parent)
> +		release_resource(&ddev->mmio_res);
> +
> +	ida_simple_remove(&dfl_device_ida, ddev->id);
> +	kfree(ddev->irqs);
> +	kfree(ddev);
> +}
> +
> +static struct dfl_device *
> +dfl_dev_add(struct dfl_feature_platform_data *pdata,
> +	    struct dfl_feature *feature)
> +{
> +	struct platform_device *pdev =3D pdata->dev;
> +	struct resource *parent_res;
> +	struct dfl_device *ddev;
> +	int id, i, ret;
> +
> +	ddev =3D kzalloc(sizeof(*ddev), GFP_KERNEL);
> +	if (!ddev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	id =3D ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		dev_err(&pdev->dev, "unable to get id\n");
> +		kfree(ddev);
> +		return ERR_PTR(id);
> +	}
> +
> +	/* freeing resources by put_device() after device_initialize() */
> +	device_initialize(&ddev->dev);
> +	ddev->dev.parent =3D &pdev->dev;
> +	ddev->dev.bus =3D &dfl_bus_type;
> +	ddev->dev.release =3D release_dfl_dev;
> +	ddev->id =3D id;
> +	ret =3D dev_set_name(&ddev->dev, "dfl_dev.%d", id);
> +	if (ret)
> +		goto put_dev;
> +
> +	ddev->type =3D feature_dev_id_type(pdev);
> +	ddev->feature_id =3D feature->id;
> +	ddev->cdev =3D pdata->dfl_cdev;
> +
> +	/* add mmio resource */
> +	parent_res =3D &pdev->resource[feature->resource_index];
> +	ddev->mmio_res.flags =3D IORESOURCE_MEM;
> +	ddev->mmio_res.start =3D parent_res->start;
> +	ddev->mmio_res.end =3D parent_res->end;
> +	ddev->mmio_res.name =3D dev_name(&ddev->dev);

It doesn't reuse the pdev->resource only because it wants a more proper nam=
e
here?

> +	ret =3D insert_resource(parent_res, &ddev->mmio_res);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> +			dev_name(&ddev->dev), &ddev->mmio_res);
> +		goto put_dev;
> +	}
> +
> +	/* then add irq resource */
> +	if (feature->nr_irqs) {
> +		ddev->irqs =3D kcalloc(feature->nr_irqs,
> +				     sizeof(*ddev->irqs), GFP_KERNEL);
> +		if (!ddev->irqs) {
> +			ret =3D -ENOMEM;
> +			goto put_dev;
> +		}
> +
> +		for (i =3D 0; i < feature->nr_irqs; i++)
> +			ddev->irqs[i] =3D feature->irq_ctx[i].irq;
> +
> +		ddev->num_irqs =3D feature->nr_irqs;
> +	}
> +
> +	ret =3D device_add(&ddev->dev);
> +	if (ret)
> +		goto put_dev;
> +
> +	dev_info(&pdev->dev, "add dfl_dev: %s\n", dev_name(&ddev->dev));
> +	return ddev;
> +
> +put_dev:
> +	/* calls release_dfl_dev() which does the clean up  */
> +	put_device(&ddev->dev);
> +	return ERR_PTR(ret);
> +}
> +
> +static void dfl_devs_uinit(struct dfl_feature_platform_data *pdata)
> +{
> +	struct dfl_feature *feature;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (feature->ddev) {
> +			device_unregister(&feature->ddev->dev);
> +			feature->ddev =3D NULL;
> +		}
> +	}
> +}
> +
> +static int dfl_devs_init(struct platform_device *pdev)
> +{
> +	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature *feature;
> +	struct dfl_device *ddev;
> +	int ret;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (feature->ioaddr)
> +			continue;
> +
> +		if (feature->ddev) {
> +			ret =3D -EBUSY;

or -EEXIST

> +			goto err;
> +		}
> +
> +		ddev =3D dfl_dev_add(pdata, feature);
> +		if (IS_ERR(ddev)) {
> +			ret =3D PTR_ERR(ddev);
> +			goto err;
> +		}
> +
> +		feature->ddev =3D ddev;
> +	}
> +
> +	return 0;
> +
> +err:
> +	dfl_devs_uinit(pdata);
> +	return ret;
> +}
> +
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *own=
er)
> +{
> +	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +		return -EINVAL;
> +
> +	dfl_drv->drv.owner =3D owner;
> +	dfl_drv->drv.bus =3D &dfl_bus_type;
> +
> +	return driver_register(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(__dfl_driver_register);
> +
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv)
> +{
> +	driver_unregister(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(dfl_driver_unregister);
> +
>  #define is_header_feature(feature) ((feature)->id =3D=3D
> FEATURE_ID_FIU_HEADER)
>=20
>  /**
> @@ -261,12 +494,15 @@ void dfl_fpga_dev_feature_uinit(struct
> platform_device *pdev)
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	struct dfl_feature *feature;
>=20
> -	dfl_fpga_dev_for_each_feature(pdata, feature)
> +	dfl_devs_uinit(pdata);

Or it's better to rename as dfl_devs_remove(pdata) or something?

> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>  		if (feature->ops) {
>  			if (feature->ops->uinit)
>  				feature->ops->uinit(pdev, feature);
>  			feature->ops =3D NULL;
>  		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
>=20
> @@ -347,6 +583,10 @@ int dfl_fpga_dev_feature_init(struct
> platform_device *pdev,
>  		drv++;
>  	}
>=20
> +	ret =3D dfl_devs_init(pdev);
> +	if (ret)
> +		goto exit;
> +
>  	return 0;
>  exit:
>  	dfl_fpga_dev_feature_uinit(pdev);
> @@ -1282,11 +1522,17 @@ static int __init dfl_fpga_init(void)
>  {
>  	int ret;
>=20
> +	ret =3D bus_register(&dfl_bus_type);
> +	if (ret)
> +		return ret;
> +
>  	dfl_ids_init();
>=20
>  	ret =3D dfl_chardev_init();
> -	if (ret)
> +	if (ret) {
>  		dfl_ids_destroy();
> +		bus_unregister(&dfl_bus_type);
> +	}
>=20
>  	return ret;
>  }
> @@ -1624,6 +1870,7 @@ static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
>  	dfl_ids_destroy();
> +	bus_unregister(&dfl_bus_type);
>  }
>=20
>  module_init(dfl_fpga_init);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5973769..d7fd03a 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -246,6 +246,7 @@ struct dfl_feature {
>  	struct dfl_feature_irq_ctx *irq_ctx;
>  	unsigned int nr_irqs;
>  	const struct dfl_feature_ops *ops;
> +	struct dfl_device *ddev;

Add some description please.

>  	void *priv;
>  };
>=20
> @@ -514,4 +515,88 @@ long dfl_feature_ioctl_set_irq(struct
> platform_device *pdev,
>  			       struct dfl_feature *feature,
>  			       unsigned long arg);
>=20
> +/**
> + * enum dfl_id_type - define the DFL FIU types
> + */
> +enum dfl_id_type {
> +	FME_ID,
> +	PORT_ID,
> +	DFL_ID_MAX,
> +};
> +
> +/**
> + * struct dfl_device_id -  dfl device identifier
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.

Only 4 bits used.

Hao

> + * @feature_id: contains 12 bits feature identifier local to its DFL FIU=
 type.
> + * @driver_data: Driver specific data
> + */
> +struct dfl_device_id {
> +	u8 type;
> +	u16 feature_id;
> +	unsigned long driver_data;
> +};
> +
> +/**
> + * struct dfl_device - represent an dfl device on dfl bus
> + *
> + * @dev: Generic device interface.
> + * @id: id of the dfl device
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @mmio_res: MMIO resource of this dfl device.
> + * @irqs: List of Linux IRQ numbers of this dfl device.
> + * @num_irqs: number of IRQs supported by this dfl device.
> + * @cdev: pointer to DFL FPGA container device this dfl device belongs t=
o.
> + * @id_entry: matched id entry in dfl driver's id table.
> + */
> +struct dfl_device {
> +	struct device dev;
> +	int id;
> +	u8 type;
> +	u16 feature_id;
> +	struct resource mmio_res;
> +	int *irqs;
> +	unsigned int num_irqs;
> +	struct dfl_fpga_cdev *cdev;
> +	const struct dfl_device_id *id_entry;
> +};
> +
> +/**
> + * struct dfl_driver - represent an dfl device driver
> + *
> + * @drv: Driver model structure.
> + * @id_table: Pointer to table of device IDs the driver is interested in=
.
> + *	      { } member terminated.
> + * @probe: Mandatory callback for device binding.
> + * @remove: Callback for device unbinding.
> + */
> +struct dfl_driver {
> +	struct device_driver drv;
> +	const struct dfl_device_id *id_table;
> +
> +	int (*probe)(struct dfl_device *dfl_dev);
> +	void (*remove)(struct dfl_device *dfl_dev);
> +};
> +
> +#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> +#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> +
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE
> + */
> +#define dfl_driver_register(drv) \
> +	__dfl_driver_register(drv, THIS_MODULE)
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *own=
er);
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> +
> +/*
> + * module_dfl_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_dfl_driver(__dfl_driver) \
> +	module_driver(__dfl_driver, dfl_driver_register, \
> +		      dfl_driver_unregister)
> +
>  #endif /* __FPGA_DFL_H */
> --
> 2.7.4


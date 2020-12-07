Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98DA2D0940
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 03:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgLGC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 21:56:09 -0500
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:56126 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbgLGC4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:56:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2B01B180A7FDB;
        Mon,  7 Dec 2020 02:55:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3868:4321:5007:6737:8660:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12679:12740:12895:13019:13148:13161:13229:13230:13439:13894:14181:14659:14721:21080:21433:21627:21795:21939:21987:21990:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: food65_0413041273da
X-Filterd-Recvd-Size: 4763
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Dec 2020 02:55:24 +0000 (UTC)
Message-ID: <b23bffa8810b3f80bf4cbc8b654f3d73a3b6a2ce.camel@perches.com>
Subject: Re: [PATCH 21/22] xlink-core: add async channel and events
From:   Joe Perches <joe@perches.com>
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Seamus Kelly <seamus.kelly@intel.com>
Date:   Sun, 06 Dec 2020 18:55:23 -0800
In-Reply-To: <20201201223511.65542-22-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-22-mgross@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 14:35 -0800, mgross@linux.intel.com wrote:
> Enable asynchronous channel and event communication.
[]
> diff --git a/drivers/misc/xlink-core/xlink-core.c b/drivers/misc/xlink-core/xlink-core.c
[]
> +
> +// sysfs attribute functions
> +
> +static ssize_t event0_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
> +	struct xlink_attr *a = &xlink_dev->eventx[0];
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
> +}
> +
> +static ssize_t event1_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
> +	struct xlink_attr *a = &xlink_dev->eventx[1];
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
> +}
> +
> +static ssize_t event2_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
> +	struct xlink_attr *a = &xlink_dev->eventx[2];
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
> +}
> +
> +static ssize_t event3_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
> +	struct xlink_attr *a = &xlink_dev->eventx[3];
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
> +}

These could use the sysfs_emit function and not scnprintf
and as well could use a single shared function with an index.

Something like:

static ssize_t eventx_show(struct device *dev, struct device_attr *attr, int index, char *buf)
{
	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
	struct xlink_attr *a = &xlink_dev->eventx[index];

	return sysfs_emit(buf, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
}

static ssize_t event0_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	return eventx_show(dev, attr, 0, buf);
}

etc...


> @@ -270,19 +353,23 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	struct xlinkconnect		con	= {0};
>  	struct xlinkrelease		rel	= {0};
>  	struct xlinkstartvpu		startvpu = {0};
> +	struct xlinkcallback		cb	= {0};
>  	struct xlinkgetdevicename	devn	= {0};
>  	struct xlinkgetdevicelist	devl	= {0};
>  	struct xlinkgetdevicestatus	devs	= {0};
>  	struct xlinkbootdevice		boot	= {0};
>  	struct xlinkresetdevice		res	= {0};
>  	struct xlinkdevmode		devm	= {0};
> +	struct xlinkregdevevent		regdevevent = {0};

Perhaps significantly less stack would be used if these declarations were
moved into the case blocks where used.  Less initialization would be done
per ioctl too.

> @@ -318,6 +405,30 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  		if (copy_to_user((void __user *)op.return_code, (void *)&rc, sizeof(rc)))
>  			return -EFAULT;
>  		break;
> +	case XL_DATA_READY_CALLBACK:
> +		if (copy_from_user(&cb, (void __user *)arg,
> +				   sizeof(struct xlinkcallback)))
> +			return -EFAULT;
> +		if (copy_from_user(&devh, (void __user *)cb.handle,
> +				   sizeof(struct xlink_handle)))
> +			return -EFAULT;
> +		CHANNEL_SET_USER_BIT(cb.chan); // set MSbit for user space call
> +		rc = xlink_data_available_event(&devh, cb.chan, cb.callback);
> +		if (copy_to_user((void __user *)cb.return_code, (void *)&rc, sizeof(rc)))
> +			return -EFAULT;
> +		break;

	case XL_DATA_READY_CALLBACK: {
		struct xlinkcallback cb	= {};
		etc...
		break;
	}




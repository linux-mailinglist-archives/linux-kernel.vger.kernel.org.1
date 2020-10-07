Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78FF285BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgJGJe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:34:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbgJGJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:34:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0979WR7c091040;
        Wed, 7 Oct 2020 05:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BWn1jSyUcjaFdH2uvbvHko17yFlogGhE2qWmz1b65jk=;
 b=nZJYPaYRmyI9q2M2Rl2aBxAroHH4Mn1FSgo3+AjpJj4EfCnAfe0ecXRPHoMIizjz97Zb
 kwqmh64oFG2atxVgo9HIRijPQEQt4gBSW6Kt2lHubQTD9dEBhw80qtJKp6gnv6aZF84s
 L6ljlGXDFxrJNOnRbN/5OeJ+t42Gzs6AI1eQGyXl+7WOu6thJ0ZeU2iznscRGwpOdJBN
 76XJJyezw5ndSREOuPBgNxAP7Pg23jAZza/e9Q3YVdV646XV2X6KsWFXKPYlFenfEXSg
 NFC3hUsA5fxRzgYdZiJ56DW9B1EPEunqf0IjNIpUV3OJw1lGyHYZ8pDFG8jvWd4H+5dy 9w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341awygcp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 05:34:23 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0979XHGM020881;
        Wed, 7 Oct 2020 09:34:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx8446a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 09:34:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0979YIqF32637384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Oct 2020 09:34:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2404CAE045;
        Wed,  7 Oct 2020 09:34:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A628CAE04D;
        Wed,  7 Oct 2020 09:34:17 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.175.219])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Oct 2020 09:34:17 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
To:     Stefan Haberland <sth@linux.ibm.com>, hch@lst.de
Cc:     axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519142259.102279-3-sth@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Message-ID: <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
Date:   Wed, 7 Oct 2020 11:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200519142259.102279-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_05:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19.05.20 16:22, Stefan Haberland wrote:
> The IBM partition parser requires device type specific information only
> available to the DASD driver to correctly register partitions. The
> current approach of using ioctl_by_bdev with a fake user space pointer
> is discouraged.
> 
> Fix this by replacing IOCTL calls with direct in-kernel function calls.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.

> ---
>  MAINTAINERS                     |  1 +
>  block/partitions/ibm.c          | 24 +++++++++++++++++------
>  drivers/s390/block/dasd_ioctl.c | 34 +++++++++++++++++++++++++++++++++
>  include/linux/dasd_mod.h        |  9 +++++++++
>  4 files changed, 62 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/dasd_mod.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1608ef8ce8d3..37f700187d74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14625,6 +14625,7 @@ S:	Supported
>  W:	http://www.ibm.com/developerworks/linux/linux390/
>  F:	block/partitions/ibm.c
>  F:	drivers/s390/block/dasd*
> +F:	include/linux/dasd_mod.h
>  
>  S390 IOMMU (PCI)
>  M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> index 073faa6a69b8..d6e18df9c53c 100644
> --- a/block/partitions/ibm.c
> +++ b/block/partitions/ibm.c
> @@ -13,10 +13,11 @@
>  #include <asm/ebcdic.h>
>  #include <linux/uaccess.h>
>  #include <asm/vtoc.h>
> +#include <linux/module.h>
> +#include <linux/dasd_mod.h>
>  
>  #include "check.h"
>  
> -
>  union label_t {
>  	struct vtoc_volume_label_cdl vol;
>  	struct vtoc_volume_label_ldl lnx;
> @@ -288,7 +289,9 @@ static int find_cms1_partitions(struct parsed_partitions *state,
>   */
>  int ibm_partition(struct parsed_partitions *state)
>  {
> +	int (*fn)(struct gendisk *disk, dasd_information2_t *info);
>  	struct block_device *bdev = state->bdev;
> +	struct gendisk *disk = bdev->bd_disk;
>  	int blocksize, res;
>  	loff_t i_size, offset, size;
>  	dasd_information2_t *info;
> @@ -299,24 +302,31 @@ int ibm_partition(struct parsed_partitions *state)
>  	union label_t *label;
>  
>  	res = 0;
> +	if (!disk->fops->getgeo)
> +		goto out_exit;
> +	fn = symbol_get(dasd_biodasdinfo);
> +	if (!fn)
> +		goto out_exit;
>  	blocksize = bdev_logical_block_size(bdev);
>  	if (blocksize <= 0)
> -		goto out_exit;
> +		goto out_symbol;
>  	i_size = i_size_read(bdev->bd_inode);
>  	if (i_size == 0)
> -		goto out_exit;
> +		goto out_symbol;
>  	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
>  	if (info == NULL)
> -		goto out_exit;
> +		goto out_symbol;
>  	geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL);
>  	if (geo == NULL)
>  		goto out_nogeo;
>  	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
>  	if (label == NULL)
>  		goto out_nolab;
> -	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
> +	/* set start if not filled by getgeo function e.g. virtblk */
> +	geo->start = get_start_sect(bdev);
> +	if (disk->fops->getgeo(bdev, geo))
>  		goto out_freeall;
> -	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
> +	if (fn(disk, info)) {
>  		kfree(info);
>  		info = NULL;
>  	}
> @@ -359,6 +369,8 @@ int ibm_partition(struct parsed_partitions *state)
>  	kfree(geo);
>  out_nogeo:
>  	kfree(info);
> +out_symbol:
> +	symbol_put(dasd_biodasdinfo);
>  out_exit:
>  	return res;
>  }
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 9b7782395c37..777734d1b4e5 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -22,6 +22,7 @@
>  #include <asm/schid.h>
>  #include <asm/cmb.h>
>  #include <linux/uaccess.h>
> +#include <linux/dasd_mod.h>
>  
>  /* This is ugly... */
>  #define PRINTK_HEADER "dasd_ioctl:"
> @@ -664,3 +665,36 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
>  	dasd_put_device(base);
>  	return rc;
>  }
> +
> +
> +/**
> + * dasd_biodasdinfo() - fill out the dasd information structure
> + * @disk [in]: pointer to gendisk structure that references a DASD
> + * @info [out]: pointer to the dasd_information2_t structure
> + *
> + * Provide access to DASD specific information.
> + * The gendisk structure is checked if it belongs to the DASD driver by
> + * comparing the gendisk->fops pointer.
> + * If it does not belong to the DASD driver -EINVAL is returned.
> + * Otherwise the provided dasd_information2_t structure is filled out.
> + *
> + * Returns:
> + *   %0 on success and a negative error value on failure.
> + */
> +int dasd_biodasdinfo(struct gendisk *disk, struct dasd_information2_t *info)
> +{
> +	struct dasd_device *base;
> +	int error;
> +
> +	if (disk->fops != &dasd_device_operations)
> +		return -EINVAL;
> +
> +	base = dasd_device_from_gendisk(disk);
> +	if (!base)
> +		return -ENODEV;
> +	error = __dasd_ioctl_information(base->block, info);
> +	dasd_put_device(base);
> +	return error;
> +}
> +/* export that symbol_get in partition detection is possible */
> +EXPORT_SYMBOL_GPL(dasd_biodasdinfo);
> diff --git a/include/linux/dasd_mod.h b/include/linux/dasd_mod.h
> new file mode 100644
> index 000000000000..d39abad2ff6e
> --- /dev/null
> +++ b/include/linux/dasd_mod.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef DASD_MOD_H
> +#define DASD_MOD_H
> +
> +#include <asm/dasd.h>
> +
> +extern int dasd_biodasdinfo(struct gendisk *disk, dasd_information2_t *info);
> +
> +#endif
> 

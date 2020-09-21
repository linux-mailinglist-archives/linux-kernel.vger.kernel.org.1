Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42088271ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIUJU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:20:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53846 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIUJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:20:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L99WGY084002;
        Mon, 21 Sep 2020 09:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=L5i8ibqvSC2T+FtuxAvNzRISxE4BuPvsixtdMaWSwaE=;
 b=Lm42xdenulALIZ4AlAjhd0+sjJLcYcAX3D/To+YscjKkExLzLwccbW1yR/mS9ZzILeVl
 LOGs+GSgzXgcdKlBjPR17RFk5hMGt20ELi6YJWqCR4D3OOWkJNolGg3BJz1MknWxsbep
 AXYr93mu+qgNBsEfQ/wVC5cE4k4IG+wK12BbHoYy4WUrNN9INHlf1NKVL4XuCuWQZOPL
 3EJGRRUi2eEDzj1NuX7TPx4Q+gAzcUAvQOOc1Pns9ztgiQIFW17VTopplhouL0Q3/2Dd
 rcBGp5xyJOp0xAJAZC6hrpiXNBxy32RMnpg+/ufZuUtNjLlFNmlA3Fc1l/AqJ2U/fhHr /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33n9xkmg0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 09:20:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L9BJfY155117;
        Mon, 21 Sep 2020 09:20:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nuwvse7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 09:20:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08L9Kcbo013575;
        Mon, 21 Sep 2020 09:20:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 02:20:38 -0700
Date:   Mon, 21 Sep 2020 12:20:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [CRM114spam]: drivers/hwmon/w83627ehf.c:2417 w83627ehf_probe()
 warn: 'res->start' not released on lines: 2412.
Message-ID: <20200921092029.GU18329@kadam>
References: <20200917094137.GL4282@kadam>
 <20200920174954.GA25438@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920174954.GA25438@gallifrey>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 06:49:54PM +0100, Dr. David Alan Gilbert wrote:
> * Dan Carpenter (dan.carpenter@oracle.com) wrote:
> > b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2405  
> > 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2406  	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> > 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2407  							 data->name,
> > 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2408  							 data,
> > 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2409  							 &w83627ehf_chip_info,
> > 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2410  							 w83627ehf_groups);
> > 08c79950a047db drivers/hwmon/w83627ehf.c     Rudolf Marek           2006-07-05  2411  
> > 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2412  	return PTR_ERR_OR_ZERO(hwmon_dev);
> >                                                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > This should be:
> > 
> > 	if (IS_ERR(hwmon_dev)) {
> > 		err = PTR_ERR(hwmon_dev);
> > 		goto exit_release;
> > 	}
> > 
> > 	return 0;
> 
> That looks about right to me; why don't you just submit that as a patch ?

These are automated emails sent from a bot.  I just look them over and
hit send.  A lot of the time they are for patches which aren't applied
to a git tree yet.

But in this case, sure I can send an email.  I looked at this one a bit
closely because it's a new warning that was only introduced last week.

regards,
dan carpenter


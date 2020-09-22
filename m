Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2716B273EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIVJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:53:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50648 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:53:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M9mtbK071259;
        Tue, 22 Sep 2020 09:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=euxC1QpbxpBKmFb/52Lm1dU/aMnRjWe/oheiZpVHIgE=;
 b=nqFxB6p4tNcKtGbikGMOU9f840oY4jptX2hYM5ASk3+8rXetnVVeQP+7Ez1JV/Jy6zuF
 utxxM4n/nZy2WMpLrynAcvaxeD54xCvojFLEHXehLkK3gn6vDlSxL7C251gU4g8a+EyU
 0FzY99hrV3zEosVHl4uruv4BF7Xbudd7fbP7FUIU0w9tbF5pOmntYbZTftPSd4+5zcvS
 qaUK7o4THvC/B29bTO7g4uM/qgXVeRz9c0q5k05YYKeP9+GnFzR9Z9lBNNK/fJlJU1bC
 ZDtVDPj4k1voQn5WSGhsyiWbT0D56RifG2e1pTUgwdZByhmk29H/vsjDzCfIJLZWjVwc 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33ndnubvyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 09:53:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M9kJvY193323;
        Tue, 22 Sep 2020 09:53:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33nujmyvkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 09:53:04 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08M9r2bq018565;
        Tue, 22 Sep 2020 09:53:02 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 02:53:02 -0700
Date:   Tue, 22 Sep 2020 12:52:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        jhubbard@nvidia.com, keescook@chromium.org,
        madhuparnabhowmik10@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix the missed put_device() for
 rio_mport_add_riodev
Message-ID: <20200922095255.GC18329@kadam>
References: <20200922072525.42330-1-jingxiangfeng@huawei.com>
 <20200922080426.GB18329@kadam>
 <5F69C18A.2070800@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F69C18A.2070800@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 05:19:06PM +0800, Jing Xiangfeng wrote:
> 
> 
> On 2020/9/22 16:04, Dan Carpenter wrote:
> > On Tue, Sep 22, 2020 at 03:25:25PM +0800, Jing Xiangfeng wrote:
> > > rio_mport_add_riodev() misses to call put_device() when the device
> > > already exists. Add the missed function call to fix it.
> > > 
> > Looks good.
> > 
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > I notice that rio_mport_del_riodev() has a related bug.
> > 
> >    1802          err = rio_add_device(rdev);
> >    1803          if (err)
> >    1804                  goto cleanup;
> >    1805          rio_dev_get(rdev);
> >                  ^^^^^^^^^^^^^^^^^
> > This calls get_device(&rdev->dev);
> > 
> >    1806
> >    1807          return 0;
> >    1808  cleanup:
> >    1809          kfree(rdev);
> >    1810          return err;
> >    1811  }
> >    1812
> >    1813  static int rio_mport_del_riodev(struct mport_cdev_priv *priv, void __user *arg)
> >    1814  {
> >    1815          struct rio_rdev_info dev_info;
> >    1816          struct rio_dev *rdev = NULL;
> >    1817          struct device  *dev;
> >    1818          struct rio_mport *mport;
> >    1819          struct rio_net *net;
> >    1820
> >    1821          if (copy_from_user(&dev_info, arg, sizeof(dev_info)))
> >    1822                  return -EFAULT;
> >    1823          dev_info.name[sizeof(dev_info.name) - 1] = '\0';
> >    1824
> >    1825          mport = priv->md->mport;
> >    1826
> >    1827          /* If device name is specified, removal by name has priority */
> >    1828          if (strlen(dev_info.name)) {
> >    1829                  dev = bus_find_device_by_name(&rio_bus_type, NULL,
> >    1830                                                dev_info.name);
> >    1831                  if (dev)
> >    1832                          rdev = to_rio_dev(dev);
> > 
> > This path takes a second get_device(&rdev->dev);
> > 
> >    1833          } else {
> >    1834                  do {
> >    1835                          rdev = rio_get_comptag(dev_info.comptag, rdev);
> >    1836                          if (rdev && rdev->dev.parent == &mport->net->dev &&
> >    1837                              rdev->destid == dev_info.destid &&
> >    1838                              rdev->hopcount == dev_info.hopcount)
> >    1839                                  break;
> > 
> > This path does not call get_device().
>  Add  calling rio_dev_get()  in this path? like the following changes:
> 
>  static int rio_mport_del_riodev(struct mport_cdev_priv *priv, void __user
> *arg)
>                         rdev = rio_get_comptag(dev_info.comptag, rdev);
>                         if (rdev && rdev->dev.parent == &mport->net->dev &&
>                             rdev->destid == dev_info.destid &&
> -                           rdev->hopcount == dev_info.hopcount)
> +                           rdev->hopcount == dev_info.hopcount) {
> +                               rio_dev_get(rdev);
>                                 break;
> +                       }

To be honest, I'm not sure how the rio_get_comptag() stuff is supposed
to work...  It probably requires some thought and testing.

Anyway, your patch is straight forward enough so let's just merge that
and hope someone with the hardware can take a look at this.

regards,
dan carpenter


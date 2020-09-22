Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B1273CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIVIEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:04:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIVIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:04:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M84dwP073465;
        Tue, 22 Sep 2020 08:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=M6GGCIzMM2JQm1SHxuewh7c+XdCDsbBYBVhLw6TeLvA=;
 b=cYqrCV2ToSuFdduguii5Ip0u+Ah+uw/icCkhfOv8kGTVgJpPEuixHcfDEGcDwqxG7Li6
 13A0ORUs6dgZ4bIX1PVDL30xJUv+0WBcqRyvY4xdWnrqxOecYWU3BZGYm0kitlX8UhPn
 R2PSArol1qd5rdWxmT9pBLsgAuraEraGlWM5SWAVFTJcAf1YS3h1wvd6OoGhaMhYMtAf
 TWeWEgPoSq2/Yw+rj7bUI+0VVjy5aAWbbLE0Wkm1En0mSJTF9n//piggwp+n5cSesO8Y
 4dcCcPDSVzBnJHDtt3TcJLu2FbC+MPyM0r4czfMcNHoCI+Zm8/GwVSDq1n6Qm/sVOMoq 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33ndnubajv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 08:04:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M83KON121690;
        Tue, 22 Sep 2020 08:04:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nuwxwe37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 08:04:36 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08M84Yna007638;
        Tue, 22 Sep 2020 08:04:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 01:04:34 -0700
Date:   Tue, 22 Sep 2020 11:04:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        jhubbard@nvidia.com, keescook@chromium.org,
        madhuparnabhowmik10@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix the missed put_device() for
 rio_mport_add_riodev
Message-ID: <20200922080426.GB18329@kadam>
References: <20200922072525.42330-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922072525.42330-1-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=2 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:25:25PM +0800, Jing Xiangfeng wrote:
> rio_mport_add_riodev() misses to call put_device() when the device
> already exists. Add the missed function call to fix it.
> 

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

I notice that rio_mport_del_riodev() has a related bug.

  1802          err = rio_add_device(rdev);
  1803          if (err)
  1804                  goto cleanup;
  1805          rio_dev_get(rdev);
                ^^^^^^^^^^^^^^^^^
This calls get_device(&rdev->dev);

  1806  
  1807          return 0;
  1808  cleanup:
  1809          kfree(rdev);
  1810          return err;
  1811  }
  1812  
  1813  static int rio_mport_del_riodev(struct mport_cdev_priv *priv, void __user *arg)
  1814  {
  1815          struct rio_rdev_info dev_info;
  1816          struct rio_dev *rdev = NULL;
  1817          struct device  *dev;
  1818          struct rio_mport *mport;
  1819          struct rio_net *net;
  1820  
  1821          if (copy_from_user(&dev_info, arg, sizeof(dev_info)))
  1822                  return -EFAULT;
  1823          dev_info.name[sizeof(dev_info.name) - 1] = '\0';
  1824  
  1825          mport = priv->md->mport;
  1826  
  1827          /* If device name is specified, removal by name has priority */
  1828          if (strlen(dev_info.name)) {
  1829                  dev = bus_find_device_by_name(&rio_bus_type, NULL,
  1830                                                dev_info.name);
  1831                  if (dev)
  1832                          rdev = to_rio_dev(dev);

This path takes a second get_device(&rdev->dev);

  1833          } else {
  1834                  do {
  1835                          rdev = rio_get_comptag(dev_info.comptag, rdev);
  1836                          if (rdev && rdev->dev.parent == &mport->net->dev &&
  1837                              rdev->destid == dev_info.destid &&
  1838                              rdev->hopcount == dev_info.hopcount)
  1839                                  break;

This path does not call get_device().

  1840                  } while (rdev);
  1841          }
  1842  
  1843          if (!rdev) {
  1844                  rmcd_debug(RDEV,
  1845                          "device name:%s ct:0x%x did:0x%x hc:0x%x not found",
  1846                          dev_info.name, dev_info.comptag, dev_info.destid,
  1847                          dev_info.hopcount);
  1848                  return -ENODEV;
  1849          }
  1850  
  1851          net = rdev->net;
  1852          rio_dev_put(rdev);

This drops a reference.

  1853          rio_del_device(rdev, RIO_DEVICE_SHUTDOWN);

This drops a second reference.  So presumably deleting by component tag
will lead to a use after free.

  1854  
  1855          if (list_empty(&net->devices)) {
  1856                  rio_free_net(net);
  1857                  mport->net = NULL;
  1858          }
  1859  
  1860          return 0;
  1861  }

regards,
dan carpenter

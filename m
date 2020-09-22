Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BFD273E66
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:19:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726489AbgIVJTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:19:15 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B6282F9DFDC43B78E195;
        Tue, 22 Sep 2020 17:19:12 +0800 (CST)
Received: from [10.174.178.248] (10.174.178.248) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 22 Sep
 2020 17:19:07 +0800
Subject: Re: [PATCH] rapidio: fix the missed put_device() for
 rio_mport_add_riodev
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20200922072525.42330-1-jingxiangfeng@huawei.com>
 <20200922080426.GB18329@kadam>
CC:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <akpm@linux-foundation.org>, <gustavoars@kernel.org>,
        <jhubbard@nvidia.com>, <keescook@chromium.org>,
        <madhuparnabhowmik10@gmail.com>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F69C18A.2070800@huawei.com>
Date:   Tue, 22 Sep 2020 17:19:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20200922080426.GB18329@kadam>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/22 16:04, Dan Carpenter wrote:
> On Tue, Sep 22, 2020 at 03:25:25PM +0800, Jing Xiangfeng wrote:
>> rio_mport_add_riodev() misses to call put_device() when the device
>> already exists. Add the missed function call to fix it.
>>
> Looks good.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> I notice that rio_mport_del_riodev() has a related bug.
>
>    1802          err = rio_add_device(rdev);
>    1803          if (err)
>    1804                  goto cleanup;
>    1805          rio_dev_get(rdev);
>                  ^^^^^^^^^^^^^^^^^
> This calls get_device(&rdev->dev);
>
>    1806
>    1807          return 0;
>    1808  cleanup:
>    1809          kfree(rdev);
>    1810          return err;
>    1811  }
>    1812
>    1813  static int rio_mport_del_riodev(struct mport_cdev_priv *priv, void __user *arg)
>    1814  {
>    1815          struct rio_rdev_info dev_info;
>    1816          struct rio_dev *rdev = NULL;
>    1817          struct device  *dev;
>    1818          struct rio_mport *mport;
>    1819          struct rio_net *net;
>    1820
>    1821          if (copy_from_user(&dev_info, arg, sizeof(dev_info)))
>    1822                  return -EFAULT;
>    1823          dev_info.name[sizeof(dev_info.name) - 1] = '\0';
>    1824
>    1825          mport = priv->md->mport;
>    1826
>    1827          /* If device name is specified, removal by name has priority */
>    1828          if (strlen(dev_info.name)) {
>    1829                  dev = bus_find_device_by_name(&rio_bus_type, NULL,
>    1830                                                dev_info.name);
>    1831                  if (dev)
>    1832                          rdev = to_rio_dev(dev);
>
> This path takes a second get_device(&rdev->dev);
>
>    1833          } else {
>    1834                  do {
>    1835                          rdev = rio_get_comptag(dev_info.comptag, rdev);
>    1836                          if (rdev && rdev->dev.parent == &mport->net->dev &&
>    1837                              rdev->destid == dev_info.destid &&
>    1838                              rdev->hopcount == dev_info.hopcount)
>    1839                                  break;
>
> This path does not call get_device().
  Add  calling rio_dev_get()  in this path? like the following changes:

  static int rio_mport_del_riodev(struct mport_cdev_priv *priv, void 
__user *arg)
                         rdev = rio_get_comptag(dev_info.comptag, rdev);
                         if (rdev && rdev->dev.parent == &mport->net->dev &&
                             rdev->destid == dev_info.destid &&
-                           rdev->hopcount == dev_info.hopcount)
+                           rdev->hopcount == dev_info.hopcount) {
+                               rio_dev_get(rdev);
                                 break;
+                       }
                 } while (rdev);
         }

>
>    1840                  } while (rdev);
>    1841          }
>    1842
>    1843          if (!rdev) {
>    1844                  rmcd_debug(RDEV,
>    1845                          "device name:%s ct:0x%x did:0x%x hc:0x%x not found",
>    1846                          dev_info.name, dev_info.comptag, dev_info.destid,
>    1847                          dev_info.hopcount);
>    1848                  return -ENODEV;
>    1849          }
>    1850
>    1851          net = rdev->net;
>    1852          rio_dev_put(rdev);
>
> This drops a reference.
>
>    1853          rio_del_device(rdev, RIO_DEVICE_SHUTDOWN);
>
> This drops a second reference.  So presumably deleting by component tag
> will lead to a use after free.
Indeed,  it  is a mismatched reference.
>
>    1854
>    1855          if (list_empty(&net->devices)) {
>    1856                  rio_free_net(net);
>    1857                  mport->net = NULL;
>    1858          }
>    1859
>    1860          return 0;
>    1861  }
>
> regards,
> dan carpenter
> .
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB22D5F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391661AbgLJPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:18:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42994 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgLJPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:17:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAFA2VI177131;
        Thu, 10 Dec 2020 15:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mhDEcViNkf52+zGizhWDgh+VrPyDtHLGaTXTeKk0xxQ=;
 b=iNI6HGHcpffdbrt5mkHtio+VjrZnJXNBPoodqf1b7BRUUoEIw/ss4LBh0Go3iQjeAI98
 g7paqNEv4hiccjtPDRyxWClpbtuwoYbYoig8wz85jRwpD81sIoGEBv4+9/+HBvqhRQBa
 SyofadJeZqLNWW2XxTuDiIvcJmuXsxckKregJiKzi86EjqNP0+Zuo1zklu5fC7PqtYK1
 /+ggKvt1rPfzE2QKuxvaLk7L5NVNxyt1U9ttpW/+uR/7N21XCQtk6c6u166yBgVCGogs
 Vh/HWzqYWyIrDWnxQIHzVOeBMp1W846+rVSDlhrnMWKhi/MrKXPLS+wkzb24J9vxK7Mw Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825mdwks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 15:16:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAF9pVm036710;
        Thu, 10 Dec 2020 15:16:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 358m52bf87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 15:16:41 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAFGcgI032409;
        Thu, 10 Dec 2020 15:16:39 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 07:16:38 -0800
Date:   Thu, 10 Dec 2020 18:16:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     shaojie.dong@isrc.iscas.ac.cn
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] staging: rtl8712: check register_netdev() return
 value
Message-ID: <20201210151631.GN2789@kadam>
References: <20201209150124.23446-1-shaojie.dong@isrc.iscas.ac.cn>
 <20201209174615.GI2767@kadam>
 <30d377fa.20bd.1764d2f9aa8.Coremail.shaojie.dong@isrc.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30d377fa.20bd.1764d2f9aa8.Coremail.shaojie.dong@isrc.iscas.ac.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=62
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=62 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:05:34PM +0800, shaojie.dong@isrc.iscas.ac.cn wrote:
> Hi
> 
> &gt; 
> &gt; This function should not be calling register_netdev().  What does that
> &gt; have to do with firmware?  It should also not free_netdev() because
> &gt; that will just lead to a use after free in the caller.
> &gt;
> 
> --&gt; check code history author<larry.finger@lwfinger.net> changed synchronous firmware loading to asynchronous firmware loading
>     before this change, register_netdev() was not calling in firmware related function.
>     For asynchronous loading, maybe register_netdev() be calling in rtl871x_load_fw_cb() is to ensure the netdev be registered after firmware loading completed
> 
> --&gt; for potential use after free issue
>     Could I only call "free_irq(adapter-&gt;pnetdev-&gt;irq, adapter-&gt;pnetdev)" when register_netdev() failed ?
>     If no need to change drivers/staging/rtl8712/hal_init.c file, I could give up my patch, thank you !
> 

Cleaning this up is a bit complicated and requires reworking the
firmware loading and it requires testing.  I don't think you have the
hardware to actually test this driver?  Probably, just leave this code
for another day.

regards,
dan carpenter


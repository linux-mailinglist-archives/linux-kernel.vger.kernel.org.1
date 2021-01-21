Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304292FE7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbhAUKax convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jan 2021 05:30:53 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2555 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbhAUKTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:19:16 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DLywf1qpSzW2x4;
        Thu, 21 Jan 2021 18:16:34 +0800 (CST)
Received: from dggpemm500010.china.huawei.com (7.185.36.134) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 21 Jan 2021 18:18:24 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm500010.china.huawei.com (7.185.36.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 18:18:24 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Thu, 21 Jan 2021 18:18:24 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
CC:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: RE: [PATCH] uacce: Add uacce_ctrl misc device
Thread-Topic: [PATCH] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW79ZyYq1sk039MU+9J2rOLgF+UaoxTpyAgACJurA=
Date:   Thu, 21 Jan 2021 10:18:24 +0000
Message-ID: <ea0511c1309a486d9646d5a32715c861@hisilicon.com>
References: <1611220154-90232-1-git-send-email-wangzhou1@hisilicon.com>
 <YAlNTSOMmsFPFAhk@kroah.com>
In-Reply-To: <YAlNTSOMmsFPFAhk@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.204]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, January 21, 2021 10:46 PM
> To: Wangzhou (B) <wangzhou1@hisilicon.com>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>; Arnd Bergmann <arnd@arndb.de>;
> linux-accelerators@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> chensihang (A) <chensihang1@hisilicon.com>
> Subject: Re: [PATCH] uacce: Add uacce_ctrl misc device
> 
> On Thu, Jan 21, 2021 at 05:09:14PM +0800, Zhou Wang wrote:
> > When IO page fault happens, DMA performance will be affected. Pin user page
> > can avoid IO page fault, this patch introduces a new char device named
> > /dev/uacce_ctrl to help to maintain pin/unpin pages. User space can do
> > pin/unpin pages by ioctls of an open file of /dev/uacce_ctrl, all pinned
> > pages under one file will be unpinned in file release process.
> 
> Also, what are you really trying to do here?  If you need to mess with
> memory pages, why can't the existing memory apis work properly for you?
> Please work with the linux-mm developers to resolve the issue using the
> standard apis and not creating a one-off char device node for this type
> of thing.

Basically the purpose is implementing a pinned memory poll for userspace
DMA to achieve better performance by removing io page fault.

I really like this can be done in generic mm code. Unfortunately there is no
this standard API in kernel to support userspace pin. Right now, various
subsystems depend on the ioctl of /dev/<name> to implement the pin, for example,
v4l2, gpu, infiniband, media etc.

I feel it is extremely hard to sell a standard mpin() API like mlock()
for this stage as mm could hardly buy this. And it will require
huge changes in kernel.
We need a way to manage what pages are pinned by process and ensure the
pages can be unpinned while the process is killed abnormally. otherwise,
memory gets leaked.
file_operations release() is a good entry for this kind of things. In
this way, we don't have to maintain the pinned page set in task_struct
and unpin them during exit().

If there is anything to make it better by doing this in a driver. I
would believe we could have a generic misc driver for pin like
vms_ballon.c for ballon. The driver doesn't have to bind with uacce.

In this way, the pinned memory pool implementation in userspace doesn't
need to depend on a specific uacce driver any more.

> 
> thanks,
> 
> greg k-h

Thanks
Barry


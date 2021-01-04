Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531722E91C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbhADIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:31:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48688 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbhADIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:31:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1048P1eH110632;
        Mon, 4 Jan 2021 08:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=nR2Q7mSO/Dz42tv8kKe3uN9e9+5MG7ulgrtXzjXMFLM=;
 b=LFp/dCsikFIToalyY/a7GLg62Szw1DakdsP3PtGO9MQr8esylHrCZwoI9Zf1wAeZ9gxr
 3weW92hNyLQwfQ//IKNPV/HWjY9MS+6PjA5u34akUYY7AxICwxg2T0vmE7acArJ5XlYe
 AAefa2H2XmKr3KPTiN4yo+55EdUmW2kHBbNZO8NJptQZ/AOYQMBewQe5GxVr0Vk+Oemk
 /3vTQb7IiF4xi7TDNmoMZm9fuIN1II8M9/gOGUyYXibGn1j3d74Wm/2fOslb2/Dtw3ao
 qwhyxdxBWLwWf7+ZhCY0J7/cbOYPRHziaUlrnbWPxAc8NhlHIhIHaQHq9TIUkYLh6+UJ lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35tebak8sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 08:30:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1048RJ9D186971;
        Mon, 4 Jan 2021 08:30:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 35uwsyucq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 08:30:59 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1048UwkR002047;
        Mon, 4 Jan 2021 08:30:58 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 08:30:07 +0000
Date:   Mon, 4 Jan 2021 11:29:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jon Mason <jdmason@kudzu.us>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ntb@googlegroups.com
Subject: Re: [GIT PULL] NTB bug fixes for v5.11
Message-ID: <20210104082948.GR2831@kadam>
References: <20201227141638.GA11393@athena.kudzu.us>
 <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 09:38:23AM -0800, Linus Torvalds wrote:
> On Sun, Dec 27, 2020 at 6:16 AM Jon Mason <jdmason@kudzu.us> wrote:
> >
> > Wang Qing (1):
> >       ntb: idt: fix error check in ntb_hw_idt.c
> 
> So this patch seems to be at least partially triggered by a smatch
> warning that is a bit questionable.
> 
> This part:
> 
>      if (IS_ERR_OR_NULL(dbgfs_topdir)) {
>          dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
> -        return PTR_ERR(dbgfs_topdir);
> +        return PTR_ERR_OR_ZERO(dbgfs_topdir);
>      }
> 
> works, but is very non-optimal and unnecessary.
> 
> The thing is, "PTR_ERR()" works just fine on a IS_ERR_OR_NULL pointer.
> It doesn't work on a _regular_ non-NULL and non-ERR pointer, and will
> return random garbage for those. But if you've tested for
> IS_ERR_OR_NULL(), then a regular PTR_ERR() is already fine.
> 
> And PTR_ERR_OR_ZERO() potentially generates an extraneous pointless
> tests against zero (to check for the ERR case).
> 
> A compiler may be able to notice that the PTR_ERR_OR_ZERO() is
> unnecessary and remove it (because of the IS_ERR_OR_NULL() checks),
> but in general we should assume compilers are "not stupid" rather than
> "really smart".
> 
> So while this patch isn't _wrong_, and I've already pulled it, the
> fact that apparently some smatch test triggers these pointless and
> potentially expensive patches is not a good idea.
> 
> I'm not sure what the smatch tests should be (NULL turns to 0, which
> may be confusing), but I'm cc'ing Dan in case he has ideas.
>

The most common bug that this check finds is the other part of that same
commit 91b8246de859 ("ntb: idt: fix error check in ntb_hw_idt.c"):

 	/* Allocate the memory for IDT NTB device data */
 	ndev = idt_create_dev(pdev, id);
-	if (IS_ERR_OR_NULL(ndev))
+	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);

idt_create_dev() never returns NULL, but if it did then we don't want
to return success.

For the debugfs stuff, the caller doesn't check the return value anyway.
Just make it a void function.  A lot of this debugfs code could be
simplified.  It's not a bug to pass an error pointer or a NULL dbgfs_topdir
pointer to debugfs_create_file().  There isn't any benefit in checking
debugfs_initialized().

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index e7a4c2aa8baa..710c17b2a923 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2504,28 +2504,14 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
  *
  * Return: zero on success, otherwise a negative error number.
  */
-static int idt_init_dbgfs(struct idt_ntb_dev *ndev)
+static void idt_init_dbgfs(struct idt_ntb_dev *ndev)
 {
 	char devname[64];
 
-	/* If the top directory is not created then do nothing */
-	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
-		dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
-		return PTR_ERR_OR_ZERO(dbgfs_topdir);
-	}
-
 	/* Create the info file node */
 	snprintf(devname, 64, "info:%s", pci_name(ndev->ntb.pdev));
 	ndev->dbgfs_info = debugfs_create_file(devname, 0400, dbgfs_topdir,
-		ndev, &idt_dbgfs_info_ops);
-	if (IS_ERR(ndev->dbgfs_info)) {
-		dev_dbg(&ndev->ntb.pdev->dev, "Failed to create DebugFS node");
-		return PTR_ERR(ndev->dbgfs_info);
-	}
-
-	dev_dbg(&ndev->ntb.pdev->dev, "NTB device DebugFS node created");
-
-	return 0;
+					       ndev, &idt_dbgfs_info_ops);
 }
 
 /*
@@ -2792,7 +2778,7 @@ static int idt_pci_probe(struct pci_dev *pdev,
 		goto err_deinit_isr;
 
 	/* Initialize DebugFS info node */
-	(void)idt_init_dbgfs(ndev);
+	idt_init_dbgfs(ndev);
 
 	/* IDT PCIe-switch NTB driver is finally initialized */
 	dev_info(&pdev->dev, "IDT NTB device is ready");
@@ -2904,9 +2890,7 @@ static int __init idt_pci_driver_init(void)
 {
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
-	/* Create the top DebugFS directory if the FS is initialized */
-	if (debugfs_initialized())
-		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	/* Register the NTB hardware driver to handle the PCI device */
 	return pci_register_driver(&idt_pci_driver);
-- 
2.29.2



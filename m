Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20172CD474
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgLCLUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:20:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47304 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgLCLUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:20:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3BJQqX038502;
        Thu, 3 Dec 2020 11:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yFSCKa3ntEPCTd+1M2c2TLYCFE/caMGOTfHMo/svBkk=;
 b=p2cAXdZsZ40/C7DztJIkXT9l/VVXU/iK2Ah5fCfQiKrwpPKEHDl+f3vSisHvlSG3x11W
 hd/F7AYIsc1xWY5cRQN5oo1/sktifz9Fl/scJNYHmO+w+8Ngqane6HE8P5nYhZcQqI0K
 acvPOiQ7IWdF0+Xs6Atk+wUEIX2IvSmXRSUZUp6PJBkHILtnOGoOqJ9rEqRgLv3w3JEy
 Ueu9Dcwlci1N9f4jxnhle/8IgR2UsSfkvLNhgpg5QWOe1FJP+JG6M7bkfoMc0/NhbD4o
 ElptF+27a2cfQaTQf7nBkxwB1C+a/WhXj7Vlr33+rWhvKunyMZKsOSj5GS2+K7cn4f3M Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 353egkw8xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 11:20:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3BGZj9184492;
        Thu, 3 Dec 2020 11:20:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35404qn0fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 11:20:03 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B3BK2io026245;
        Thu, 3 Dec 2020 11:20:02 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 03:20:01 -0800
Date:   Thu, 3 Dec 2020 14:19:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: arch/s390/pci/pci_event.c:101 __zpci_event_availability() error:
 we previously assumed 'zdev->zbus' could be null (see line 83)
Message-ID: <20201203111954.GK2789@kadam>
References: <20201203102759.GQ2767@kadam>
 <52b96642-f78c-478e-913d-b294c385c5ab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52b96642-f78c-478e-913d-b294c385c5ab@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:52:48AM +0100, Niklas Schnelle wrote:
> 
> 
> On 12/3/20 11:27 AM, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   3bb61aa61828499a7d0f5e560051625fd02ae7e4
> > commit: 3047766bc6ec9c6bc9ece85b45a41ff401e8d988 s390/pci: fix enabling a reserved PCI function
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > arch/s390/pci/pci_event.c:101 __zpci_event_availability() error: we previously assumed 'zdev->zbus' could be null (see line 83)
> > 
> > vim +101 arch/s390/pci/pci_event.c
> > 
> > aa3b7c296732b43 Sebastian Ott   2013-12-12   76  static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
> > cbc0dd1f856b52b Jan Glauber     2012-11-29   77  {
> > cbc0dd1f856b52b Jan Glauber     2012-11-29   78  	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
> > 9a99649f2a89fdf Sebastian Ott   2016-01-29   79  	struct pci_dev *pdev = NULL;
> > 623bd44d3f277b7 Sebastian Ott   2017-05-09   80  	enum zpci_state state;
> > d795ddad36cbc82 Sebastian Ott   2013-11-15   81  	int ret;
> > cbc0dd1f856b52b Jan Glauber     2012-11-29   82  
> > 05bc1be6db4b268 Pierre Morel    2020-03-23  @83  	if (zdev && zdev->zbus && zdev->zbus->bus)
> >                                                                      ^^^^^^^^^
> > Check for NULL
> > 
> > 44510d6fa0c00aa Pierre Morel    2020-04-22   84  		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
> > 9a99649f2a89fdf Sebastian Ott   2016-01-29   85  
> > 1f1dcbd4f23bd1f Sebastian Ott   2013-10-22   86  	zpci_err("avail CCDF:\n");
> > 1f1dcbd4f23bd1f Sebastian Ott   2013-10-22   87  	zpci_err_hex(ccdf, sizeof(*ccdf));
> > cbc0dd1f856b52b Jan Glauber     2012-11-29   88  
> > cbc0dd1f856b52b Jan Glauber     2012-11-29   89  	switch (ccdf->pec) {
> > 7fc611ff3ff1a0b Sebastian Ott   2015-06-16   90  	case 0x0301: /* Reserved|Standby -> Configured */
> > 7fc611ff3ff1a0b Sebastian Ott   2015-06-16   91  		if (!zdev) {
> > f606b3ef47c9f87 Pierre Morel    2020-03-25   92  			ret = clp_add_pci_device(ccdf->fid, ccdf->fh, 1);
> > 7fc611ff3ff1a0b Sebastian Ott   2015-06-16   93  			break;
> > 7fc611ff3ff1a0b Sebastian Ott   2015-06-16   94  		}
> > fcf2f402937a669 Sebastian Ott   2013-12-18   95  		zdev->fh = ccdf->fh;
> > f606b3ef47c9f87 Pierre Morel    2020-03-25   96  		zdev->state = ZPCI_FN_STATE_CONFIGURED;
> > 3047766bc6ec9c6 Niklas Schnelle 2020-06-18   97  		ret = zpci_enable_device(zdev);
> > 3047766bc6ec9c6 Niklas Schnelle 2020-06-18   98  		if (ret)
> > 3047766bc6ec9c6 Niklas Schnelle 2020-06-18   99  			break;
> > 3047766bc6ec9c6 Niklas Schnelle 2020-06-18  100  
> > 3047766bc6ec9c6 Niklas Schnelle 2020-06-18 @101  		pdev = pci_scan_single_device(zdev->zbus->bus, zdev->devfn);
> >                                                                                               ^^^^^^^^^^^^^^^^
> > Unchecked dereference
> 
> First, thanks for reporting this is definitely appreciated!
> We have also seen the same smatch report internally 
> and I determined that this is a false positive.
> 
> This is because the existing zdev->zbus NULL check could already never
> trigger.

I don't consider it a "false positive" exactly because the NULL checking
is inconsisent.  I would instead say that it is "correct but harmless".

That said, if Smatch can determined that "zdev->zbus" is not NULL then
it doesn't print a warning in these situations.  As it stands now Smatch
doesn't understand lists very well, but I plan to fix this in upcoming
months.  Once that gets fixed, Smatch will still assume that
zpci_create_device() is racy...  :/  And then finally it will only
silence the warning when the cross function database has been built and
I don't think the the zero bot builds the DB for s390.

Anyway, these don't affect runtime so it's not time sensitive.  Thanks
for taking the time to look at these!

regards,
dan carpenter


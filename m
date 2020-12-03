Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355892CD378
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbgLCK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:29:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53362 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbgLCK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:29:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3ANWb8132403;
        Thu, 3 Dec 2020 10:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=26hXJ64bQ930lPy8PikL3ahXMhYmtEpJXwPHMsAVm2I=;
 b=Gz+3teXE4qdL8ZWGS44Ks+G24VGzQCA474v/CKagWLIkSXf6yIef3/HmHcYF3Vl9KORY
 VqL/p/vCRoHI818CeieqDTm5cgtEb/7chvVNOwczeOvcIP1fMfJJfBHPr6SOBQcDVXA7
 Sipca+LC9aEf92EP3V9eKEVwngPHMfFHCVg7GvabqEkgtL48pwYPK+PyUcHbZyFqG/dk
 i39uzT55f7bk7YTO8uoiD5/Zrhf9o+hfp+3PyvCZIhCBF0P2BGVxBI0g2krstQR+InmZ
 tOJfcUywoLQDqyt6BoxDjNB9pz2PG/M8NOEGOjeSbpkOY0UYxhaOTpX7onDx69CnyzFM AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 353dyqw58d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 10:28:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3AQU9X041697;
        Thu, 3 Dec 2020 10:28:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35404qk7q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 10:28:12 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B3ASAN5018280;
        Thu, 3 Dec 2020 10:28:10 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 02:28:06 -0800
Date:   Thu, 3 Dec 2020 13:27:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: arch/s390/pci/pci_event.c:101 __zpci_event_availability() error: we
 previously assumed 'zdev->zbus' could be null (see line 83)
Message-ID: <20201203102759.GQ2767@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bb61aa61828499a7d0f5e560051625fd02ae7e4
commit: 3047766bc6ec9c6bc9ece85b45a41ff401e8d988 s390/pci: fix enabling a reserved PCI function

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/s390/pci/pci_event.c:101 __zpci_event_availability() error: we previously assumed 'zdev->zbus' could be null (see line 83)

vim +101 arch/s390/pci/pci_event.c

aa3b7c296732b43 Sebastian Ott   2013-12-12   76  static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
cbc0dd1f856b52b Jan Glauber     2012-11-29   77  {
cbc0dd1f856b52b Jan Glauber     2012-11-29   78  	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
9a99649f2a89fdf Sebastian Ott   2016-01-29   79  	struct pci_dev *pdev = NULL;
623bd44d3f277b7 Sebastian Ott   2017-05-09   80  	enum zpci_state state;
d795ddad36cbc82 Sebastian Ott   2013-11-15   81  	int ret;
cbc0dd1f856b52b Jan Glauber     2012-11-29   82  
05bc1be6db4b268 Pierre Morel    2020-03-23  @83  	if (zdev && zdev->zbus && zdev->zbus->bus)
                                                                     ^^^^^^^^^
Check for NULL

44510d6fa0c00aa Pierre Morel    2020-04-22   84  		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
9a99649f2a89fdf Sebastian Ott   2016-01-29   85  
1f1dcbd4f23bd1f Sebastian Ott   2013-10-22   86  	zpci_err("avail CCDF:\n");
1f1dcbd4f23bd1f Sebastian Ott   2013-10-22   87  	zpci_err_hex(ccdf, sizeof(*ccdf));
cbc0dd1f856b52b Jan Glauber     2012-11-29   88  
cbc0dd1f856b52b Jan Glauber     2012-11-29   89  	switch (ccdf->pec) {
7fc611ff3ff1a0b Sebastian Ott   2015-06-16   90  	case 0x0301: /* Reserved|Standby -> Configured */
7fc611ff3ff1a0b Sebastian Ott   2015-06-16   91  		if (!zdev) {
f606b3ef47c9f87 Pierre Morel    2020-03-25   92  			ret = clp_add_pci_device(ccdf->fid, ccdf->fh, 1);
7fc611ff3ff1a0b Sebastian Ott   2015-06-16   93  			break;
7fc611ff3ff1a0b Sebastian Ott   2015-06-16   94  		}
fcf2f402937a669 Sebastian Ott   2013-12-18   95  		zdev->fh = ccdf->fh;
f606b3ef47c9f87 Pierre Morel    2020-03-25   96  		zdev->state = ZPCI_FN_STATE_CONFIGURED;
3047766bc6ec9c6 Niklas Schnelle 2020-06-18   97  		ret = zpci_enable_device(zdev);
3047766bc6ec9c6 Niklas Schnelle 2020-06-18   98  		if (ret)
3047766bc6ec9c6 Niklas Schnelle 2020-06-18   99  			break;
3047766bc6ec9c6 Niklas Schnelle 2020-06-18  100  
3047766bc6ec9c6 Niklas Schnelle 2020-06-18 @101  		pdev = pci_scan_single_device(zdev->zbus->bus, zdev->devfn);
                                                                                              ^^^^^^^^^^^^^^^^
Unchecked dereference

3047766bc6ec9c6 Niklas Schnelle 2020-06-18  102  		if (!pdev)
3047766bc6ec9c6 Niklas Schnelle 2020-06-18  103  			break;
3047766bc6ec9c6 Niklas Schnelle 2020-06-18  104  
3047766bc6ec9c6 Niklas Schnelle 2020-06-18  105  		pci_bus_add_device(pdev);
3047766bc6ec9c6 Niklas Schnelle 2020-06-18  106  		pci_lock_rescan_remove();
3047766bc6ec9c6 Niklas Schnelle 2020-06-18  107  		pci_bus_add_devices(zdev->zbus->bus);
3047766bc6ec9c6 Niklas Schnelle 2020-06-18  108  		pci_unlock_rescan_remove();
cbc0dd1f856b52b Jan Glauber     2012-11-29  109  		break;
d795ddad36cbc82 Sebastian Ott   2013-11-15  110  	case 0x0302: /* Reserved -> Standby */
f606b3ef47c9f87 Pierre Morel    2020-03-25  111  		if (!zdev) {
d795ddad36cbc82 Sebastian Ott   2013-11-15  112  			clp_add_pci_device(ccdf->fid, ccdf->fh, 0);
cbc0dd1f856b52b Jan Glauber     2012-11-29  113  			break;
f606b3ef47c9f87 Pierre Morel    2020-03-25  114  		}
f606b3ef47c9f87 Pierre Morel    2020-03-25  115  		zdev->fh = ccdf->fh;
f606b3ef47c9f87 Pierre Morel    2020-03-25  116  		break;
d795ddad36cbc82 Sebastian Ott   2013-11-15  117  	case 0x0303: /* Deconfiguration requested */
623bd44d3f277b7 Sebastian Ott   2017-05-09  118  		if (!zdev)
623bd44d3f277b7 Sebastian Ott   2017-05-09  119  			break;
d795ddad36cbc82 Sebastian Ott   2013-11-15  120  		if (pdev)
2a01bd1bd3d28d1 Sebastian Ott   2015-07-28  121  			pci_stop_and_remove_bus_device_locked(pdev);
cbc0dd1f856b52b Jan Glauber     2012-11-29  122  
d795ddad36cbc82 Sebastian Ott   2013-11-15  123  		ret = zpci_disable_device(zdev);
d795ddad36cbc82 Sebastian Ott   2013-11-15  124  		if (ret)
d795ddad36cbc82 Sebastian Ott   2013-11-15  125  			break;
1f1dcbd4f23bd1f Sebastian Ott   2013-10-22  126  
d795ddad36cbc82 Sebastian Ott   2013-11-15  127  		ret = sclp_pci_deconfigure(zdev->fid);
d795ddad36cbc82 Sebastian Ott   2013-11-15  128  		zpci_dbg(3, "deconf fid:%x, rc:%d\n", zdev->fid, ret);
d795ddad36cbc82 Sebastian Ott   2013-11-15  129  		if (!ret)
d795ddad36cbc82 Sebastian Ott   2013-11-15  130  			zdev->state = ZPCI_FN_STATE_STANDBY;
cbc0dd1f856b52b Jan Glauber     2012-11-29  131  
d795ddad36cbc82 Sebastian Ott   2013-11-15  132  		break;
623bd44d3f277b7 Sebastian Ott   2017-05-09  133  	case 0x0304: /* Configured -> Standby|Reserved */
623bd44d3f277b7 Sebastian Ott   2017-05-09  134  		if (!zdev)
623bd44d3f277b7 Sebastian Ott   2017-05-09  135  			break;
0c0c2776926018e Sebastian Ott   2013-12-12  136  		if (pdev) {
0c0c2776926018e Sebastian Ott   2013-12-12  137  			/* Give the driver a hint that the function is
0c0c2776926018e Sebastian Ott   2013-12-12  138  			 * already unusable. */
0c0c2776926018e Sebastian Ott   2013-12-12  139  			pdev->error_state = pci_channel_io_perm_failure;
2a01bd1bd3d28d1 Sebastian Ott   2015-07-28  140  			pci_stop_and_remove_bus_device_locked(pdev);
0c0c2776926018e Sebastian Ott   2013-12-12  141  		}
1f1dcbd4f23bd1f Sebastian Ott   2013-10-22  142  
d795ddad36cbc82 Sebastian Ott   2013-11-15  143  		zdev->state = ZPCI_FN_STATE_STANDBY;
623bd44d3f277b7 Sebastian Ott   2017-05-09  144  		if (!clp_get_state(ccdf->fid, &state) &&
623bd44d3f277b7 Sebastian Ott   2017-05-09  145  		    state == ZPCI_FN_STATE_RESERVED) {
05bc1be6db4b268 Pierre Morel    2020-03-23  146  			zpci_zdev_put(zdev);
623bd44d3f277b7 Sebastian Ott   2017-05-09  147  		}
d795ddad36cbc82 Sebastian Ott   2013-11-15  148  		break;
d795ddad36cbc82 Sebastian Ott   2013-11-15  149  	case 0x0306: /* 0x308 or 0x302 for multiple devices */
d795ddad36cbc82 Sebastian Ott   2013-11-15  150  		clp_rescan_pci_devices();
d795ddad36cbc82 Sebastian Ott   2013-11-15  151  		break;
d795ddad36cbc82 Sebastian Ott   2013-11-15  152  	case 0x0308: /* Standby -> Reserved */
704268925d32a04 Sebastian Ott   2013-12-12  153  		if (!zdev)
704268925d32a04 Sebastian Ott   2013-12-12  154  			break;
05bc1be6db4b268 Pierre Morel    2020-03-23  155  		zpci_zdev_put(zdev);
d795ddad36cbc82 Sebastian Ott   2013-11-15  156  		break;
d795ddad36cbc82 Sebastian Ott   2013-11-15  157  	default:
d795ddad36cbc82 Sebastian Ott   2013-11-15  158  		break;
cbc0dd1f856b52b Jan Glauber     2012-11-29  159  	}
cbc0dd1f856b52b Jan Glauber     2012-11-29  160  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dWYAkE0V1FpFQHQ3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--dWYAkE0V1FpFQHQ3--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4776A2FB16A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbhASG2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:28:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33728 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbhASGPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:15:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J6ATeR105726;
        Tue, 19 Jan 2021 06:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Mjoslg3ikM5C9Oji96r/TuteDiGErVqCTEcbtPHEVII=;
 b=MpnBKFeWXVB8gAUqh6WidXrMB2sx3VyJ7+/UJ6EV3vqgA9Qk+nvgbK0TbAohJ3xnCQFA
 KhOXc8hqQP5lsfg3AYiDe7txjzEEdM1zvjj4C+SYh20KPjLKh8d0DsTxYheKTsY5ak+e
 y7/o6CHddqbG3PxaKqYH+EhmQoxsgbyChtcV8ptTYslZC5H2AvXqncL795hrBp28ge3A
 z46D0rwp6VB2oAYwt9AUuP40WcvToaxJvxiHh6Z5kxXZyaz6Vyx3cPlRoKd05ygBLqOY
 QeBgO5+2+PN2hhY+PWEg2Xg0k+Yit6R1nLH0gGjDJ4ZhdNpRowPGpb4JVtQ6weCYke9I bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 363nnafrqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 06:14:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J6BTG0141697;
        Tue, 19 Jan 2021 06:14:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 364a2w2bdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 06:14:32 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10J6EUuW002888;
        Tue, 19 Jan 2021 06:14:30 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jan 2021 22:14:29 -0800
Date:   Tue, 19 Jan 2021 09:14:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: arch/s390/pci/pci_event.c:101 __zpci_event_availability() error: we
 previously assumed 'zdev->zbus' could be null (see line 83)
Message-ID: <20210119061422.GC2696@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   65f0d2414b7079556fbbcc070b3d1c9f9587606d
commit: 3047766bc6ec9c6bc9ece85b45a41ff401e8d988 s390/pci: fix enabling a reserved PCI function
config: s390-randconfig-m031-20210114 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/s390/pci/pci_event.c:101 __zpci_event_availability() error: we previously assumed 'zdev->zbus' could be null (see line 83)

vim +101 arch/s390/pci/pci_event.c

aa3b7c296732b4 Sebastian Ott   2013-12-12   76  static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
cbc0dd1f856b52 Jan Glauber     2012-11-29   77  {
cbc0dd1f856b52 Jan Glauber     2012-11-29   78  	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
9a99649f2a89fd Sebastian Ott   2016-01-29   79  	struct pci_dev *pdev = NULL;
623bd44d3f277b Sebastian Ott   2017-05-09   80  	enum zpci_state state;
d795ddad36cbc8 Sebastian Ott   2013-11-15   81  	int ret;
cbc0dd1f856b52 Jan Glauber     2012-11-29   82  
05bc1be6db4b26 Pierre Morel    2020-03-23  @83  	if (zdev && zdev->zbus && zdev->zbus->bus)
                                                                    ^^^^^^^^^^
Can this be NULL?

44510d6fa0c00a Pierre Morel    2020-04-22   84  		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
9a99649f2a89fd Sebastian Ott   2016-01-29   85  
1f1dcbd4f23bd1 Sebastian Ott   2013-10-22   86  	zpci_err("avail CCDF:\n");
1f1dcbd4f23bd1 Sebastian Ott   2013-10-22   87  	zpci_err_hex(ccdf, sizeof(*ccdf));
cbc0dd1f856b52 Jan Glauber     2012-11-29   88  
cbc0dd1f856b52 Jan Glauber     2012-11-29   89  	switch (ccdf->pec) {
7fc611ff3ff1a0 Sebastian Ott   2015-06-16   90  	case 0x0301: /* Reserved|Standby -> Configured */
7fc611ff3ff1a0 Sebastian Ott   2015-06-16   91  		if (!zdev) {
f606b3ef47c9f8 Pierre Morel    2020-03-25   92  			ret = clp_add_pci_device(ccdf->fid, ccdf->fh, 1);
7fc611ff3ff1a0 Sebastian Ott   2015-06-16   93  			break;
7fc611ff3ff1a0 Sebastian Ott   2015-06-16   94  		}
fcf2f402937a66 Sebastian Ott   2013-12-18   95  		zdev->fh = ccdf->fh;
f606b3ef47c9f8 Pierre Morel    2020-03-25   96  		zdev->state = ZPCI_FN_STATE_CONFIGURED;
3047766bc6ec9c Niklas Schnelle 2020-06-18   97  		ret = zpci_enable_device(zdev);
3047766bc6ec9c Niklas Schnelle 2020-06-18   98  		if (ret)
3047766bc6ec9c Niklas Schnelle 2020-06-18   99  			break;
3047766bc6ec9c Niklas Schnelle 2020-06-18  100  
3047766bc6ec9c Niklas Schnelle 2020-06-18 @101  		pdev = pci_scan_single_device(zdev->zbus->bus, zdev->devfn);
                                                                                              ^^^^^^^^^^^^^^^
Unchecked dereference

3047766bc6ec9c Niklas Schnelle 2020-06-18  102  		if (!pdev)
3047766bc6ec9c Niklas Schnelle 2020-06-18  103  			break;
3047766bc6ec9c Niklas Schnelle 2020-06-18  104  
3047766bc6ec9c Niklas Schnelle 2020-06-18  105  		pci_bus_add_device(pdev);
3047766bc6ec9c Niklas Schnelle 2020-06-18  106  		pci_lock_rescan_remove();
3047766bc6ec9c Niklas Schnelle 2020-06-18  107  		pci_bus_add_devices(zdev->zbus->bus);
3047766bc6ec9c Niklas Schnelle 2020-06-18  108  		pci_unlock_rescan_remove();
cbc0dd1f856b52 Jan Glauber     2012-11-29  109  		break;
d795ddad36cbc8 Sebastian Ott   2013-11-15  110  	case 0x0302: /* Reserved -> Standby */
f606b3ef47c9f8 Pierre Morel    2020-03-25  111  		if (!zdev) {
d795ddad36cbc8 Sebastian Ott   2013-11-15  112  			clp_add_pci_device(ccdf->fid, ccdf->fh, 0);
cbc0dd1f856b52 Jan Glauber     2012-11-29  113  			break;
f606b3ef47c9f8 Pierre Morel    2020-03-25  114  		}
f606b3ef47c9f8 Pierre Morel    2020-03-25  115  		zdev->fh = ccdf->fh;
f606b3ef47c9f8 Pierre Morel    2020-03-25  116  		break;
d795ddad36cbc8 Sebastian Ott   2013-11-15  117  	case 0x0303: /* Deconfiguration requested */
623bd44d3f277b Sebastian Ott   2017-05-09  118  		if (!zdev)
623bd44d3f277b Sebastian Ott   2017-05-09  119  			break;
d795ddad36cbc8 Sebastian Ott   2013-11-15  120  		if (pdev)
2a01bd1bd3d28d Sebastian Ott   2015-07-28  121  			pci_stop_and_remove_bus_device_locked(pdev);
cbc0dd1f856b52 Jan Glauber     2012-11-29  122  
d795ddad36cbc8 Sebastian Ott   2013-11-15  123  		ret = zpci_disable_device(zdev);
d795ddad36cbc8 Sebastian Ott   2013-11-15  124  		if (ret)
d795ddad36cbc8 Sebastian Ott   2013-11-15  125  			break;
1f1dcbd4f23bd1 Sebastian Ott   2013-10-22  126  
d795ddad36cbc8 Sebastian Ott   2013-11-15  127  		ret = sclp_pci_deconfigure(zdev->fid);
d795ddad36cbc8 Sebastian Ott   2013-11-15  128  		zpci_dbg(3, "deconf fid:%x, rc:%d\n", zdev->fid, ret);
d795ddad36cbc8 Sebastian Ott   2013-11-15  129  		if (!ret)
d795ddad36cbc8 Sebastian Ott   2013-11-15  130  			zdev->state = ZPCI_FN_STATE_STANDBY;
cbc0dd1f856b52 Jan Glauber     2012-11-29  131  
d795ddad36cbc8 Sebastian Ott   2013-11-15  132  		break;
623bd44d3f277b Sebastian Ott   2017-05-09  133  	case 0x0304: /* Configured -> Standby|Reserved */
623bd44d3f277b Sebastian Ott   2017-05-09  134  		if (!zdev)
623bd44d3f277b Sebastian Ott   2017-05-09  135  			break;
0c0c2776926018 Sebastian Ott   2013-12-12  136  		if (pdev) {
0c0c2776926018 Sebastian Ott   2013-12-12  137  			/* Give the driver a hint that the function is
0c0c2776926018 Sebastian Ott   2013-12-12  138  			 * already unusable. */
0c0c2776926018 Sebastian Ott   2013-12-12  139  			pdev->error_state = pci_channel_io_perm_failure;
2a01bd1bd3d28d Sebastian Ott   2015-07-28  140  			pci_stop_and_remove_bus_device_locked(pdev);
0c0c2776926018 Sebastian Ott   2013-12-12  141  		}
1f1dcbd4f23bd1 Sebastian Ott   2013-10-22  142  
d795ddad36cbc8 Sebastian Ott   2013-11-15  143  		zdev->state = ZPCI_FN_STATE_STANDBY;
623bd44d3f277b Sebastian Ott   2017-05-09  144  		if (!clp_get_state(ccdf->fid, &state) &&
623bd44d3f277b Sebastian Ott   2017-05-09  145  		    state == ZPCI_FN_STATE_RESERVED) {
05bc1be6db4b26 Pierre Morel    2020-03-23  146  			zpci_zdev_put(zdev);
623bd44d3f277b Sebastian Ott   2017-05-09  147  		}
d795ddad36cbc8 Sebastian Ott   2013-11-15  148  		break;
d795ddad36cbc8 Sebastian Ott   2013-11-15  149  	case 0x0306: /* 0x308 or 0x302 for multiple devices */
d795ddad36cbc8 Sebastian Ott   2013-11-15  150  		clp_rescan_pci_devices();
d795ddad36cbc8 Sebastian Ott   2013-11-15  151  		break;
d795ddad36cbc8 Sebastian Ott   2013-11-15  152  	case 0x0308: /* Standby -> Reserved */
704268925d32a0 Sebastian Ott   2013-12-12  153  		if (!zdev)
704268925d32a0 Sebastian Ott   2013-12-12  154  			break;
05bc1be6db4b26 Pierre Morel    2020-03-23  155  		zpci_zdev_put(zdev);
d795ddad36cbc8 Sebastian Ott   2013-11-15  156  		break;
d795ddad36cbc8 Sebastian Ott   2013-11-15  157  	default:
d795ddad36cbc8 Sebastian Ott   2013-11-15  158  		break;
cbc0dd1f856b52 Jan Glauber     2012-11-29  159  	}
cbc0dd1f856b52 Jan Glauber     2012-11-29  160  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--DiL7RhKs8rK9YGuF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sI82t3v/B/H6Bb/IWQEA

--DiL7RhKs8rK9YGuF--

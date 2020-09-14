Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBED268401
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgINFRW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Sep 2020 01:17:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52525 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgINFRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:17:22 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08E5H0bI4024942, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb05.realtek.com.tw[172.21.6.98])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08E5H0bI4024942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Sep 2020 13:17:00 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 14 Sep 2020 13:17:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 14 Sep 2020 13:17:00 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::12:c5fd:7be0:22a]) by
 RTEXMB04.realtek.com.tw ([fe80::12:c5fd:7be0:22a%3]) with mapi id
 15.01.2044.006; Mon, 14 Sep 2020 13:17:00 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     kernel test robot <lkp@intel.com>,
        Kevin Yang <kevin_yang@realtek.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: RE: drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no previous prototype for 'rtw_pci_probe'
Thread-Topic: drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no
 previous prototype for 'rtw_pci_probe'
Thread-Index: AQHWieSmw2vhRusuQEuDM5QZJLn2PKlnmExA
Date:   Mon, 14 Sep 2020 05:16:59 +0000
Message-ID: <6463246c14a24bc989ea56d9c4443784@realtek.com>
References: <202009132352.cN4c9rTC%lkp@intel.com>
In-Reply-To: <202009132352.cN4c9rTC%lkp@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ef2e9a563b0cd7965e2a1263125dcbb1c86aa6cc
> commit: ba0fbe236fb8a7b992e82d6eafb03a600f5eba43 rtw88: extract: make
> 8822c an individual kernel module
> date:   4 months ago
> config: i386-randconfig-r034-20200913 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout ba0fbe236fb8a7b992e82d6eafb03a600f5eba43
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no previous
> >> prototype for 'rtw_pci_probe' [-Wmissing-prototypes]
>     1477 | int rtw_pci_probe(struct pci_dev *pdev,
>          |     ^~~~~~~~~~~~~
> >> drivers/net/wireless/realtek/rtw88/pci.c:1557:6: warning: no previous
> >> prototype for 'rtw_pci_remove' [-Wmissing-prototypes]
>     1557 | void rtw_pci_remove(struct pci_dev *pdev)
>          |      ^~~~~~~~~~~~~~
> >> drivers/net/wireless/realtek/rtw88/pci.c:1579:6: warning: no previous
> >> prototype for 'rtw_pci_shutdown' [-Wmissing-prototypes]
>     1579 | void rtw_pci_shutdown(struct pci_dev *pdev)
>          |      ^~~~~~~~~~~~~~~~
> 
> #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b
> a0fbe236fb8a7b992e82d6eafb03a600f5eba43
> git remote add linus
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout ba0fbe236fb8a7b992e82d6eafb03a600f5eba43
> vim +/rtw_pci_probe +1477 drivers/net/wireless/realtek/rtw88/pci.c
> 
> 79066903454b0fe Yu-Yen Ting      2019-09-03  1476
> 72f256c2b948622 Zong-Zhe Yang    2020-05-15 @1477  int
> rtw_pci_probe(struct pci_dev *pdev,
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1478  		  const
> struct pci_device_id *id)
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1479  {
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1480  	struct
> ieee80211_hw *hw;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1481  	struct rtw_dev
> *rtwdev;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1482  	int
> drv_data_size;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1483  	int ret;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1484
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1485  	drv_data_size
> = sizeof(struct rtw_dev) + sizeof(struct rtw_pci);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1486  	hw =
> ieee80211_alloc_hw(drv_data_size, &rtw_ops);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1487  	if (!hw) {
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1488
> 	dev_err(&pdev->dev, "failed to allocate hw\n");
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1489  		return
> -ENOMEM;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1490  	}
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1491
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1492  	rtwdev =
> hw->priv;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1493  	rtwdev->hw =
> hw;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1494  	rtwdev->dev =
> &pdev->dev;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1495  	rtwdev->chip =
> (struct rtw_chip_info *)id->driver_data;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1496
> 	rtwdev->hci.ops = &rtw_pci_ops;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1497
> 	rtwdev->hci.type = RTW_HCI_TYPE_PCIE;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1498
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1499  	ret =
> rtw_core_init(rtwdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1500  	if (ret)
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1501  		goto
> err_release_hw;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1502
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1503
> 	rtw_dbg(rtwdev, RTW_DBG_PCI,
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1504  		"rtw88 pci
> probe: vendor=0x%4.04X device=0x%4.04X rev=%d\n",
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1505
> 	pdev->vendor, pdev->device, pdev->revision);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1506
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1507  	ret =
> rtw_pci_claim(rtwdev, pdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1508  	if (ret) {
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1509
> 	rtw_err(rtwdev, "failed to claim pci device\n");
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1510  		goto
> err_deinit_core;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1511  	}
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1512
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1513  	ret =
> rtw_pci_setup_resource(rtwdev, pdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1514  	if (ret) {
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1515
> 	rtw_err(rtwdev, "failed to setup pci resources\n");
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1516  		goto
> err_pci_declaim;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1517  	}
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1518
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1519  	ret =
> rtw_chip_info_setup(rtwdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1520  	if (ret) {
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1521
> 	rtw_err(rtwdev, "failed to setup chip information\n");
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1522  		goto
> err_destroy_pci;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1523  	}
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1524
> 474264d5a6b7db4 Yan-Hsuan Chuang 2019-10-08  1525
> 	rtw_pci_phy_cfg(rtwdev);
> 474264d5a6b7db4 Yan-Hsuan Chuang 2019-10-08  1526
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1527  	ret =
> rtw_register_hw(rtwdev, hw);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1528  	if (ret) {
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1529
> 	rtw_err(rtwdev, "failed to register hw\n");
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1530  		goto
> err_destroy_pci;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1531  	}
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1532
> 79066903454b0fe Yu-Yen Ting      2019-09-03  1533  	ret =
> rtw_pci_request_irq(rtwdev, pdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1534  	if (ret) {
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1535
> 	ieee80211_unregister_hw(hw);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1536  		goto
> err_destroy_pci;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1537  	}
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1538
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1539  	return 0;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1540 e3037485c68ec1a
> Yan-Hsuan Chuang 2019-04-26  1541  err_destroy_pci:
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1542
> 	rtw_pci_destroy(rtwdev, pdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1543 e3037485c68ec1a
> Yan-Hsuan Chuang 2019-04-26  1544  err_pci_declaim:
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1545
> 	rtw_pci_declaim(rtwdev, pdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1546 e3037485c68ec1a
> Yan-Hsuan Chuang 2019-04-26  1547  err_deinit_core:
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1548
> 	rtw_core_deinit(rtwdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1549 e3037485c68ec1a
> Yan-Hsuan Chuang 2019-04-26  1550  err_release_hw:
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1551
> 	ieee80211_free_hw(hw);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1552
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1553  	return ret;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1554  }
> 72f256c2b948622 Zong-Zhe Yang    2020-05-15  1555
> EXPORT_SYMBOL(rtw_pci_probe);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1556
> 72f256c2b948622 Zong-Zhe Yang    2020-05-15 @1557  void
> rtw_pci_remove(struct pci_dev *pdev)
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1558  {
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1559  	struct
> ieee80211_hw *hw = pci_get_drvdata(pdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1560  	struct rtw_dev
> *rtwdev;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1561  	struct rtw_pci
> *rtwpci;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1562
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1563  	if (!hw)
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1564  		return;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1565
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1566  	rtwdev =
> hw->priv;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1567  	rtwpci = (struct
> rtw_pci *)rtwdev->priv;
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1568
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1569
> 	rtw_unregister_hw(rtwdev, hw);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1570
> 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1571
> 	rtw_pci_destroy(rtwdev, pdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1572
> 	rtw_pci_declaim(rtwdev, pdev);
> 79066903454b0fe Yu-Yen Ting      2019-09-03  1573
> 	rtw_pci_free_irq(rtwdev, pdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1574
> 	rtw_core_deinit(rtwdev);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1575
> 	ieee80211_free_hw(hw);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1576  }
> 72f256c2b948622 Zong-Zhe Yang    2020-05-15  1577
> EXPORT_SYMBOL(rtw_pci_remove);
> e3037485c68ec1a Yan-Hsuan Chuang 2019-04-26  1578
> 72f256c2b948622 Zong-Zhe Yang    2020-05-15 @1579  void
> rtw_pci_shutdown(struct pci_dev *pdev)
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1580  {
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1581  	struct
> ieee80211_hw *hw = pci_get_drvdata(pdev);
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1582  	struct rtw_dev
> *rtwdev;
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1583  	struct
> rtw_chip_info *chip;
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1584
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1585  	if (!hw)
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1586  		return;
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1587
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1588  	rtwdev =
> hw->priv;
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1589  	chip =
> rtwdev->chip;
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1590
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1591  	if
> (chip->ops->shutdown)
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1592
> 	chip->ops->shutdown(rtwdev);
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1593  }
> 72f256c2b948622 Zong-Zhe Yang    2020-05-15  1594
> EXPORT_SYMBOL(rtw_pci_shutdown);
> 05202746ed70ea9 Ping-Ke Shih     2020-05-12  1595
> 
> :::::: The code at line 1477 was first introduced by commit
> :::::: 72f256c2b948622cc45ff8bc0456dd6039d8fe36 rtw88: extract: export
> symbols about pci interface
> 
> :::::: TO: Zong-Zhe Yang <kevin_yang@realtek.com>
> :::::: CC: Kalle Valo <kvalo@codeaurora.org>
> 
> ---

Hi Kalle,

The exported function is used by the following patchset.
So this is a false alarm.
Thanks

Yen-Hsuan


> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> ------Please consider the environment before printing this e-mail.

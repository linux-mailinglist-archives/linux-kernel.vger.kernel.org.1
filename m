Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5A2859B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgJGHmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:42:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:42:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0977fPkV021437;
        Wed, 7 Oct 2020 07:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=DT2yU/2M13jT+YZvQVofD8f7nvBvHajBu+AYWYGeYhI=;
 b=L+0qZPNJ4L2zK4U86Lsdiqov8zudQ9B5SSIVAkFeN97RJTvNK3AO9YkmXex1zZJkfAnL
 bkbsl1NC/+LtXqRQljK9WMFQpm1e4rcwK/bTOBUALd6h7tz6UwF7s7Qekx1cwYVPHa2u
 OuVF/AQRE+sN/gznTQmizoZJD8E3eYYDE2O9L00yHe73MX9qeAcsh2gkxQRACml+ka64
 C2ugIwyKhoLUhhq2NVTJRK1Jyu6Tg/03lnKVO+X5nqf1zuadTCPd2BTjNYbmlr2NfdFp
 vBLdyXZh68i7iZo6XnI8fBsqUIbHRXWh54vvfISVzwV4TyWnXu4qMO5f+U3annmFT04d iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33ym34n8nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 07:42:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0977eAUi110335;
        Wed, 7 Oct 2020 07:42:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33y37y752n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 07:42:36 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0977gZoL015842;
        Wed, 7 Oct 2020 07:42:35 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 00:42:33 -0700
Date:   Wed, 7 Oct 2020 10:42:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kees Cook <keescook@chromium.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:5638
 bnx2x_link_settings_status() warn: signedness bug returning '(-22)'
Message-ID: <20201007074228.GO4282@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2KGcTUzwJ+J1jnia"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2KGcTUzwJ+J1jnia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d3d45f8220d60a0b2aaaacf8fb2be4e6ffd9008e
commit: 2c855d73f2f6107f5b8ebc45f8b934bf7f4419e0 bnx2x: Remove read_status_t function casts
config: x86_64-randconfig-m001-20201003 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:5638 bnx2x_link_settings_status() warn: signedness bug returning '(-22)'

Old smatch warnings:
drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:7184 bnx2x_8073_8727_external_rom_boot() error: uninitialized symbol 'fw_ver1'.

vim +5638 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c

2c855d73f2f6107 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Kees Cook        2019-11-14  5614  static u8 bnx2x_link_settings_status(struct bnx2x_phy *phy,
                                                                                                           ^^

3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5615  				     struct link_params *params,
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5616  				     struct link_vars *vars)
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5617  {
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5618  	struct bnx2x *bp = params->bp;
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5619  
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5620  	u16 gp_status, duplex = DUPLEX_HALF, link_up = 0, speed_mask;
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5621  	int rc = 0;
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5622  
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5623  	/* Read gp_status */
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5624  	CL22_RD_OVER_CL45(bp, phy,
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5625  			  MDIO_REG_BANK_GP_STATUS,
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5626  			  MDIO_GP_STATUS_TOP_AN_STATUS1,
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5627  			  &gp_status);
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5628  	if (gp_status & MDIO_GP_STATUS_TOP_AN_STATUS1_DUPLEX_STATUS)
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5629  		duplex = DUPLEX_FULL;
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5630  	if (gp_status & MDIO_GP_STATUS_TOP_AN_STATUS1_LINK_STATUS)
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5631  		link_up = 1;
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5632  	speed_mask = gp_status & GP_STATUS_SPEED_MASK;
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5633  	DP(NETIF_MSG_LINK, "gp_status 0x%x, is_link_up %d, speed_mask 0x%x\n",
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5634  		       gp_status, link_up, speed_mask);
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5635  	rc = bnx2x_get_link_speed_duplex(phy, params, vars, link_up, speed_mask,
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5636  					 duplex);
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5637  	if (rc == -EINVAL)
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14 @5638  		return rc;
                                                                                                                ^^^^^^^^^^
return -EINVAL gets truncated to a u8.

3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5639  
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5640  	if (gp_status & MDIO_GP_STATUS_TOP_AN_STATUS1_LINK_STATUS) {
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5641  		if (SINGLE_MEDIA_DIRECT(params)) {
430d172a635c3dd drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Yaniv Rosner     2012-09-11  5642  			vars->duplex = duplex;
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5643  			bnx2x_flow_ctrl_resolve(phy, params, vars, gp_status);
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5644  			if (phy->req_line_speed == SPEED_AUTO_NEG)
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5645  				bnx2x_xgxs_an_resolve(phy, params, vars,
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5646  						      gp_status);
3c9ada227c56c6f drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2011-06-14  5647  		}
d231023eb17134e drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Yuval Mintz      2012-06-20  5648  	} else { /* Link_down */
c18aa15d08a2d1a drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2010-09-07  5649  		if ((phy->req_line_speed == SPEED_AUTO_NEG) &&
c18aa15d08a2d1a drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2010-09-07  5650  		    SINGLE_MEDIA_DIRECT(params)) {
239d686d494f10e drivers/net/bnx2x_link.c                         Eilon Greenstein 2009-08-12  5651  			/* Check signal is detected */
c18aa15d08a2d1a drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2010-09-07  5652  			bnx2x_check_fallback_to_cl37(phy, params);
239d686d494f10e drivers/net/bnx2x_link.c                         Eilon Greenstein 2009-08-12  5653  		}
ea4e040abc72f2d drivers/net/bnx2x_link.c                         Yaniv Rosner     2008-06-23  5654  	}
ea4e040abc72f2d drivers/net/bnx2x_link.c                         Yaniv Rosner     2008-06-23  5655  
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5656  	/* Read LP advertised speeds*/
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5657  	if (SINGLE_MEDIA_DIRECT(params) &&
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5658  	    (vars->link_status & LINK_STATUS_AUTO_NEGOTIATE_COMPLETE)) {
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5659  		u16 val;
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5660  
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5661  		CL22_RD_OVER_CL45(bp, phy, MDIO_REG_BANK_CL73_IEEEB1,
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5662  				  MDIO_CL73_IEEEB1_AN_LP_ADV2, &val);
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5663  
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5664  		if (val & MDIO_CL73_IEEEB1_AN_ADV2_ADVR_1000M_KX)
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5665  			vars->link_status |=
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5666  				LINK_STATUS_LINK_PARTNER_1000TFD_CAPABLE;
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5667  		if (val & (MDIO_CL73_IEEEB1_AN_ADV2_ADVR_10G_KX4 |
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5668  			   MDIO_CL73_IEEEB1_AN_ADV2_ADVR_10G_KR))
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5669  			vars->link_status |=
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5670  				LINK_STATUS_LINK_PARTNER_10GXFD_CAPABLE;
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5671  
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5672  		CL22_RD_OVER_CL45(bp, phy, MDIO_REG_BANK_OVER_1G,
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5673  				  MDIO_OVER_1G_LP_UP1, &val);
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5674  
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5675  		if (val & MDIO_OVER_1G_UP1_2_5G)
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5676  			vars->link_status |=
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5677  				LINK_STATUS_LINK_PARTNER_2500XFD_CAPABLE;
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5678  		if (val & (MDIO_OVER_1G_UP1_10G | MDIO_OVER_1G_UP1_10GH))
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5679  			vars->link_status |=
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5680  				LINK_STATUS_LINK_PARTNER_10GXFD_CAPABLE;
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5681  	}
9e7e8399c5d3c4d drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c Mintz Yuval      2012-02-15  5682  
a22f078867ef362 drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2010-09-07  5683  	DP(NETIF_MSG_LINK, "duplex %x  flow_ctrl 0x%x link_status 0x%x\n",
a22f078867ef362 drivers/net/bnx2x/bnx2x_link.c                   Yaniv Rosner     2010-09-07  5684  		   vars->duplex, vars->flow_ctrl, vars->link_status);
ea4e040abc72f2d drivers/net/bnx2x_link.c                         Yaniv Rosner     2008-06-23  5685  	return rc;
ea4e040abc72f2d drivers/net/bnx2x_link.c                         Yaniv Rosner     2008-06-23  5686  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2KGcTUzwJ+J1jnia
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/wIhxXxr1dQBAA==

--2KGcTUzwJ+J1jnia--

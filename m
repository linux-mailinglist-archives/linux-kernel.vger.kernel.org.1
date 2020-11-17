Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E8A2B5A27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgKQHPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:15:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55042 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgKQHPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:15:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH7A8Bg081987;
        Tue, 17 Nov 2020 07:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2Er4Ef/B2oUzeMoaWyPoLq8u1BgWABeaEVsse/R6ZAI=;
 b=YSpk9V+2+1+Yl4RocsGc+JhuBXzfk2KhCJX3Ih5OEj+3/2IbZ13e3OTUjHFYG0EF9UUo
 kM9T2qVkKc6RR2klyynFZw23U6JYvolQ/0MluXO3bETSh4rBNVCrS61zonQk+0BbqFsJ
 nKogRFhVM7P24DUnx4paQxb91j2sAy6pw0Bax44Fz2G+PiTJ2HaZpD3Rb6MSr77hC1jL
 zair2B4cwfs+BQrrdIil2d4ECuTgZhRN7bihy0LAgDVrMI1SCK5bmt08/VirVhMfAyAu
 /lClGx41pMuHu4H2yBXB0LqDaUgxQ/T617F6GXP5E2WNE4FlA6mG6pvJakBvH8I8073Z 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34t76krxnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 07:14:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH79Qpq076947;
        Tue, 17 Nov 2020 07:14:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34ts0qg8u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 07:14:52 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AH7EpdO009382;
        Tue, 17 Nov 2020 07:14:51 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 23:14:50 -0800
Date:   Tue, 17 Nov 2020 10:14:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "lkp@intel.com" <lkp@intel.com>, Dan Carpenter <error27@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>
Subject: Re: drivers/net/ethernet/freescale/gianfar.c:580 gfar_parse_group()
 warn: 'grp->regs' not released on lines: 517.
Message-ID: <20201117071442.GF18329@kadam>
References: <20201116092505.GU29398@kadam>
 <VE1PR04MB6687ADE11367CF7FAE759B678FE20@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6687ADE11367CF7FAE759B678FE20@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 01:41:15AM +0000, Leo Li wrote:
> > ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> > 2013-01-29  513  		gfar_irq(grp, ER)->irq =
> > irq_of_parse_and_map(np, 2);
> > fea0f6650979a4f drivers/net/ethernet/freescale/gianfar.c Mark Brown
> > 2015-11-26  514  		if (!gfar_irq(grp, TX)->irq ||
> > fea0f6650979a4f drivers/net/ethernet/freescale/gianfar.c Mark Brown
> > 2015-11-26  515  		    !gfar_irq(grp, RX)->irq ||
> > fea0f6650979a4f drivers/net/ethernet/freescale/gianfar.c Mark Brown
> > 2015-11-26  516  		    !gfar_irq(grp, ER)->irq)
> > 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet 2009-11-
> > 02  517  			return -EINVAL;
> > 
> > This should unmap "grp->regs".
> 
> This variable is unmapped in the caller with a wholesale cleanup function unmap_group_regs().  Probably a false positive for smatch?
> 

Yeah.  Thanks.  Smatch doesn't consider that the variable might be freed
in the caller.

regards,
dan carpenter


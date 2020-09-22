Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6876A273E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIVJR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:17:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44304 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIVJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:17:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M9F9Bv058619;
        Tue, 22 Sep 2020 09:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0LlcmxUgv23UmLo9kyhfbOkV0pFyrGTGgW1VdjwNSd4=;
 b=dTQbnJI6UN0bN/BwmreesITbFiCsz3PgN3opYy6YmGmla1B8XM02BDPYf6pyJyxpjhoy
 Ie9XX0T44dfmJKiK/B7ANDTYMOEqWl5UAxNGs4qTqK6CkPnIz669nzPdP257xkTBzp9o
 a2sNw0KRPP7g5BkBrXw3rh5RD63Y013y0hEO2ayOLffOQZmkV6OFEFEpexkr66J8bYmL
 EO+joaP1Vck0URLRVJtJVbm/7ZSzmf69/CTXRJM3jHa72dh+Lg3fi2Pndh9LYn4/ZeDr
 XnJ5JRdx15xoop8ugb6aye6BxQ4wMJEZ7P00Jgh/usHBYmS5VOF9Ev7qLR6ffkI03wDI 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33q5rga2ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 09:17:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M9FqbA139159;
        Tue, 22 Sep 2020 09:17:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33nuw3bvpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 09:17:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08M9HH2C009085;
        Tue, 22 Sep 2020 09:17:18 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 02:17:17 -0700
Date:   Tue, 22 Sep 2020 12:17:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-clk@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v6 5/8] clk: clock-wizard: Add support for fractional
 support
Message-ID: <20200922091709.GD4282@kadam>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1598621996-31040-6-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598621996-31040-6-git-send-email-shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 07:09:53PM +0530, Shubhrajyoti Datta wrote:
> +
> +	/* Check status register */
> +	err= readl_poll_timeout(divider->base + WZRD_DR_STATUS_REG_OFFSET, value,
> +				value & WZRD_DR_LOCK_BIT_MASK,
> +				WZRD_USEC_POLL, WZRD_TIMEOUT_POLL);

Checkpatch will catch the missing space in "err= readl_".

regards,
dan carpenter


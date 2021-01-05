Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457BA2EAD43
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbhAEOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:19:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbhAEOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:19:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105EF1aM101866;
        Tue, 5 Jan 2021 14:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VYAOVPzTCDHPVHPsBdE7ahRv/jF/NxuZ8z4HhpbF+Cc=;
 b=SE0oq+04evcDpFCjnKCLQPghRdLeNiXKbdU2N0XIAneKqhhzf23Zvr79nCj8PgDZKeBT
 Vrqmx/XGHjN15zW1ms4epwzNQU5uj94H9vI06S/3WMQWRUytPnmRXAruAVks8DE3bv1G
 le2GF33B/dwqudcnfm0TqscsGKjG3i4pChHv06qu/Jaxo5g2v298+cgEEHN15WZqM1Pa
 B4181mm3j3g1x2aogtZ9kHR2deCn6ZcTqVaFJ+M6U4kGSKYN6TYQZ1rcTZyGKnUyJkws
 woTjsAK9x83V48WFDhK1Pv1WqicOxw/ooBYKIrRKgV495PxV+vxmLPaKSMPBEI0JfThD Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35tgskrxp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 14:17:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105EAlHG005518;
        Tue, 5 Jan 2021 14:17:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35v1f8nbc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 14:17:58 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 105EHghU011314;
        Tue, 5 Jan 2021 14:17:42 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 14:17:41 +0000
Date:   Tue, 5 Jan 2021 17:17:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        devel@driverdev.osuosl.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>, Sheng Pan <span@analogixsemi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7625: add MIPI DPI input feature
 support
Message-ID: <20210105141701.GG2809@kadam>
References: <cover.1609380663.git.xji@analogixsemi.com>
 <f7fce2657d3c98a4d705f88eb9684f97b646793e.1609380663.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7fce2657d3c98a4d705f88eb9684f97b646793e.1609380663.git.xji@analogixsemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 10:22:36AM +0800, Xin Ji wrote:
>  static int anx7625_read_ctrl_status_p0(struct anx7625_data *ctx)
>  {
>  	return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, AP_AUX_CTRL_STATUS);
> @@ -189,10 +203,64 @@ static int wait_aux_op_finish(struct anx7625_data *ctx)
>  			       AP_AUX_CTRL_STATUS);
>  	if (val < 0 || (val & 0x0F)) {
>  		DRM_DEV_ERROR(dev, "aux status %02x\n", val);
> -		val = -EIO;
> +		return -EIO;
>  	}
>  
> -	return val;
> +	return 0;

This s/val/0/ change seems like a bug fix.  Could you please send that
as a separate patch at the start of the patch set?

> +}

regards,
dan carpenter


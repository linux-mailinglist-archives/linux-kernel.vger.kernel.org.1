Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB762244881
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 12:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgHNK4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 06:56:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49482 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgHNK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:56:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EAm0ED019383;
        Fri, 14 Aug 2020 10:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YVf5FoCiDmx//g4f29YFy952k+cHe4okX6wlg0hwp/8=;
 b=IG14Xl21IEnwYwIzRgqIoe+8REtaKqUG4vtnbIdEzeK8+4FIHQrAHvVHN1D4/T33VBGV
 6LHPCA5O2RmFqhXNpU76jDEwfCvLlsUbMsj7lfzLASiWi4WUk1gdM33U6QdWJ924jO89
 kL7UnM3ZwO3/Y0RfAp/qqTojBfp8MkdjvlCUoHSN6hLwajTrV0q5ffW9EaS3nRT299ln
 ILcGu8wdE1zdwYDJAArU29Ct5CbT4kBCq2vHxB2zkwgi20D4OnAs4hNzFa9lqCVuWGbM
 jHl27kj5UJ5bEPuT5bauYDsV4SEmpMBJRG//sU53UqD+LWkaXy5b4lHA5UoTCDaVBzjn 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32t2ye431r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Aug 2020 10:56:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EArWCi040932;
        Fri, 14 Aug 2020 10:56:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 32t5ycahmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Aug 2020 10:56:27 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07EAuOtO012838;
        Fri, 14 Aug 2020 10:56:25 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 10:56:23 +0000
Date:   Fri, 14 Aug 2020 13:56:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: audio: fix uninitialized value issue
Message-ID: <20200814105616.GP1793@kadam>
References: <b6a5c28b6812232c90426f77cbe60600f9a91019.1597389343.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a5c28b6812232c90426f77cbe60600f9a91019.1597389343.git.vaibhav.sr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008140084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 01:07:20PM +0530, Vaibhav Agarwal wrote:
> The current implementation for gbcodec_mixer_dapm_ctl_put() uses
> uninitialized gbvalue for comparison with updated value. This was found
> using static analysis with coverity.
> 
> Uninitialized scalar variable (UNINIT)
> 11. uninit_use: Using uninitialized value
> gbvalue.value.integer_value[0].
> 460        if (gbvalue.value.integer_value[0] != val) {
> 
> This patch fixes the issue with fetching the gbvalue before using it for
>     comparision.
> 
> Fixes: 6339d2322c47 ("greybus: audio: Add topology parser for GB codec")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> ---
> Changelog:
> v2: Fix the missing check for return value after get_control.
> ---
>  drivers/staging/greybus/audio_topology.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 2f9fdbdcd547..9f98691b2f5f 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -456,6 +456,18 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
>  	val = ucontrol->value.integer.value[0] & mask;
>  	connect = !!val;
>  
> +	ret = gb_pm_runtime_get_sync(bundle);
> +	if (ret)
> +		return ret;
> +
> +	ret = gb_audio_gb_get_control(module->mgmt_connection, data->ctl_id,
> +				      GB_AUDIO_INVALID_INDEX, &gbvalue);
> +	if (ret) {
> +		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
> +				    __func__, kcontrol->id.name);

gb_pm_runtime_put_autosuspend(bundle) on this error path?

> +		return ret;
> +	}

regards,
dan carpenter


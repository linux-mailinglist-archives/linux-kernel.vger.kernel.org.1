Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEC2FB708
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbhASJuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:50:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41322 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387607AbhASJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:35:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J9XO8w080442;
        Tue, 19 Jan 2021 09:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mPNMsGIPx1KtxDaTRvGKKYalFMRW2Q89hhpj3Ft7KuA=;
 b=qBsuDb8YsCZFSUK8Skivb6bTzRnP8acm/j6Fsuhe4tzAzqqCy+Gcvq5PhaCUtqCeWpyr
 szdEeKojXuQudqi9DriqLgAiGJcRUeLYJKESY/px6abvpt1xCvpO+ReKRZ8JKw8tg5eS
 06LhIYe05eaNKIz44tXAPCU3l24l/zoBJ6tlgEqVIarUDOFD1qW457x4hqmAmzzHJ5od
 njR+FpK82okUlpg5DF9/AVEQjzAIR4w3GzhweT6vWoxs8qaAr74Ag4kGBJabqKZR0nSq
 YwivJj97Szx0/Mpsn8em+WxO97EF16Jed5P65yFjihmdo+bAOSikIyOjU8Mxi17Z5pSa 9g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 363nnagbf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 09:34:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10J9VZ0t145481;
        Tue, 19 Jan 2021 09:34:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 364a2wbtvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 09:34:11 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10J9Y5LS024333;
        Tue, 19 Jan 2021 09:34:05 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 01:34:04 -0800
Date:   Tue, 19 Jan 2021 12:33:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Czekay <johannes.czekay@fau.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        jbwyatt4@gmail.com, gustavo@embeddedor.com,
        linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org,
        rkovhaev@gmail.com, nicolai.fischer@fau.de, hqjagain@gmail.com
Subject: Re: [PATCH 6/6] wlan-ng: clean up reused macros
Message-ID: <20210119093356.GL2696@kadam>
References: <20210118010955.48663-1-johannes.czekay@fau.de>
 <20210118010955.48663-7-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118010955.48663-7-johannes.czekay@fau.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 02:09:56AM +0100, Johannes Czekay wrote:
> This patch cleans up two "macro argument reuse" warnings by checkpatch.
> This should also make the code much more readable.
> 
> Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
> Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
> Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
> ---
>  drivers/staging/wlan-ng/p80211metastruct.h | 18 +-------
>  drivers/staging/wlan-ng/prism2mgmt.c       | 48 ++++++----------------
>  2 files changed, 14 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211metastruct.h b/drivers/staging/wlan-ng/p80211metastruct.h
> index 4adc64580185..e963227f797c 100644
> --- a/drivers/staging/wlan-ng/p80211metastruct.h
> +++ b/drivers/staging/wlan-ng/p80211metastruct.h
> @@ -114,22 +114,8 @@ struct p80211msg_dot11req_scan_results {
>  	struct p80211item_uint32 cfpollreq;
>  	struct p80211item_uint32 privacy;
>  	struct p80211item_uint32 capinfo;
> -	struct p80211item_uint32 basicrate1;
> -	struct p80211item_uint32 basicrate2;
> -	struct p80211item_uint32 basicrate3;
> -	struct p80211item_uint32 basicrate4;
> -	struct p80211item_uint32 basicrate5;
> -	struct p80211item_uint32 basicrate6;
> -	struct p80211item_uint32 basicrate7;
> -	struct p80211item_uint32 basicrate8;
> -	struct p80211item_uint32 supprate1;
> -	struct p80211item_uint32 supprate2;
> -	struct p80211item_uint32 supprate3;
> -	struct p80211item_uint32 supprate4;
> -	struct p80211item_uint32 supprate5;
> -	struct p80211item_uint32 supprate6;
> -	struct p80211item_uint32 supprate7;
> -	struct p80211item_uint32 supprate8;
> +	struct p80211item_uint32 basicrate[8];
> +	struct p80211item_uint32 supprate[8];
>  } __packed;
>  
>  struct p80211msg_dot11req_start {
> diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
> index 1bd36dc2b7ff..8540c3336907 100644
> --- a/drivers/staging/wlan-ng/prism2mgmt.c
> +++ b/drivers/staging/wlan-ng/prism2mgmt.c
> @@ -388,6 +388,7 @@ int prism2mgmt_scan_results(struct wlandevice *wlandev, void *msgp)
>  	struct hfa384x_hscan_result_sub *item = NULL;
>  
>  	int count;
> +	int i;
>  
>  	req = msgp;
>  
> @@ -437,42 +438,17 @@ int prism2mgmt_scan_results(struct wlandevice *wlandev, void *msgp)
>  		if (item->supprates[count] == 0)
>  			break;
>  
> -#define REQBASICRATE(N) \
> -	do { \
> -		if ((count >= (N)) && DOT11_RATE5_ISBASIC_GET(	\
> -			item->supprates[(N) - 1])) { \
> -			req->basicrate ## N .data = item->supprates[(N) - 1]; \
> -			req->basicrate ## N .status = \
> -				P80211ENUM_msgitem_status_data_ok; \
> -		} \
> -	} while (0)
> -
> -	REQBASICRATE(1);
> -	REQBASICRATE(2);
> -	REQBASICRATE(3);
> -	REQBASICRATE(4);
> -	REQBASICRATE(5);
> -	REQBASICRATE(6);
> -	REQBASICRATE(7);
> -	REQBASICRATE(8);
> -
> -#define REQSUPPRATE(N) \
> -	do { \
> -		if (count >= (N)) {					\
> -			req->supprate ## N .data = item->supprates[(N) - 1]; \
> -			req->supprate ## N .status = \
> -				P80211ENUM_msgitem_status_data_ok; \
> -		} \
> -	} while (0)
> -
> -	REQSUPPRATE(1);
> -	REQSUPPRATE(2);
> -	REQSUPPRATE(3);
> -	REQSUPPRATE(4);
> -	REQSUPPRATE(5);
> -	REQSUPPRATE(6);
> -	REQSUPPRATE(7);
> -	REQSUPPRATE(8);
> +	for (i = 0; i < 8; i++) {
> +		if (count > 1) {

This should be "i" instead of "1".  And conditions are more readable if
you put the part that changes first "if (variable < limit)" to avoid
backwards think.

	if (i < count) {

Or you could reverse it the other way:

	if (i >= count)
		break;

> +			if (DOT11_RATE5_ISBASIC_GET(item->supprates[i])) {
> +				req->basicrate[i].data = item->supprates[i];
> +				req->basicrate[i].status = P80211ENUM_msgitem_status_data_ok;
> +			}
> +
> +			req->supprate[i].data = item->supprates[i];
> +			req->supprate[i].status = P80211ENUM_msgitem_status_data_ok;
> +		}
> +	}

It's sort of surprising that we can change how we write this information
but we don't have to change how it is read.  I guess presumably it's
just dumped as hex to debugfs or something like that...  Who knows.  :/

regards,
dan carpenter


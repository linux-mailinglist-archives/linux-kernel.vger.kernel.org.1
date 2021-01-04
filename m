Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724E2E906B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 07:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbhADGXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 01:23:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbhADGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 01:23:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1046MU92156425;
        Mon, 4 Jan 2021 06:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=i3zLV37UoQGBxAAUgHBj/zVXWGYnaznsGYKDdTlH6Nw=;
 b=pdrcOjFamTYR+RdUDQaF1PJygf83I/A4YBJAbE1bmmlD4fkM0+NU/HKt9WoK5Jdw8WZ4
 hS0HW8vBO7luAwbX2rlfLeFdk1kdo50eP9YDifLjdtbgwBd6S9uttPFQLS/7XgxW3a90
 2fDitN/vJM2qG2jOZy/NK2UgvaZk2hwhY9ves/TLG/IjEmgP94Hsy3esUg5w6S9BGduM
 +B1WUtBQJ0iJPZHN5muGoP4pjM0QdxL5aVFM2iPqQd1O8tYr2TDjttUjlg4rWEap2cRS
 Ei9DvORCJMF82zHC2QNBdXyaRy5CKKJfgDLRXPbAyrySzgvR3JbevOLlRb7H9k4LvJx1 fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35tg8qtumw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 06:22:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1046KILc169108;
        Mon, 4 Jan 2021 06:22:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35uvcn24n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 06:22:29 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1046MMld020483;
        Mon, 4 Jan 2021 06:22:22 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 06:22:22 +0000
Date:   Mon, 4 Jan 2021 09:22:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Coiby Xu <coiby.xu@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] staging: greybus: fix stack size warning with UBSAN
Message-ID: <20210104062203.GP2831@kadam>
References: <20210103223541.2790855-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103223541.2790855-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 11:35:32PM +0100, Arnd Bergmann wrote:
> @@ -1050,78 +1088,28 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>  	strlcpy(temp_name, w->name, NAME_SIZE);
>  	snprintf(w->name, NAME_SIZE, "GB %d %s", module->dev_id, temp_name);
>  
> +	if (w->type > ARRAY_SIZE(gbaudio_widgets)) {
                    ^^

Off by one.  >= here.


> +		ret = -EINVAL;
> +		goto error;
> +	}
> +	*dw = gbaudio_widgets[w->type];
> +	dw->name = w->name;

regards,
dan carpenter


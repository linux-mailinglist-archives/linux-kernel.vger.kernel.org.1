Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502352E9773
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbhADOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:40:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59642 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:40:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104Ed2ll051392;
        Mon, 4 Jan 2021 14:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=za6fUHPraZkJSmgQd0MfL/D7Gta8uwv84NRnuMLMMAk=;
 b=UVpFBTbN68drUH/biQbbV0Lg2u2xzdSQRoiYbL6rxJBJFjygwCS5Mme5JUMa7MlAYEKz
 WL/eYoJKaSqYVP8zBFn5vhiGpNrYVF7EznmKJN8n7e443Bph+Fd0PeoMnmTUAAM2rXfd
 YT5vpAUMYvWHMWq8Fpg7NsjeTLHyZtp7djd9vTPkpJVKih9J5emvhaRG2kCvgdph8y+J
 /iXsncoHyTxI6LtUNuVg9JxL4vIOMmx4XGJdYlx7BY6TqC9y9jXst1Z74vGYDQYQx0hd
 SnVMchYDxy7/KnBOeyBBqQuNTXN6X97Ts6PXffahduiSy7FegEPQ05mJAS96FDvoLWDa 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35tgskmhmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 14:40:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104EWhfq162238;
        Mon, 4 Jan 2021 14:40:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35uxnr7tqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 14:40:05 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104Ee2hJ026040;
        Mon, 4 Jan 2021 14:40:02 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 06:40:01 -0800
Date:   Mon, 4 Jan 2021 17:39:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Song Chen <chensong_2000@189.cn>
Cc:     greg@kroah.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: board: Remove macro board_staging
Message-ID: <20210104143951.GS2809@kadam>
References: <1608890085-1267-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608890085-1267-1-git-send-email-chensong_2000@189.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 05:54:45PM +0800, Song Chen wrote:
> Macro is not supposed to have flow control in it's
> statement, remove.
> 

It took me a long time to figure out what this commit message is saying.
It turns out that it is inspired by checkpatch.  Forget all that nonsense
about "imperative tense" commit messages.  The only thing which matters
for drivers/staging/ is that the commit message is clear what the
problem is and how you are going to fix it.

  Checkpatch complains that macros should not have return statements in
  them.  "WARNING: Macros with flow control statements should be avoided"
  So I am removing the board_staging() macro and open coding it.

But in this case the checkpatch warning is a false positive.  The issue
that checkpatch is trying to fix is that we don't want return, break, or
goto statements in a macro.  Otherwise the code looks like this:

	frob();
	frob();
	frob();

It has three invisible return statements and we don't know what error
codes it is returning.

In this case, the board_staging() driver is implementing whole functions
so there are no hidden gotos.

That said, the board_staging() macro looks pretty rubbish.  It breaks
cscope.  It's not readable.  So I quite like the patch, it just needs a
new commit message.  It can be simple:

    It's cleaner and less code to delete the board_staging().

> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  drivers/staging/board/armadillo800eva.c | 10 ++++++----
>  drivers/staging/board/board.h           | 11 -----------
>  drivers/staging/board/kzm9d.c           | 18 ++++++++++--------
>  3 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/board/armadillo800eva.c b/drivers/staging/board/armadillo800eva.c
> index 0225234..a7e8487 100644
> --- a/drivers/staging/board/armadillo800eva.c
> +++ b/drivers/staging/board/armadillo800eva.c
> @@ -80,9 +80,11 @@ static const struct board_staging_dev armadillo800eva_devices[] __initconst = {
>  
>  static void __init armadillo800eva_init(void)

I think device_initcall() functions need to return int.  I am surprised
this even compiles.

>  {
> -	board_staging_gic_setup_xlate("arm,pl390", 32);
> -	board_staging_register_devices(armadillo800eva_devices,
> -				       ARRAY_SIZE(armadillo800eva_devices));
> +	if (of_machine_is_compatible("renesas,armadillo800eva")) {

Reverse this if statement.

	if (!of_machine_is_compatible("renesas,armadillo800eva"))
		return 0;


> +		board_staging_gic_setup_xlate("arm,pl390", 32);
> +		board_staging_register_devices(armadillo800eva_devices,
> +					       ARRAY_SIZE(armadillo800eva_devices));
> +	}
>  }
>  
> -board_staging("renesas,armadillo800eva", armadillo800eva_init);
> +device_initcall(armadillo800eva_init);
> diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
> index 5609daf..f1c233e 100644
> --- a/drivers/staging/board/board.h
> +++ b/drivers/staging/board/board.h
> @@ -32,15 +32,4 @@ int board_staging_register_device(const struct board_staging_dev *dev);
>  void board_staging_register_devices(const struct board_staging_dev *devs,
>  				    unsigned int ndevs);
>  
> -#define board_staging(str, fn)			\
> -static int __init runtime_board_check(void)	\
> -{						\
> -	if (of_machine_is_compatible(str))	\
> -		fn();				\
> -						\
> -	return 0;				\
> -}						\
> -						\
> -device_initcall(runtime_board_check)
> -
>  #endif /* __BOARD_H__ */
> diff --git a/drivers/staging/board/kzm9d.c b/drivers/staging/board/kzm9d.c
> index d449a83..72b1ad45 100644
> --- a/drivers/staging/board/kzm9d.c
> +++ b/drivers/staging/board/kzm9d.c
> @@ -12,15 +12,17 @@ static struct resource usbs1_res[] __initdata = {
>  
>  static void __init kzm9d_init(void)

Same.  return int.

>  {
> -	board_staging_gic_setup_xlate("arm,pl390", 32);
> +	if (of_machine_is_compatible("renesas,kzm9d")) {

Same reverse the if statement.

regards,
dan carpenter


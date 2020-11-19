Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231872B9784
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgKSQLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:11:53 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:20306 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgKSQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:11:53 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJGB4KP020481;
        Thu, 19 Nov 2020 16:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pps0720;
 bh=6jw4ejOJMXX+Yv3O+A+xmea6DZ7CwF56Nzrqpf3yDhY=;
 b=Ri2kX+tL1nkGj1wCDkNmhMmjUVYqTzPSPxHPB6tpAT2QCHER8slMl59PLSqWRYqdufMe
 fhrFBY7DNDihOX8dhOn7wjyKMRqjqQFU0t9JtbjX6VDpIyWJLNZ0R2Aoa3hqosTCNJNM
 ulzFbIgj9cy311N8ru2gYCTsgA2FU3am7myOyA18X0gnO9ZW9VjUlculHlC894UAINff
 rplbmQIbsN3fbmFrPdPtAnFlcDCKug+EcjTqVO9Ouv1h3qTiSBE5MlNC7SOOzvZ0aKYt
 oNoKmHPuoKfbPIZNvP1OMuXyCxbIjGRCoo67vxpGCHOqWBS6scuecTZN6D9/o+AIorAl CA== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 34vgcbmya5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 16:11:38 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 5B26251;
        Thu, 19 Nov 2020 16:11:38 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.129.62])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 6B5C945;
        Thu, 19 Nov 2020 16:11:37 +0000 (UTC)
Date:   Thu, 19 Nov 2020 10:11:37 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH v2] misc/sgi-xp: Replace in_interrupt() usage
Message-ID: <20201119161108.GA1798712@swahl-home.5wahls.com>
References: <20201119081354.836813-1-bigeasy@linutronix.de>
 <X7YwZZgvk92Cghl7@kroah.com>
 <20201119103151.ppo45mj53ulbxjx4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119103151.ppo45mj53ulbxjx4@linutronix.de>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Thu, Nov 19, 2020 at 11:31:51AM +0100, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The usage of in_interrupt() in xpc_partition_disengaged() is clearly
> intended to avoid canceling the timeout timer when the function is invoked
> from the timer callback.
> 
> While in_interrupt() is deprecated and ill defined as it does not provide
> what the name suggests it catches the intended case.
> 
> Add an argument to xpc_partition_disengaged() which is true if called
> from timer and otherwise false.
> Use del_timer_sync() instead of del_singleshot_timer_sync() which is the
> same thing.
> 
> Note: This does not prevent reentrancy into the function as the function
> has no concurrency control and timer callback and regular task context
> callers can happen concurrently on different CPUs or the timer can
> interrupt the task context before it is able to cancel it.
> 
> While the only driver which is providing the arch_xpc_ops callbacks
> (xpc_uv) seems not to have a reentrancy problem and the only negative
> effect would be a double dev_info() entry in dmesg, the whole mechanism is
> conceptually broken.
> 
> But that's not subject of this cleanup endeavour and left as an exercise to
> the folks who might have interest to make that code fully correct.
> 
> [bigeasy: Add the argument, use del_timer_sync().]
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Cliff Whickman <cpw@sgi.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Robin Holt <robinmholt@gmail.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> ---
> v1…v2: Use xpc_partition_disengaged_from_timer() and don't export the
>        argument. Suggested by Greg.
> 
>  drivers/misc/sgi-xp/xpc.h           |  1 +
>  drivers/misc/sgi-xp/xpc_main.c      |  2 +-
>  drivers/misc/sgi-xp/xpc_partition.c | 20 +++++++++++++++-----
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/sgi-xp/xpc.h b/drivers/misc/sgi-xp/xpc.h
> index 71db60edff655..225f2bb84e39b 100644
> --- a/drivers/misc/sgi-xp/xpc.h
> +++ b/drivers/misc/sgi-xp/xpc.h
> @@ -634,6 +634,7 @@ extern int xpc_setup_rsvd_page(void);
>  extern void xpc_teardown_rsvd_page(void);
>  extern int xpc_identify_activate_IRQ_sender(void);
>  extern int xpc_partition_disengaged(struct xpc_partition *);
> +extern int xpc_partition_disengaged_from_timer(struct xpc_partition *part);
>  extern enum xp_retval xpc_mark_partition_active(struct xpc_partition *);
>  extern void xpc_mark_partition_inactive(struct xpc_partition *);
>  extern void xpc_discovery(void);
> diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
> index e5244fc1dab30..84610bbcc1314 100644
> --- a/drivers/misc/sgi-xp/xpc_main.c
> +++ b/drivers/misc/sgi-xp/xpc_main.c
> @@ -179,7 +179,7 @@ xpc_timeout_partition_disengage(struct timer_list *t)
>  
>  	DBUG_ON(time_is_after_jiffies(part->disengage_timeout));
>  
> -	(void)xpc_partition_disengaged(part);
> +	xpc_partition_disengaged_from_timer(part);
>  
>  	DBUG_ON(part->disengage_timeout != 0);
>  	DBUG_ON(xpc_arch_ops.partition_engaged(XPC_PARTID(part)));
> diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
> index 57df06820bae2..1999d02923dee 100644
> --- a/drivers/misc/sgi-xp/xpc_partition.c
> +++ b/drivers/misc/sgi-xp/xpc_partition.c
> @@ -262,8 +262,8 @@ xpc_get_remote_rp(int nasid, unsigned long *discovered_nasids,
>   * from us. Though we requested the remote partition to deactivate with regard
>   * to us, we really only need to wait for the other side to disengage from us.
>   */
> -int
> -xpc_partition_disengaged(struct xpc_partition *part)
> +static int __xpc_partition_disengaged(struct xpc_partition *part,
> +				      bool from_timer)
>  {
>  	short partid = XPC_PARTID(part);
>  	int disengaged;
> @@ -289,9 +289,9 @@ xpc_partition_disengaged(struct xpc_partition *part)
>  		}
>  		part->disengage_timeout = 0;
>  
> -		/* cancel the timer function, provided it's not us */
> -		if (!in_interrupt())
> -			del_singleshot_timer_sync(&part->disengage_timer);
> +		/* Cancel the timer function if not called from it */
> +		if (!from_timer)
> +			del_timer_sync(&part->disengage_timer);
>  
>  		DBUG_ON(part->act_state != XPC_P_AS_DEACTIVATING &&
>  			part->act_state != XPC_P_AS_INACTIVE);
> @@ -303,6 +303,16 @@ xpc_partition_disengaged(struct xpc_partition *part)
>  	return disengaged;
>  }
>  
> +int xpc_partition_disengaged(struct xpc_partition *part)
> +{
> +	return __xpc_partition_disengaged(part, false);
> +}
> +
> +int xpc_partition_disengaged_from_timer(struct xpc_partition *part)
> +{
> +	return __xpc_partition_disengaged(part, true);
> +}
> +
>  /*
>   * Mark specified partition as active.
>   */
> -- 
> 2.29.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise

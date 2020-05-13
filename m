Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8FF1D1DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 20:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbgEMSmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 14:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387492AbgEMSma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:42:30 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2031205CB;
        Wed, 13 May 2020 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589395350;
        bh=kAXfoNhJQ4Rt3gH00cO4/PLU7dM6uI3o++14BZ+s2UA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aU+X2cSyyOZQLMafXp2I+o70bu3ARsJUDK57o2XOttzxaJeIcMmFd8FvA6YwInylR
         u/KUf9gMcrVYv3EKCp4MokeXb62gEHgm89XzIsVRPormwo05C1kFPYJRzsR3m4ge6P
         iHgAGuWKFlnxqz7rBjHTydq70ksfrhU/ptwgvcJI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EDE6F352352C; Wed, 13 May 2020 11:42:29 -0700 (PDT)
Date:   Wed, 13 May 2020 11:42:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 10/10] rcu: Nocb (de)activate through sysfs
Message-ID: <20200513184229.GX2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-11-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-11-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:14PM +0200, Frederic Weisbecker wrote:
> Not for merge.
> 
> Make nocb toggable for a given CPU using:
> 	/sys/devices/system/cpu/cpu*/hotplug/nocb
> 
> This is only intended for those who want to test this patchset. The real
> interfaces will be cpuset/isolation and rcutorture.

Makes sense!

Speaking of rcutorture, what level of testing has this series undergone?

							Thanx, Paul

> Not-Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/cpu.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 2371292f30b0..ac6283dcb897 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2208,10 +2208,33 @@ static ssize_t show_cpuhp_fail(struct device *dev,
>  
>  static DEVICE_ATTR(fail, 0644, show_cpuhp_fail, write_cpuhp_fail);
>  
> +static ssize_t write_nocb(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t count)
> +{
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val == 0)
> +		rcu_nocb_cpu_deoffload(dev->id);
> +	else if (val == 1)
> +		rcu_nocb_cpu_offload(dev->id);
> +	else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(nocb, 0644, NULL, write_nocb);
> +
>  static struct attribute *cpuhp_cpu_attrs[] = {
>  	&dev_attr_state.attr,
>  	&dev_attr_target.attr,
>  	&dev_attr_fail.attr,
> +	&dev_attr_nocb.attr,
>  	NULL
>  };
>  
> -- 
> 2.25.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC9273751
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgIVA0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbgIVA0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:26:30 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42DB23A79;
        Tue, 22 Sep 2020 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600734389;
        bh=eLAh2ypGQpjglb6NTTFyP44k517JfwtKW4jC6CAnNI8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EvxFyPecpDJjMJGWcmiyMSKkhoCQvKEgTMdrhZkkQcQZtE3K8jmsnZ+ucFv+wjl7g
         l6unZ6vUvwXUZaT0klE0SKAVrxjR4IF2D1wItd8Bu3i94kLUpw/xMtynQK1Uz1ICfh
         C3COnKdCvTopYw6HVyxIC3BMJavAzX+pvdhSLwJM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 937E035226C1; Mon, 21 Sep 2020 17:26:29 -0700 (PDT)
Date:   Mon, 21 Sep 2020 17:26:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 12/12] rcu: Nocb (de)activate through sysfs
Message-ID: <20200922002629.GS29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-13-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921124351.24035-13-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:43:51PM +0200, Frederic Weisbecker wrote:
> Not for merge.
> 
> Make nocb toggable for a given CPU using:
> 	/sys/devices/system/cpu/cpu*/hotplug/nocb
> 
> This is only intended for those who want to test this patchset. The real
> interfaces will be cpuset/isolation and rcutorture.

Excellent choice for testing in the near term!

How does rcutorture fare with this series if an additional kthread toggles
offloading on and off continually?

All questions and concerns aside, excellent progress and nice work!!!

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
> index 6ff2578ecf17..a36634113b8e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2224,10 +2224,33 @@ static ssize_t show_cpuhp_fail(struct device *dev,
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
> 2.28.0
> 

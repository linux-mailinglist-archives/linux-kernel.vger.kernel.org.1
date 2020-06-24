Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5C207B83
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 20:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406079AbgFXS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 14:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405956AbgFXS2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:28:39 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4E920738;
        Wed, 24 Jun 2020 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593023319;
        bh=MzwuoMAmLth+NFCHyQ1yJFVWJK3LQtCK+GPYwfcCChw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CEWA/FNOfQqqOptQ/cRr21qM7soPky4gD1f8lJGD94BX3L1Uex2TUndon/Deu9hEf
         kcq9O35m8ErA442XRbUoTt2q1x4/vJ3RFfA6P+3HF0x3LVTGknGeLVlm/XOLjFkEhN
         5R87+xMfyPEsUuIQXy8ow47pzAlC+JOQ8RxHKrdk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8D55C35228BC; Wed, 24 Jun 2020 11:28:39 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:28:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH linux-next] refperf: __srcu_struct_srcu_refctl_scale
 can be static
Message-ID: <20200624182839.GI9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202006250116.MYIhw039%lkp@intel.com>
 <20200624174709.GA165567@6b4061f35fb6>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624174709.GA165567@6b4061f35fb6>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 01:47:09AM +0800, kernel test robot wrote:
> 
> Signed-off-by: kernel test robot <lkp@intel.com>

This gets me the following from gcc version 7.5.0:

kernel/rcu/refscale.c:162:1: error: duplicate ‘static’
 static DEFINE_STATIC_SRCU(srcu_refctl_scale);
 ^~~~~~

Is the concern the __srcu_struct_srcu_refctl_scale that is defined
as non-static?  Last I checked, non-static was required in order for
the ___srcu_struct_ptrs mechanism to correctly allocate the needed
per-CPU data.

						Thanx, Paul

> ---
>  refscale.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index d9291f883b5428..4097b53867b33d 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -159,7 +159,7 @@ static struct ref_scale_ops rcu_ops = {
>  };
>  
>  // Definitions for SRCU ref scale testing.
> -DEFINE_STATIC_SRCU(srcu_refctl_scale);
> +static DEFINE_STATIC_SRCU(srcu_refctl_scale);
>  static struct srcu_struct *srcu_ctlp = &srcu_refctl_scale;
>  
>  static void srcu_ref_scale_read_section(const int nloops)

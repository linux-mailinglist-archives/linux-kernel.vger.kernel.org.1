Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC37284FF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJFQgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFQgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:36:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E77206F7;
        Tue,  6 Oct 2020 16:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602002175;
        bh=+CB8jjMst8zzdLXuxv7WzYg9JvfJ4Ew3REwkQs+PixE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CFefulwnACxWtiRop2t5IpgD8jLNnu2F+9ovGVNZgl5pYpfGBu+m6GGVF3emU3D/T
         3A8qY4qMJb0BJfK8JvghLHZqakujmBI4h9Zza2q2iciT/0hgSRJk/HHZLGQFT/2B3T
         qC00C+rQ49KsEvikaOQEoJPAkr6mKbpndBhcqc3Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 198FB3520A8C; Tue,  6 Oct 2020 09:36:15 -0700 (PDT)
Date:   Tue, 6 Oct 2020 09:36:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: RCU: Requirements.rst: fix a list block
Message-ID: <20201006163615.GL29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1601990386.git.mchehab+huawei@kernel.org>
 <9f666389cd803b392bf422d31e50c5f9f8c9474c.1601990386.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f666389cd803b392bf422d31e50c5f9f8c9474c.1601990386.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 03:21:32PM +0200, Mauro Carvalho Chehab wrote:
> As warned by Sphinx:
> 	.../Documentation/RCU/Design/Requirements/Requirements.rst:1959: WARNING: Unexpected indentation.
> 
> The list block is missing a space before it, making Sphinx
> to get it wrong.
> 
> Fixes: 2a721e5f0b2c ("docs: Update RCU's hotplug requirements with a bit about design")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/Design/Requirements/Requirements.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 98557fee90cc..9f362827133a 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1954,6 +1954,7 @@ offline CPUs.  However, as a debugging measure, the FQS loop does splat
>  if offline CPUs block an RCU grace period for too long.
>  
>  An offline CPU's quiescent state will be reported either:
> +
>  1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
>  2.  When grace period initialization (``rcu_gp_init()``) detects a
>      race either with CPU offlining or with a task unblocking on a leaf
> -- 
> 2.26.2
> 

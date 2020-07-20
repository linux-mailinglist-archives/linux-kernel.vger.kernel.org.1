Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA468226982
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgGTQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 12:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732614AbgGTQ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:26:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B9222CB1;
        Mon, 20 Jul 2020 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595262406;
        bh=1hv6+9s9uHgrO4FGazjtcjrsMtVaE6v2htgNsjv4PEU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gW02FtPTErbRzEv9138QhaWszPxdiiuy1mSoVmiSimp+ELKwxdsAeBsgb4TeQNfDv
         n4sdFWI1Db7DVceSzZaqIyY+3OacV1FHJv61Hk0vq3tq6THAfsgVLnNv7X/YCo50r5
         ve5LSq8NdPk1Acr1TUgdqe8yYgh6rc0N5ArShaIQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E0A563522A8C; Mon, 20 Jul 2020 09:26:45 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:26:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] refperf: avoid null pointer dereference when buf
 fails to allocate
Message-ID: <20200720162645.GS9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200716143856.1708123-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716143856.1708123-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:38:56PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently in the unlikely event that buf fails to be allocated it
> is dereferenced a few times.  Use the errexit flag to determine if
> buf should be written to to avoid the null pointer dereferences.
> 
> Addresses-Coverity: ("Dereference after null check")
> Fixes: f518f154ecef ("refperf: Dynamically allocate experiment-summary output buffer")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Good catch, applied, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/refscale.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index d9291f883b54..952595c678b3 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -546,9 +546,11 @@ static int main_func(void *arg)
>  	// Print the average of all experiments
>  	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
>  
> -	buf[0] = 0;
> -	strcat(buf, "\n");
> -	strcat(buf, "Runs\tTime(ns)\n");
> +	if (!errexit) {
> +		buf[0] = 0;
> +		strcat(buf, "\n");
> +		strcat(buf, "Runs\tTime(ns)\n");
> +	}
>  
>  	for (exp = 0; exp < nruns; exp++) {
>  		u64 avg;
> -- 
> 2.27.0
> 

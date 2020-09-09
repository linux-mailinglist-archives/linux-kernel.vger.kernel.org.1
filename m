Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90BF262BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIIJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgIIJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:24:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EBAC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:24:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so1625609pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w90SDair7JoYZHSRoRms18sB50MZLQwaofVsG2qPpa8=;
        b=EJ/2Q9mh4RsgGvFBloK2ugShDt2KEkXAUz0NeIxbxLw+gXMFwFOR2UefTyJIGgIvPG
         ZDQVdt1k2GMTfxz/eCpTmcD/UamwfI+0hYr9HPNEYQLlyoZNXpIDELDe0En9HXsmd5me
         h01y22hF1VBRWadrSvKeL2m8CjS4CUyHDX3KMH5hi/gp/wU6TLu8NyvxsDj9WDW8esRX
         hvM8/xVnieYm4raxwIXM4opmZ9lIbzsru80k8koVspDr4Pbvegv0zwDeCqB1ABdcPM74
         M+9CcWCt/Ycu5ctUDLkPKNJhebloHpyf3VyrsvE5lPJNnOdsRb1j7maQp3OpiBYSsHBF
         o3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w90SDair7JoYZHSRoRms18sB50MZLQwaofVsG2qPpa8=;
        b=r8lNdRFD4dj7zq0+ELd8uZV9PpLeKsd6xJHv7TI+0nLctUXG0h0ecAFs9j13+sTxZW
         QMv8tQWvZp6hg4vk4U58lWB/Hj/WtsSOsMaqwpEvo99DY3SRvAIwgxeLHmCw88nEvfdS
         dglo8eYBMunTy2kQQEo98boNuIBu60GHq8m4O5K7KlZYV0EMeFhUXxz/OYFkkmcgWPV7
         Hmm3ykNrKghTtfQNFwLZ+5cEPtAl7JyhZqzDNhqN6f+Fh1fiaIJ3AA73TINJ+ouRXDA0
         hDWCQlhTH0Acd/5o9UrwFD9DimAeCV1bALnN/jLFJecun/GditC2runOb7+LwX24oK2q
         MZLQ==
X-Gm-Message-State: AOAM533pxBNa0MkCceLYck+iYf9KvzTKcOMnIb87t6M0o3n92rdo/MQQ
        dLvSprDfPH8ZO+Ie4CkUsRxlVR957NPGMpj9
X-Google-Smtp-Source: ABdhPJwDC7CCcMjIw2sNP/CE7OjrggwmsplFHFFErgXAaC/qgWnpNcK/Vyr8gJ9TXcYCtvwwmagIWA==
X-Received: by 2002:a63:4c57:: with SMTP id m23mr2237110pgl.77.1599643456997;
        Wed, 09 Sep 2020 02:24:16 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id q5sm2042175pfn.172.2020.09.09.02.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:24:16 -0700 (PDT)
Subject: Re: [PATCH kernel] srcu: Fix static initialization
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <20200908144306.33355-1-aik@ozlabs.ru>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <cc25257d-804e-8cf7-150b-e6bdbaf184be@ozlabs.ru>
Date:   Wed, 9 Sep 2020 19:24:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200908144306.33355-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2020 00:43, Alexey Kardashevskiy wrote:
> init_srcu_struct_nodes() is called with is_static==true only internally
> and when this happens, the srcu->sda is not initialized in
> init_srcu_struct_fields() and we crash on dereferencing @sdp.
> 
> This fixes the crash by moving "if (is_static)" out of the loop which
> only does useful work for is_static=false case anyway.
> 
> Found by syzkaller.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  kernel/rcu/srcutree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index c100acf332ed..49b54a50bde8 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -135,6 +135,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
>  				   levelspread[level - 1];
>  	}
>  
> +	if (is_static)
> +		return;

Actually, this is needed here too:

 if (!ssp->sda)
         return;

as
ssp->sda = alloc_percpu(struct srcu_data)

can fail if the process is killed too soon - it is quite easy to get
this situation with syzkaller (syscalls fuzzer)

Makes sense?


> +
>  	/*
>  	 * Initialize the per-CPU srcu_data array, which feeds into the
>  	 * leaves of the srcu_node tree.
> @@ -161,8 +164,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
>  		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
>  		sdp->ssp = ssp;
>  		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> -		if (is_static)
> -			continue;
>  
>  		/* Dynamically allocated, better be no srcu_read_locks()! */
>  		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
> 

-- 
Alexey

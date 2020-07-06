Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A662161B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 00:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGFWw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 18:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgGFWw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:52:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7280520723;
        Mon,  6 Jul 2020 22:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594075977;
        bh=/zPTzdT52DxAQxEtTuQDG2kRipe5LYxYbAjAVaIgbGI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CUGekMk5km9Tt2x5clXP5WC900nnaIvlUkT4PvjpgplTviRqi6MifzgBh3AiO/EGJ
         JSW99Jt0ohW8QAXq4QNQYhtF2hl2pA+Ipbb1hrN7Ha136yfmKgi7yml9EH2s7QZFcA
         5jot/rxWeuv+Y3uIWdIfYLglnG1PR7kzovACD/4g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5A0D53522637; Mon,  6 Jul 2020 15:52:57 -0700 (PDT)
Date:   Mon, 6 Jul 2020 15:52:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] locktorture: make function
 torture_percpu_rwsem_init() static
Message-ID: <20200706225257.GP9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200703050527.67249-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703050527.67249-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 01:05:27PM +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> kernel/locking/locktorture.c:569:6: warning:
>  symbol 'torture_percpu_rwsem_init' was not declared. Should it be static?
> 
> And this function is not used outside of locktorture.c,
> so this commit marks it static.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thank you!!!

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 9cfa5e89cff7..62d215b2e39f 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -566,7 +566,7 @@ static struct lock_torture_ops rwsem_lock_ops = {
>  #include <linux/percpu-rwsem.h>
>  static struct percpu_rw_semaphore pcpu_rwsem;
>  
> -void torture_percpu_rwsem_init(void)
> +static void torture_percpu_rwsem_init(void)
>  {
>  	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
>  }
> 

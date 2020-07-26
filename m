Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1D22E2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 00:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGZWBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 18:01:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44236 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGZWBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 18:01:54 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jzoiA-0002BQ-0a; Sun, 26 Jul 2020 22:01:38 +0000
Date:   Mon, 27 Jul 2020 00:01:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     oleg@redhat.com, ebiederm@xmission.com, liuzhiqiang26@huawei.com,
        guro@fb.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] signal: fix typo in comment
Message-ID: <20200726220137.v4yr2ln5nkigwxm4@wittgenstein>
References: <20200724090531.GA14409@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724090531.GA14409@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:05:31AM +0200, Pavel Machek wrote:
> Fix typo in comment.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

Applied to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fixes

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index ee22ec78fd6d..6f16f7c5d375 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -719,7 +719,7 @@ static int dequeue_synchronous_signal(kernel_siginfo_t *info)
>  	 * Return the first synchronous signal in the queue.
>  	 */
>  	list_for_each_entry(q, &pending->list, list) {
> -		/* Synchronous signals have a postive si_code */
> +		/* Synchronous signals have a positive si_code */
>  		if ((q->info.si_code > SI_USER) &&
>  		    (sigmask(q->info.si_signo) & SYNCHRONOUS_MASK)) {
>  			sync = q;
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597712400A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 03:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHJBI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 21:08:28 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:11531 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgHJBI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 21:08:28 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BPyWs6XnSz5h;
        Mon, 10 Aug 2020 03:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597021706; bh=chu0ZBeiZ8dGi27gbnG6aICuw6HQae/zeFgdiN9tYD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dynOzaSMmzQWZ1ARXQNGIIxryl8ZRdGN0rOBvGSToVIRRo1E/sIN1sNDy51yih4ln
         xCsQAzdm7FvmxPh8+OGuOMiS7ekEKrDQXGxmprFebZ/+JcmprpPuDSDKpOHBds4taT
         8PzHC//ooZPKKztW4O4z3I7mJrz+0K7FwhNEMol+VCO2jkszpiLzWFToeQeITPDbB1
         /iE9Bp7GyfVyVHPp8S4EUiXQtprBBjjxDf/FrijYBkR+ZdS8x1+F35E0nqYDUhUZTA
         qqhloI9AuGMMyWfrqtKhVqWlJUhv0npFp8Ly+GGx9GBz2bw0WpoeKY6yKh4Ofaicoh
         L5vqRr8P6CzVA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 03:08:24 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: simplify locking
Message-ID: <20200810010824.GB13107@qmqm.qmqm.pl>
References: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
 <40871bc7-2d6c-10d4-53b3-0aded21edf3b@gmail.com>
 <20200809223030.GB5522@qmqm.qmqm.pl>
 <8850c09f-4b24-7ab2-a0f7-e0d752f5a404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8850c09f-4b24-7ab2-a0f7-e0d752f5a404@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 03:21:47AM +0300, Dmitry Osipenko wrote:
> 10.08.2020 01:30, Michał Mirosław пишет:
> > On Mon, Aug 10, 2020 at 12:40:04AM +0300, Dmitry Osipenko wrote:
> >> 10.08.2020 00:16, Michał Mirosław пишет:
> >>> Simplify regulator locking by removing locking around locking. rdev->ref
> >>> is now accessed only when the lock is taken. The code still smells fishy,
> >>> but now its obvious why.
> >>>
> >>> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> >>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> >>> ---
> >>>  drivers/regulator/core.c         | 37 ++++++--------------------------
> >>>  include/linux/regulator/driver.h |  1 -
> >>>  2 files changed, 6 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> >>> index 9e18997777d3..b0662927487c 100644
> >>> --- a/drivers/regulator/core.c
> >>> +++ b/drivers/regulator/core.c
> >>> @@ -45,7 +45,6 @@
> >>>  	pr_debug("%s: " fmt, rdev_get_name(rdev), ##__VA_ARGS__)
> >>>  
> >>>  static DEFINE_WW_CLASS(regulator_ww_class);
> >>> -static DEFINE_MUTEX(regulator_nesting_mutex);
> >>>  static DEFINE_MUTEX(regulator_list_mutex);
> >>>  static LIST_HEAD(regulator_map_list);
> >>>  static LIST_HEAD(regulator_ena_gpio_list);
> >>> @@ -150,32 +149,13 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
> >>>  static inline int regulator_lock_nested(struct regulator_dev *rdev,
> >>>  					struct ww_acquire_ctx *ww_ctx)
> >>>  {
> >>> -	bool lock = false;
> >>>  	int ret = 0;
> >>>  
> >>> -	mutex_lock(&regulator_nesting_mutex);
> >>> +	if (ww_ctx || !mutex_trylock_recursive(&rdev->mutex.base))
> >>
> >> Have you seen comment to the mutex_trylock_recursive()?
> >>
> >> https://elixir.bootlin.com/linux/v5.8/source/include/linux/mutex.h#L205
> >>
> >>  * This function should not be used, _ever_. It is purely for hysterical GEM
> >>  * raisins, and once those are gone this will be removed.
> >>
> >> I knew about this function and I don't think it's okay to use it, hence
> >> this is why there is that "nesting_mutex" and "owner" checking.
> >>
> >> If you disagree, then perhaps you should make another patch to remove
> >> the stale comment to trylock_recursive().
> > 
> > I think that reimplementing the function just to not use it is not the
> > right solution. The whole locking protocol is problematic and this patch
> > just uncovers one side of it.
> 
> It's not clear to me what is uncovered, the ref_cnt was always accessed
> under lock. Could you please explain in a more details?
> 
> Would be awesome if you could improve the code, but then you should
> un-deprecate the trylock_recursive() before making use of it. Maybe
> nobody will mind and it all will be good in the end.

This might be a religious argument. Having said that: I believe using
a deprecated function is better than open coding it. Otherwise it would
be forbidden (ie. removed), not just deprecated.

Of course this assumes that you *really* need a recursive mutex here.

Best Regards,
Michał Mirosław

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10526ACAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgIOS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:56:32 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:13189 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbgIOSzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:55:16 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BrXV63fvqz8j;
        Tue, 15 Sep 2020 20:55:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1600196110; bh=NaC/VRbEWEYMUBHMHJkGwyKqbQJ++oRmOocrI9IyLZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gklWQqNUqMthGQTu4sKojKm8eWYYEwfetwjgeTQs3Rj83U3Cvnwazh4vsrsSp/OAw
         NIiNqUuc8QziJoOK2ePWpEIujm9VwQLDxqCkV/kWGA/rPU3AEQlyqAjg79Nwd/0uhq
         0Sf2jk/2KAzAD6z5G2gFhPV0TVCgycKzjef8jg/R4bAsuFTKQSatEJHCVbmvhRh6B6
         h2yV/b7Jw2jgSZmMq1PbRJQfNVDIU84ncOaZnXW1xTp6Kp8FnfxjesqEOVJQwh6pcP
         lWFQ3NjKrFg0LHruBH6YdBYC9UoXYx0zrIakwe4xexXSwkRKJ2ekSLuKgtqgIM0jIA
         ZizzXglqWlc7g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 15 Sep 2020 20:55:06 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 0/3] regulator: unexport regulator_lock/unlock()
Message-ID: <20200915185506.GA24017@qmqm.qmqm.pl>
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
 <159950194954.52863.7080307258573052895.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159950194954.52863.7080307258573052895.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 07:05:49PM +0100, Mark Brown wrote:
> On Mon, 10 Aug 2020 06:33:30 +0200, Micha³ Miros³aw wrote:
> > This removes regulator_lock/unlock() calls around
> > regulator_notifier_call_chain() as they are redundant - drivers
> > already have to guarantee regulator_dev's existence during the call.
> > 
> > This should make reasoing about the lock easier, as this was the only
> > use outside regulator core code.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/3] regulator: don't require mutex for regulator_notifier_call_chain()
>       commit: 3bca239d6184df61a619d78764e0481242d844b4
> [2/3] regulator: remove locking around regulator_notifier_call_chain()
>       commit: e9c142b0d2c08178a9e146d47d8fe397373bda3e
> [3/3] regulator: unexport regulator_lock/unlock()
>       (no commit info)
[...]

It looks like the third one didn't get in? (Can't see it in the
for-next branch).

Best Regards
Micha³ Miros³aw

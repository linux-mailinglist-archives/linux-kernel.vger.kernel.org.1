Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F64240FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgHJTZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 15:25:54 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40562 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgHJTZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:25:50 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQQt43t5Lz2d;
        Mon, 10 Aug 2020 21:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597087548; bh=96ltwqbn2GOc+mKdVGQPN+AplT8W3CJs2uYbud2i7c8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VhGKPDGz3aEeFZK4MWHoiuExtTuAckut/jzZEPfujlMdVn+U4jBEjjOpgIy9YWKd2
         zx2vLgzWAVnwsEe8apeH5xdsH2JnPY4couOheSd5F+p5VUn4Li+tCJ28Y7IgeK3eh/
         FW0vMD6grmZhH+rVB1bkGDYkKUwLrZU3xwvfmUoXnIE7AFSbdG8HWXO975v3lX8aeR
         f7WZvgKywYDO+FhkZLSjv3a0iAchFQHazYB8oyH0booMqmt85z2DAlgtucKt8+fqMy
         jlMwAtJ/vcNaUqAhE2PGEKfW0lkbZ0EzhTjO9mwqpTmFZmzkB/JyTYF2MD63leYTj/
         2Ax7UAVwhyCiQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 21:25:47 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: regulator: deadlock vs memory reclaim
Message-ID: <20200810192547.GB26750@qmqm.qmqm.pl>
References: <20200809222537.GA5522@qmqm.qmqm.pl>
 <20200810153928.GD6438@sirena.org.uk>
 <20200810160936.GA1100@qmqm.qmqm.pl>
 <20200810173136.GF6438@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810173136.GF6438@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 06:31:36PM +0100, Mark Brown wrote:
> On Mon, Aug 10, 2020 at 06:09:36PM +0200, Micha� Miros�aw wrote:
> > On Mon, Aug 10, 2020 at 04:39:28PM +0100, Mark Brown wrote:
> > > On Mon, Aug 10, 2020 at 12:25:37AM +0200, Micha� Miros�aw wrote:
> > > > regulator_lock_dependent() starts by taking regulator_list_mutex, The
> > > > same mutex covers eg. regulator initialization, including memory allocations
> > > > that happen there. This will deadlock when you have filesystem on eg. eMMC
> > > > (which uses a regulator to control module voltages) and you register
> > > > a new regulator (hotplug a device?) when under memory pressure.
> > > OK, that's very much a corner case, it only applies in the case of
> > > coupled regulators.  The most obvious thing here would be to move the
> > > allocations on registration out of the locked region, we really only
> > > need this in the regulator_find_coupler() call I think.  If the
> > > regulator isn't coupled we don't need to take the lock at all.
> > Currently, regulator_lock_dependent() is called by eg. regulator_enable() and
> > regulator_get_voltage(), so actually any regulator can deadlock this way.
> The initialization cases that are the trigger are only done for coupled
> regulators though AFAICT, otherwise we're not doing allocations with the
> lock held and should be able to progress.

I caught a few lockdep complaints that suggest otherwise, but I'm still
looking into that.

> > > > Basically, we have a BKL for regulator_enable() and we're using ww_mutex
> > > > as a recursive mutex with no deadlock prevention whatsoever. The locks
> > > > also seem to cover way to much (eg. initialization even before making the
> > > > regulator visible to the system).
> > > Could you be more specific about what you're looking at here?  There's
> > > nothing too obvious jumping out from the code here other than the bit
> > > around the coupling allocation, otherwise it looks like we're locking
> > > list walks.
> > When you look at the regulator API (regulator_enable() and friends),
> > then in their implementation we always start by .._lock_dependent(),
> > which takes regulator_list_mutex around its work. This mutex is what
> > makes the code deadlock-prone vs memory allocations. I have a feeling
> > that this lock is a workaround for historical requirements (recursive
> > locking of regulator_dev) that might be no longer needed or is just
> > too defensive programming. Hence my other patches and this inquiry.
> We need to both walk up the tree for operations that involve the parent
> and rope in any peers that are coupled, the idea is basically to avoid
> changes to the coupling while we're trying to figure that out.

This part I understand and this is what ww_mutex should take care of.
But there is another lock that's taken around ww_mutex locking transaction
that causes the trouble. I would expect that the rdev->mutex should be
enough to guard against changes in coupled regulators list, but this
might need a fix in the registration phase to guarantee that (it
probably should do the same ww_mutex locking dance as .._lock_dependent()
does now).

Best Regards,
Micha��Miros�aw

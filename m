Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECA240B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHJQ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 12:26:00 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:41914 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgHJQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:25:59 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQLtZ0yqrz2d;
        Mon, 10 Aug 2020 18:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597076758; bh=8mCk9Jx3F4pOPDKskEp8Z8k7Z55vu8IimoDHIF4fU60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hW9j33LEo1/ymEM5pn9EyKLiOD3Kxbh5Qx6CVI/Fy6rzD38uiBkv2CnS3G0LFEaee
         fSOhrIwzk3f4LmapiD6r3rVum+ds3tnryCgcZMtjRe4hLnG51/K9378u4Z+f6bsIVF
         IxS3t/MZ+KCubkH5fvgc+QVo5qLbzTUqNBy0cIojd1OnjpvfpH54OlgroameMy40Ey
         CCKrGwvj/yWPMmaNC7jobVn7Cu16Z2/f3Z7xoK3P2m0eaAqQkcNwkwwe2olSVtBfJf
         3jcgZdkbq9Bdg7J83m62WthFR0SjpHEJmObGae9av8JC+J+XQxTvTIC3gTr6l/BxY4
         /dZ+6bkZxXWog==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 18:25:56 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: fix pointer table overallocation
Message-ID: <20200810162556.GA3394@qmqm.qmqm.pl>
References: <407fbd06a02caf038a9ba3baa51c7d6d47cd6517.1597000795.git.mirq-linux@rere.qmqm.pl>
 <5ef51b56-c533-46c8-621d-7907129594e9@gmail.com>
 <20200810123747.GC6438@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810123747.GC6438@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 01:37:47PM +0100, Mark Brown wrote:
> On Sun, Aug 09, 2020 at 10:44:25PM +0300, Dmitry Osipenko wrote:
> > 09.08.2020 22:21, Michał Mirosław пишет:
> > > The code allocates sizeof(regulator_dev) for a pointer. Make it less
> > > generous. Let kcalloc() calculate the size, while at it.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
> 
> > Hello, Michał! Thank you for the patch! Not sure whether it's worthwhile
> > to backport this change since it's an improvement, I'll leave it to Mark
> > to decide, otherwise looks good to me.
> 
> Yeah, this is more a performance improvement than a fix.

Should I resend without Cc: stable?

Best Regards,
Michał Mirosław

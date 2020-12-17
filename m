Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACB2DD950
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 20:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgLQT0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 14:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQT0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 14:26:42 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA84C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 11:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From
        :Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=id/RU4OEULTzXYn9FVYP9FWC/5fwm6DcgOfQXfSgdAw=; b=duW5i/z4gePeQy2kdqksQSYcpE
        d/cu5oq7Owsz0j1u6bgAG091GDRfjrvipYXzLBlbYC4BfFbiJAi9Rwhdb00rWLvK2qTaFuAFzCcNO
        qVp/Akyjwh7AQuFuSwKDU+A8/p/NGgU34FLvmi0ZW3kDmlnWLEdopsLEDoxoGJmSD173Mbfmj0M0g
        ln2iC/PAHRsCnFM4SMpHKDotYmEz27G7VBfZVaohbSoHgkZINalK/yV/My66lD8fPzk2EyCW/q9sD
        leQimD6p9/JjM0FxrDpFOXhnin5Xp1xbosyevJDsaPzg98f0k2fLWft+9k/u0rvN0TFfVxosH1CNu
        2Wfm9Adw==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1kpyuS-0004ft-2Q; Thu, 17 Dec 2020 19:25:56 +0000
Date:   Thu, 17 Dec 2020 19:25:56 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     konstantin@linuxfoundation.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Oliver Graute <oliver.graute@gmail.com>, corbet@lwn.net,
        miguel.ojeda.sandonis@gmail.com, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PGP pathfinder service is no longer maintained
Message-ID: <20201217192555.GA17262@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216224344.h3r7wbo7fgatupm5@chatter.i7.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20201216224344.h3r7wbo7fgatupm5@chatter.i7.local> (earth.lists.linux-kernel) you wrote:
> On Wed, Dec 16, 2020 at 10:20:18PM +0000, Matthew Wilcox wrote:
> > > Unfortunately the site https://pgp.cs.uu.nl/ is not maintained 
> > > anymore
> > > and the "Finding paths to Linus" link in the Kernel Maintainer PGP guide
> > > is dead. Is there any alternative sites to find a way through the web of
> > > trust?
> > 
> > Several.  Konstantin has a local one: https://github.com/mricon/wotmate

> This is how we generate these:
> https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/graphs

> > and if you want a web service, I like this one:
> > https://the.earth.li/~noodles/pathfind.html

> FYI, it says "The pathfinder is currently out of action due to queries 
> taking far too long to respond. It may return in the future when I find 
> enough time to optimize it." :)

I've re-enabled it for the moment; the keyserver now only holds keys it
has paths to so hopefully it'll be a bit better behaved now.

J.

-- 
Give me liberty or I will cut you.

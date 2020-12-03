Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20132CD858
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgLCN7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLCN7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:59:01 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D64AC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 05:58:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 928DC128074A;
        Thu,  3 Dec 2020 05:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607003898;
        bh=2e4QVL6oFGBsIaZX31w+Mg071wTO2ua7Y21muJ4Hi3I=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=eq3/hiAvSAZlIM2WTLDZAbxwmU9+teGEQmv447OEzXMBw9lA7GlbtvfOZo5xZsM8n
         1qcWdTBPCWKk9qp/bDDP8cYKl3dDBrcdAIzQjRSgNDCipEIv4O5Fo8F0wcpzsoSEF6
         tUhvoBNxneFp5TIiDHyNcCRVg3BGb4rOpMIf2qjY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uG4WwRwZhca0; Thu,  3 Dec 2020 05:58:18 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 40B4D1280742;
        Thu,  3 Dec 2020 05:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607003898;
        bh=2e4QVL6oFGBsIaZX31w+Mg071wTO2ua7Y21muJ4Hi3I=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=eq3/hiAvSAZlIM2WTLDZAbxwmU9+teGEQmv447OEzXMBw9lA7GlbtvfOZo5xZsM8n
         1qcWdTBPCWKk9qp/bDDP8cYKl3dDBrcdAIzQjRSgNDCipEIv4O5Fo8F0wcpzsoSEF6
         tUhvoBNxneFp5TIiDHyNcCRVg3BGb4rOpMIf2qjY=
Message-ID: <694039d6e386d999fd74d038cf2627f5b3b0ca71.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Dec 2020 05:58:17 -0800
In-Reply-To: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 00:43 +0100, Vlastimil Babka wrote:
> Hi,
> 
> there was a bit of debate on Twitter about this, so I thought I would
> bring it here. Imagine a scenario where patch sits as a commit in
> -next and there's a bug report or fix, possibly by a bot or with some
> static analysis. The maintainer decides to fold it into the original
> patch, which makes sense for e.g. bisectability. But there seem to be
> no clear rules about attribution in this case, which looks like there
> should be, probably in
> Documentation/maintainer/modifying-patches.rst
> 
> The original bug fix might include a From: $author, a Reported-by:
> (e.g. syzbot), Fixes: $next-commit, some tag such as Addresses-
> Coverity: to credit the static analysis tool, and an SoB. After
> folding, all that's left might be a line as "include fix from
> $author" in the SoB area. This is a loss of metadata/attribution just
> due to folding, and might make contributors unhappy. Had they sent
> the fix after the original commit was mainline and immutable, all
> the info above would "survive" in the form of new commit.

It has been the case since forever that discussion which improves an
uncommitted patch is only captured in email (which now may be preserved
in a link tag).  Patch updates that come in after the patch is
committed get their own commit.  We've tried to move people away from
counting commits as an indicator of upstream eminence, but it's still a
fact of life that this is what matters to a lot of open source
community managers.  The tension we have is between liking a clean
commit in the tree as opposed to a sequence of commits tracking the
evolution of the patch and this community manager desire to track
patches.

So there are two embedded questions here: firstly, should we be as
wedded to clean history as we are, because showing the evolution would
simply solve this?  Secondly, if we are agreed on clean history, how
can we make engagement via email as important as engagement via commit
for the community managers so the Link tag is enough?  I've got to say
I think trying to add tags to recognize patch evolution is a mistake
and we instead investigate one of the two proposals above.

James



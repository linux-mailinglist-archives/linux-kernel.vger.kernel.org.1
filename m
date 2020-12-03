Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2C2CDF47
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgLCUEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:04:50 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:56838 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbgLCUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:04:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 22AA71280B71;
        Thu,  3 Dec 2020 12:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607025850;
        bh=HexzAZacNggZxtGW31Mcyz0+xUVZxQ1FJZ1MlQz9IPs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qZBF4ptSr8bG0N4UTqqqmJAjjjQTV06ac3tcNPrvLRFQ6fPUe8U98bOIAR1STlNHs
         Isk5fuj6+OM7y3EYvnLvyuyt8ISVWiEnpOTBeGQx3pNDLiRyWdQmr3RrfFvYwzO25E
         GKW5gYxCTJFfJuz44OYtBLi0UE9zkNkb+/PmW2uY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t5uHidc9ZBPY; Thu,  3 Dec 2020 12:04:10 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B9BB11280B6F;
        Thu,  3 Dec 2020 12:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607025850;
        bh=HexzAZacNggZxtGW31Mcyz0+xUVZxQ1FJZ1MlQz9IPs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qZBF4ptSr8bG0N4UTqqqmJAjjjQTV06ac3tcNPrvLRFQ6fPUe8U98bOIAR1STlNHs
         Isk5fuj6+OM7y3EYvnLvyuyt8ISVWiEnpOTBeGQx3pNDLiRyWdQmr3RrfFvYwzO25E
         GKW5gYxCTJFfJuz44OYtBLi0UE9zkNkb+/PmW2uY=
Message-ID: <147e17a3a1e54d46611b285a973c03f14b19dc96.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy6545@gmail.com>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Dec 2020 12:04:08 -0800
In-Reply-To: <CAFhKne9ZSbwrH6-g7og2BBEEDGd6ScDnZTNg3znQLvLDCDfeoA@mail.gmail.com>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
         <694039d6e386d999fd74d038cf2627f5b3b0ca71.camel@HansenPartnership.com>
         <CAFhKne9ZSbwrH6-g7og2BBEEDGd6ScDnZTNg3znQLvLDCDfeoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 13:52 -0500, Matthew Wilcox wrote:
> It's not so much "clean history" that's the desire. It's "don't leave
> landmines for git bisect".

... top posting?

Well functional git bisect and show the evolution of the patch aren't
mutually exclusive.  Plus our current clean history approach doesn't
always detect them ...

That said, I agree that if a review comes in that shows a patch would
break the build or runtime in a way that would damage bisection, it
should be folded.  I suppose this argues that only less trivial changes
can be shown as part of the unfolded history, and since they're
obviously less important than the review driven folded change it would
add more bias to track them.

I fall back to my link is enough comment.

James



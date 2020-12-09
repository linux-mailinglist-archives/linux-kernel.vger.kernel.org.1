Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818002D3DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgLIIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:45:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgLIIpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:45:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33E76AC94;
        Wed,  9 Dec 2020 08:45:04 +0000 (UTC)
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
 <CAPcyv4jDHMt4PpR2Htvw27rn5i5sCkwXtoZH-rFbtG8Hj7x1sg@mail.gmail.com>
 <20201203093458.GA16543@unreal>
 <CAMuHMdVcPELarE=eJEc-=AdyfmhhZQsYtUggWCaetuEdk=VpMQ@mail.gmail.com>
 <20201203104047.GD16543@unreal> <X8ku1MmZeeIaMRF4@kroah.com>
 <202012081619.6593C87D3@keescook>
 <13d04c4cc769ebd1dd58470f4d22ada5c9cd28e7.camel@perches.com>
 <20201209075849.GD2767@kadam>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
Message-ID: <a6dfe760-c3b4-8bc4-3c7f-cc1208b626fa@suse.cz>
Date:   Wed, 9 Dec 2020 09:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209075849.GD2767@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 8:58 AM, Dan Carpenter wrote:
> On Tue, Dec 08, 2020 at 09:01:49PM -0800, Joe Perches wrote:
>> On Tue, 2020-12-08 at 16:34 -0800, Kees Cook wrote:
>> 
>> > If not "Adjusted-by", what about "Tweaked-by", "Helped-by",
>> > "Corrected-by"?
>> 
>> Improved-by: / Enhanced-by: / Revisions-by: 
>> 
> 
> I don't think we should give any credit for improvements or enhancements,

Well, some are actually useful and not about reviewer's preferred style :) But
if an author redoes the patch as a result, it's their choice to mention useful
improvements in the next version's change log.

> only for fixes.  Complaining about style is its own reward.

Right, let's focus on fixes and reports of bugs, that would have resulted in a
standalone commit, but don't.

> Having to redo a patch is already a huge headache.  Normally, I already
> considered the reviewer's prefered style and decided I didn't like it.
> Then to make me redo the patch in an ugly style and say thankyou on
> top of that???  Forget about it.  Plus, as a reviewer I hate reviewing
> patches over and over.
> 
> I've argued for years that we should have a Fixes-from: tag.  The zero

Standardizing the Fixes-from: tag (or any better name) would be a forward
progress, yes.

> day bot is already encouraging people to add Reported-by tags for this
> and a lot of people do.

"Reported-by:" becomes ambiguous once the bugfix for the reported issue in the
patch is folded, as it's no longer clear whether the bot reported the original
issue the patch is fixing, or a bug in the fix. So we should have a different
variant. "Fixes-reported-by:" so it has the same prefix?

> regards,
> dan carpenter
> 


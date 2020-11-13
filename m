Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FE2B28C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKMWrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:47:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9BAC0613D1;
        Fri, 13 Nov 2020 14:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=WP9+FE6KfgAeIygIl6/ZRDYbND6KnO3/4miAiqPhc8E=; b=AZtwsAICMyaWo/8BV27woLF1MI
        7bKrHKN+1pnQVAqEagyciCOarcPJ5h9r6cnCwCVn8cMnqqf4Jgz7GEIer6U5zG4t0fvnbCJNjrP8h
        BpEt4FvtivCd6rXSpbLWyw1QdLNZSNVACfnKW0WJB6Mw4uAU0+R5S/OuRJtQYf7KHd7dedVLiMgMV
        588GVQZQKJ0DtBqxwSld2esy0HyXJWexr7LTRXWVput8GR/63ykoXIMjLm3mFElR8tTeP+e05DIpA
        1UYbatP2b4tAzEvcMsqOjA44DAzZPq3iLkLJ53xrvlw/M2HQKxHkN8Iy0dXaxsqQhd53fyJ6ZFc4p
        7njWVqVw==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdhqa-00026C-Ta; Fri, 13 Nov 2020 22:47:13 +0000
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet
 more detailed & helpful
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1605203187.git.linux@leemhuis.info>
 <20201113153313.68ff210c@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <52f7937e-5a83-7783-83c9-820b24c2dca6@infradead.org>
Date:   Fri, 13 Nov 2020 14:47:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113153313.68ff210c@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 2:33 PM, Jonathan Corbet wrote:
> On Thu, 12 Nov 2020 18:58:37 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
>> This series rewrites the "how to report bugs to the Linux kernel
>> maintainers" document to make it more straight forward and its essence
>> easier to grasp. At the same time make the text provide a lot more details
>> about the process in form of a reference section, so users that want or
>> need to know them have them at hand.
>>
>> The goal of this rewrite: improve the quality of the bug reports and
>> reduce the number of reports that get ignored. This was motivated by many
>> reports of poor quality the submitter noticed while looking after Linux
>> kernel regression tracking many moons ago.
> 
> So I've not had a chance to try to read through the whole thing again,
> will try to do so in the near future.
> 
> As for how to proceed...getting others to review this is going to be a bit
> of a challenge.  Perhaps the right approach is to just merge the new
> document under a new name - reporting-bugs-the-novel.txt or something -
> then try to get a few people to look at specific parts of it?  Once all
> seems well we can rename it over the old document and call it done.
> 
> Make sense?

I like that idea.

I don't plan to review the series in detail like I did with v1.

-- 
~Randy


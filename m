Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66D72BB088
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgKTQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbgKTQ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:27:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6CFC0613CF;
        Fri, 20 Nov 2020 08:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=7Y8ty/OHid/7xfd+STeqJh1pPeiPdY+PYtVeDGND+YI=; b=lYKcOBRrKaBosabnRWTDqQaI80
        vSJ5lUA58C3LdCBO5PzpvUyalYGL0O054d/Yd17EydymuFGFrF+CrDemCdyyQgC+uefraKdx3F8k4
        gMmWz/Ak7wapY5BcVhAwb+CHL6BjhOEFuyHwAp1z9XjNjXsvfoIFHcXElIBbFbL+CyIOvB+NQwu/4
        lFZ2ArmsiB67R2tv8L/7Lauku9m/OF0kuUvjAms9Dhov7sbJt2eUDcFxQ2EcwhFdO0wBxoW3uOUqL
        jMSAlIW6EH+MzQAAqFVILzrQExxe0rwcG4NX04Y5L1Z0BdgWkQwJUyQQqblyWh4QKgOIDGvzZ9Px5
        ErrJ2LMg==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg9GH-0007Fz-Sf; Fri, 20 Nov 2020 16:27:50 +0000
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet
 more detailed & helpful
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1605203187.git.linux@leemhuis.info>
 <20201113153313.68ff210c@lwn.net>
 <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
 <20201118172958.5b014a44@lwn.net>
 <2dcea97c-7b98-1ad2-d2ba-e7f7d77dc855@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <465a1a11-726a-73f8-bf30-05fa8d902620@infradead.org>
Date:   Fri, 20 Nov 2020 08:27:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2dcea97c-7b98-1ad2-d2ba-e7f7d77dc855@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 2:46 AM, Thorsten Leemhuis wrote:
>    Any improvements for the text or other feedback is thus very much welcome. Please send it to 'Thorsten Leemhuis <linux@leemhuis.info>' and 'Jonathan Corbet <corbet@lwn.net>', ideally with 'Linux kernel mailing list (LKML) <linux-kernel@vger.kernel.org>' and the 'Linux Kernel Documentation List <linux-doc@vger.kernel.org>' in CC.
> 
>    Areas in the text that still need work or discussion contain a hint like this which point out the remaining issues; all of them start with the word "FIXME" to make them easy to find.
> ```
> 
> Randy let me know if you want to be mentioned there, too.

No thanks, I don't need to be mentioned.
I'll see it (unless I can't).

-- 
~Randy


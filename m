Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5647E2F1DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbhAKSO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbhAKSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:14:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031BFC06179F;
        Mon, 11 Jan 2021 10:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+yL4rFpmpqzWF4MRa4OI55Sy1AqIMFXHO/4zaA5wwVI=; b=LXC5eg/Jo2DjmQwekxjr1Admpe
        f7ldsBTyXRvxqctPXkrJTYxCI0aUrx60J1kEyO7ukhRh8BBhSRx4sYeOmWqcgX7E9O2mEFMlNJw5q
        Lk6Fb3DK7yCc76rJer/lt3B4POITOFwoK+nrZOZBg5is9BgQlaYeD1fmXEE07S78YhqdNE+UKJtJQ
        Gz29Hm7D+inCpduh4rsMdCr76P7fkDyV8CTGLH2dIVVG2QqihaEuMG0mk8EHK9jZS+ogQ0TOn8cIM
        rqazYjyyDltCKk898rRYRVxsWt1VuCJKWP44w3ehp8k1qqBDn38oJ5IEfBwHyriNEBD1P27WM+HG6
        cHwwSlwQ==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kz1hj-0004ph-QH; Mon, 11 Jan 2021 18:14:12 +0000
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ca51584-1739-e532-d40e-e4447065ea1e@infradead.org>
Date:   Mon, 11 Jan 2021 10:14:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210110121033.130504-1-linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/21 4:10 AM, Thorsten Leemhuis wrote:
> * About 66 of those ~200 components will assign bugs to email addresses
>   that look valid, but 125 of them end with @kernel-bugs.osdl.org or
>   @kernel-bugs.kernel.org. Those domains do not exist anymore, mails
>   sent there bounce ('Unrouteable address'). It's possible that the
>   server might be rewriting those domain names and nevertheless
>   delivers new reports and comments by mails to some human; but it
>   seems more like they never get mailed to anyone and thus just linger
>   in the database; no wonder quite a few of bugs filed against such
>   components never get a single reply (see below).

Those @kernel-bugs email addresses should not be a problem:

  https://korg.docs.kernel.org/bugzilla.html#real-assignees-vs-virtual-assignees



AFAIK, USB bugs go to linux-usb@vger.kernel.org,
SCSI bugs go to linux-scsi@vger.kernel.org.

netdev didn't want bugs sent there automatically IIRC, so a
human takes care of doing that if warranted.

Andrew Morton takes MM bugs and Cc:s them to linux-mm mailing list
and then asks for discussion to continue on the mailing list.


We could/should probably see if we can add more project-specific
mailing lists to the automatic reporting -- but probably not LKML.

Otherwise some bug reports might never be heard about.

-- 
~Randy


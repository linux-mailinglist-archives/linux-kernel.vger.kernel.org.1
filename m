Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAF82F8E74
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbhAPRts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbhAPRtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:49:47 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D5C061573;
        Sat, 16 Jan 2021 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=v0ekcJxqDvgNYtHV3L+FbsaxiK5FN3UzjN2IWKZqH4c=; b=vSIXMh4HWuVbbjPlTTFlfzKFT5
        rTkVtEIPgi8saZFOqzSMkPfMHm4wLXE0mpsFBMWt/McJ5G2UZ5cj9qAxzTqCjpR5iLK74L6yh5KxA
        S4VEFVRnkbDlTHjTPYM49VdV7Tc3ZthTe/XJSyg7jP6RP+fCikEIViJPuG8IvCsLcE2TD5niMnyrh
        YWP6nEbUXlR2z87w2z0M6ck+oPcN9N/D5KD8xTl8hvWqYdUQ4nB+gTa9UzplGPAB1QxrTv4Tp1MO6
        /4mkJJRo8VEnsQzQLonrNF/V4EzjbjAu2x3jNrLLONCg70+i/xf/hbvk0yra2LQKC1k/TuYrUP2Wn
        Gw6yB6kg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0ogR-0000Eb-0l; Sat, 16 Jan 2021 16:44:15 +0000
Subject: Re: [PATCH] docs: process/howto.rst: make sections on bug reporting
 match practice
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20210116143542.69199-1-linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0b60cae3-565e-9e26-9320-b8c8dde4115d@infradead.org>
Date:   Sat, 16 Jan 2021 08:44:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210116143542.69199-1-linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/21 6:35 AM, Thorsten Leemhuis wrote:
> The file Documentation/process/howto.rst points to bugzilla.kernel.org
> as the primary place to report kernel bugs to. For most of the kernel
> that's the wrong place, as the MAINTAINERS file shows. Adjust those
> sections to make them match current practice.
> 
> This change also removes a contradiction with the recently added text
> Documentation/admin-guide/reporting-issues.rst, which is a reason for a
> 'this needs further discussion' warning note in there. The change is
> thus a prerequisite to remove that warning, nevertheless it is left for
> now to make sure people review the text's approach more carefully.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> v1:
> - kind of a follow up to "[PATCH v1 (RFC)] docs: discourage users from using bugzilla.kernel.org"[1] – I decided to break that idea down into smaller pieces, which I guess is easier for everyone
> 
> [1] https://lore.kernel.org/lkml/20210110121033.130504-1-linux@leemhuis.info/

LGTM (with one nit below).

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Documentation/process/howto.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
> index 7a5c105e34d4..e4beeca57e5f 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -342,16 +342,10 @@ Adventurous testers are very welcome to runtime-test the linux-next.
>  Bug Reporting
>  -------------
>  
> -https://bugzilla.kernel.org is where the Linux kernel developers track kernel
> -bugs.  Users are encouraged to report all bugs that they find in this
> -tool.  For details on how to use the kernel bugzilla, please see:
> -
> -	https://bugzilla.kernel.org/page.cgi?id=faq.html
> -
>  The file 'Documentation/admin-guide/reporting-issues.rst' in the main kernel
> -source directory has a good template for how to report a possible kernel bug,
> -and details what kind of information is needed by the kernel developers to help
> -track down the problem.
> +source directory describes how to report a possible kernel bug, and details
> +what kind of information is needed by the kernel developers to help track
> +down the problem.
>  
>  
>  Managing bug reports
> @@ -364,7 +358,13 @@ improve your skills, and other developers will be aware of your presence.
>  Fixing bugs is one of the best ways to get merits among other developers,
>  because not many people like wasting time fixing other people's bugs.
>  
> -To work in the already reported bug reports, go to https://bugzilla.kernel.org.
> +To work on already reported bug reports, find a subsystem you are interested in.
> +Check the MAINTAINERS file where bugs for that subsystem get reported to; often

I would say:
   Check the MAINTAINERS file for where bugs for that subsystem are reported; often

> +it will be a mailing list, rarely a bugtracker. Search the archives of said
> +place for recent reports and help where you see fit. You may also want to check
> +https://bugzilla.kernel.org for bug reports; only a handful of kernel subsystems
> +use it actively for reporting or tracking, nevertheless bugs for the whole
> +kernel get filed there.
>  
>  
>  Mailing lists
> 


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law

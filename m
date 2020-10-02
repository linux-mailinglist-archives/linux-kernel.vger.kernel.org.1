Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9E281902
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbgJBRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:18:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A610DC0613D0;
        Fri,  2 Oct 2020 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qkr1WYXSjxy46n4RZR9Wr5P/yXKe7+Ih5EwxJcET+b0=; b=lB1dODytWUuttXxwNQuj4Ee6Q6
        Aem6yQmbo+S2ADigRrBRY1mI0ssu48AzTcIJDlYzOB87b3XgIGyqZEbULoJTHvVYSwluaiG/tuF0J
        O9IdNb5Edj93+K3SNic9PfMONf0mNfGtexPTXtIFE8iAqi5RmulNv43VgubphbY/H5gOELC+hxyZe
        xOFXCKn+jBujMpGcvgRPn7nS8NW0dlRClZplNBw17XhTjY0yLDxhMV3Uk87+crOPih6V/ZpTkKMSP
        P2MDMQJ3M/Gxc5Hk4IZw7di8aGCL9MuWc2PJdH8pRhbOw8ntVHTaLLYPP2sAqY0+cTZQvsz+woq66
        HrWYUU8w==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOOgv-0003u7-Ct; Fri, 02 Oct 2020 17:17:57 +0000
Subject: Re: [RFC PATCH v1 10/26] docs: reporting-bugs: remind people to look
 for existing reports
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <e445ed892324469219638e7b546bbfe5265b1e93.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f7925522-cb19-bc4f-77e2-0246dde9b1c3@infradead.org>
Date:   Fri, 2 Oct 2020 10:17:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e445ed892324469219638e7b546bbfe5265b1e93.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Tells users to search for existing reports, as not reporting them a
> second time is in their own interest. Tel them where to look and provide
> a few hints how to search properly, as that is easy to get wrong. That
> seems to be especially true when it comes to things like graphics cards
> or wifi modules: mentioning the model name often is not much help, but
> mentioning its main chip often leads to the results you are looking for.
> This might be obvious to kernel developers, but for many users it's not.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> 
> = RFC =
> 
> Have I gone to far in describing how to find good search terms? I got the
> impression quite a few users to it poorly.
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 58 ++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 3e9923c9650e..4828e8924136 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -491,6 +491,64 @@ sometimes modified during tree-wide cleanups by developers that do not care
>  about the particular code at all. Hence, use this option with care.
>  
>  
> +Search for existing reports
> +---------------------------
> +
> +    *Search the archives of the bug tracker or mailing list in question
> +    thoroughly for reports that might match your issue. Also check if you find
> +    something with your favorite internet search engine or in the Linux Kernel
> +    Mailing List (LKML) archives. If you find anything, join the discussion
> +    instead of sending a new report.*
> +
> +Reporting an issue that someone else already brought forward is often a waste of
> +time for everyone involved, especially you as the reporter. So it's in your own
> +interest to thoroughly check if somebody reported the issue already. Thus do not
> +hurry with this step of the reporting process, spending 30 to 60 minutes or even

                                         process. Spending

> +more time can save you and others quite a lot of time and trouble.
> +
> +The best place to search is the bug tracker or the mailing list where your
> +report needs to be filed. You'll find quite a few of those lists on
> +`lore.kernel.org/ <https://lore.kernel.org/>`_, but some are hosted in different
> +places. That for example is the case for the ath10k Wi-Fi driver used as example
> +in the previous step. But you'll often find the archives for these lists easily
> +on the net. Searching for 'archive ath10k@lists.infradead.org' for example
> +will quickly lead you to the `Info page for the ath10k mailing list
> +<https://lists.infradead.org/mailman/listinfo/ath10k>`_, which at the top links
> +to its `list archives <https://lists.infradead.org/pipermail/ath10k/>`_.
> +
> +Sadly this and quite a few other lists miss a way to search the archives. In
> +those cases use a regular internet search engine and add something like
> +'site:lists.infradead.org/pipermail/ath10k/' to your search terms, which limits
> +the results to the archives at that URL.
> +
> +Additionally, search the internet and the `Linux Kernel Mailing List (LKML)
> +archives <https://lore.kernel.org/lkml/>`_, as maybe the real culprit might be
> +in some other subsystem. Searching in `bugzilla.kernel.org
> +<https://bugzilla.kernel.org/>`_ might also be a good idea, but if you find
> +anything there keep in mind: it's not the official place to file reports, hence
> +the reports you find there might have not even reached the people responsible
> +for the subsystem in question.
> +
> +If you get flooded with results consider telling your search engine to limit the
> +results to posts from the past month or year. And wherever you search, make sure
> +to use good search terms; vary them a few times, too. While doing so try to look
> +at the issue from perspective of someone else: that will help you to come up

                from the perspective

> +with other words to use as search terms. Also make sure to not use too many

                                                           not to use
?

> +search terms at once. Remember to search with and without information like the
> +name of the kernel driver or the name of the affected hardware component. But
> +its exact brand name (say 'ASUS Red Devil Radeon RX 5700 XT Gaming OC') often is
> +not much helpful, better use the name of the model line (Radeon 5700), the code
> +name of the main chip ('Navi' or 'Navi10'), its manufacturer ('AMD'), and things
> +like that.
> +
> +In case you find an existing report consider joining the discussion, as you

                                report,

> +might be able to provide valuable additional information. That can be important
> +even when a fix is prepared or in its final stages already, as developers might
> +look for people that can provide additional information or test a proposed fix.
> +See the section 'Duties after the report went out' for details how to get

                                                      for details on how to get
I must like more prepostions...

> +properly involved.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy


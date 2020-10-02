Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177CB280C80
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 05:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgJBD0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 23:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBD0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 23:26:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26952C0613D0;
        Thu,  1 Oct 2020 20:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=yrCLPRBOEJ1Uv5fdSBy9H8UF8mXbPMcG1AE17Ac18tE=; b=JXLNg/m8lV6iDH65Me/ezi7/V1
        fbWghPoc/HpPOk0BIsciUaWWDHvxGCoCnXC8y0my7eT0VrSA0JOBfrHSQQ3k/zablB94udRANDC1w
        91upBfGeasebvd4c1ViPq0XAj+2I7kRh1LE3JGFObEsqXOlR9MNHaFA+1dJFgF607MJ0Q9j4ENdKe
        sYVKPwe8B72Ry0qma98VB5eBPauTlBmSUkACQXQ5fd85qKgpd1dtyBtxd5onRl7T+EZ1aWmD4te/i
        bRiGHty6J6GIZ+zHGNcQvDq3A/8ujutCz65qm5nuBcIARp0dttGjUwcNt1hzG/Y105VolSf+cBxnn
        DsUv+oDg==;
Received: from [2601:1c0:6280:3f0::863]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOBhn-00078j-Tt; Fri, 02 Oct 2020 03:26:00 +0000
Subject: Re: [RFC PATCH v1 04/26] docs: reporting-bugs: step-by-step guide for
 issues in stable & longterm
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <b81c54734a767f7da9ec68fae6b82ea0a8c96011.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b7ab110b-3f4d-382c-5802-5dd4291ea118@infradead.org>
Date:   Thu, 1 Oct 2020 20:25:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b81c54734a767f7da9ec68fae6b82ea0a8c96011.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Handle stable and longterm kernels in a subsection, as dealing with them
> directly in the main part of the step-by-step guide turned out to make
> it messy and hard to follow: it looked a bit like code with a large
> amount of if-then-else section to handle special cases, which made the
> default code-flow hard to understand.
> 
> Yet again each step will later be repeated in a reference section and
> described in more detail.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 49 ++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 203df36af55f..e0a6f4328e87 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -156,6 +156,55 @@ After these preparations you'll now enter the main part:
>     yourself, if you don't get any help or if it is unsatisfying.
>  
>  
> +Reporting issues only occurring in older kernel version lines
> +-------------------------------------------------------------
> +
> +This section is for you, if you tried the latest mainline kernel as outlined
> +above, but failed to reproduce your issue there; at the same time you want to
> +see the issue fixed in older version lines or a vendor kernel that's regularly
> +rebased on new stable or longterm releases. If that case follow these steps:
> +
> + * Prepare yourself for the possibility that going through the next few steps
> +   might not get the issue solved in older releases: the fix might be too big or
> +   risky to get backported there.
> +
> + * Check if the kernel developers still maintain the Linux kernel version line
> +   you care about: go to `the front-page of kernel.org <https://kernel.org>`_
> +   and make sure it mentions the latest release of the particular version line
> +   without an '[EOL]' tag.

Explain somewhere that EOL = End Of Life (in parens).

> +
> + * Check the `archives of the Linux stable mailing list
> +   <https://lore.kernel.org/stable/>`_  for existing reports.
> +
> + * Install the latest release from the particular version line as a vanilla
> +   kernel. Ensure this kernel is not tainted and still shows the problem, as the
> +   issue might have already been fixed there.
> +
> + * Search the Linux kernel version control system for the change that fixed
> +   the issue in mainline, as its commit message might tell you if the fix is
> +   scheduled for backporting already. If you don't find anything that way,
> +   search the appropriate mailing lists for posts that discuss such an issue or
> +   peer-review possible fixes. That might lead you to the commit with the fix
> +   or tell you if it's unsuitable for backporting. If backporting was not
> +   considered at all, join the newest discussion, asking if its in the cards.

                                                               it's

> +
> + * Check if you're dealing with a regression that was never present in
> +   mainline by installing the first release of the version line you care about.
> +   If the issue doesn't show up with it, you basically need to report the issue
> +   with this version like you would report a problem with mainline (see above).
> +   This ideally includes a bisection followed by a search for existing reports
> +   on the net; with the help of the subject and the two relevant commit-ids. If
> +   that doesn't turn up anything, write the report; CC or forward the report to
> +   the stable maintainers, the stable mailing list, and those that authored the

                                                           those who (?)

> +   change. Include the shortened commit-id if you found the change that causes
> +   it.
> +
> + * One of the former steps should lead to a solution. If that doesn't work out,
> +   ask the maintainers for the subsystem that seems to be causing the issue for
> +   advice; CC the mailing list for the particular subsystem as well as the
> +   stable mailing list.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy


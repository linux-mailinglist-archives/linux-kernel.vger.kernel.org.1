Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB228184C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgJBQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBQty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:49:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A9C0613D0;
        Fri,  2 Oct 2020 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LTn/ASGqXGVfozcQ2KbyHKqeALKDKvpZHhAJrGUqeM8=; b=ABDpe/D2yMGPDW24nqAgBnyZUj
        aYEJw9Vg/dRqj7Dr2SLKp41pO/saWS8ji8KFV23TeqMisqCRUWpycHveU7l/nBz1U7Nx+E2jEPiqi
        YnfNSxNlNI6DZTaJAc3nF12qbsuRa0EvG+XKN7QTs0iItJuG5TjPWPr75ROqrlyefQce3IAlVKIQH
        URv6ZyWhQuK0UWhn1i6V5wqsPzpGpXrYs88QGCG7Qor9pRvjVRbY5MfW90/L+tAO7vbpMYnAXYDqy
        xN3a+SqsQEFeRSbOFd/RWnA35taH/0tvNVslCTP7bF0z/pPTR+59Ge/MZyEMTxItMN9Qvc9hiKaeH
        q9Hjt7Kg==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOOFj-0001EC-5w; Fri, 02 Oct 2020 16:49:51 +0000
Subject: Re: [RFC PATCH v1 05/26] docs: reporting-bugs: begin reference
 section providing details
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <cd3e2465fec04e83d55ec6821fd6f111709eaf8e.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0c188514-0cf2-7201-004f-5a78398eef6c@infradead.org>
Date:   Fri, 2 Oct 2020 09:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cd3e2465fec04e83d55ec6821fd6f111709eaf8e.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Provide an introduction to the reference section that will provide more
> details how to report an issue. Mention a few general things here. Those
> are not strictly needed, but likely wise to write down somewhere.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> 
> = RFC =
> 
> Should we keep the links to
> https://www.chiark.greenend.org.uk/~sgtatham/bugs.html and
> http://www.catb.org/esr/faqs/smart-questions.html? Are they worth it? Or is
> there anything similar or better that's a bit fresher and ideally still
> maintained?

Dunno. They are interesting but outdated.

> ---
>  Documentation/admin-guide/reporting-bugs.rst | 46 +++++++++++++++++---
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index e0a6f4328e87..be1bce8d43aa 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -205,6 +205,46 @@ rebased on new stable or longterm releases. If that case follow these steps:
>     stable mailing list.
>  
>  
> +Reference section: Reporting issues to the kernel maintainers
> +=============================================================
> +
> +The detailed guides above outlines all the mayor steps in brief fashion, which

                             outline          major

> +should be enough for most people. But sometimes there are situations where even
> +experienced users might wonder how to actually do one of those steps. That's
> +what this section is for, as it will provide a lot more details on each of the
> +steps. Consider this a reference documentation: it's possible to read it from

                        as

> +top to bottom, but more meant to skim over and a place to look up details in
> +case you need them.
> +
> +A few words of general advice before digging into the details:
> +
> + * The Linux kernel developers are well aware this process is complicated and
> +   demands more than other FLOSS projects. We'd love to make it simpler, but
> +   that would require work in various places as well as infrastructure that
> +   would need constant maintenance; nobody has stepped up to do that work, so
> +   that's just how things are for now.
> +
> + * A warranty or support contract with some vendor doesn't entitle you to
> +   request fixes from developers in the upstream Linux kernel community: such
> +   contracts are completely outside the scope of the Linux kernel, its
> +   development community, and this document. That's why you can't demand
> +   anything such a contract guarantees in this context, not even if the
> +   developer handling the issue works for the vendor in question. If you want to
> +   claim your rights, use the vendors support channel instead. When doing so,

                                 vendor's

> +   you might want to mention you'd like to see the issue fixed in the upstream
> +   Linux kernel; motivate them by saying it's the only way to ensure the fix in
> +   the end will get incorporated in all Linux distributions.
> +
> + * If you never reported an issue to a FLOSS project before you should consider
> +   reading `How to Report Bugs Effectively
> +   <https://www.chiark.greenend.org.uk/~sgtatham/bugs.html>`_
> +   and `How To Ask Questions The Smart Way
> +   <http://www.catb.org/esr/faqs/smart-questions.html>`_.
> +
> +With that of the table, find below the details on how to properly report issues

             off

> +to the Linux kernel developers.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> @@ -281,12 +321,6 @@ http://vger.kernel.org/lkml/).
>  Tips for reporting bugs
>  -----------------------
>  
> -If you haven't reported a bug before, please read:
> -
> -	https://www.chiark.greenend.org.uk/~sgtatham/bugs.html
> -
> -	http://www.catb.org/esr/faqs/smart-questions.html
> -
>  It's REALLY important to report bugs that seem unrelated as separate email
>  threads or separate bugzilla entries.  If you report several unrelated
>  bugs at once, it's difficult for maintainers to tease apart the relevant
> 


-- 
~Randy


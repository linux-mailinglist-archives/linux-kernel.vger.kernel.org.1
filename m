Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2428195A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbgJBRfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:35:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F42C0613D0;
        Fri,  2 Oct 2020 10:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Plv1q4RaDS3LKbq6PyPtmyTZBfCxGANkmEqdyjsbB7o=; b=ZIdMrhlbvZXE2MzezSS6h8wl5M
        atfijwW2e8f/McQfa+q1jLWado4pjb85NucnP4lG2CIv5Drx3GLeiLr3/ZJQBKDEthAMMFNJeQgm+
        J32UhLPqaFgklW0D4WxTG5jwZkoKlGlOQvPY9zuI7e8+HF+qBFpHJTBLvjskdviSGWgtAncaKWAFy
        8aTpvKqhBwP+DyOevu4eDvhMrrLcG8N6msrK2gIt9tnVwW5gwlBMqKgzSTdv6zP6Lg8uG2cfImdzX
        z3pka9Crm0iIHsi2xCldIHzBdHpb6iAZuN2FrL7nQvryk2dJxFJrl4JZciUd2qnfxyOoFJx8gPG/u
        DYX1lreA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOOy2-0005P8-Ib; Fri, 02 Oct 2020 17:35:38 +0000
Subject: Re: [RFC PATCH v1 14/26] docs: reporting-bugs: make users write
 notes, one for each issue
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <bf99a4e5af05e7076795e33beb6d48f95571328e.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b035746-909c-a65f-470c-ce34a9b71306@infradead.org>
Date:   Fri, 2 Oct 2020 10:35:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bf99a4e5af05e7076795e33beb6d48f95571328e.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Tell users to write some rough notes how to reproduce the issue. They
> will need those notes soon once they have to reproduce the issue with
> the latest mainline kernel. At the same time they can serve as basis for
> the report later.
> 
> While at it point out that each report should focus on one issue, as
> that is a good time for it: it will make the notes more straight forward
> if the reader deal with multiple issues at once.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 35 +++++++++++++++-----
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 2292b79cf462..f99d92a05bca 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -617,6 +617,32 @@ should minimize it:
>     look like a regression.
>  
>  
> +Document how to reproduce issue
> +-------------------------------
> +
> +    *Write down coarsely how to reproduce the issue. If you deal with multiple
> +    issue at once, create separate notes for each of them and make sure they

       issues

> +    work independently on a freshly booted system. That's needed, as each issue
> +    needs to get reported to the kernel developers separately, unless they are
> +    strongly entangled.*
> +
> +If you deal with multiple issue at once, you'll have to report each of them

                             issues

> +separately, as they might be handled by different developers. Describing various
> +issues in one report also makes it quite difficult for others to tear it apart.
> +Hence, only combine issues in one report if they are strongly entangled.
> +
> +Additionally, during the reporting process you will have to test if the issue
> +happens with other kernel versions. Therefore, it will make your work easier if
> +you know exactly how to reproduce it quickly on a freshly booted system.
> +
> +Note: it's often fruitless to debug issues that only happened once, as they
> +might be caused by a bit flip due to cosmic radiation. That's why you should try
> +to rule that out by reproducing the issue before going further. Feed free to

                                                                   Feel

> +ignore this if you are experienced enough to tell a one-time error due to faulty
> +hardware apart from a kernel issue that rarely happens and thus is hard to
> +reproduce.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> @@ -639,15 +665,6 @@ How to report Linux kernel bugs
>  ===============================
>  
>  
> -Tips for reporting bugs
> ------------------------
> -
> -It's REALLY important to report bugs that seem unrelated as separate email
> -threads or separate bugzilla entries.  If you report several unrelated
> -bugs at once, it's difficult for maintainers to tease apart the relevant
> -data.
> -
> -
>  Gather information
>  ------------------
>  
> 


-- 
~Randy


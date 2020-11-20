Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854582BB8A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgKTV6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:58:14 -0500
Received: from ms.lwn.net ([45.79.88.28]:36810 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTV6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:58:14 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 16EB14FA;
        Fri, 20 Nov 2020 21:58:14 +0000 (UTC)
Date:   Fri, 20 Nov 2020 14:58:13 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and
 yet more detailed & helpful
Message-ID: <20201120145813.76b7b326@lwn.net>
In-Reply-To: <2dcea97c-7b98-1ad2-d2ba-e7f7d77dc855@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
        <20201113153313.68ff210c@lwn.net>
        <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
        <20201118172958.5b014a44@lwn.net>
        <2dcea97c-7b98-1ad2-d2ba-e7f7d77dc855@leemhuis.info>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 11:46:07 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> Am 19.11.20 um 01:29 schrieb Jonathan Corbet:
> > On Sun, 15 Nov 2020 11:13:52 +0100
> > Thorsten Leemhuis <linux@leemhuis.info> wrote:  
> 
> >   - Collapse the whole thing down to a patch adding reporting-bugs-v2.rst
> >     (or some suitable name).  I do wonder if it should also move to the
> >     process manual as part of this; not only admins will report bugs.  
> 
> After a night's sleep and Randy's comment I for now settled on
> Documentation/admin-guide/reporting-issues.rst

Keeping it in the admin guide is OK.  Not sure about the name, though; if
you're really dead set against bugs, maybe reporting-problems.rst?

> >   - Add a comment at the top saying it's a proposed replacement and
> >     soliciting comments.  [...]  
> Struggled a bit to find the right words, but I think this should work:
> 
> ```
> .. important::
> 
>     This document is being prepared to replace 
> Documentation/admin-guide/reporting-bugs.rst. The main work is done and 
> you are already free to follow its instructions when reporting issues to 
> the Linux kernel developers. But keep in mind, below text still needs a 
> few finishing touches and review. It was merged to the Linux kernel 
> sources at this stage to make this process easier and increase the 
> text's visibility.
> 
>     Any improvements for the text or other feedback is thus very much 
> welcome. Please send it to 'Thorsten Leemhuis <linux@leemhuis.info>' and 
> 'Jonathan Corbet <corbet@lwn.net>', ideally with 'Linux kernel mailing 
> list (LKML) <linux-kernel@vger.kernel.org>' and the 'Linux Kernel 
> Documentation List <linux-doc@vger.kernel.org>' in CC.
> 
>     Areas in the text that still need work or discussion contain a hint 
> like this which point out the remaining issues; all of them start with 
> the word "FIXME" to make them easy to find.
> ```

Seems OK.

> >   - In a separate patch you could add a comment to the existing document
> >     pointing to the new one as the true source of wisdom.  
> 
> This is what I plan to add:
> 
> ```
> .. note::
> 
>     Instead of reading below text consider reading this document 
> instead: Documentation/admin-guide/reporting-issues.rst. It's intended 
> to replace below text in the near future, as it's easier to grasp and 
> more straight forward; it also provides way more details and more 
> accurately describes the steps currently needed when reporting bugs to 
> the Linux developers.
> ```

I'd be a bit more straightforward:

	This document is obsolete, and will be replaced by
	Documentation/admin-guide/$NAME in the near future.

Not sure that more is really needed?

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031BF2BA7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKTKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKTKqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:46:24 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477FC0613CF;
        Fri, 20 Nov 2020 02:46:24 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kg3vn-0003MW-8K; Fri, 20 Nov 2020 11:46:19 +0100
To:     Jonathan Corbet <corbet@lwn.net>
References: <cover.1605203187.git.linux@leemhuis.info>
 <20201113153313.68ff210c@lwn.net>
 <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
 <20201118172958.5b014a44@lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet
 more detailed & helpful
Message-ID: <2dcea97c-7b98-1ad2-d2ba-e7f7d77dc855@leemhuis.info>
Date:   Fri, 20 Nov 2020 11:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201118172958.5b014a44@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605869184;bb9553f8;
X-HE-SMSGID: 1kg3vn-0003MW-8K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.11.20 um 01:29 schrieb Jonathan Corbet:
> On Sun, 15 Nov 2020 11:13:52 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:

>   - Collapse the whole thing down to a patch adding reporting-bugs-v2.rst
>     (or some suitable name).  I do wonder if it should also move to the
>     process manual as part of this; not only admins will report bugs.

After a night's sleep and Randy's comment I for now settled on
Documentation/admin-guide/reporting-issues.rst

>   - Add a comment at the top saying it's a proposed replacement and
>     soliciting comments.  [...]
Struggled a bit to find the right words, but I think this should work:

```
.. important::

    This document is being prepared to replace 
Documentation/admin-guide/reporting-bugs.rst. The main work is done and 
you are already free to follow its instructions when reporting issues to 
the Linux kernel developers. But keep in mind, below text still needs a 
few finishing touches and review. It was merged to the Linux kernel 
sources at this stage to make this process easier and increase the 
text's visibility.

    Any improvements for the text or other feedback is thus very much 
welcome. Please send it to 'Thorsten Leemhuis <linux@leemhuis.info>' and 
'Jonathan Corbet <corbet@lwn.net>', ideally with 'Linux kernel mailing 
list (LKML) <linux-kernel@vger.kernel.org>' and the 'Linux Kernel 
Documentation List <linux-doc@vger.kernel.org>' in CC.

    Areas in the text that still need work or discussion contain a hint 
like this which point out the remaining issues; all of them start with 
the word "FIXME" to make them easy to find.
```

Randy let me know if you want to be mentioned there, too.

>   - In a separate patch you could add a comment to the existing document
>     pointing to the new one as the true source of wisdom.

This is what I plan to add:

```
.. note::

    Instead of reading below text consider reading this document 
instead: Documentation/admin-guide/reporting-issues.rst. It's intended 
to replace below text in the near future, as it's easier to grasp and 
more straight forward; it also provides way more details and more 
accurately describes the steps currently needed when reporting bugs to 
the Linux developers.
```

Ciao, Thorsten

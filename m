Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CFA2AF4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKKPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgKKPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:36:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEE6C0613D4;
        Wed, 11 Nov 2020 07:36:19 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kcsAT-0008J6-20; Wed, 11 Nov 2020 16:36:17 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <e9166fcbb777e9b7685745e572ab7c7322596ec2.1601541165.git.linux@leemhuis.info>
 <275187e0-92b5-d0a6-0bf7-76c827e2c808@infradead.org>
 <a08d1012-78bf-5f84-26d2-4f596bc3b59d@leemhuis.info>
Subject: Re: [RFC PATCH v1 15/26] docs: reporting-bugs: make readers test
 mainline, but leave a loophole
Message-ID: <873abf9c-5651-8dc3-70ea-b14e498661a7@leemhuis.info>
Date:   Wed, 11 Nov 2020 16:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a08d1012-78bf-5f84-26d2-4f596bc3b59d@leemhuis.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605108980;4708b4d6;
X-HE-SMSGID: 1kcsAT-0008J6-20
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.10.20 um 12:11 schrieb Thorsten Leemhuis:
> Am 02.10.20 um 19:51 schrieb Randy Dunlap:
>> On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
>>> = RFC =
>>>
>>> Am I asking for too much from users by telling them to test mainline? But most
>>> will likely have an outdated and heavily patched vendor kernel anyway, so they
>>> have to install a vanilla kernel if they want to report something upstream;
>>> that's why I thought "well, then let's go all in and make them test mainline.
>> That is appropriate IMO.

I'm preparing to send v2 and was a bit unhappy with this and another 
section when seeing it again after weeks. In the end I reshuffled and 
rewrote significant parts of it, see below.

Randy, would be great if you could take another look, but no pressure: 
just ignore it, if you lack the time or energy.

```
Install a fresh kernel for testing
----------------------------------

     *Install the latest Linux mainline kernel: that's where all issues 
get fixed first, because it's the version line the kernel developers 
mainly care about. Testing and reporting with the latest Linux stable 
kernel can be an acceptable alternative in some situations, for example 
during the merge window; but during that period you might want to 
suspend your efforts till its end anyway.*

Reporting an issue to the Linux kernel developers they fixed weeks or 
months ago is annoying for them and wasting their and your time. That's 
why it's in everybody's interest to check if the issue occurs with the 
latest codebase before reporting it.

In the scope of the Linux kernel the term 'latest' means: a kernel 
version recently created from the main line of development, as this 
'mainline' tree is where developer first apply fixes; only after that 
they are allowed to get backported to older, still supported version 
lines called 'stable' and 'longterm' kernels. That's why you should 
check a recent mainline kernel, even if you deal with an issue you only 
want to see fixed in an older version line. Another reason: some fixes 
are only applied to mainline or recent version lines, as it's too hard 
or risky to backport them to older versions. If that the case, reporting 
the issue again is unlikely to change anything.

Longterm kernels (sometimes called "LTS kernels") are therefore 
unsuitable for testing, they simply are too distant from current 
development. Even the latest Linux 'stable' kernel is a significant bit 
behind and thus better avoided. But sometimes it's even the right 
choice, but in those cases you might want to wait a few days before 
trying to reproduce an issue with the latest codebase:

Choosing between mainline, stable and waiting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Head over to `kernel.org <https://kernel.org/>`_ to decide which version 
to use. Ignore the big yellow button that says 'Latest release' and look 
a little lower for a table. At its top you'll see a line starting with 
'mainline', which most of the time will point to a pre-release with a 
version number like '5.8-rc2'. If that's the case, you'll want to use 
this mainline kernel for testing. Do not let that 'rc' scare you, these 
'development kernels' are pretty reliable — and you made a backup, as 
you were instructed above, don't you?

In about two out of every nine to ten weeks, 'mainline' might point you 
to a proper release with a version number like '5.7'. If that happens, 
consider suspending the reporting process until the first pre-release of 
the next version  (5.8-rc1) shows up on kernel.org. That's because the 
Linux development cycle then is in its two-week long 'merge window'. The 
bulk of the changes and all intrusive ones get merged for the next 
release during this time. It's a bit more risky to use mainline during 
this period. Kernel developers are also often quite busy then and might 
have no spare time to deal with issue reports. It's also quite possible 
that one of the many changes applied during the merge window fixes the 
issue you face; that's why you soon would have to retest with a newer 
kernel version anyway, as outlined below in the section 'Duties after 
the report when out'.

That's why it might make sense to wait till the merge window is over. 
But don't to that if you're dealing with something that shouldn't wait. 
In that case consider obtaining the latest mainline kernel via git (see 
below) or use the latest stable version offered on kernel.org. Using 
that is also acceptable in case mainline for some reason does currently 
not work for you. An in general: using it for reproducing the issue is 
also better than not reporting it issue at all.

How to obtain a fresh Linux kernel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can use pre-build or self-compiled kernel for testing; if you chose 
the latter approach, you can either obtain the source-code using git or 
download it as tar archive.

Using a pre-compiled kernel for testing is often the quickest, easiest, 
and safest way – especially is you are unfamiliar with the Linux kernel. 
But it needs to be a vanilla kernel, which can be hard to come buy. You 
are in luck if you are using a popular Linux distribution: for quite a 
few of them you'll find repositories on the net that contain packages 
with the latest mainline or stable kernels in vanilla fashion. It's 
totally okay to use these, just make sure from the repository's 
documentation they are really vanilla. And ensure the packages contain 
the latest versions as offered on kernel.org; they are likely unsuitable 
if the package is older than a week, as new mainline and stable kernels 
typically bet released at least once a week. And be aware that you might 
need to build your own kernel later anyway when it comes helping to test 
fixes, as described later in this document.

Developers and experienced Linux users familiar with git are often best 
served by obtaining the latest Linux kernel sources straight from the 
`official development repository on kernel.org 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_. 
Those are likely a bit ahead of the latest mainline pre-release. Don't 
worry about it: they are as reliable as a proper pre-release, unless the 
kernel's development cycle is currently in the middle of a merge window. 
But even then they are quite reliable.

People unfamiliar with git are often best served by downloading the 
sources as tarball from `kernel.org <https://kernel.org/>`_.

How to actually build a kernel not described here, as many websites 
explain the necessary steps already. If you are new to it, consider 
following one of those how-to's that suggest to use ``make 
localmodconfig``, as that tries to pick up the configuration of your 
current kernel and then tries to adjust it somewhat for your system. 
That does not make the resulting kernel any better, but quicker to compile.
```

Ciao, Thorsten

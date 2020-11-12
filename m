Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CCD2AFE46
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgKLFgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgKLDeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 22:34:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43A1C0613D1;
        Wed, 11 Nov 2020 19:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qNzJGu3xdVaK6XYAoGRv6/dUvX+61VnpRBKnhJMD9cU=; b=L5XvDnfghP5wURZ11Fnax/Bi51
        oQ8L5wWClvwFx4ljSp9uDd5yIpu0XYYFiq/iwy8+57OJDQj1cD2MQNzZ4wFFRvNaV1hZ7aF9t5Z6v
        ZGnzmSwyNpPbTzkSoZD7hfGkZojWkizQ6083483I+jnOQl24dHR47vEiYVDa3GEEIk87vC/tcpm6a
        C8u0McM7YdFXGkzCgQAb03z5bFg54mSsakAXov3Vmm8zprtVU2kkYxqUGWZwiY67CAH7A91T4Jh1l
        vwDFn5hLVAaq0anysEOyr2scBYgyNtp5C3H30+KA/JXCO3GSqBqEQXRbhl0g4590ZDSdiWMI8JzHr
        iaDogVqg==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kd3N4-0003BZ-CB; Thu, 12 Nov 2020 03:34:02 +0000
Subject: Re: [RFC PATCH v1 02/26] docs: reporting-bugs: Create a TLDR how to
 report issues
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <dc293f6d4f71ea827c861c64e88dfa0316f1d934.1601541165.git.linux@leemhuis.info>
 <8f3fce56-fdc4-c248-05ec-4fda1ee6fc54@infradead.org>
 <2b87f58f-ca74-6c73-fb7a-853cca2751bb@leemhuis.info>
 <6a8ffd01-ff1c-284b-42ac-23cd164e0873@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7eb95400-5ff1-ef14-d03f-b4d0f7482ac5@infradead.org>
Date:   Wed, 11 Nov 2020 19:33:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6a8ffd01-ff1c-284b-42ac-23cd164e0873@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 7:24 AM, Thorsten Leemhuis wrote:
> Am 03.10.20 um 09:27 schrieb Thorsten Leemhuis:
>> Randy, many thanks for looking through this, you feedback is much
>> appreciated! Consider all the obvious spelling and grammatical mistakes
>> you pointed out fixed, I won't mention all of them in this reply to keep
>> things easier to follow.
>>
>> Am 02.10.20 um 04:32 schrieb Randy Dunlap:
>>> On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
>>> […]
>>>> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
>>>> +how developers of that particular area expect to be told about issues; note,
>>>     for how
>>> ?
>> Not sure myself, but I guess you're right and thus followed your advice :-D
> 
> I'm preparing to send v2 and was a bit unhappy with this and another section when seeing it again after weeks. In the end I reshuffled and rewrote significant parts of it, see below.
> 
> Randy, would be great if you could take another look, but no pressure: just ignore it, if you lack the time or energy.
> 
> ```
> The short guide (aka TL;DR)
> ===========================
> 
> If you're facing multiple issues with the Linux kernel at once, report each separately to its developers. Try your best guess which kernel part might be causing the issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its developers expect to be told about issues. Note, it's rarely `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_, as in almost all cases the report needs to be sent by email!
> 
> Check the destination thoroughly for existing reports; also search the LKML archives and the web. Join existing discussion if you find matches. If you don't find any, install `the latest Linux mainline kernel <https://kernel.org/>`_. Make sure it's vanilla, thus is not patched or using add-on kernel modules. Also ensure the kernel is running in a healthy environment and is not already tainted before the issue occurs.
> 
> If you can reproduce your issue with the mainline kernel, send a report to the destination you determined earlier. Make sure it includes all relevant information, which in case of a regression should mention the change that's causing it which can often can be found with a bisection. Also ensure the report reaches all people that need to know about it, for example the security team, the stable maintainers or the developers of the patch that causes a regression. Once the report it out, answer any questions that might be raised and help where you can. That includes keeping the ball rolling: every time a new rc1 mainline kernel is released, check if the issue is still happening there and attach a status update to your initial report.
> 
> If you can not reproduce the issue with the mainline kernel, consider sticking with it; if you'd like to use an older version line and want to see it fixed there, first make sure it's still supported. Install its latest release as vanilla kernel. If you cannot reproduce the issue there, try to find the commit that fixed it in mainline or any discussion preceding it: those will often mention if backporting is planed or considered impassable. If backporting was not discussed, ask if it's in the cards. In case you don't find

                                       impossible.  ??

 any commits or a preceding discussion, see the Linux-stable mailing list archives for existing reports, as it might be a regression specific to the version line. If it is, it round about needs to be reported like a problem in mainline (including the bisection).

                                 maybe:  it still needs to be reported like

> 
> If you reached this point without a solution, ask for advice one the subsystem's mailing list.
> ```

Otherwise it looks good to me.

thanks.
-- 
~Randy


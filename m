Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD22D281874
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgJBQ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJBQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:59:55 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858DC0613D0;
        Fri,  2 Oct 2020 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=D1Z6zDq9Svnq7K1KUkOaNB83eAQx8W6cXMTOYb39NaM=; b=AYJaH86wofYwH5G51WnTXr92d5
        cfxrkK4xHS3aFioUQj1miXl12ZQOVW0XHvQKmJpDpxKFJ2g+KndPIZUuoKfwu+3J7TLlpd/fqdrnJ
        ++vXqbraSN99bdimg2o1V1N5YN21+Vn2frQj7UWJ66ngfyWmCb1vz+qqPVsiubkekEuZQ45wSwHLv
        5bDF6LyJGJ/ybJxoYFUo7VhNTCC3UKc8Q0IqGYxFrHyhFOjO2uwBEYtp5z96v/DT6RBF2nlSf0ztA
        5orOD4d6WtsJHsj+7URjd+8e5Eqg4ZZd7Jeaxh0EiIUu9Ce4hOMEP6ayp4FkQeWL9MJdpe+ObnSDD
        /aW0EccA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOOPQ-0002aV-4F; Fri, 02 Oct 2020 16:59:52 +0000
Subject: Re: [RFC PATCH v1 07/26] docs: reporting-bugs: let users classify
 their issue
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <d9917c1f15a965f75f20ca9f0db4ca3ae24c9e98.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a6e344f-71ca-209f-c540-3a03949a3a94@infradead.org>
Date:   Fri, 2 Oct 2020 09:59:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d9917c1f15a965f75f20ca9f0db4ca3ae24c9e98.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Explicitly outline that some issues are more important than others and
> thus need to be handled differently in some steps that are about to
> follow. This makes things explicit and easy to find if you need to look
> up what issues actually qualify as "regression" or a "severe problem".
> 
> The alternative would have been: explain each of the three types in the
> place where it requires special handling for the first time. But that
> makes it quite easy to miss and harder to find when you need to look it
> up.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 39 ++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 434e1a890dfe..430a0c3ee0ad 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -272,6 +272,45 @@ you want to circumvent it consider installing the mainline kernel yourself; just
>  make sure it's the latest one (see below).
>  
>  
> +Issue of high priority?
> +-----------------------
> +
> +    *See if the issue you are dealing with qualifies as regression, security
> +    issue, or a really severe problem: those are 'issues of high priority' that
> +    need special handling in some steps that are about to follow.*
> +
> +Linus Torvalds and the leading Linux kernel developers want to see some issues
> +fixed as soon as possible, hence these 'issues of high priority' get handled
> +slightly different in the reporting process. Three type of cases qualify:

            differently
at least that's what I would say. :)

> +regressions, security issues, and really severe problems.
> +
> +You deal with a 'regression' if something that worked with an older version of
> +the Linux kernel does not work with a newer one or somehow works worse with it.
> +It thus is a regression when a Wi-Fi driver that did a fine job with Linux 5.7
> +somehow misbehaves with 5.8 or doesn't work at all. It's also a regression if
> +an application shows erratic behavior with a newer kernel, which might happen
> +due to incompatible changes in the interface between the kernel and the
> +userland (like procfs and sysfs). Significantly reduced performance or
> +increased power consumption also qualify as regression. But keep in mind: the
> +new kernel needs to be build with a configuration that is similar to the one

                          built

> +from the old kernel (see below how to archive that). That's because

                                         achieve

> +process is sometimes only possible by doing incompatible changes; but to avoid

eh?  That's because ... ???

> +regression such changes have to be enabled explicitly during build time
> +configuration.
> +
> +What qualifies as security issue is left to your judgment. Consider reading
> +:ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>` before
> +proceeding.
> +
> +An issue is a 'really severe problem' when something totally unacceptable bad

                                                                unacceptably

> +happens. That's for example the case when a Linux kernel corrupts the data it's
> +handling or damages hardware it's running on. You're also dealing with a severe
> +issue when the kernel suddenly stops working with an error message ('kernel
> +panic') or without any farewell note at all. Note: do not confused a 'panic' (a

                                                             confuse

> +fatal error where the kernels stop itself) with a 'Oops' (a recoverable error),
> +as the kernel remains running after an 'Oops'.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

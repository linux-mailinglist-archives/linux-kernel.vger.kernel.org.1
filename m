Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B211FC037
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 22:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgFPUsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFPUsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:48:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A69C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:48:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ne5so1978139pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m2P9idazAxka1hZIUUZvV63ZK5j25rtNzd8Y+2LJOUI=;
        b=dmqZ1Nz+wl49hQajWMxFTtvFc+HUS5of9sr8Afyt97qYujziKI/PXkO33Fja18iB6Z
         3cT9dp8n3YAC7dmHar6jK8yJ+Aqg40a5HS1z0XCqnBzUJbmo5NoKWoeA7Onv6QL8he/M
         80F81qAiruwvfN7CYnVJHqTFL/3e2fBRE/3ymNgWlwJos8Hxjj5s/K3vRrYVJNJp2MvG
         mkLpf8PpHI0Phb9qK/Sp03KD7EE9FIT0kfhtYo2Fi81/XZeIJV8lt8EB2xW36B5i8fLX
         3SP/Pi4l9PyB4D08WBo87QSqdiV/3/L52sFQe6szmhRIvxVudaWArCMgvDvkJLXYhl49
         I24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m2P9idazAxka1hZIUUZvV63ZK5j25rtNzd8Y+2LJOUI=;
        b=JKHcDmmYmL/cIEpnA2m+Ob5tGLiXVlT62SyYZH/Zqbpee9QRQ6rpmc0H2glxNjs8aH
         CgSZGUAbThRIdNNWo6B8fcPO6wKV9BLAoPuPmvwCS0uPetkROZ+HKOl/3LbE2sfvLABt
         LaMZmvEBcwPfsLl2H6k4I9EbNTN5HFvvPzpUwHadOf4iVNypdHg+UzjOQnPcPgR2O7sv
         TbrBMKW8bat9Nwee4acHgwixkMX7/Gj4XMZD02ZYXm+EeUXEpDFG167sfkH74wCoCe2R
         JIXJDiOUcsHpoBB8+zVP5beZgPvmPpCvQTlJpZyp/bbAN9hPvIBsInC4ZqcOnyKKOpFD
         +9fw==
X-Gm-Message-State: AOAM532eIjWrV/rYc26NruYhO15EscTtOd1MdV6C48IU80GfFS6KH/OB
        jsM7DlYUAKg84Rv0AIXZuJfWMA==
X-Google-Smtp-Source: ABdhPJwuYwwPV8Rupxbl+dxr6M+lp9Ae0HvkzcOMrO5ohV18T1DBfOeCRj2MGVXdOYCIVaIKOz2WQA==
X-Received: by 2002:a17:90a:68ca:: with SMTP id q10mr4861572pjj.120.1592340502384;
        Tue, 16 Jun 2020 13:48:22 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id m14sm15310095pgn.83.2020.06.16.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 13:48:21 -0700 (PDT)
Date:   Tue, 16 Jun 2020 13:48:17 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <20200616204817.GA212825@google.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:11:06PM +0000, Bird, Tim wrote:
> Some months ago I started work on a document to formalize how
> kselftest implements the TAP specification.  However, I didn't finish
> that work.  Maybe it's time to do so now.
> 
> kselftest has developed a few differences from the original
> TAP specification, and  some extensions that I believe are worth
> documenting.
> 
> Essentially, we have created our own KTAP (kernel TAP)
> format.  I think it is worth documenting our conventions, in order to
> keep everyone on the same page.
> 
> Below is a partially completed document on my understanding
> of KTAP, based on examination of some of the kselftest test
> output.  I have not reconciled this with the kunit output format,
> which I believe has some differences (which maybe we should
> resolve before we get too far into this).
> 
> I submit the document now, before it is finished, because a patch
> was recently introduced to alter one of the result conventions
> (from SKIP='not ok' to SKIP='ok').
> 
> See the document include inline below
> 
> ====== start of ktap-doc-rfc.txt ======

[...]

> --- from here on is not-yet-organized material
> 
> Tip:
>  - don't change the test plan based on skipped tests.
>    - it is better to report that a test case was skipped, than to
>      not report it
>    - that is, don't adjust the number of test cases based on skipped
>      tests
> 
> Other things to mention:
> TAP13 elements not used:
>  - yaml for diagnostic messages

We talked about this before, but I would like some way to get failed
expectation/assertion information in the test in a consistent machine
parsible way. Currently we do the following:

� � # Subtest: example
� � 1..1
� � # example_simple_test: initializing
� � # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
� � Expected 1 + 1 == 3, but
� � � � 1 + 1 == 2
� � � � 3 == 3
� � not ok 1 - example_simple_test
not ok 5 - example

Technically not TAP compliant, but no one seems to mind. I am okay with
keeping it the way it is, but if we don't want it in the KTAP spec, we
will need some kind of recourse.

>    - reason: try to keep things line-based, since output from other things
>    may be interspersed with messages from the test itself
>  - TODO directive

Is this more of stating a fact or desire? We don't use TODO either, but
it looks like it could be useful.

> KTAP Extensions beyond TAP13:
>  - nesting
>    - via indentation
>      - indentation makes it easier for humans to read
>  - test identifier
>     - multiple parts, separated by ':'

Can you elabroate on this more? I am not sure what you mean.

>  - summary lines
>    - can be skipped by CI systems that do their own calculations
> 
> Other notes:
>  - automatic assignment of result status based on exit code
> 
> Tips:
>  - do NOT describe the result in the test line
>    - the test case description should be the same whether the test
>      succeeds or fails
>    - use diagnostic lines to describe or explain results, if this is
>      desirable
>  - test numbers are considered harmful
>    - test harnesses should use the test description as the identifier
>    - test numbers change when testcases are added or removed
>      - which means that results can't be compared between different
>        versions of the test
>  - recommendations for diagnostic messages:
>    - reason for failure
>    - reason for skip
>    - diagnostic data should always preceding the result line
>      - problem: harness may emit result before test can do assessment
>        to determine reason for result
>      - this is what the kernel uses
> 
> Differences between kernel test result format and TAP13:
>  - in KTAP the "# SKIP" directive is placed after the description on
>    the test result line
> 
> ====== start of ktap-doc-rfc.txt ======
> OK - that's the end of the RFC doc.
> 
> Here are a few questions:
>  - is this document desired or not?
>     - is it too long or too short?
>  - if the document is desired, where should it be placed?

I like it. I don't think we can rely on the TAP people updating their
stuff based on my interactions with them. So having a spec which is
actually maintained would be nice.

Maybe in Documentation/dev-tools/ ?

>    I assume somewhere under Documentation, and put into
>    .rst format. Suggestions for a name and location are welcome.
>  - is this document accurate?
>    I think KUNIT does a few things differently than this description.
>    - is the intent to have kunit and kselftest have the same output format?
>       if so, then these should be rationalized.

Yeah, I think it would be nice if all test frameworks/libraries for the
kernel output tests in the same language.

Cheers

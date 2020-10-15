Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9628FAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgJOV53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgJOV53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:57:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:57:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so251859pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+HirN9imkTNenxnF1fARCZ++oG/BPbJh5tZatzn08Pk=;
        b=NryStx+0D7n93j4bJ+39S+L/RJOrazFnYAsRRDiVE7ats47+CyDN/3kJNv+f9sea/O
         Z8oyFOqrLTFunDVsds0hgV3+nIDFIcdrfJOjZWTaww0wJnqZppeXwDX6IGcC5sZtBghw
         CukaZ4IKfMNGzJRKasMyR1cyCQ3ioP0G2omcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+HirN9imkTNenxnF1fARCZ++oG/BPbJh5tZatzn08Pk=;
        b=F48zBaFx9Y6rxAR9jFMNm+qbSQ3gVWKRxpI7sO3Li5zBtDq+4SABrfogsHMIFYKLlV
         PaYgSiSBse7lOkX3b0VaqZgl+lRhg40rnJ1IWW0i6H2eQsONBmQJWol4XvyXF/VeUIN2
         xPqMlUWcLaj+melF2IygrHYCDSQmMEY9HPSMMBIT1LF+X3TzbncpQMT4XJAEOuAbVIrd
         epuYnBFAzq6GxRNqm0DmfeRBkEH6HecuigrIiTjSvVnYBohpcbIfc1/NUN3VQXygsRE7
         YFatCBPP7GoiL8YFoWIMxntJrTL7SFlXgESdHdR9c2YelMvXAIKZQiHEWb6cqZtLTYt2
         ZeZg==
X-Gm-Message-State: AOAM533MECTFOSA3LfCYRtEeyEj518RIhb3PB9BQykiR25NsbB6gXk4A
        mUgV+2tMOEWftQ7pBetd8bBScHhqpBYEIQ==
X-Google-Smtp-Source: ABdhPJwAvPB5af0CfJASapqoGe3tufGFbINTyn4eNTbKiWpIy7TpGbula57cC6HG75GjKrqYOt0Dbw==
X-Received: by 2002:aa7:9828:0:b029:152:192d:9237 with SMTP id q8-20020aa798280000b0290152192d9237mr624696pfl.80.1602799048599;
        Thu, 15 Oct 2020 14:57:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bx22sm278682pjb.40.2020.10.15.14.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 14:57:27 -0700 (PDT)
Date:   Thu, 15 Oct 2020 14:57:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] selftests/run_kselftest.sh: Make each test
 individually selectable
Message-ID: <202010151336.3B30332@keescook>
References: <20200928202650.2530280-1-keescook@chromium.org>
 <20200928202650.2530280-3-keescook@chromium.org>
 <CA+G9fYtqqzWtb65pk8J=-Afv0KZ9iy3_bA-WmiJjbe5Y6qXbAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtqqzWtb65pk8J=-Afv0KZ9iy3_bA-WmiJjbe5Y6qXbAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 02:57:34PM +0530, Naresh Kamboju wrote:
> On Tue, 29 Sep 2020 at 01:56, Kees Cook <keescook@chromium.org> wrote:
> >
> > Currently with run_kselftest.sh there is no way to choose which test
> > we could run. All the tests listed in kselftest-list.txt are all run
> > every time. This patch enhanced the run_kselftest.sh to make the test
> > collections (or tests) individually selectable. e.g.:
> >
> > $ ./run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep
> >
> > Additionally adds a way to list all known tests with "-l", usage
> > with "-h", and perform a dry run without running tests with "-n".
> 
> 
> While testing this patch set on LAVA the skip test functionality is not working.
> We may have to revisit test definitions kselftest skip logic
> or else
> may add one more option to skip a given test on run_kselftest.sh script.
> 
> ref:
> https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/kselftest.sh#L196

Yes, LAVA's hack to skip tests needs to be adjusted. Here's what it
should probably look like:
https://github.com/Linaro/test-definitions/pull/231

-- 
Kees Cook

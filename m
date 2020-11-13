Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFE22B2424
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKMS7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgKMS7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:59:04 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:59:04 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z3so8381416pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qGmv8BzyPst13CeS3xRkYG813MXy36+7XsO3CpXIfKk=;
        b=CuEuoUtoyQzQpd6Womn5/uVLQGnmSiRGcc7NUDUN0HYRqd81DJYsNca/x1ge2tdhED
         kZdqPGflPk0HfeQuTIcvyWI7aeJkAcg2qwfKtoPyu4Acdt7C07HWD31r2TCR7HJ96pI2
         K6CfJciOq6Qn1ERVT53WRa7V0AQmISXJ0vAJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qGmv8BzyPst13CeS3xRkYG813MXy36+7XsO3CpXIfKk=;
        b=F5/NcCg96yYhy5T1F1NSutcJBNDcfYK6j0pqCHb6yPQpPIrxlCGWe8GrEKSkYFxGnB
         AaERoUqVFp6dMG6Wa1jtscF3QMVFn/stuzjeQAaepK2wv1dKBDO/PUKWZPlPkLGbqyty
         YTDqsSgkK1Mt0T44nG8mbnEDKm7CeCXW9wzvBQApOtG/rQM19xwMALmhZlme7IxNPhBf
         YSKKyufHgOnmC+WE9csm1ob+cYOzVBUCbvJwEE9Ea9FzfbXYxQCu6wXtlCvO6UeIxJ77
         swDISV6wYc7l2qXwLUWNp52cqYZVnTu9YVnJQEDdJC+37Ye3mx5GEJNdSA/aj/g89mgT
         F6bA==
X-Gm-Message-State: AOAM53118HVlg3ZmoWTV/ocamCl0YTI78gWMviUpFF26SWzxr1jbWvwV
        abYZJgj01XkPMeaX9kgUUrDhrw==
X-Google-Smtp-Source: ABdhPJwloG4E2l4LNBfE1hE8jMXVjsJDi5yKPtCW9gchg6Ja0mhv509ooLTLS2BqpM6sAKiBUl4blw==
X-Received: by 2002:a17:90a:460a:: with SMTP id w10mr4387456pjg.232.1605293943782;
        Fri, 13 Nov 2020 10:59:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n4sm2304169pgh.12.2020.11.13.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 10:59:02 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:59:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] perf/x86: fix sysfs type mismatches
Message-ID: <202011131058.C331BE3C@keescook>
References: <20201113183126.1239404-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113183126.1239404-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:31:26AM -0800, Sami Tolvanen wrote:
> This change switches rapl to use PMU_FORMAT_ATTR, and fixes two other
> macros to use device_attribute instead of kobj_attribute to avoid
> callback type mismatches that trip indirect call checking with Clang's
> Control-Flow Integrity (CFI).
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

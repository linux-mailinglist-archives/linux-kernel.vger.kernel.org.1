Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4D25A56A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBGN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 02:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgIBGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:13:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF41C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 23:13:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o21so3266008wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iqd3bsowREDTYEVeGZ9VhDsWWfsaRpNMJIu5Ds4gx2g=;
        b=B9faO6hTm/56+u5sVOL4bax36f9/sfr3W32Ww28aFIYXNDYuDoksgXIi4hhSRsr1Gj
         kuaF4StDHIpnbWyABPexzyRmGWsMuKHSfEpy/oRxo/nSMF6SCaOOZ6elPQ6c7RlXmJSA
         BfPbJ9l4p+0f33mPgp9yQrXZXShRnhNyh4httqSa7abhNR4XuMnR7tn8yJVtemXFuyEN
         m6li2ctvqvvSaIZn7IK3r9fy+tD9duq0YEKO7XNtxsFfF8eAV4sX03ag/uulyvUsDj98
         otrFVEl5MM46mee7asZZJlFi5ueP0tZSgw3LEkQloGgrLQuADKh/VBqtZvRdryugYZAq
         ghQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iqd3bsowREDTYEVeGZ9VhDsWWfsaRpNMJIu5Ds4gx2g=;
        b=L9U/59ZRU1CF1PEG23RlyXT40rkBzOfqLhzaGXtwfaotTBUAgHzPBc8BAJX7nlDZDj
         q1lXqcGQ2kMHzJsSIQJ1l0p30/nAW9PRvFYP1lIdX4b4/KtFZR70mukT8Zq7FDetbrGy
         Gknz7fP/0Odmcv2XgBBMi3vKq0n8xQoVAYMBthbeZmvXA4xU1z11kRxNHPvaPc9o7DW6
         8JwJF+Hqe5ZsfsJFHA9nJjMHAWBbOPW0nnY0/DILDn2+OKAhwmNhVALO1u/wrFh460Hj
         u5wrQG2rpKaqFus8WwX5cOWJtOjrGTxHgg75DXR2XMDIGKxVtdgv7jmcX5ikDA3y3/VE
         +veg==
X-Gm-Message-State: AOAM532Wq9D0/msgZKqPnS6p8TrIZI0u3UrnnleIEvLcPk9hzE+3Vndd
        CvvxM25C++0u/YmdCr7WTbxJZw==
X-Google-Smtp-Source: ABdhPJwL7FLejXtrVwUqdEuOpsyykxM3LSW2wkJ07/4cgh9fxFaaYW7lbo9BIfgItLZBNajZ4glP6A==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr4951241wmh.37.1599027202216;
        Tue, 01 Sep 2020 23:13:22 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id z9sm4988328wmg.46.2020.09.01.23.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:13:21 -0700 (PDT)
Date:   Wed, 2 Sep 2020 08:13:15 +0200
From:   Marco Elver <elver@google.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kernel-team@fb.com, mingo@kernel.org,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        cai@lca.pw, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH kcsan 18/19] bitops, kcsan: Partially revert
 instrumentation for non-atomic bitops
Message-ID: <20200902061315.GA1167979@elver.google.com>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
 <20200831181805.1833-18-paulmck@kernel.org>
 <20200902033006.GB49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902033006.GB49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:30AM +0800, Boqun Feng wrote:
> Hi Paul and Marco,
> 
> The whole update patchset looks good to me, just one question out of
> curiosity fo this one, please see below:
> 
> On Mon, Aug 31, 2020 at 11:18:04AM -0700, paulmck@kernel.org wrote:
> > From: Marco Elver <elver@google.com>
> > 
> > Previous to the change to distinguish read-write accesses, when
> > CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y is set, KCSAN would consider
> > the non-atomic bitops as atomic. We want to partially revert to this
> > behaviour, but with one important distinction: report racing
> > modifications, since lost bits due to non-atomicity are certainly
> > possible.
> > 
> > Given the operations here only modify a single bit, assuming
> > non-atomicity of the writer is sufficient may be reasonable for certain
> > usage (and follows the permissible nature of the "assume plain writes
> > atomic" rule). In other words:
> > 
> > 	1. We want non-atomic read-modify-write races to be reported;
> > 	   this is accomplished by kcsan_check_read(), where any
> > 	   concurrent write (atomic or not) will generate a report.
> > 
> > 	2. We do not want to report races with marked readers, but -do-
> > 	   want to report races with unmarked readers; this is
> > 	   accomplished by the instrument_write() ("assume atomic
> > 	   write" with Kconfig option set).
> > 
> 
> Is there any code in kernel using the above assumption (i.e.
> non-atomicity of the writer is sufficient)? IOW, have you observed
> anything bad (e.g. an anoying false positive) after applying the
> read_write changes but without this patch?

We were looking for an answer to:

	https://lkml.kernel.org/r/20200810124516.GM17456@casper.infradead.org

Initially we thought using atomic bitops might be required, but after a
longer offline discussion realized that simply marking the reader in
this case, but retaining the non-atomic bitop is probably all that's
needed.

The version of KCSAN that found the above was still using KCSAN from
Linux 5.8, but we realized with the changed read-write instrumentation
to bitops in this series, we'd regress and still report the race even if
the reader was marked. To avoid this with the default KCSAN config, we
determined that we need the patch here.

The bitops are indeed a bit more special, because for both the atomic
and non-atomic bitops we *can* reason about the generated code (since we
control it, although not sure about the asm-generic ones), and that
makes reasoning about accesses racing with non-atomic bitops more
feasible. At least that's our rationale for deciding that reverting
non-atomic bitops treatment to it's more relaxed version is ok.

Thanks,
-- Marco

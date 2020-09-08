Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64CF261A89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgIHShH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731698AbgIHScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6845FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:23:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c196so6186296pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mfB0S2TmcGDxX8xZkZ/chTU0dmPHOOO8nuKSmYrB2mM=;
        b=Oo/DQrZCB0KIovn2oIQvAUWTptWqamehVi+n9pOLZRf1yPmAlsDgequytTa8T71Hfc
         MnZ8qfVQW2q6h/Gb3s3xMzJv0ALrHyHScJJ+WdbP6brRxtmNudTvVWKGbUjfoC5KHF4b
         uGSGjTSSevWadA70wvgbB72exIK9HnLgQdo9pBIgjKkAOXHzO50M1u7BZGl1okDbUiqz
         czRJlEsh6kR0+ujAUZ5GoU2okMRHEd7MJeAWIce5U7hvYLvI/36yTxGrED/UXTfJN1Pp
         +8kHwWJ0fqPNtnwRBmLuZUKXP2wEoOXwXAgDcmvidR+BlAhYV4QFIECLoW9snCOd1lTW
         zkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mfB0S2TmcGDxX8xZkZ/chTU0dmPHOOO8nuKSmYrB2mM=;
        b=LetHXZKczNxvV/5XDznd0k92nBQjs0kEYwav3ascvVNrXAt/2ATNLPyxiCH6i4/LyG
         X3JPQyK+D6Ta6fSPAORN9eEUQJ5n499JhHfmhVaubJGjGp1RZAVBzjQBE2fBET7hfKm+
         n+ueTibbCAmkr3qBi3dnuNk5O1b+6f8qXtEzWd9KwF3mgnZYuongJ34Mj+Nd1SSrQAIz
         kyXBMroshXI2iPsPElUJsSZskEsVfSBYNW/s0k8yHAmHhfO/0Y6CQajJ3l7pJdeNbgP+
         jw5aCngpTTOJ0Xf5kwiVE1t7ErxCixN8JfQ3An10gpF+R+NUHZyaPlgid6uQcJFhSS+Q
         2OIQ==
X-Gm-Message-State: AOAM530Nmo4H5G0sV3qkUGlyuZGrmy9RalQWGgR/3y+6Jhai2e/k7/Z9
        nUm/MHGUD0jrEKxYtupluFurTg==
X-Google-Smtp-Source: ABdhPJwprY99iDi73Le2vnSOxXHnK9OCb6eXlfe519dNjZDsp0xdQH72w/MWOHjt+KXl9278n5yCtw==
X-Received: by 2002:a17:902:10f:: with SMTP id 15mr24890192plb.121.1599589394447;
        Tue, 08 Sep 2020 11:23:14 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id h11sm108910pfe.185.2020.09.08.11.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:13 -0700 (PDT)
Date:   Tue, 8 Sep 2020 11:23:08 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 10/28] kbuild: lto: fix module versioning
Message-ID: <20200908182308.GA1227805@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-11-samitolvanen@google.com>
 <202009031510.32523E45EC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009031510.32523E45EC@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:11:54PM -0700, Kees Cook wrote:
> On Thu, Sep 03, 2020 at 01:30:35PM -0700, Sami Tolvanen wrote:
> > With CONFIG_MODVERSIONS, version information is linked into each
> > compilation unit that exports symbols. With LTO, we cannot use this
> > method as all C code is compiled into LLVM bitcode instead. This
> > change collects symbol versions into .symversions files and merges
> > them in link-vmlinux.sh where they are all linked into vmlinux.o at
> > the same time.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> The only thought I have here is I wonder if this change could be made
> universally instead of gating on LTO? (i.e. is it noticeably slower to
> do it this way under non-LTO?)

I don't think it's noticeably slower, but keeping the version information
in object files when possible is cleaner, in my opinion.

Sami

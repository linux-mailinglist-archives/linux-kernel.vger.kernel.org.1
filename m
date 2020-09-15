Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C984626A4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIOMI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgIOMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:01:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B833EC061351
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:01:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so2971665wrl.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D1RHl8ABdhn5KjoXJVQFbK3lZzim3prS8WaJzdIy+Zo=;
        b=Zb9L1jobJQn7TM+/5qKmWs5QBd2EXGxISO/ZkcumPM8Vro0Vr55MmlKUwUifKoKJg+
         zl/iDbZ2w5XqrlxmJkjZgmmZP5NI1934atyy561Ay2MXa+FnuuynbncFOlg6j1nAM8ei
         nQJq5CvBO8QomgfteMuJPONS1P+ZZCvCiP3bLKVjNIYXIcqQgdzXgAjr3TShuD/NTpLq
         WK/qwY8X5PijIrR+U2tADWCc41LFvUI6wRrhWcMVNdBvt24fQOuGsuHn/kO9UmXlrJl9
         lA14MFwIiIxLtPEKAUDzC+4CdfxeTGre++QHrUGZAZncOeGJWO14UVlnAnY/vdGLIltr
         bPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1RHl8ABdhn5KjoXJVQFbK3lZzim3prS8WaJzdIy+Zo=;
        b=qD1ADhZXIsKNiQyLeO5ZybpRQF7y5C9Gk2YdKAsSpePKMkpax6RaZ/heERnLJT6afC
         Hpw4Ma9bU5EaOU9lh5FfWhVhQKecv9xJwwiNlRxTXYwPl9EvLbwK5ltE4sjVBsIMex4O
         956DFlEk1XnzqedAqds+vVDhj7VZkm+y/eKB4GLQLVKZTMuWM3XyxNJNnnNNXmw9N+ZJ
         nI1v+rwk/DJtU2Tj3CGGP0b1xGgjPu0XHUG50/4elRW2rNoxm0yS2l4+JSyWCqgN3TEC
         DhP0c9jLAQRfadXGIXPQFA9Q8V09cdjYKJKWfgZf49s4jTKU6BVyXLkLAifyLWEPF838
         1DXA==
X-Gm-Message-State: AOAM530EsKDMvu4mag+/F+yMcJwqa3DKpUa1xlGSgg7IChi9peWdNDOq
        ubpts0RoN+rtYBIFT0/6MKjVZg==
X-Google-Smtp-Source: ABdhPJw9xzBTkm1ex/SpXs3gzQoe/wJz8pjYJNPqDjhDGb9ai+C4+hJhDspqERQLDE8pW/IN0QMg9Q==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr22458843wri.292.1600171267204;
        Tue, 15 Sep 2020 05:01:07 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id s124sm25145526wme.29.2020.09.15.05.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:01:06 -0700 (PDT)
Date:   Tue, 15 Sep 2020 12:01:05 +0000
From:   George Popescu <georgepope@google.com>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>, maz@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        dbrazdil@google.com, broonie@kernel.org, maskray@google.com,
        ascull@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/14] Fix CFLAGS for UBSAN_BOUNDS on Clang
Message-ID: <20200915120105.GA2294884@google.com>
References: <20200914172750.852684-1-georgepope@google.com>
 <20200914172750.852684-7-georgepope@google.com>
 <202009141509.CDDC8C8@keescook>
 <20200915102458.GA1650630@google.com>
 <CANpmjNOTcS_vvZ1swh1iHYaRbTvGKnPAe4Q2DpR1MGhk_oZDeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOTcS_vvZ1swh1iHYaRbTvGKnPAe4Q2DpR1MGhk_oZDeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 01:18:11PM +0200, Marco Elver wrote:
> On Tue, 15 Sep 2020 at 12:25, George Popescu <georgepope@google.com> wrote:
> > On Mon, Sep 14, 2020 at 03:13:14PM -0700, Kees Cook wrote:
> > > On Mon, Sep 14, 2020 at 05:27:42PM +0000, George-Aurelian Popescu wrote:
> > > > From: George Popescu <georgepope@google.com>
> > > >
> > > > When the kernel is compiled with Clang, UBSAN_BOUNDS inserts a brk after
> > > > the handler call, preventing it from printing any information processed
> > > > inside the buffer.
> > > > For Clang -fsanitize=bounds expands to -fsanitize=array-bounds and
> > > > -fsanitize=local-bounds, and the latter adds a brk after the handler
> > > > call
> > >
> > This would mean losing the local-bounds coverage. I tried to  test it without
> > local-bounds and with a locally defined array on the stack and it works fine
> > (the handler is called and the error reported). For me it feels like
> > --array-bounds and --local-bounds are triggered for the same type of
> > undefined_behaviours but they are handling them different.
> 
> Does -fno-sanitize-trap=bounds help?>

I tried replacing it with:
      ifdef CONFIG_CC_IS_CLANG
            CFLAGS_UBSAN += $(call cc-option, -fno-sanitize-trap=bounds)
            CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
      else
            CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
      endif

The code traps.

Thanks,
George

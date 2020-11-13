Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863B22B2420
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgKMS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgKMS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:57:40 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:57:40 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so8422776pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1itoSNkHonPSiiU5cCwB+hrqPjiUJLVZ8eun9HcAhcQ=;
        b=eQ7pBfkoR8TVJzlzFle9uw1Hjd5Z4C3wJlxjAm5e2bZtckwY2gVOcyyUOQRKfnuHTC
         Tv0HCfLp14N+Z7ly7iHqEHXe1IqS8KHEUTb6g+VAQbbPQ1KW+Rve4i2yG6m0GjIDNypC
         tLg7F4Hscl/n8uz92vTPyJBltKWalhaDw97xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1itoSNkHonPSiiU5cCwB+hrqPjiUJLVZ8eun9HcAhcQ=;
        b=rdFSmpjvF/nqcjFu4xcusjNlQ5HY3AQ/Dcpq4VXxdjexIEPEoAVQEtyVbH9/ljfBL5
         Ct79vMn72t9g8dwws4HUc+EgEGMm6JWZcq8jM+FhjTRg+f5ZRiQmaDLkNAMvb/jXK6TR
         moi7OQh5Nv1Yl+/69abHfj/5dlXlILgdJttmo9fJQQ6XFgGoqhIf9egqEJJBFTJ4cPtm
         lBswfS2mRy0O4o5bpxDxphEgxqq2ylm9EydJKqnom8yvQgNPX2TQN0vJ5S+3o/l9C+nx
         DogPHUvV4amLzKbj8gDv9JtPkXBh2ZRKqnDPcWIcqp0ZSc/fk7H2gAGmAKtIHgXdnhWP
         mvSg==
X-Gm-Message-State: AOAM531b5dhBxuMS/FygBAhrNebsDqExNELbVAjv4gqzHqmpzVdGc8NY
        SSvIaoecKr/mjJGF6X9NsfXHEVh4u4UWZcOh
X-Google-Smtp-Source: ABdhPJydx9UlcJoFoWYdDzTPkTk22qjS7mcdnC9+v7wC/Xeh28t4PS7VN1t00pZ8wU/Ykd0Qaipu5Q==
X-Received: by 2002:a62:5253:0:b029:18a:b277:6be2 with SMTP id g80-20020a6252530000b029018ab2776be2mr3389287pfb.0.1605293860445;
        Fri, 13 Nov 2020 10:57:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ga18sm3290528pjb.5.2020.11.13.10.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 10:57:39 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:57:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/ftrace: mark my_tramp[12]? global
Message-ID: <202011131057.907A4449@keescook>
References: <20201113183414.1446671-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113183414.1446671-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:34:14AM -0800, Sami Tolvanen wrote:
> my_tramp[12]? are declared as global functions in C, but they are not
> marked global in the inline assembly definition. This mismatch confuses
> Clang's Control-Flow Integrity checking. Fix the definitions by adding
> .globl.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

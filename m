Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C987B2CB094
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgLAW6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgLAW6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:58:33 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D4DC061A04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 14:57:53 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so2269350pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 14:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gGPZVkS0BS7EX3qtKKqZonvL2UvrJlAXlI+Z6tp/Obo=;
        b=i4aAeWGyU4DZ/J5ItxCdN3Hm8dkZllgwH4DlRJXRMbXFzeuBNiEpFCMOPXl6SdjT4H
         Bjetwk4SLQ+rYxPSW+gIxGQhXo52pTGs4I/wxnZ0p0qLBphclbtyIjoflvlfWAokOLLS
         PxOQyYU4LV4J4TxIqejcXjKi6KQthpeWRqCHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gGPZVkS0BS7EX3qtKKqZonvL2UvrJlAXlI+Z6tp/Obo=;
        b=YlB6ZMW49L9Z1yo/RSMHyjqrw6VJC1QYsC+KOs7dj9pB+BrS77JTSSFFuI9wm5kGb+
         znQ1f+EQ8iTX/f/hEtd/Y2Iu6+TgyjHupAkMEG692pMrF3F7TDfNmb9qGpM+KpUvxPoP
         5xGhoCQ0d0D3pbzhK19TqfiCTXUK3RPLW9b7oIPx+/3YDWo0RcNVtFamJLMu7p4xiLXA
         5tHOzOoFD5NxGylF86+Aw65MfMPsfqcbdk5754W3Aylkjc1kiJsSuF8YEDNgg1gcyepl
         gx5Iam4KhhD2MIkPL9zpOyLQA2sL3RadNxi0jnMJjYFPn46nFcEftQqGDqlVhdgUD8Bn
         +uQA==
X-Gm-Message-State: AOAM5307CFZitn100JO/wNy5Y0WEOLbNvw89APX+WVrP3RISlphIvhcP
        8yDTCIiBKudiZm/2llLFywa5LA==
X-Google-Smtp-Source: ABdhPJxjQIgF4OUUx+XLdTNkmeUk+aNs7Cwk4t1xuqlQVJ6LLs4+Gvp7RAFlnO1u4uN26eoQL1tQIg==
X-Received: by 2002:a17:90a:e604:: with SMTP id j4mr5062597pjy.19.1606863472991;
        Tue, 01 Dec 2020 14:57:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm593202pgh.5.2020.12.01.14.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:57:52 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:57:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, gofmanp@gmail.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 4/7] entry: Support Syscall User Dispatch on common
 syscall entry
Message-ID: <202012011457.047EFC2@keescook>
References: <20201127193238.821364-1-krisman@collabora.com>
 <20201127193238.821364-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127193238.821364-5-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 02:32:35PM -0500, Gabriel Krisman Bertazi wrote:
> Syscall User Dispatch (SUD) must take precedence over seccomp and
> ptrace, since the use case is emulation (it can be invoked with a
> different ABI) such that seccomp filtering by syscall number doesn't
> make sense in the first place.  In addition, either the syscall is
> dispatched back to userspace, in which case there is no resource for to
> trace, or the syscall will be executed, and seccomp/ptrace will execute
> next.
> 
> Since SUD runs before tracepoints, it needs to be a SYSCALL_WORK_EXIT as
> well, just to prevent a trace exit event when dispatch was triggered.
> For that, the on_syscall_dispatch() examines context to skip the
> tracepoint, audit and other work.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6CD2D7F89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393916AbgLKTkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393614AbgLKTj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:39:57 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7295BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:39:17 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id c12so7338152pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QIo3bVfXx+Lw6yjMPp9SCxURrwOhgHYFY1xv/a61tbE=;
        b=EE79xVzCQ878gaWv70KGbugsUsEVTVKRvTDVaxUCXctFF4VuLtHqWGm7O6JTdNX8aA
         ZUj064dim+/Wo4zvDThfieGnLPm9Ywj2XT/QL9UVcnjgFWFjfgYaAhLsr4RNTdKtHHVI
         4mlilYnavzNrhDGan8smtOwpweHr7t1gqxPOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIo3bVfXx+Lw6yjMPp9SCxURrwOhgHYFY1xv/a61tbE=;
        b=p8TFg+AEwdzc/qATcQnxcq00KFFXqPHj8d9mswgcrC7h5dNIhlHPkIuKIZTv77HfS4
         Xp8puD7crVsoXAqRWNLrh4YGmNNc8uq+fv6jXuqkQeZhA+pOqjyzdBH5YsAcqq/3u+Gv
         5sYZppYxp/BBoYydUQ7CqdXME7HKJLV83cLjT8jDwwswEAw1yLtkSxv2pSxyjz+3w/15
         EXYEgJjEaSGUnItipjaSvdSeVrwAe1toGTVf3a8F6Zykx375qmcDkRYjw2jYsr7rPf6D
         v7VkcyisdNp0df84TP54Z7BDvyjQx2HbiQH4MXIq0R5QTpusHXQL1N3bASS9X3JEql4N
         /+ew==
X-Gm-Message-State: AOAM532SgHVK6gzUTDosA2J4vFFp6R7KF3V0oZPzPotAMNfiueWk8TDM
        cswXkiNDiPWLHhGii/J3ADuCG+zJBeKHyg==
X-Google-Smtp-Source: ABdhPJyXXcdsdOi+abTcXE1bh4agGGO9zoA56tTZLE0YkcYA83KnSclETRXTn0Xpes2srW5EBHYjXQ==
X-Received: by 2002:aa7:9312:0:b029:19d:fa90:3f42 with SMTP id 18-20020aa793120000b029019dfa903f42mr2634148pfj.18.1607715557089;
        Fri, 11 Dec 2020 11:39:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t127sm11513482pfd.68.2020.12.11.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 11:39:16 -0800 (PST)
Date:   Fri, 11 Dec 2020 11:39:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adam Zabrocki <pi3@pi3.com.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] x86/kprobes: Fix optprobe to detect padding int3
 correctly
Message-ID: <202012111139.948F2ECF1@keescook>
References: <160767025681.3880685.16021570341428835411.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160767025681.3880685.16021570341428835411.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 04:04:17PM +0900, Masami Hiramatsu wrote:
> Fix optprobe to detect padding int3 correctly.
> 
> Since commit 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP
> for linker fill bytes") changed the padding bytes between functions
> from nop to int3, when optprobe decodes a target function it finds
> int3 and gives up the jump optimization.
> 
> Instead of giving up any int3 detection, this checks whether the
> rest of bytes to the end of the function are int3 or not. If all
> of those are int3, those come from the linker. In that case,
> optprobe continues jump optimization.
> 
> Fixes: 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker fill bytes")
> Cc: stable@vger.kernel.org
> Reported-by: Adam Zabrocki <pi3@pi3.com.pl>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

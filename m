Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B692899CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbgJIUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJIUfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 16:35:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 13:35:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m15so5005270pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAgIyoM28V03H4jcAStTAZSvK32l/n16PfEafwB23ng=;
        b=Y08A4wc6Chy3fHgEl70jRCplNZeHVk/GeR3Kb92wDjLdSl3ubSsynjnz194w4dKP1w
         RZBm6MFfrWrWU5ncATGQi2tEI3QLeOwrWtsw3QzbLQAaC3LWKhpeJjwrMwGLtz1oq/pW
         DlyeiAcZEcyLLUDcs5ofEielZzAASjoxzbUIivNq6TlURRRykvgIk47aIbRGCByr8O3G
         h5cXvLlcBb7BxnRdtv/PrE0erHmJcJHVkbKxtZf+bBjrL6BrRVGiewQQImIceZYTyfyj
         mXRBJCGusUZuEjOshZiQQXeZQNKd229whBxHZY6+DTaGsLrL4SxDwqHfjYQSHIGzNRZD
         7weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAgIyoM28V03H4jcAStTAZSvK32l/n16PfEafwB23ng=;
        b=AZSrZCfV4t8TnpYqSwTTSX89NeRhGO36JqbIy5EFZy3Rj80TeSd7JLYxvI41QxXkbZ
         ofoSHREvIMz3qFD57Nrd7Ul1RQkUfIAFZ4lr945C/yuCua48vxSoXG6rv73EZFYnkn2B
         1A1p0zYXHVLj+lZ8Na9ShhXvI44/wvytRZit39nKg6I1NUIrdp6iZerQxvMNGWEdUY2f
         GmQMB2EATEa0y98QyF88yojfSwtVCAliVoHjefcTMd+LlHq8SbqV64GuYDD57N/VLv5I
         uDSy6eHbhN2i73TTsDuNOQeLEpTH4DnqeGkMVfT7LoRDfDuiTNFpdB6A3s8q7c6UzpE/
         BDZA==
X-Gm-Message-State: AOAM533ycmqAOtUY6GbCDPRmZyx9v4G/rDS+7XcxigL9dzaxgHoaErkk
        YTkKf3ZK8KaYDHfSGh9D3bOLCeDm1ClsA2u0TGKqVQ==
X-Google-Smtp-Source: ABdhPJwLGBT33EDwxC7fBIm1aBvmy2yzWc6PbpoehWDLD+GJqvFCaHHYyvHLrhXIQ0m6gHJNMWNugNkyNdwEExIOkEI=
X-Received: by 2002:a17:902:8b86:b029:d4:c98b:c314 with SMTP id
 ay6-20020a1709028b86b02900d4c98bc314mr1736057plb.48.1602275751546; Fri, 09
 Oct 2020 13:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602255803.git.zanussi@kernel.org>
In-Reply-To: <cover.1602255803.git.zanussi@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 9 Oct 2020 13:35:14 -0700
Message-ID: <CAJHvVchmmJ4LF-wY=BJgJSaEo7w6AhgKzsF9Q5HCDN276uv=HA@mail.gmail.com>
Subject: Re: [PATCH 0/5] tracing: Synthetic event dynamic string fixes
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 8:17 AM Tom Zanussi <zanussi@kernel.org> wrote:
>
> These patches provide fixes for the problems observed by Masami in the
> new synthetic event dynamic string patchset.
>
> The first patch (tracing: Don't show dynamic string internals in
> synthetic event description) removes the __data_loc from the event
> description but leaves it in the format.
>
> The patch (tracing: Add synthetic event error logging) addresses the
> lack of error messages when parse errors occur.
>
> The remaining three patches address the other problems Masami noted
> which result from allowing illegal characters in synthetic event and
> field names when defining an event.  The is_good_name() function is
> used to check that's not possible for the probe events, but should
> also be used for the synthetic events as well.
>
> (tracing: Move is_good_name() from trace_probe.h to trace.h) makes
> that function available to other trace subsystems by putting it in
> trace.h.  (tracing: Check that the synthetic event and field names are
> legal) applies it to the synthetic events, and (selftests/ftrace:
> Change synthetic event name for inter-event-combined test) changes a
> testcase that now fails because it uses an illegal name.
>
> The following changes since commit 848183553e431e6e9c2ea2f72421a7a1bbc6532e:
>
>   tracing: Fix synthetic print fmt check for use of __get_str() (2020-10-08 15:29:07 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/dynstring-fixes-v1

I applied this series, and then my mmap_lock tracepoints series, onto
v5.9-rc8. I played with the edge cases Masami raised in the other
thread, and I also tried constructing a synthetic event as we
discussed on the thread about my series.

As far as I can see, this addresses the edge cases Masami pointed out,
and it all seems to work as intended. It works fine with the kind of
synthetic event I'm hoping to define for my particular use case.

So, for what it's worth:

Tested-By: Axel Rasmussen <axelrasmussen@google.com>

>
> Tom Zanussi (5):
>   tracing: Don't show dynamic string internals in synthetic event
>     description
>   tracing: Move is_good_name() from trace_probe.h to trace.h
>   tracing: Check that the synthetic event and field names are legal
>   tracing: Add synthetic event error logging
>   selftests/ftrace: Change synthetic event name for inter-event-combined
>     test
>
>  kernel/trace/trace.h                          |  13 ++
>  kernel/trace/trace_events_synth.c             | 133 +++++++++++++++++-
>  kernel/trace/trace_probe.h                    |  13 --
>  .../trigger-inter-event-combined-hist.tc      |   8 +-
>  4 files changed, 147 insertions(+), 20 deletions(-)
>
> --
> 2.17.1
>

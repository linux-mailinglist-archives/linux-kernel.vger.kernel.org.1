Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134A027DB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgI2V5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgI2V5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:57:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B35C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:57:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s31so5030806pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/OJ+hGul9V2Z4KJ9/Icrdv537pi3bbPLRFN0e0T6pk=;
        b=UZdtN8Y/tGfQ/ZGzeOHsdwamEaty92m/di0YmBL75oxm6d3+rB/8/zyz1YDULbBVHR
         dihKbPiWMG9bvNU7FVgSQAGmV3es5ez69hUVkSc3lPx0Bv5Mh2xI3C0iaXfW+HVzkzZr
         w/h1MCrpvNZ9gRi4Z+1cweDfdT2UlNgS3r9JX+sR84HxBqm6rU2vLW+LhHaGfUVoQfPt
         yDY+YiSsLQpT/UsBkUYFraIe3ZbE1k1e62DKXCAc8x6VnAYuaMhAXGz9d9c9BvQsY2Kn
         G4fGkjUIYuggjBJ0zjKaBU8sDJ/MrAIhN1fYjCefHJmammumqMLQE4pxl+xVTiyHGHoU
         S1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/OJ+hGul9V2Z4KJ9/Icrdv537pi3bbPLRFN0e0T6pk=;
        b=naL4F9USvzYiRB/+40RDWmQkHtSZdTcJjnIhIesKinFdvO9rhbaq2ePA9Ci8BZtqvw
         UwpcOjkj7YKXX7I8vz8sTNjjbQQZZvXd2GH4GRrBFuDeGDY1npmh3cEmeb4aMVQrBCKW
         QtlVGj4M1x6wvqg/xPcpfX8tgQsBZXXfpMF2RDKCTOgpiXANvpmqQA+IOqy50Oqn7yek
         unkEv5lkAvDQ1ealayJmr5tpctXpNOncTzNDPnh5GxMQkz/hE2P0E86Fr2uLARdU/DlL
         Bybmos88vFxJ99hxMLnBhcT6QXMCwYACbMAHkXLq3iLi9GPk/z4NXn9eZhpfEI1peJ2p
         /feQ==
X-Gm-Message-State: AOAM533S6M4CiezaXTZHR6YE9gJ5eww6izUPOnNIsP+xkR0GYElXYbhF
        ad7VEJT5CAqwAT90UrA8xlYjsjq8vMK6+DZcqEZ8Bg==
X-Google-Smtp-Source: ABdhPJznySVMu3FRv/BfC5/VB4y6if4/gxeGzjdGlFEx8wjx/oQC39BvAeUGTtvY6XZad6ReVUYR2lUVgORrGi9GGWw=
X-Received: by 2002:a17:902:544:b029:d2:6379:a892 with SMTP id
 62-20020a1709020544b02900d26379a892mr6646545plf.53.1601416635987; Tue, 29 Sep
 2020 14:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601410890.git.zanussi@kernel.org> <834e9060c2e7e3272e25d8bfc6e7566639c18aa9.1601410890.git.zanussi@kernel.org>
In-Reply-To: <834e9060c2e7e3272e25d8bfc6e7566639c18aa9.1601410890.git.zanussi@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 29 Sep 2020 14:56:39 -0700
Message-ID: <CAJHvVcgBxBa_CHhRYGiwKEK=0RVzBFrNc3Z9YP+3M_N1PLXFTQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] tracing: Fix parse_synth_field() error handling
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 1:33 PM Tom Zanussi <zanussi@kernel.org> wrote:
>
> synth_field_size() returns either the size or an error.  However, the
> code assigns the return val to ssize_t which is unsigned, and then
> tests whether it's less than 0, which it isn't so discards the error.

I think the patch is correct, but the commit message is not.
field->size is a size_t (unsigned), not an ssize_t (signed). I think
this should say instead something like:

synth_field_size() returns either a positive size or an error (zero or
a negative value). However, the existing code assumes the only error
value is 0. It doesn't handle negative error codes, as it assigns
directly to field->size (a size_t; unsigned), thereby interpreting the
error code as a valid size instead.

>
> Do the test before assignment to field->size.
>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_synth.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index a9cd7793f7ea..6e7282c7b530 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -465,6 +465,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>         struct synth_field *field;
>         const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
>         int len, ret = 0;
> +       int size;

Why not make this an ssize_t

>
>         if (field_type[0] == ';')
>                 field_type++;
> @@ -520,11 +521,12 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>                         field->type[len - 1] = '\0';
>         }
>
> -       field->size = synth_field_size(field->type);
> -       if (!field->size) {
> +       size = synth_field_size(field->type);
> +       if (size < 0) {
>                 ret = -EINVAL;
>                 goto free;
>         }
> +       field->size = size;
>
>         if (synth_field_is_string(field->type))
>                 field->is_string = true;
> --
> 2.17.1
>

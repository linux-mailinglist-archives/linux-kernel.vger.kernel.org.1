Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF07627F55C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbgI3Wp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgI3Wp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:45:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:45:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so2451764pfk.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/ZPak3BTvrioXHI78G4zTRcYvP1bkJgddq8BHFaNxk=;
        b=l6QC85pR2EH86LDskFtqdRuL9G+9uR/4gW6mXooytcKTmwOZKeokP7fKHPl7732fQD
         pWkCfL6lgRSN5VyZQ1ctARqyoc4VGuPKZUylxNIMHbegIenKz/BpwfddpAJRLYUTWrWD
         oNp5H4GisF2U9luGnnhmgP9xxIKfLa4vTXsUtOXSMPsAQ6dQxzUd/D3QO9p4uadfcPeM
         mUGc9KTJfzdAFIQtEn9ij6EIFfge4pnTt4l+wby2QbJywMVmve1zKnupVzXKZ1c+R3Su
         yLeSxlxA+39XwVhEMnnj8Ysoqs7fKwwaOopT3FT9AbyxZHJXuOWwVH+XJSzmO44BIjdv
         GeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/ZPak3BTvrioXHI78G4zTRcYvP1bkJgddq8BHFaNxk=;
        b=TNIHz2qGD3Rbc3OzZ5zEHPnG3nHnH1i/hciFWY2jCMzN3B9K8kTUbRlQZGHWseKz6s
         Si3Ih3xUOevXbMukKZrPcYz1/E+gqDDF3CcMTgBy+q407N61PaE17paPbBO25LRGFvLQ
         Q9EpDwNd53KvKjdP75207S16BG0Om73jYhZ7JOF/ruY5uUthnDay9R6Mi/rVI1m5CMhG
         hTQGHQSNMIYqQXkMu3Gd8zQLxyxHfq6n9jxWl6boBOzB5OLUoRUGox1ZyWB+akBynQEJ
         tFc1weCo6SyFC0Qzn/6/w4RmKgSHTUeX8t6dtW8lCLMms0oWVDTb8sqG4ZX6kyvcZGkv
         b3Ag==
X-Gm-Message-State: AOAM532tAj+og5MAtusc05NPoY/8mrFiR8mMEMeBNUnPGmdInU0r/Vde
        0FL0LNT6z9fZ/wzxTr2VJ5nRXJHsxiZU8BYiXgEr0I/TxetnBw==
X-Google-Smtp-Source: ABdhPJxTONG5Tg92cKT6Qz9I93oFz54zuDir17NCfILR06C97S/vNPWdf2SAlgICTUjDdldJNNz7E+1VPM3bXYso8Dc=
X-Received: by 2002:a17:902:c211:b029:d2:565d:bc9d with SMTP id
 17-20020a170902c211b02900d2565dbc9dmr4154560pll.48.1601505958298; Wed, 30 Sep
 2020 15:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601490263.git.zanussi@kernel.org> <8616d1a2485fee1ae71d27d7c598acf1c9e32abe.1601490263.git.zanussi@kernel.org>
In-Reply-To: <8616d1a2485fee1ae71d27d7c598acf1c9e32abe.1601490263.git.zanussi@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 30 Sep 2020 15:45:22 -0700
Message-ID: <CAJHvVchLJ4_Oha6bXa2k26JAy6hMVmOZpxfZRGvRPEUZahd5dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tracing: Change STR_VAR_MAX_LEN
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I still get the same WARN_ON behavior when trying to use bpftrace.
But, I spent some time today reading through that call path, and at
this point I'm convinced that it's the version of bpftrace I'm using
which is slightly broken, not the kernel in this case. (To be fair,
I'm trying to use some unreleased tip-of-tree version of it, with some
not-yet-merged patches, and some extra hacks on top of all that, so
it's not particularly surprising...)

In my experiments with just the synthetic event + histogram triggers,
this patchset works as expected for my use case.

So (for the whole series, not just this one patch):

Tested-by: Axel Rasmussen <axelrasmussen@google.com>

On Wed, Sep 30, 2020 at 11:41 AM Tom Zanussi <zanussi@kernel.org> wrote:
>
> 32 is too small for this value, and anyway it makes more sense to use
> MAX_FILTER_STR_VAL, as this is also the value used for variable-length
> __strings.
>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_synth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
> index ac35c45207c4..5166705d1556 100644
> --- a/kernel/trace/trace_synth.h
> +++ b/kernel/trace/trace_synth.h
> @@ -7,7 +7,7 @@
>  #define SYNTH_SYSTEM           "synthetic"
>  #define SYNTH_FIELDS_MAX       32
>
> -#define STR_VAR_LEN_MAX                32 /* must be multiple of sizeof(u64) */
> +#define STR_VAR_LEN_MAX                MAX_FILTER_STR_VAL /* must be multiple of sizeof(u64) */
>
>  struct synth_field {
>         char *type;
> --
> 2.17.1
>

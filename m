Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8210E1CF5DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgELNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:32:29 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01CDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:32:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di6so6252022qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=69F/dO93fLWYVW8s/bQK6cRsZlBg6dqg0tqZZwynyLA=;
        b=muylQ8X139wB63+0Qh/pwLoK53v4mik8qjCVpPJpyJf53eQEMMR6PurmKE9dyxIR7I
         /+bPOaWFQfeS3ZeV5wI3Pl4rZhRUpbAMxkDDvDLN5Zym8ipIF4s0IBCQ+e6xm9WQO5bJ
         Pg1JJK9BSDavqN4sCQXC48cOLXXi+DEiOZBlwZpqN2KAoSYfn9VmE1wgF2qORfkrZyCQ
         7yLK4VkvUTzZiUdV5CLTJpmjAQwml+TXBJQiffzJM6vhKFKuH90KSBr3P2uORBpRPHtf
         wVu3U1mATW4jaNac8rITBT3+FwMEtzc71HyMbhu+k9Ha8AaaED47FuGwJdLBmTnJSprD
         G0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69F/dO93fLWYVW8s/bQK6cRsZlBg6dqg0tqZZwynyLA=;
        b=oJhuKy+M+t9pRLeuqQBgYC8mTxBD27LMrTulHTVApK9gQKvlUXwKjp+3LLaGO6PqL/
         yZ0MWZZoV70AnMxPPhy43GVa2SmunsYRYKMt/sZzaVjiCLL6XtU8Nh2ujTexaNwB2puM
         4yx6qIt0IRAvNU1CJiafaOUBzivXm/ck/RVg9Kc+uVu546yJqdV05JU30/yU0HBlYQb8
         kpUaEs5HnPpVUx/9d/aNFKIQq88KMzblkkW24GhkUtWb+14P1geQ3g6RxLgk2edpGava
         q60QzpWJXeDwMvv8yf8sT5R2qnuNtsZcR0Ilrc/twzmazfYFenKT7LJ477Ywx2amLpi7
         7few==
X-Gm-Message-State: AGi0PubBHk3x44gh61vWLv9LbBrEZp/sQkTDgmwtnrWvJHn8idfkJdN5
        iTxR/X0OcCWrLab9t9zswqK9qhgtH20=
X-Google-Smtp-Source: APiQypI/YHlqjPtAKhGhaErqCvwMKBqpTkZORBd9/ThbR1XGiYR9CooTLIxYpWFi+wmHXeA0I9b/9Q==
X-Received: by 2002:a05:6214:146b:: with SMTP id c11mr20236348qvy.191.1589290347065;
        Tue, 12 May 2020 06:32:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a21sm9266794qtw.24.2020.05.12.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:32:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A64E840AFD; Tue, 12 May 2020 10:32:23 -0300 (-03)
Date:   Tue, 12 May 2020 10:32:23 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH perf/urgent] perf tools: Fix is_bpf_image function logic
Message-ID: <20200512133223.GI28888@kernel.org>
References: <20200512122310.3154754-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512122310.3154754-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 02:23:10PM +0200, Jiri Olsa escreveu:
> Adrian reported that is_bpf_image is not working the way it was
> intended - passing on trampolines and dispatcher names. Instead
> it returned true for all the bpf names.
> 
> The reason even this logic worked properly is that all bpf objects,
> even trampolines and dispatcher, were assigned DSO_BINARY_TYPE__BPF_IMAGE
> binary_type.
> 
> The later for bpf_prog objects, the binary_type was fixed in bpf load event
> processing, which is executed after the ksymbol code.
> 
> Fixing the is_bpf_image logic, so it properly recognizes trampoline
> and dispatcher objects.

This is not applying on top of torvalds/master, not tip/perf/urgent, and
you forgot to add the Fixes: line, lemme try to find this...

- Arnaldo
 
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Jiri Olsa <jolsa@redhat.com>
> ---
>  tools/perf/util/machine.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 8ed2135893bb..d5384807372b 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -738,8 +738,8 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
>  
>  static int is_bpf_image(const char *name)
>  {
> -	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) ||
> -	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1);
> +	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
> +	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
>  }
>  
>  static int machine__process_ksymbol_register(struct machine *machine,
> -- 
> 2.25.4
> 

-- 

- Arnaldo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3F293458
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 07:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391712AbgJTFn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 01:43:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35730 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbgJTFn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 01:43:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so544451wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 22:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5Xsn5fVg6yvPijDHWOwZOrIy+RcAOXElW04b9r54Fw=;
        b=skzboaG6P1pqZSeCwtGf0QkBBam9B6v8HaEJuaGTgraWw1b1ZjMQt3ekC1wc4z81b8
         nm2rl1g9HHfx3nopGlqvwEGDDEoCosDz8H3kQyOf5DM07X02efIx90VNkMjqNV/oLYKo
         K78fm4iPAKgErq00rhLLyU5NkY69sV5c+ruGY8q277oMmxAbvTIV6RUEW5Ct5UUH/IiF
         USD/p6rLCDKi1nxjn7rQ8tsNIYh4pMqq8uzXBuwHOgwoFuaOpYR1zThYgLumHvOE/1ks
         lYbE5RtdnjJzLHSmJ4YbmJ6Nux0cHQc1GSld48Q5HLcqgV0KAYmoueiQPeZ/Eh+U/esp
         pKHQ==
X-Gm-Message-State: AOAM533EVRDJk51MadLx/AMPpFSTPf7blnr1cymx8vEjl4WF3CdpNvF5
        gdR2xv5sDoKqgI2PSwio+dEa+S04skmkTBTETy0=
X-Google-Smtp-Source: ABdhPJyuCMsV35IC5ATvfNzP4dHOY+T1G7HN9oHfC5998q3bSWWuWrMS4Ge1eLQ712AJIoiNe8h3Jm/KtT3kX/rxKzI=
X-Received: by 2002:adf:a345:: with SMTP id d5mr1438322wrb.55.1603172607668;
 Mon, 19 Oct 2020 22:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <1603121908-53543-1-git-send-email-john.garry@huawei.com> <1603121908-53543-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1603121908-53543-2-git-send-email-john.garry@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Oct 2020 14:43:16 +0900
Message-ID: <CAM9d7cg0j3j-EXY2MULYWpyMri5_GxBnHVNvrHN4UG0pwsa=mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf jevents: Tidy error handling
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Yao Jin <yao.jin@linux.intel.com>, yeyunfeng@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 20, 2020 at 12:42 AM John Garry <john.garry@huawei.com> wrote:
>
> There is much duplication in the error handling for directory traversing
> for processing JSONs.
>
> Factor out the common code to tidy a bit.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
[SNIP]
> -empty_map:
> +err_processing_std_arch_event_dir:
> +       err_string_ext = " for std arch event";
> +err_processing_dir:
> +       if (verbose || rc > 0) {
> +               pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,
> +                       err_string_ext);

This was printed only if verbose is set but now changed.

Thanks
Namhyung


> +               empty_map = 1;
> +       } else {
> +               ret = 1;
> +       }
> +err_close_eventsfp:
>         fclose(eventsfp);
> -       create_empty_mapping(output_file);
> +       if (empty_map)
> +               create_empty_mapping(output_file);
> +err_out:
>         free_arch_std_events();
> -out_free_mapfile:
>         free(mapfile);
>         return ret;
>  }
> --
> 2.26.2
>

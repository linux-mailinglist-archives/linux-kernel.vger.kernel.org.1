Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357651E95D6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgEaF4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 01:56:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35397 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaF4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 01:56:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id x14so8207993wrp.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 22:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5HdXPIUVuqtEa85SUndrPJ85k1iTc2y+k+Dc82zgCE=;
        b=T6x5VxDAsXeSFSObHsRYjgYYzaCPi84Jh68QLt6NcergrS7hHW6UsKo0slD71+RxDk
         M14yugHD3yGIYRTnqNmgezTOVPcGPqEnEQSoYSKrUn3VV3olsQ4dtuXA+AD8Ua0pMYdw
         iBAZuSTd20ZdukFV8eXQ1sJs8eEjRNuFnRD3ol4FMVaok8vEo+zW+zp4fa9lKxjV0PPO
         FvCu5fc/SUA6z22PmTm9vc42UfnfHXhVH7E7Yh+VfAhIU/pYW1/eKQrYBF+8LLic7+Dv
         UEtHagahk0DHSWyqa+VZF/cMfgVzyZKMxd+6cDh8vVo9Xa8dw4k3D+8FXQUluC2TCavw
         jxeA==
X-Gm-Message-State: AOAM530lA5rwF6vQJZoqeZ1gdWigk4BnwydBvoU14AxbJ0/hpFIw9nyJ
        bBy9RI7eP5xBlFJS+tZmcuEopyZSjDD5RatfE7Y=
X-Google-Smtp-Source: ABdhPJwXsaSzLnuqv5HCQfZsszHNOf93ODIJDzjfxkcLBFJOITp8xFhBsM1cEaf1GSSZ/O+vPUwLPModRi3onKL7gBM=
X-Received: by 2002:adf:db46:: with SMTP id f6mr16261278wrj.80.1590904612302;
 Sat, 30 May 2020 22:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200510150628.16610-1-changbin.du@gmail.com> <20200510150628.16610-7-changbin.du@gmail.com>
 <20200520210106.GT32678@kernel.org>
In-Reply-To: <20200520210106.GT32678@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 31 May 2020 14:56:41 +0900
Message-ID: <CAM9d7cjcaNGwYE+kWFfonDn7M4KgZBmFdG0bMaJ_pDmiwVVs_g@mail.gmail.com>
Subject: Re: [PATCH 06/19] perf ftrace: add support for trace option sleep-time
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 6:01 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, May 10, 2020 at 11:06:15PM +0800, Changbin Du escreveu:
> > This adds an option '--nosleep-time' which allow us only to measure
> > on-CPU time. This option is function_graph tracer only.
>
> This seems, for now, very specific to the function_graph tracer, so
> perhaps we should have a:
>
>         --function_graph_opts nosleep-time,other,another,etc
>
> ?

Agreed.  Also I don't want to add an option in a negative form
as it's confusing.  Actually, our option parser can recognize
--no-xxx form automatically so adding a positive option (--xxx)
can handle that too.

Thanks
Namhyung

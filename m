Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E926847E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgINGKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgINGKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:10:09 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411CD221E7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600063806;
        bh=gRfQi8Y/zVpyvyp+ighIXW73BdG51yD5X7tJ3596N1A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YVUJRDj0Ic1/CpKcLrV0F3HgmCgmH+afICkTmLfhWwrcRiHDr2CnKLJu5PqesWAS+
         9Zzj9TvouRnL/lw9j98/mekrrxex4dTJA1xLKj7vCdPUDH/gIncTCnKQ1ohJqcLuV9
         /LOEwjEqKAtiUAApf2bpwJfMexk6zXP7RSr7/Qlg=
Received: by mail-lf1-f41.google.com with SMTP id q8so12102683lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:10:06 -0700 (PDT)
X-Gm-Message-State: AOAM532NBdx8gKIC8gdzWunG7pnraMzpP7aFTfbY1msTDdySJOgxMLGz
        Ylc0OrPFCqOtrd0uYTLtsGilqOzoUVlMWv0qkAA=
X-Google-Smtp-Source: ABdhPJzfD85LEbn1RMbKHVgRbfr5GGWW4QkAKY8dPx11eG7y/46JHyMRK2g+W5HH90o7lPdnpSi7Vea1ckAXY6/XeGY=
X-Received: by 2002:a19:7902:: with SMTP id u2mr4091112lfc.515.1600063804480;
 Sun, 13 Sep 2020 23:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-2-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-2-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Sep 2020 23:09:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7jkH7kmG9HZ_fs2dGq=G=AE17ofexkKkVLD-qCYC0=dg@mail.gmail.com>
Message-ID: <CAPhsuW7jkH7kmG9HZ_fs2dGq=G=AE17ofexkKkVLD-qCYC0=dg@mail.gmail.com>
Subject: Re: [PATCH 01/26] bpf: Move stack_map_get_build_id into lib
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 2:05 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Moving stack_map_get_build_id into lib with
> prototype in linux/buildid.h header:
>
>   int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
>
> This function returns build id for given struct vm_area_struct.
> There is no functional change to stack_map_get_build_id function.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

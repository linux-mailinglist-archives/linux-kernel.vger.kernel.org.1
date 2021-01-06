Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D002EB7AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAFBeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:34:37 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42071 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbhAFBeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:34:36 -0500
Received: by mail-lf1-f42.google.com with SMTP id b26so2990000lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 17:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VULe2PD9S0Rq4By2KrktstGWOoVFndWrtS1t9BEbL14=;
        b=bGZ+4DgUggkaFsIC59ZbwJICDxEkQr5vu7PaL4heI6xXEDGOAFl/V+PF48l8JbVWce
         QMs2Yf/dxKfzgmdZSenC61VCOlHzEftR6xLqQlntJHm26sSQ5pQx0GLaj+GGDze9Evqu
         FlLuVoq/Y5qDp7DWsWnbIDMwqXUUKB/g9T3mTdmBqu12JCrTjmmAZlV7ouCG20jLvJKI
         arKfcPbhTyxFpSYg+ts8a4UoDI0vVwtdjN8qv5uBdOXgJJruM9HnNNuVJ2pKHPiJaAxW
         Ix662uCfo5S858qna3jGjcvAy2A5GCvMLlW9sppE5Kvuq4jvjhSUE/7QJrfc13FT0+1I
         XfTA==
X-Gm-Message-State: AOAM532m+huCHODT7ZQd/Gbi4Y60ozwrbJBqafKGhP3uxBoE2DCLfz2e
        13eneeKz6+yzVgYWR9Q5WJjs4+osGCjUeC74ptI=
X-Google-Smtp-Source: ABdhPJw75CwqbflCHKrOckC8Pr/FizdzdIpvc4Q2vRyPYsQzy8ab9amSv6LlR9XRxsSIJe5OONAkbEpE29ySScqRWms=
X-Received: by 2002:a2e:b8cd:: with SMTP id s13mr940879ljp.26.1609896834859;
 Tue, 05 Jan 2021 17:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20201216090556.813996-1-namhyung@kernel.org> <20201216090556.813996-3-namhyung@kernel.org>
 <20201229115158.GH521329@kernel.org>
In-Reply-To: <20201229115158.GH521329@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 10:33:43 +0900
Message-ID: <CAM9d7cidFuM5gmjq8=uy+mJjHHEVE=q6qESkc_OeTeGEQkGbnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/lib/fs: Cache cgroupfs mount point
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Dec 29, 2020 at 8:51 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Dec 16, 2020 at 06:05:56PM +0900, Namhyung Kim escreveu:
> > Currently it parses the /proc file everytime it opens a file in the
> > cgroupfs.  Save the last result to avoid it (assuming it won't be
> > changed between the accesses).
>
> Which is the most likely case, but can't we use something like inotify
> to detect that and bail out or warn the user?

Hmm.. looks doable.  Will check.

Thanks,
Namhyung

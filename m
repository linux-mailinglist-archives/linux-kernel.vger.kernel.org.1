Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59429A3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 05:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505422AbgJ0Ep4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 00:45:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44622 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501914AbgJ0Epz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 00:45:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id t9so326519wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 21:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmAyLEcR2tdPTiT4aGYBK9tERH8lFFNxrJCHCsIMZek=;
        b=Oa4mAtCh715j6TkUy+/uY+u2lK3mewQqLVECqIWZiBXDVmSf757P+GmD9J1qKjPbPF
         hAZNWj3DalSNuczA2DxQ1L6RwHUyF11hFSU/Mm7nGUuuHn9A2HmXPbxg9c5jRjQaJPmK
         9hfMSYT9MHu8vLNVpyRU9rHCZYMHRDZ/ujvzN/kSx9l6HhN4tNltim5V4rK0rXwjtSl9
         VwU7qFvQc8u23nO1Qt1WLuoRMvBdX06wcn5c3gz4OCVXniG2Msj7Po+udSmHPWdfxs2t
         zf+rjYxt1TLTaOVMS8cU6qCKQFDO8cqoc1FkIkSgnQ/OmEyd0XGdCDW52czLctadHCKG
         QhkA==
X-Gm-Message-State: AOAM531QufFh8XViyLP+/MS+rpCGtEfMuC6AObuBjpU9BIFF7ypqt2Ai
        iSgi6JGsw/Z805ozWl+O1FzCsJFAUAZDFZdbid4=
X-Google-Smtp-Source: ABdhPJxAQf8Nl74/sZxMQmMOdkTaAtYeEmjkfSzoMVvkslghe1kVaC81YPCig8k5QTtK47JIcC4pcIwa759VafbAPxY=
X-Received: by 2002:adf:a553:: with SMTP id j19mr417267wrb.349.1603773953952;
 Mon, 26 Oct 2020 21:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201026141937.582087-1-namhyung@kernel.org> <20201026152108.GW466880@tassilo.jf.intel.com>
 <87y2jtq970.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87y2jtq970.fsf@ashishki-desk.ger.corp.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Oct 2020 13:45:43 +0900
Message-ID: <CAM9d7cizsTGrQKDaJnFFXUXmTHCQSzj=+mK2P_ek0Hw1JrF2TQ@mail.gmail.com>
Subject: Re: [RFC] perf evlist: Warn if event group has mixed sw/hw events
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 27, 2020 at 12:49 AM Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> Andi Kleen <ak@linux.intel.com> writes:
>
> > On Mon, Oct 26, 2020 at 11:19:37PM +0900, Namhyung Kim wrote:
> >> This patch just added a warning before running it.  I'd really want to
> >> fix the kernel if possible but don't have a good idea.  Thoughts?
> >
> > The easiest fix would be some multi threading in perf stat opening, then then
> > extra latencies could be mostly hidden. One thread per group would probably
> > be overkill, but just a few threads would lower the penalty significantly.
> >
> > I think that would be better than this patch and it's likely not that much
> > more complicated, as this is already a lot of code.
> >
> >> +{
> >> +    const char *known_sw_pmu[] = {
> >> +            "software", "tracepoint", "breakpoint", "kprobe", "uprobe", "msr"
> >
> > That's a non scalable approach. New pmus get added regularly. It would be better to
> > indicate this in a generic way from the kernel.
>
> That, and also, intel_pt is a software PMU and a few of its features
> depend on intel_pt/.../ being a group leader.

Thanks for the info, that's good to know.

So do you mean intel_pt requires other HW events in the same group?

Thanks
Namhyung

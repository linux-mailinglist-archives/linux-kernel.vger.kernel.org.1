Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A302FA2C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392856AbhAROTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:19:03 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41135 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390459AbhARLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:45:13 -0500
Received: by mail-lj1-f180.google.com with SMTP id f11so17882716ljm.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oo2wTOBVbYOJ6gk7kSBKlMDMgikCLwk64Nd1TJ5u0AM=;
        b=Oca7raApiiBuFtrLL6m1eOBjouLgHqsD7kpeUy+bneLxX319wsj2tjTxXvC1P1R6LF
         L9j5ELZc4tFziDv8YzBpCCIAsXOVhC/qZqD6RsZofjg4MCYaBxUvYIDQrBinqVbsQhZK
         1iNV0hARXDJePYFlxNz2yNoE+hKpS157qQDO9KGpa2idiIINyRNsEIJ9gYWB7FgLSP0Q
         SXdPJm8b8bAAZJFskCZaSE5jUEnSscLwc6cEqSXEEaT+wBHttE0jBSNim1uiO0KcwSdH
         5SGDxUhyJ4NE34vcBsNWJIU8QrN1N3L9PSvv32zelLsIqXDnW7dXbWFb0ESdYNWgpu/T
         M8EA==
X-Gm-Message-State: AOAM533bO0+b1kyp9RgtQ/v7tCs/lWwz2tfpxN10bLqaqN5/HmYGUWDK
        DBshYkjI3AOFbefiLrUVpkj5PnDG/iKsAE+FvXQ=
X-Google-Smtp-Source: ABdhPJxo36mC0IdbUyKtQNnPXxWeMcjY0ogllArVF8wbWjFRbHr2XbCzys8GKMzL/z4q9ZCfyXctXi8Zsuc9TFPpRZI=
X-Received: by 2002:a2e:870e:: with SMTP id m14mr10328879lji.166.1610970271528;
 Mon, 18 Jan 2021 03:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20210118034323.427029-1-namhyung@kernel.org> <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
In-Reply-To: <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 18 Jan 2021 20:44:20 +0900
Message-ID: <CAM9d7cgr+Vxq_SnEkSO5zU0QN-X6-LLJDKUfE4C72Nomnrr=+Q@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Emit PERF_RECORD_LOST for pinned events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Jan 18, 2021 at 7:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 18, 2021 at 12:43:23PM +0900, Namhyung Kim wrote:
> > As of now we silently ignore pinned events when it's failed to be
> > scheduled and make it error state not try to schedule it again.
> > That means we won't get any samples for the event.
> >
> > But there's no way for users to notice and respond to it.  Let's
> > emit a lost event with a new misc bit to indicate this situation.
>
> Users should get a read(2) error IIRC, does that not work?

Ah, right.  maybe I'm too specific to perf record's perspective.

In perf record, it doesn't use read(2) so I thought it should
have the information in the stream of sample data.

Thanks,
Namhyung

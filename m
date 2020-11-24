Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769562C2FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390930AbgKXSX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390922AbgKXSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:23:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7C5C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:23:26 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so3244541wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E7iKeDCDBZ7LJEqPWQhYyIDhVTyrdGn4l+s4bIfrllk=;
        b=1Aow5cj08YgHjdvrfxI6i9PeQ1XPtwW42xCIQbwZyq4KCUWzL0XpWa+Yb5xBaLmxUz
         1ZO7scWuu8l6aobb6ihOQQ0YbLt4/WnpCXIrqsygMgCcmNy5tLiMbyy6/SAUvOuk34OW
         QNVQR0TquV0JjNQV+wVOvoVhTt4lnwgPK4ky54RVfowYjmzFdZ5X8ZnEWCsDlVsJKIb6
         Jw10UTliZjx1t23JwpeFUZWyFOoSI9eXx+lnPJrgMqEdA0FPdQiNWUPlek1VbWeipSpC
         /uG++JyjkdpXhoVqFJy1mxjhKhmPR86kepUxGuhB3QDd3NISvtpALkqhEd7wKRLWVd0Z
         xZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E7iKeDCDBZ7LJEqPWQhYyIDhVTyrdGn4l+s4bIfrllk=;
        b=ui23lEkeSOuKpX19EUcuKgucPtOx5mDB7q460Nzn0/iRKcM5ZEQWz4LNqJjzmVWoS2
         sMSKYRBmEBGfcPTPcRRyFkws017TzFdOS/DejTX2lKRe/TZvuvbEl6w3PFMOLcm4hXnB
         GwvR1T3VeEnPp8mlOeU68qsKyvvLMAenLzLFt+ubHj69Ot8gJJXCLZ3ln7Zbj9kZc7n/
         uLbmgcZtXRtEkNIISr6vfbQqX/I48w5zMGsi3ZIAEej0jrMmPfE3njaGJgGaPIKdiSGM
         OaRUaEtNP0TSwoAjTGCQlT+8E3YWxD0jdAdEVxy2Kl1VZIopper7gAEuuoXDHNBSKRqa
         4uQA==
X-Gm-Message-State: AOAM531L8hzSgj6YmvLgFvS30woPRMKEtdEFUdO9oyv1zgJoBTxyjZ1P
        gBUdLJgi6KxeR9+1YIIsYf8wUQ==
X-Google-Smtp-Source: ABdhPJz0M1LvQLJvYBVfg1utzJAUjFMfE6zwxq7zZfU686Pzr73wfq7FMMaivbewtTsb0gHgjPOcPA==
X-Received: by 2002:a1c:7e11:: with SMTP id z17mr6002386wmc.83.1606242204824;
        Tue, 24 Nov 2020 10:23:24 -0800 (PST)
Received: from ntb.petris.klfree.czf (snat2.klfree.cz. [81.201.48.25])
        by smtp.gmail.com with ESMTPSA id g186sm7414649wmf.2.2020.11.24.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:23:24 -0800 (PST)
Date:   Tue, 24 Nov 2020 19:15:19 +0100
From:   Petr Malat <oss@malat.biz>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/3] Revert "perf session: Fix decompression of
 PERF_RECORD_COMPRESSED records"
Message-ID: <20201124181519.GA29264@ntb.petris.klfree.czf>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz>
 <20201124143645.GD2088148@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124143645.GD2088148@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Tue, Nov 24, 2020 at 03:36:45PM +0100, Jiri Olsa wrote:
> On Tue, Nov 24, 2020 at 11:29:15AM +0100, Petr Malat wrote:
> > Both mmapped and compressed events can be split by the buffer boundary,
> > it doesn't make sense to handle them differently.
> I'm going to need more than this, if there's a problem
> with current code please share more details, what's
> broken and how it shows
It's easy to trigger the problem - make a perf recording larger than
MMAP_SIZE (32MB on 32-bit platform) and run perf report on it. There
is a small chance recorded events will be aligned on the 32 MB
boundary and in that case just repeat the test.

The problem was introduced by "perf session: Avoid infinite loop when
seeing invalid header.size", which instead of aborting the execution
when there is a truncated event at the end of the file just terminated
execution whenever there is a split event. Later then the problem has
been noticed for compressed events and fixed by "perf session: Fix
decompression of PERF_RECORD_COMPRESSED records" by effectively
reverting "perf session: Avoid infinite loop when seeing invalid
header.size" for compressed events, which left uncompressed events
broken.

I think the best is to revert these 2 changes and fix the original
problem by aborting when there is no actual shift during remapping - as
long as we shift, it's clear we must approach the end of the file so
such an algorithm can't loop forever.
BR,
  Petr

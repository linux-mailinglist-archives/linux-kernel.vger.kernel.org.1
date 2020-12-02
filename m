Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00C22CBFED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLBOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgLBOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:41:43 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C79C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:40:57 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w16so1186463pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0znZ5T0Rl3TgEd+3wUsBs+bUsjWjxcV7k04cq2A4Qxk=;
        b=mVlueOU6nhchCKpxrEtB5d+wPBE9RWmZi52NcWaIzX8DPM7ngBkEHMeQ42MhQDuPs5
         EU6Lka4WnRAqZfzzr//CdXutFdc9fu79mdYYRbEkQ6LBFEFByOChmSpQRcoLxr8kuWWa
         QPtEsT0FNjU0v7waU9XBIqL+q7P7a5q2pwDMLMl0hr38NMZqN/XOXqUqQz0mTBwONDiw
         bS/aBzUUzrhHMdpVnDYRXlYSRpP2niVS8sOC0RaZq8OlVwLJwJydwQw3Guvf4Do4IGWS
         UcSrqdDw9wuPb8ahJJuErynEPMwIfpa2LlcYIyXO6IMbSX3orWbhp6s4CbZCOyJlwOIe
         MuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0znZ5T0Rl3TgEd+3wUsBs+bUsjWjxcV7k04cq2A4Qxk=;
        b=fmOCJnsNhGzijuevLgETk38hkAH06yWWftC80e8yWWD8LsiwxfoprxyuwaOrYy/UAH
         lEO3vwU9/vq8MEGuSZplLtGxoYfyKk/QucmjOdyjAc2BCng/MLb2Bi5PQHBkCD2FF6Jk
         ZwD4sWWsxbPcQXfkr74X1DIeWG8fYPBEw202pGPXzn3IdiqgkLptB1QOZ5itJhILU1yT
         miDl27a21fiGbG3zESpqzsJADgGBDLFQtJG4M960TjNUTllAXVIrrL7RjIwgNksUrsWm
         qcrRUTCB2JJ0pbV5Xi8nXl9iGzBLQ3H/jfNsr/yIorxz6tB0MbDz8dL2GViFBejy8BtK
         fc7A==
X-Gm-Message-State: AOAM530cBIYmF+B1SvgiqOcnuEi3dOnbWggCoxltbu2okENhcgrOivD3
        jqU/iTvru4+FqpEefF7fEG8=
X-Google-Smtp-Source: ABdhPJxlp1Vjb2cWRjWZaEiU62L5IBp8+7lQFOMvz/++haCeTXtxNbJW3cZ1JyARHOXEHb1ZI67hGg==
X-Received: by 2002:a63:f203:: with SMTP id v3mr172649pgh.39.1606920056727;
        Wed, 02 Dec 2020 06:40:56 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id g33sm76288pgm.74.2020.12.02.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:40:55 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 2 Dec 2020 23:40:49 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        irogers@google.com, gmx@google.com, acme@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
Message-ID: <X8encVJSgbXVLGvT@google.com>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com>
 <20201201172903.GT3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201172903.GT3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Kan,

On Tue, Dec 01, 2020 at 06:29:03PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 30, 2020 at 11:38:42AM -0800, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Some calls to sched_task() in a context switch can be avoided. For
> > example, large PEBS only requires flushing the buffer in context switch
> > out. The current code still invokes the sched_task() for large PEBS in
> > context switch in.
> 
> I still hate this one, how's something like this then?
> Which I still don't really like.. but at least its simpler.
> 
> (completely untested, may contain spurious edits, might ICE the
> compiler and set your pets on fire if it doesn't)

I've tested Kan's v2 patches and it worked well.  Will test your
version (with the fix in the other email) too.


> 
> And given this is an optimization, can we actually measure it to improve
> matters?

I just checked perf bench sched pipe result.  Without perf record
running, it usually takes less than 7 seconds.  Note that this (and
below) is a median value of 10 runs.

  # perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

     Total time: 6.875 [sec]

       6.875700 usecs/op
         145439 ops/sec


And I ran it again with perf record like below.  This is a result when
I applied the patch 1 and 2 only.

  # perf record -aB -c 100001 -e cycles:pp perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

     Total time: 8.198 [sec]

       8.198952 usecs/op
         121966 ops/sec
  [ perf record: Woken up 10 times to write data ]
  [ perf record: Captured and wrote 4.972 MB perf.data ]


With patch 3 applied, the total time went down a little bit.

  # perf record -aB -c 100001 -e cycles:pp perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

     Total time: 7.785 [sec]

       7.785119 usecs/op
         128450 ops/sec
  [ perf record: Woken up 12 times to write data ]
  [ perf record: Captured and wrote 4.622 MB perf.data ]


Thanks,
Namhyung

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C342D284583
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 07:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgJFFkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 01:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFFkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 01:40:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D4C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 22:40:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c6so666259plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 22:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FaWnN2n+VAlJs+jx1EpKZlZmEAHXLoWBnPEH4Rre/HY=;
        b=p5DW7i1ATpok7LdNTJ6CODSEYkTk5Re7W5Bz9B3sRPIn8TiLlYO/8wmPYdWgewr4k8
         mngo0GxumZOqYngB5PtPChb5btwonBGzwT8gEZ82Kfgg71PwpMuHQx9YCtfC9TZfd9oP
         Pu4c76pozTcQbiAHpA0D+B0V8S3GxfEJ0nOLi7Q/lda9SqcuuIHXNXnAd2gsY8e5iWeK
         yTQZ8O5mRIcb7XuxJFOZJ/d7/pcpDGHJqrFz4Zzxyi/FcwFxNC/4TjohZy8Umjn1q++a
         0E+zWQodHHANvDzmEAUIIpwTJHr15b9P4Ym19pyi1ZkxAxA+qsKdXk7yPykZzRD5p7wA
         AXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FaWnN2n+VAlJs+jx1EpKZlZmEAHXLoWBnPEH4Rre/HY=;
        b=REJ7c49ppxQ3Lgs7fBplj1THAMw6ejwtBcK+tUz5p9ZlvBH5+80umObAFkMNyhKwCK
         0kKTraoeYvClf9blUrZWOw8S/PoqLIlXrBGjssJXYteoyKgVBpfMUqsbPLkZeocuPbgX
         WzYcTOZwWUcdfE9kWYjiU4FkghA5wLP/ZI7JfRxxRr6yQr9pyOLakba8hqJD+GlgyPco
         SrTootoIVtQjpGR6fX+zhJWvqcO3HPegbzHAEPHEKFHzGIbtigDcHda7BitNa9lHCnpN
         rGxwdOVMp1goXjiyMTz88+QDJEP9iItCxtusKQfbF8rQuu7U5ccVvh20bzgESnjTJGTW
         wmQQ==
X-Gm-Message-State: AOAM533DonfGuEbBnzD1+oX/OkAVgGLUVAefPhI+J9PxgxFreWAEzriD
        aUQeHIC5zQqBJ0b3bB9xGPg=
X-Google-Smtp-Source: ABdhPJzxa2SCdXapsflBjSvMtyMnaPURIYqg6ZwH78uW9C7Snv/dVXX1wQr3b4P2cwHRJUJBkq0USg==
X-Received: by 2002:a17:902:b688:b029:d2:43a9:ef1f with SMTP id c8-20020a170902b688b02900d243a9ef1fmr1769668pls.9.1601962838725;
        Mon, 05 Oct 2020 22:40:38 -0700 (PDT)
Received: from google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id j4sm1986730pfd.101.2020.10.05.22.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 22:40:37 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 6 Oct 2020 14:40:32 +0900
From:   namhyung@kernel.org
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Al Grant <al.grant@foss.arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf inject: Flush ordered events on FINISHED_ROUND
Message-ID: <20201006054032.GA1724372@google.com>
References: <20201002130317.1356440-1-namhyung@kernel.org>
 <20201004195239.GA217601@krava>
 <CAM9d7cgsxkefHAgyMf-GoP4-OdSsaRmhSGLwPMoYn=-c9YXxDw@mail.gmail.com>
 <20201006023949.GA1682192@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201006023949.GA1682192@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 11:39:49AM +0900, namhyung@kernel.org wrote:
> > > On Fri, Oct 02, 2020 at 10:03:17PM +0900, Namhyung Kim wrote:
> > > > Below measures time and memory usage during the perf inject and
> > > > report using ~190MB data file.
> > > >
> > > > Before:
> > > >   perf inject:  11.09 s,  382148 KB
> > > >   perf report:   8.05 s,  397440 KB
> > > >
> > > > After:
> > > >   perf inject:  16.24 s,   83376 KB
> > > >   perf report:   7.96 s,  216184 KB
> > > >
> > > > As you can see, it used 2x memory of the input size.  I guess it's
> > > > because it needs to keep the copy for the whole input.  But I don't
> > > > understand why processing time of perf inject increased..
> 
> Measuring it with time shows:
> 
>            before       after
>   real    11.309s     17.040s
>   user     8.084s     13.940s
>   sys      6.535s      6.732s
> 
> So it's user space to make the difference.  I've run perf record on
> both (with cycles:U) and the dominant function is same: queue_event.
> (46.98% vs 65.87%)
> 
> It seems the flushing the queue makes more overhead on sorting.

So I suspect the cache-miss ratio affects the performance.  With
flushing, data is processed in the middle and all the entries are
reused after flush so it would invalidate all the cache lines
occasionally.

This is the perf stat result:

* Before

     7,167,414,019      L1-dcache-loads                                             
       337,471,761      L1-dcache-read-misses     #    4.71% of all L1-dcache hits  

      11.011224671 seconds time elapsed


* After

     7,075,556,792      L1-dcache-loads                                             
       771,810,388      L1-dcache-read-misses     #   10.91% of all L1-dcache hits  

      17.015901863 seconds time elapsed


Hmm.. it's a memory & time trade-off then.  Maybe we need a switch to
select which one?

Thanks
Namhyung

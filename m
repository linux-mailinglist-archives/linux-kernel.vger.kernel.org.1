Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0712C8365
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgK3LlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgK3LlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:41:15 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:40:29 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id y22so7394447edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RKiITCXuJcTGV6hXTDksrqg/arpEfBV8bbz5G97muVg=;
        b=cscBK8qG7eZusLB1ds7dGjaTAyfQIHx6lmfKkrYVDTegEOHOgBgEYrsXplIBPrX2hl
         oWqFKqfwrRAuFOOPJHseKYO8UQVgm9iduC4HuikcfbfsURM80s569FC1zVdcrUTlMLP+
         82/QdOWTJcJpciXq9y5ZgEhA1DbzX74WosZ7PTpdDXi0TAxrzgyctRQISOcBKkLxn/6J
         TN9jzvgMX62Bvhv+fNf1yVk8AZCag5zv0oT6cKCcAfXOPsemGwurTiGfYqgTSdr8jSUs
         ZsGfwhur//3LYpLWCAFszBM1f0mfP/aLJ0mGG1C3si0z/wJ62QZcRPD+7o3E0Fl5RCSl
         3n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RKiITCXuJcTGV6hXTDksrqg/arpEfBV8bbz5G97muVg=;
        b=HYdfnSGhdpFkQr4vUMb2Czlp9wA4P7fcSO2tUlK5ww2oQ19Iqewta7zsWzjuNUla3u
         Du+L0JR9ZFifIgOCjI1tIKPbNMTNRf3W2fXRHSDr1uajSDvtEKH0eOx891uJEFpTyQCF
         gtc3JB+HLaqNh1ZgLgAtb+8LaAepq1Wk4/W5Y0HYT+ee21ITWjuSBqanHfSo5Q1RjX8u
         aIf6ZyBevYXudyfV7V21Gh87NhbeZ5cGfOScvUUX46HmRZ+y8XZdhxC8tI3ctRlfE3gO
         9bI6R6/Keugyda5cVpJBf/aWCkTz/4ELauYtPl+hrf2Knkgl+X+6txQSSxAXhXKs5FL6
         VOfA==
X-Gm-Message-State: AOAM533KXdAC2XZW3tN41H6/WyeNTf2ntBObeqaD9fQar0jge2thLyMQ
        POC0IsZ+GozyWyta8eSAohp1/Q==
X-Google-Smtp-Source: ABdhPJwFUj6jNo76rbjE8JZETu+R8pu+hEHHXulpbtlHXyN7ysYIWNR98RzPK0cqVos8+C61oux8Hg==
X-Received: by 2002:a50:8a8b:: with SMTP id j11mr6087629edj.19.1606736427756;
        Mon, 30 Nov 2020 03:40:27 -0800 (PST)
Received: from ntb.petris.klfree.czf (snat2.klfree.cz. [81.201.48.25])
        by smtp.gmail.com with ESMTPSA id s19sm5155013edx.7.2020.11.30.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 03:40:27 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:40:20 +0100
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
Message-ID: <20201130114020.GA29476@ntb.petris.klfree.czf>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz>
 <20201124143645.GD2088148@krava>
 <20201124181519.GA29264@ntb.petris.klfree.czf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124181519.GA29264@ntb.petris.klfree.czf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiří,
were you able to reproduce the issue? I may also upload perf-archive
if that would help.
  Petr

On Tue, Nov 24, 2020 at 07:15:19PM +0100, Petr Malat wrote:
> Hi!
> On Tue, Nov 24, 2020 at 03:36:45PM +0100, Jiri Olsa wrote:
> > On Tue, Nov 24, 2020 at 11:29:15AM +0100, Petr Malat wrote:
> > > Both mmapped and compressed events can be split by the buffer boundary,
> > > it doesn't make sense to handle them differently.
> > I'm going to need more than this, if there's a problem
> > with current code please share more details, what's
> > broken and how it shows
> It's easy to trigger the problem - make a perf recording larger than
> MMAP_SIZE (32MB on 32-bit platform) and run perf report on it. There
> is a small chance recorded events will be aligned on the 32 MB
> boundary and in that case just repeat the test.
> 
> The problem was introduced by "perf session: Avoid infinite loop when
> seeing invalid header.size", which instead of aborting the execution
> when there is a truncated event at the end of the file just terminated
> execution whenever there is a split event. Later then the problem has
> been noticed for compressed events and fixed by "perf session: Fix
> decompression of PERF_RECORD_COMPRESSED records" by effectively
> reverting "perf session: Avoid infinite loop when seeing invalid
> header.size" for compressed events, which left uncompressed events
> broken.
> 
> I think the best is to revert these 2 changes and fix the original
> problem by aborting when there is no actual shift during remapping - as
> long as we shift, it's clear we must approach the end of the file so
> such an algorithm can't loop forever.
> BR,
>   Petr

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF60277473
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgIXO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:58:02 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C575CC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:58:02 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id f11so2048834qvw.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h9qkcbMHlRJM7O8sVKuFGurhPQrKy5/mr+PHNIoNebU=;
        b=oIn1+5/5s08WNPyUD6MubZE3J1pjr8QTozz7D1Fu9YMdM5SimVa96WBNW1m7SSA6y6
         XYAnNK448hxc1uzLgCYLhOtG6F06YRlu5VY7u9SSEBoOXCn13N/hVF03CjslJEet+aR4
         tvuEnY9VZLWXvdGIyHqfeyiVxWDfST8zxgwbROTceYneQ/BZgg2H9pHVwzsaZddJHztT
         2FE9ZxN/OyODmISjbVeIE74PoOAa+OViOReCthQP1tBco4sWf/PSb19yKSVp/EcADJ9R
         aSWnAF04W+/N0fIRxoz2K8h1NP8QXiw02SoFrEsQF830rTsrZMHA0XnJ+gGIaBiQJc8J
         Yfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h9qkcbMHlRJM7O8sVKuFGurhPQrKy5/mr+PHNIoNebU=;
        b=ItdCvul3whaSla3HzZGo+Q1ixYGMKB4BxWtw22HbHZBE60Wge3mz48l6r9fOzQo3ze
         oPs7x5CVrmjsKVTrsbyaD47RlKNJpAOZ4g/kUSkqQv7u+k285om6qnX4XcdSK1UZm3VF
         TgRLieo3XO+oKiJ9jd3Fqdz+gZ5nGXjYcXUSVd/sj/Q4Nsl5340Vihpd2HT33mMj2fZ9
         aeKCTg9UoXtmK2lk+pSwiwhcWmOIxYvV+rMOiiR752iitmbOapRUFLcKCfKUavohRVsv
         4qPWLkl+hqyl2bnEd9/fSTsMtwKJjmLLNiKcPiPYt4WmN2Hnx58TWl8vh1Qi7VHNex1I
         B2AA==
X-Gm-Message-State: AOAM533rEuoJGcjPdWU+j89KO+nQdR4olpEKhE1Xq01Cx9TSyXAYsbWP
        50JQPa5OPH2bfYlnnrWNbcXdPjmtjPP22g==
X-Google-Smtp-Source: ABdhPJzf8empZZWk1V9NB1DOBKRyZOGNCuGE2w0nPTvSMMtt7DSCh1ikW7S9/rp4FY7tbp8+J76Umw==
X-Received: by 2002:ad4:518c:: with SMTP id b12mr5919034qvp.38.1600959481701;
        Thu, 24 Sep 2020 07:58:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3600])
        by smtp.gmail.com with ESMTPSA id 85sm2141994qkn.64.2020.09.24.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:58:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 24 Sep 2020 10:57:58 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: sched: rq->nr_iowait transiently going negative after the recent
 p->on_cpu optimization
Message-ID: <20200924145758.GG4268@mtj.duckdns.org>
References: <20200918172759.GA4247@mtj.thefacebook.com>
 <20200924115042.GG2628@hirez.programming.kicks-ass.net>
 <20200924142751.GF4268@mtj.duckdns.org>
 <20200924145041.GP2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924145041.GP2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 04:50:41PM +0200, Peter Zijlstra wrote:
> > Rik suggested that it'd be sufficient to return 0 on underflow especially
> > given that 0 is actually the right number to describe the state. So, maybe
> > that can be a nicer code-wise?
> 
> I worry about things where one CPU has a positive value and one or more
> (other) CPUs have a temporary negative value.

I think it'd make more sense to max'ing them per-cpu as that's the right
per-cpu state. nr_iowait_cpu() needs that anyway, so maybe the summing
function can just use nr_iowait_cpu()?

Thanks.

-- 
tejun

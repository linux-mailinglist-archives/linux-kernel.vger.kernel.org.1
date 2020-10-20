Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21562928F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgJSOIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgJSOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:08:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97774C0613CE;
        Mon, 19 Oct 2020 07:08:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gv6so5785878pjb.4;
        Mon, 19 Oct 2020 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L/d/GrMtM3G1c7gvNmCkj3g3XnSIby04pR6OkOZiUrg=;
        b=fTxFHbVbjA29MvwNlN3s+0MwtuIYMz+pD+EqynopaECm3ah0DIt33sJkGzB4BSp4DW
         L8YgUxOWOuv3dwiNagbVhTH9eopfPQVQHv7EMAocSBB9NN0TAqWsEWKNE5lpUCEdjfO/
         xoOlJRVTOBg5UqCKEx5Kt0+xbzrmD3VbyPHSQQ7cwYlECaXn6MEjBUrmuCSyCMnuxUve
         A3b+oVWYGrbhfuGpeTDFOt/Pv1uYAY7qMM0ZkJgpRKgCDm4hxfsjLWLpndJwHawRqiD6
         Ns3b4wX/M/crm6WxKnmwNA91eOQkTEN7aCY5iGYA/oTuIdXDqCpVZdMLOHAtGnRx7WPy
         ps6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=L/d/GrMtM3G1c7gvNmCkj3g3XnSIby04pR6OkOZiUrg=;
        b=ik6G4FXPXhu02H6eZ6rBKsGoIl6dod+4PSalwekic4hyEIdImkhStijHjAzZeYjNy6
         MNOW9R/nA38ATzAGTU/mSBRyVCrUSxJjj0hUT7Kv5xSY0bMEQeORbx9e8NW3lZYJamf+
         8JKRNzuVtm1NIs0rtiCJJv4HfO4kox//sycyVFCXzASJa+d928Rm5FVlcw2732LRJnyV
         4SioUx2NwuoY+Oec8xmOj+wIHBB3zksOkWZhueZNgRd5YXckjj4K16sLHkBf/HW/rOJU
         sMhPDuGGGpbE9bfBn9fshk4ZDB02EPLlQ1G6lPj3ZgcnLp4mS4lmgMuvJBfL0Ge9obtd
         IMDg==
X-Gm-Message-State: AOAM530LNlpmIHeOlKtKK33Jx0QUs/wCyUrbpqCjQus/wU1ylFZClark
        kZUQJrD7370T0PbBsCF5iGSqqLMbc68=
X-Google-Smtp-Source: ABdhPJx4RKnl2RSyvoZFLRslOtAzjB/CSFLKr0RY1iFncYxGq72yLZM5acJa93UpH8CpVSP7IxJM2g==
X-Received: by 2002:a17:902:d689:b029:d5:ced2:7968 with SMTP id v9-20020a170902d689b02900d5ced27968mr13532891ply.2.1603116514046;
        Mon, 19 Oct 2020 07:08:34 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id z18sm40554pfn.158.2020.10.19.07.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:08:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 19 Oct 2020 07:08:30 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, bigeasy@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: Fix __zram_bvec_{read,write}() locking order
Message-ID: <20201019140830.GA3118409@google.com>
References: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
 <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
 <20201016153324.GA1976566@google.com>
 <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:13:53PM +0200, Peter Zijlstra wrote:
> 
> Mikhail reported a lockdep spat detailing how __zram_bvec_read() and
> __zram_bvec_write() use zstrm->lock and zspage->lock in opposite order.
> 
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks for the fix.

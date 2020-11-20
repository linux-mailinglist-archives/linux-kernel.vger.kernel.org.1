Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0A2BB77B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 21:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgKTUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgKTUkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:40:11 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28549C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:40:11 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id w10so9720885ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TD3o5iLKwU8zdratpmBsatFArpZthyFmbqxgB9MOjPI=;
        b=l3vaiI1ac+8dhD50x/5uK13Cu2aUgwNOWKJNmC+bu+75M3KtxPGQGFUHugXkXFSOtz
         RYDLWqI5QSaSpHPS1G+BXBpU+AVvdbLMW0Jk+LzwlsOyPE2JcnfhQxnEjPJnzJmSfWRr
         +MsGH76gSVMw4g7190iaec4efnBG0EDi+SaQ7AvMDAcqp68dJz2GsHoqsit+WNfN9fy9
         k1zNH2z8TFCnjxDt7a4fQgrLALzNepcfTuSKzXd8cKzYm82jcvNXNBPBVofaQnpNV2KQ
         oQPtYP1XYk4eIie9ePH0hMOiFrF0uBYu6MlRmhEp4yZ1/hGRGwk502ppiafCmL6YIaum
         A3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TD3o5iLKwU8zdratpmBsatFArpZthyFmbqxgB9MOjPI=;
        b=flgEUMauIgaTqtCGe8cYZhJ7lKSbCr/mXK1rXvSIpOwe3iWOpbrKQ0PVTuBE6c0W+G
         e0ySDLG/VvWTt59mwmNvI3zdxRAzXO0gXwvHlXc5D5pdshJGNorjmBBunWSOZqI9qWL1
         5lQicPOl+Adxuje92JX3KMPZoEVNPHBoWmKvA25NfS75VrnxU3xcJzsSen6OGZjtj7I4
         1kvYazZQnj9FJJgKFt7K7BtdHAtAScx/xxBTSnkqU9eXp2o+kVd99awUISHObo/T4E/L
         VNsG1rXi8XXZBiftueFk4/USnRO4A7Du5BfEuXUCQOCsJ1ct/A/fTk+LC2w255gPOjJX
         Fokg==
X-Gm-Message-State: AOAM5301p/uJyKXLTn6sujXwCoDM++t/hsPhHwfv1zG2b423pD7BrReW
        mF9CPvZe9ibpuLExOlAvbsl4xEPBEc8oqyDt
X-Google-Smtp-Source: ABdhPJx2YPyA8+PrxQVdxE2fbx1FR9qm5FX6boWJoKvZ1Tsrv7fg2bruJzhdDC5G6i4LoN3rp3bbpA==
X-Received: by 2002:a92:a80d:: with SMTP id o13mr12283087ilh.60.1605904810251;
        Fri, 20 Nov 2020 12:40:10 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id w3sm2068621iol.9.2020.11.20.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:40:09 -0800 (PST)
Date:   Fri, 20 Nov 2020 13:40:05 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] mm: proc: Avoid fullmm flush for young/dirty bit
 toggling
Message-ID: <20201120204005.GC1303870@google.com>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120143557.6715-7-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:35:57PM +0000, Will Deacon wrote:
> clear_refs_write() uses the 'fullmm' API for invalidating TLBs after
> updating the page-tables for the current mm. However, since the mm is not
> being freed, this can result in stale TLB entries on architectures which
> elide 'fullmm' invalidation.
> 
> Ensure that TLB invalidation is performed after updating soft-dirty
> entries via clear_refs_write() by using the non-fullmm API to MMU gather.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index a76d339b5754..316af047f1aa 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1238,7 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  			count = -EINTR;
>  			goto out_mm;
>  		}
> -		tlb_gather_mmu_fullmm(&tlb, mm);
> +		tlb_gather_mmu(&tlb, mm, 0, TASK_SIZE);

Let's assume my reply to patch 4 is wrong, and therefore we still need
tlb_gather/finish_mmu() here. But then wouldn't this change deprive
architectures other than ARM the opportunity to optimize based on the
fact it's a full-mm flush?

It seems to me ARM's interpretation of tlb->fullmm is a special case,
not the other way around.

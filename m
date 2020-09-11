Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FED266A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKV3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:29:40 -0400
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:47002
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgIKV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599859778;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=X3TtwRyF4MrXHPxSveLidpndKZuj/b006x1oePgvspw=;
        b=GiZKWNGQwnm8svSKCHDUE2wgq49Fz3HDorLVPOWNHcgXVMuvI75LSxpidV1/Wq2T
        7pDG0bz4FbcPctc8NNS+6xcfFwaOmPWmZekgxpgVGFc9NjXc4KgS95Lzu91Kn8KGnwc
        itsgDfIzTx6JM9WugAcsIuDlt8hqo7epCBLJtfFQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599859778;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=X3TtwRyF4MrXHPxSveLidpndKZuj/b006x1oePgvspw=;
        b=dc31XpDpUtLoOvJezHgEcV77xMCQDN0Hy4KQNk9k3R4hm1hUXUC1L2MI/PN0Sf29
        8ozsPW4AnXwEhIAvV9+BUMZZ3bTNc6+4yPDMFaqZH3EFGfU5nVnihyNyrWz3z9Dit70
        v70i8RjFg+X2yOlyrC4zO8hzViEkD8FYaxwMJG3o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 21:29:38 +0000
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] cma_alloc(), indefinitely retry allocations for -EBUSY
 failures
In-Reply-To: <010101747ef2a10a-bb03bde7-7852-4d77-8706-cd099ef36004-000000@us-west-2.amazonses.com>
References: <010101747ef2a10a-bb03bde7-7852-4d77-8706-cd099ef36004-000000@us-west-2.amazonses.com>
Message-ID: <010101747f12e499-1418e736-fe1b-449f-bc7c-4af35f855d13-000000@us-west-2.amazonses.com>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-11 13:54, Chris Goldsworthy wrote:
> [PATCH v2] cma_alloc(), indefinitely retry allocations for -EBUSY 
> failures
> 
> On mobile devices, failure to allocate from a CMA area constitutes a
> functional failure.  Sometimes during CMA allocations, we have observed
> that pages in a CMA area allocated through alloc_pages(), that we're 
> trying
> to migrate away to make room for a CMA allocation, are temporarily 
> pinned.
> This temporary pinning can occur when a process that owns the pinned 
> page
> is being forked (the example is explained further in the commit text), 
> or it is
> exiting.  This patch addresses this issue by indefinitely retrying 
> allocations
> that fail due to a return of -EBUSY.
> 
> ** This change log was re-sent due to threading issues **
> 
> Change log:
> 
> v1: We were performing retries of the allocation a fixed number of 
> times.
> Andrew Morton disliked this, as it didn't guarantee that the allocation 
> would
> succeed.
> 
> https://lkml.org/lkml/2020/8/5/1096
> https://lkml.org/lkml/2020/8/21/1490
> 
> v2: To address this concern, we switched to retrying indefinitely, as 
> opposed to
> doing to retrying  the allocation a limited number of times.
> 
> Chris Goldsworthy (1):
>   mm: cma: indefinitely retry allocations in cma_alloc
> 
>  mm/cma.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
test
-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

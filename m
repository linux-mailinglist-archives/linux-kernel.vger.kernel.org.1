Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F932121B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 13:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgGBLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgGBLFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:05:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W7vOkyxsbYhaQ0GGmRUCdYNP3bzUA8L6GrJCj+KCQMo=; b=N5oiHn9gfkXS1SWEc806/XUf6k
        vUSGLyKW9Cx/xBI2iSjUwMKmOD2jkbGkGhEe8YywPJfM716/TfAZbVZ7mo85ZJftrNve8sR+D9j5r
        WyckWcckppDAXPvlaU8PoECAK5z8f/rMEmz6dtoajx3dOirlVLoDzsFcAb1bi/ymuDZeVGgVk4b9r
        D18gi9NUXThq/kURC3l7QuQyDSGtkRjv/MX7DVNyNEo0ieo7VGS9pUZiwM9yD/rgDokSr25vBcGU2
        LjXKOeTqcjQQesDwSw9o1Y+Cs2a4UgxIdArGi/3ZFmKh1oPKjv4/dw2NFrkKtgrk2LRgEKqqffplV
        bQT0/pAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqx2F-0008PQ-Ic; Thu, 02 Jul 2020 11:05:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 970CB30015A;
        Thu,  2 Jul 2020 13:05:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8409022172012; Thu,  2 Jul 2020 13:05:42 +0200 (CEST)
Date:   Thu, 2 Jul 2020 13:05:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix potential memory leak special_get_alts()
Message-ID: <20200702110542.GP4800@hirez.programming.kicks-ass.net>
References: <20200702110025.16883-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702110025.16883-1-chenwandun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 07:00:25PM +0800, Chen Wandun wrote:
> If get_alt_entry() return error, struct special_alt will leak.
> 
> Fixes: 442f04c34a1a ("objtool: Add tool to perform compile-time stack metadata validation")
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

https://lkml.kernel.org/r/20200427144439.rrywv56mjfypupgh@treble

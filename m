Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84621214152
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGCVwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGCVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:52:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B249C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lU/uXJfhXSguevBC4rPhh3n/kmpGM+LeT9/Wol7zCDc=; b=dAXQ/RS+LAD5awMVpxUelA7BoC
        fQVg4CTt+VJkOPEHeDwVj8fvvFP4LPQKX2q61FC6KeEc05mysCryWo0u2uLeov5UJD6AdsTEQ61ZS
        U7IrAd+eJoNXQIMXZ20JM0CcTBrFUWv10PyGb2e9RZujYKdDofSsYqK5vMjBb4mVw3tjev1YgNgqk
        fNebVhAOB0IdB6jDCyzN2TdACFanBC5KMFQaaFnmsKvYAQjGI9tjnYOx2PWOzdnxsg5AkshTPlt1P
        yoO0UxJIAs3jBJaH+PN2lSbj08GqBZmRAnq36r11lRvGoLf7l+1efGrl3yAUOsszlBOkhGcvjtsWp
        G6eYy6JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTbB-0007Bf-Id; Fri, 03 Jul 2020 21:51:57 +0000
Date:   Fri, 3 Jul 2020 22:51:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        peter enderborg <peter.enderborg@sony.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703215157.GI25523@casper.infradead.org>
References: <20200703155749.GA6255@pc636>
 <8a2a55e6-6087-e4bf-3d35-ed4b4c216369@sony.com>
 <20200703192807.GB5207@pc636>
 <CAHk-=wiagrzJs9OBe_6bHK+Cc6RdoCOV85CiJAd3MhYnc8idfw@mail.gmail.com>
 <20200703212047.GA6856@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703212047.GA6856@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:20:47PM +0200, Uladzislau Rezki wrote:
> Some background:
> Actually i have been thinking about making vmalloc address space to
> be per-CPU, i.e. divide it to per-CPU address space making an allocation
> lock-less. It will eliminate a high lock contention. When i have done
> a prototype i noticed and realized that there is a silly issue with
> nr_cpu_ids on some systems.

vfree() may happen on a different CPU from the one which called vmalloc(),
so I'm not sure you're going to get as large a win as you think you will.

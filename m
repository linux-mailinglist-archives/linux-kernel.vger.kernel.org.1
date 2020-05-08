Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F81CA76C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgEHJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 05:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgEHJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:45:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F8C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e3aVuwxP1slnDxi0vmc40CnHLXr+QgTfgkl2AN458bg=; b=QrSO+ZmEvt+uQd+ex56tkF4v+b
        d31GzWMPCXPmxeE9z5JrPpsOHep2F6d83KbGNpu7OYTz8Cq9qGAH1VH4/7M6Eo93TXgusUJStzFj/
        3SXBYwFs6rBDFP/47lpqzUQ3iLvTlJivxuVOOgqbPpXyMSaQbbn+3EmzIqU77Ox4DSF9s4HaqgBZs
        /USg8kQ2iIO1zOiaSj77/+UvhBuaGjcsGQArr9LBF2YWMttkmNwJ03V9eHtQgzroJ75g/OWO2rJua
        jUozE7GRrROlTBoUkml2rfmfTohWDVyMBRMsSQljEffiETPp6gPEzJ0vmdP9iLiqJwbncPze0Bm7G
        4CvHqp2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzZI-0006YZ-Al; Fri, 08 May 2020 09:45:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54196301A80;
        Fri,  8 May 2020 11:45:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45B442B852F43; Fri,  8 May 2020 11:45:18 +0200 (CEST)
Date:   Fri, 8 May 2020 11:45:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200508094518.GW5298@hirez.programming.kicks-ass.net>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507232941.jccuywl56bppxfyp@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:29:41PM -0500, Josh Poimboeuf wrote:
> On Wed, May 06, 2020 at 04:07:25PM +0200, Arnd Bergmann wrote:
> > Hi,
> > 
> > During randconfig testing with clang-10 I came across a number
> > of additional objtool warnings, I'll send another mail about those
> > when I have collected more information and some object files.
> > 
> > This one sticks out however, as objtool returns an error code that
> > stops the build:
> 
> > fs/dlm/lock.o: warning: objtool: __receive_convert_reply()+0x1e5: can't find jump dest instruction at .text+0xcaa7
> 
> Thanks for sending the patch for this one.  Objtool always gets confused
> by new compiler versions, I really think we need to revert
>  
>   644592d32837 ("objtool: Fail the kernel build on fatal errors")
> 
> because objtool is never going to be reliable enough such that we can be
> confident that failing the build is the right thing to do.

So on the one hand I agree. We're forever playing catch up with the
compilers, and as I said earlier, objtool generating an error has the
very unfortunate effect of the actual .o file getting deleted by the
build system, which is all sorts of annoying when you then want to
figure out what objtool got upset about.

So, yes, we probably should revert that.

OTOH, if we don't break the build, people are going to continue to
ignore objtool warnings/errors when they writes new code.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC819E535
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDDNci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 09:32:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41398 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgDDNci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 09:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sKdYVJdX3k84mHqdB1JfFeNgO6VOXjckqROOgUeE4T4=; b=RQqJwzxbWHaBvffTkFmFoeuIT9
        0KZmodiErmNfv2LtfCUfDyJcjHkH4RfSOsoid7JlkKJUV5p4ScnNpXWzE3P5xzexAeQYc+FSYrS2i
        DSaqwcVupQPV7yMZHG1+CeA3Ub8qwESC4xifxPz4VkD6B8qd4j4cB5d4lWko4QUvEic+AOt5aA6yT
        tDfHhJssqVIlazOv4p2qEkzwn5mkkkcQFA36DiUq3ufECxfRLpzCDjNmpAxWGioYRN5qGXrar8Oxz
        SJFv2y3X3dK1HAUtSWuDomXCt2XKVh94H/Axybee9XKp9DtahS09PRNRHVkBHFJtBExlkop3QdpSy
        7xaibUIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKiuM-0008Ff-Hf; Sat, 04 Apr 2020 13:32:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C0A9304D2B;
        Sat,  4 Apr 2020 15:32:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE02D2B1362DC; Sat,  4 Apr 2020 15:32:18 +0200 (CEST)
Date:   Sat, 4 Apr 2020 15:32:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200404133218.GL20760@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
 <20200403154620.GS20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403154620.GS20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 05:46:20PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
> > Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
> > work here?
> 
> Yes, it would.

Sorry, I have reconsidered. While it will shut up objtool, it will not
'work'. That is, the ORC data generated will not correctly unwind.

I'll try and write a longer email tonight.

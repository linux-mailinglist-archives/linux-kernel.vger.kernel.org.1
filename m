Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2924281209
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbgJBMLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:11:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352E6C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 05:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wAkAIyuFajetfoFJ3id7YILxbAP0xrZwqSUaItPSmak=; b=wBuNSwrt2N0rJBcY3sIwOzP3CQ
        Hp2kkS+Cz0RwwtwpKroEBXj0o/10s2mt8595FKa8hgrPyyDcwHdo6C3amifbi0JTGY4wj9jryhO6e
        sUNndacSikgohw+0kLZ2uaFjxf/GIscI6Yq8zevDW29hURF0ZasNuh4jCPDoMbZfWn3NL8R322SUZ
        UVZwrf/ZAkZEQzR4QpKLj1uU+ELJxWnutXSukqUBM1wLy9JDK2tpJV84884GdzxIpAHBLlOmgYHg4
        WjzmsYo9+IKGmneHXA25375lsilsEMCKcq2CJ9tRUQovAkzXcuoDu4ncBzMuBCWT+HbRwC4LgHnv2
        fQl+V8jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOJuT-0002cx-IC; Fri, 02 Oct 2020 12:11:37 +0000
Date:   Fri, 2 Oct 2020 13:11:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pintu Kumar <pintu@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/util.c: Add error logs for commitment overflow
Message-ID: <20201002121137.GY20115@casper.infradead.org>
References: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 05:27:41PM +0530, Pintu Kumar wrote:
> This is the output we can see on a 256MB system and with a simple malloc
> and fork program.
> 
> [root@ ~]# cat /proc/meminfo
> MemTotal:         249520 kB   ==> 243MB
> MemFree:          179100 kB
> 
> PPID	PID	USER	RSS	VSZ	STAT	ARGS
>  150	164	root	1440	250580	S	./consume-and-fork.out 243
> 
> __vm_enough_memory: commitment overflow: ppid:150, pid:164, pages:62451
> fork failed[count:0]: Cannot allocate memory

I don't think the __func__ is particularly useful information.  I would
also expect the name of the process to be more interesting than the PID.
And why is the ppid useful?

Wouldn't this message be more useful?

fork: Would overcommit system (pid:162 name:./consume-and-fork.out)

ie put it in dup_mmap() and use current->comm

> +	pr_err_once("%s: commitment overflow: ppid:%d, pid:%d, pages:%ld\n",
> +			__func__, current->parent->pid, current->pid, pages);
> +

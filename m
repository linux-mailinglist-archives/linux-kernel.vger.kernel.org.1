Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F872B16F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKMIHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:07:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58854C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SXn6GEnExSXe9DRU2m5d4oWqNn7pd2IiBBAqqclId9A=; b=gdBQ8xFYXmvLLuQswnE3lGZU+m
        fzHwAG5kTwBLVYlLuBcclhxwfsNNzs0B/yto/rJygJtIKTmqv9QtxU5Vr+CoKkNFbxfNGBA1VHnbt
        4LlKjc8wFu8+5etoOFncw7rDY4Kuz/Iu2WTG4W6TZNcB0OR9wPcu/a7E7TZbPYcSM9hS+QS6pxMfC
        JQJ6j76QlKEnsl0liVVkdVnzdvptO6AdasZI+L6EaOKnZt/8QhJPEP8ul0Sp/4P6YpVaUYRGnPRt4
        Z1p9XOqSFbGEz/YO7Ya7cHj/DKR85grt83aHJiWJ5fPzlRiv34Blw+XbonomgZ0X6Ywvv3tdCFgTY
        hhf+hqsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdU7L-0001P2-Bj; Fri, 13 Nov 2020 08:07:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EFE8300238;
        Fri, 13 Nov 2020 09:07:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E15982C084CAB; Fri, 13 Nov 2020 09:07:33 +0100 (CET)
Date:   Fri, 13 Nov 2020 09:07:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/3 v6] ftrace: Add access to function arguments for all
 callbacks
Message-ID: <20201113080733.GZ2628@hirez.programming.kicks-ass.net>
References: <20201113020142.252688534@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113020142.252688534@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:01:42PM -0500, Steven Rostedt wrote:
> Steven Rostedt (VMware) (3):
>       ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
>       ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
>       livepatch: Use the default ftrace_ops instead of REGS when ARGS is available

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

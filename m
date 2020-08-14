Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2413924430F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 04:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHNCiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 22:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgHNCiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:38:19 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A8820716;
        Fri, 14 Aug 2020 02:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597372699;
        bh=5BqXQK5WCJSTx1xuZ99dJlnoRjlBLK83T9Mfanz/2hQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TVSPc72nPkfi9NAFEnGe6ZGf36NcazYo+X9OqkpOWXSiAbwKhSqqqTPXMIXSP6swh
         r5PCe5kIVLsCke8IIVjf7FeLWX3Me0EmW5bczF2bAiWBHICdYXxF4UNrXR4AMrNcoh
         TzjpQILOa1Grlwf/B5rpJqYv3UOZnd/jgE3qqYYk=
Date:   Thu, 13 Aug 2020 19:38:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] bootconfig: Fix off-by-one in
 xbc_node_compose_key_after()
Message-Id: <20200813193818.a44ea9afc447f57d470b2def@linux-foundation.org>
In-Reply-To: <20200813183050.029a6003@oasis.local.home>
References: <20200813183050.029a6003@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 18:30:50 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> While reviewing some patches for bootconfig, I noticed the following
> code in xbc_node_compose_key_after():
> 
> 	ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
> 		       depth ? "." : "");
> 	if (ret < 0)
> 		return ret;
> 	if (ret > size) {
> 		size = 0;
> 	} else {
> 		size -= ret;
> 		buf += ret;
> 	}
> 
> But snprintf() returns the number of bytes that would be written, not
> the number of bytes that are written (ignoring the nul terminator).
> This means that if the number of non null bytes written were to equal
> size, then the nul byte, which snprintf() always adds, will overwrite
> that last byte.
> 
> 	ret = snprintf(buf, 5, "hello");
> 	printf("buf = '%s'\n", buf);
> 	printf("ret = %d\n", ret);
> 
> produces:
> 
> 	buf = 'hell'
> 	ret = 5
> 
> The string was truncated without ret being greater than 5.
> Test (ret >= size) for overwrite.

What are the end-user visible effects of the bug?  IOW, why cc:stable?



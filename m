Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4726A2EA0BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbhADXYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbhADXYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:24:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBE31206F8;
        Mon,  4 Jan 2021 23:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609802638;
        bh=/J9lOmW1YaeKRhNVv8DZ4Ehhw7//zHi8b0Ji/4NfsR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P4dNs6DhpupKwWDgq6M18i+ydv9hR1ncOpcGuAPA1AqQwa7R/N0dql+dW/xi1HMH8
         XR6acxwKb2N/cl2Jxpl5NAye2BP62lqyIFJbPqWvERy9f025hqUp1GgQTjI6WFS13v
         /nvqnFLn5C5ZFs1fV638Y6NEyvj0nOw7YVdGXl3U=
Date:   Mon, 4 Jan 2021 15:23:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hui Su <sh_def@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/page_alloc: remove the static for local variable
 node_order
Message-Id: <20210104152357.d56d10e0443bae984a174f18@linux-foundation.org>
In-Reply-To: <20201230124233.GE28221@casper.infradead.org>
References: <20201230114014.GA1934427@ubuntu-A520I-AC>
        <20201230124233.GE28221@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 12:42:33 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Dec 30, 2020 at 07:40:14PM +0800, Hui Su wrote:
> > local variable node_order do not need the static here.
> 
> It bloody well does.  It can be up to 2^10 entries on x86 (and larger
> on others) That's 4kB which you've now moved onto the stack.

That being said, could we kmalloc the scratch area in
__build_all_zonelists()?  And maybe remove that static spinlock?

(what blocks node and cpu hotplug in there??)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFD2E789D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgL3Mn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3Mn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:43:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC137C061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 04:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GFv7dLiw0NpGHZG0c6KE16f5Mn2s1/PKG0D3EAXZlPg=; b=uN/ggEkRMYWqEeLgaDS0WEauPE
        ovr2dGeW22qLxFinoQ3HQw/jht1QBOn3NHnINc7l6Febx4iec63rXVLHg0MsNjAmB2lH3CpcwdhHp
        ydmxXJH98wiYjyMvX1jeaFpRMSchSy5sTWnjoZdvWq8UWYSKojnT8ShdhTyinN3UnduhQMdAgplaw
        Ri+P6xo1M/rdZXBdXZsJY7mjelKw3iCYuim786Zvre4qNWFxEWOlvA2SR06bubgHDXnrE/lS6NgK9
        cyG+mpGFBuquSvUm/u/1RdkIImRIID0m7Z3KnwkNdAHsYxa6vd22CjTkubmagNl4e3d7LRoxlgkH2
        +skMHlKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kuaoD-001IVR-LA; Wed, 30 Dec 2020 12:42:34 +0000
Date:   Wed, 30 Dec 2020 12:42:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hui Su <sh_def@163.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/page_alloc: remove the static for local variable
 node_order
Message-ID: <20201230124233.GE28221@casper.infradead.org>
References: <20201230114014.GA1934427@ubuntu-A520I-AC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230114014.GA1934427@ubuntu-A520I-AC>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 07:40:14PM +0800, Hui Su wrote:
> local variable node_order do not need the static here.

It bloody well does.  It can be up to 2^10 entries on x86 (and larger
on others) That's 4kB which you've now moved onto the stack.

Please, learn more about what you're doing.  I suggest sending patches
to drivers/staging; that will help you learn how to submit patches to
linux.

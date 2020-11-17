Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13202B6C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgKQSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:03:07 -0500
Received: from m12-13.163.com ([220.181.12.13]:57819 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbgKQSDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=PF7Fm
        nWexI8aUiHza1IDKXIAbnpRAZGxrXIeRXk7E0U=; b=ghx63B/Y9rEaMyKSR/t6U
        sjcEEi9J0xsSWhN1ZOAV12NiJHA4+V/v0svrOnJ9E2rdxBckjWpkj9BI2f3/GVgK
        kIFVnvCnLMT0xRH7c040CpizFQXPm1p3B3Cs1X53WGUhHK+OXf/CXJhOgqhivwXD
        VWmlFRUhHb12D5PATSVJJs=
Received: from localhost (unknown [101.86.213.141])
        by smtp9 (Coremail) with SMTP id DcCowADHZkt5DLRfqKjbRA--.42929S2;
        Wed, 18 Nov 2020 01:46:33 +0800 (CST)
Date:   Wed, 18 Nov 2020 01:46:33 +0800
From:   Hui Su <sh_def@163.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117174633.GA158014@rlk>
References: <20201117171242.GA120587@rlk>
 <20201117174117.GQ29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117174117.GQ29991@casper.infradead.org>
X-CM-TRANSID: DcCowADHZkt5DLRfqKjbRA--.42929S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrZ2TUUUUU
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWRnfX1WBtcWFFgAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 05:41:17PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 18, 2020 at 01:12:42AM +0800, Hui Su wrote:
> > lru_list lru bit 0 can tell whether the list is
> > avtive lru-list or not.
> > lru_list lru bit 1 can tell whether the list is
> > file lru-list or not.
> > 
> > And fix some define type in shrink_active_list()
> > and get_scan_count().
> > 
> > v1->v2:
> > correct the commit message, and fix the define type.
> 
> No, still incorrect.

I am a little confused, can you tell in detail?

Thanks.


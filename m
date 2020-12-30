Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172362E799E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgL3NTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:19:54 -0500
Received: from m12-12.163.com ([220.181.12.12]:35848 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgL3NTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Vq/jt
        T4DcwIkqvSQv+fIEjUupKGdKzlR1CmJFed2Syo=; b=dus3OHVjPMKoZKgllID3Z
        fxasKX1pKSRoGYwKpWAhT7HnKT8djuiVdHLxgZCFqS3YoozF/f/51Vlr9kYB2kCY
        LuZTlnpvIjAEfOOZTj87lcCGQoenMs2mBRFvD1vrHV74nIaPqtCVk4i2upBXJ+2O
        Ubum3yz3MQcXosgOxPCQ6M=
Received: from localhost (unknown [101.86.213.121])
        by smtp8 (Coremail) with SMTP id DMCowACHENzAeexf9qzHJg--.23498S2;
        Wed, 30 Dec 2020 20:59:45 +0800 (CST)
Date:   Wed, 30 Dec 2020 20:59:44 +0800
From:   Hui Su <sh_def@163.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/page_alloc: remove the static for local variable
 node_order
Message-ID: <20201230125944.GA2040977@ubuntu-A520I-AC>
References: <20201230114014.GA1934427@ubuntu-A520I-AC>
 <20201230124233.GE28221@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230124233.GE28221@casper.infradead.org>
X-CM-TRANSID: DMCowACHENzAeexf9qzHJg--.23498S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUc4lkUUUUU
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIAELX10TCy4s7QAAsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthew:

On Wed, Dec 30, 2020 at 12:42:33PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 30, 2020 at 07:40:14PM +0800, Hui Su wrote:
> > local variable node_order do not need the static here.
> 
> It bloody well does.  It can be up to 2^10 entries on x86 (and larger
> on others) That's 4kB which you've now moved onto the stack.
> 
Thanks for your explanation, this change will put too much onto the stack
in some cases which i didn't consider.

Please ignore this change.

> Please, learn more about what you're doing.  I suggest sending patches
> to drivers/staging; that will help you learn how to submit patches to
> linux.





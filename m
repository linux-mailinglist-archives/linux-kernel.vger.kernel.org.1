Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D716725C82B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgICRkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 13:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgICRkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:40:08 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E692620722;
        Thu,  3 Sep 2020 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599154808;
        bh=he/icALJc5nxcmM8oVZBySI9LjdCFoBo+OczlPqUxkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzCsy3xVMtMVKsfdqUr58p7DNzmt/RChq1Nup4j1boBs2CpaBeZOyBPJLtypL0k0o
         3bwHzfsh8AalyuKNtr9tOeDrjRqgFFekkbLYvHxID3SoeNcIgsTzdbqoObs1/yK3iv
         gY6JI3E6k0uQ6RQA4DZnd2me70ySJhiuu+yKVXQk=
Date:   Thu, 3 Sep 2020 10:40:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: Documentation edits/fixes
Message-ID: <20200903174007.GA3619770@google.com>
References: <96f99afb-c54e-8f46-ebac-80a62f65b876@infradead.org>
 <20200903103027.4c8d0b07@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903103027.4c8d0b07@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03, Jonathan Corbet wrote:
> On Wed, 2 Sep 2020 17:08:31 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Correct grammar and spelling.
> > 
> > Drop duplicate section for resize.f2fs.
> > 
> > Change one occurrence of F2fs to F2FS for consistency.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > Cc: Chao Yu <yuchao0@huawei.com>
> > Cc: linux-f2fs-devel@lists.sourceforge.net
> > ---
> >  Documentation/filesystems/f2fs.rst |   53 +++++++++++----------------
> >  1 file changed, 23 insertions(+), 30 deletions(-)
> 
> So this, I guess, needs to go through the f2fs tree since it doesn't apply
> to docs-next currently.

Yup, I applied in f2fs tree.
Thanks,

> 
> Thanks,
> 
> jon

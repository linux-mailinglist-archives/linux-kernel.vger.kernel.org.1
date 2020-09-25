Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A06E278EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgIYQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgIYQpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:45:41 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D562207C4;
        Fri, 25 Sep 2020 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601052340;
        bh=jCFSSAzfkPx0FSPQZ22vjowCCmUJwQx6Nnx+KhlIOzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wjyiZ5KbaEaamDgZO/UH46Jx+G5zQ1OuC8xQnXkX5QjK3+dqnkXTgI310MPEtjdS0
         +6ejXQSItYHr02ZIjcXYVIfhXd2z9tbnPrQzJrYMvlhYt/rl9IzsxAwuZK7vtp+Bz8
         0YEwOtDDH30ohov6SWDlO6CeGJTIl2vtNANp9mHY=
Date:   Fri, 25 Sep 2020 09:45:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     syzbot <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>,
        chao@kernel.org, glider@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [f2fs-dev] KMSAN: uninit-value in f2fs_lookup
Message-ID: <20200925164538.GB3315208@gmail.com>
References: <000000000000f9f80905b01c7185@google.com>
 <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
 <20200925163819.GA3315208@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925163819.GA3315208@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 09:38:19AM -0700, Eric Biggers wrote:
> On Fri, Sep 25, 2020 at 05:06:33PM +0800, Chao Yu wrote:
> > Hi,
> > 
> > I don't see any problem here, thanks for your report. :)
> > 
> > Thanks,
> 
> What about if max_depth == 0 in __f2fs_find_entry()?  Then __f2fs_find_entry()
> would return NULL without initializing *res_page.

... and I now see Dan Carpenter already pointed this out.  I was a bit late!

- Eric

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3942283048
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJEGMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 02:12:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEGMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 02:12:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601878369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9UlIgNYow+e5d0wNkhgzXJXHRjARVpEObiHO2PF7OdQ=;
        b=Zn00WraDkJM6dqF1L360RuBWNmu4+J8ozMIdWZzbF5QtByD1IVAkBJuPRwFF1MoIL6oCPC
        oPBJdZQcJZd7yrDqbyRB83/6apWx8tgsEJjWC6jPRJLfh82+UPn8VJU3kojRC9eWvWkemG
        WrAxPKFdPxuOAk1GG3OXlTeyBG6S1AQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B9A5B1B9;
        Mon,  5 Oct 2020 06:12:49 +0000 (UTC)
Date:   Mon, 5 Oct 2020 08:12:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: optionally disable brk()
Message-ID: <20201005061248.GN4555@dhcp22.suse.cz>
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 03-10-20 00:44:09, Topi Miettinen wrote:
> On 2.10.2020 20.52, David Hildenbrand wrote:
> > On 02.10.20 19:19, Topi Miettinen wrote:
> > > The brk() system call allows to change data segment size (heap). This
> > > is mainly used by glibc for memory allocation, but it can use mmap()
> > > and that results in more randomized memory mappings since the heap is
> > > always located at fixed offset to program while mmap()ed memory is
> > > randomized.
> > 
> > Want to take more Unix out of Linux?
> > 
> > Honestly, why care about disabling? User space can happily use mmap() if
> > it prefers.
> 
> brk() interface doesn't seem to be used much and glibc is happy to switch to
> mmap() if brk() fails, so why not allow disabling it optionally? If you
> don't care to disable, don't do it and this is even the default.

I do not think we want to have config per syscall, do we? There are many
other syscalls which are rarely used. Your changelog is actually missing
the most important part. Why do we care so much to increase the config
space and make the kerneel even more tricky for users to configure? How
do I know that something won't break? brk() is one of those syscalls
that has been here for ever and a lot of userspace might depend on it.
I haven't checked but the code size is very unlikely to be shrunk much
as this is mostly a tiny wrapper around mmap code. We are not going to
get rid of any complexity.

So what is the point?
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A202C1971
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgKWX36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:29:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKWX35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:29:57 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA3720717;
        Mon, 23 Nov 2020 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606174196;
        bh=shHEZAcsfJx7Tv0vz0iSz7SQorKsGx54gtCekwl4J14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DX9OYx+yUVf++0Ni+ebQf3EyOiDt/8qqb9L/Xcd3gEXOZXc+TOCb424vDJpetNgpG
         cjdP6AZlmx3D3C/LLeUSF0mLFUkpd9M2Mlt2ZnCnN96qxIc3wk98MQbDjSv/yMHPmf
         YS9VdrEwp0jfrT3zO9s84zIZNPkwo0+fUSGr6PDU=
Date:   Mon, 23 Nov 2020 15:29:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
Message-ID: <X7xF8+jko5d71CKq@sol.localdomain>
References: <20201123031751.36811-1-daeho43@gmail.com>
 <20201123031751.36811-2-daeho43@gmail.com>
 <20201123184821.GB3694916@gmail.com>
 <CACOAw_xEe=3H60njSfwJSToFnVbOHabUd2Nt=uZJLvCfxFgM4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_xEe=3H60njSfwJSToFnVbOHabUd2Nt=uZJLvCfxFgM4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 08:02:21AM +0900, Daeho Jeong wrote:
> Jaegeuk,
> 
> My mistake~
> 
> Eric,
> 
> What I want is like do_page_cache_ra(), but I used
> page_cache_ra_unbounded() directly, because we already checked that
> read is within i_size.
>
> Or we could use do_page_cache_ra(), but it might do the same check in it again.
> What do you think?

page_cache_ra_unbounded() is basically a quirk for how fs-verity is implemented
in ext4 and f2fs.  I don't think people would be happy if it's used in other
cases, where it's not needed.  Checking against i_size multiple times is fine.

> 
> I could add some description about these in
> Documentation/filesystems/f2fs.rst and I implemented tests internally.

Documentation in f2fs.rst sounds good.  All the f2fs ioctls should be
documented there.

The tests should be runnable by any kernel developer; "internal" tests aren't
very useful.  Could you add tests to xfstests?

- Eric

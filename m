Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613C81F6E81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgFKUIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 16:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:32944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgFKUIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:08:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5872D206C3;
        Thu, 11 Jun 2020 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591906091;
        bh=3jpJtP3t9hFdqcShtE4lp5CSs9AaxqocOw7hGV3sFEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dclekmqdeFuzWGTcwkZPttowYQpJhfd1aymjlvyX70zNx+lZtgl/fCH2oI2jJOQUK
         T98bQvSDzgCCkmTUhC8IXvDebugK8p/KG9gSKlJaP0AMKG00IF7IhWWyLASQw0x296
         jnlU0kncHpaeHJIcf5VLF3/FaUSkocgPL+ZwqM+8=
Date:   Thu, 11 Jun 2020 23:08:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Matteo Croce <mcroce@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch.pl: perform commit ID check from external to
 git folder
Message-ID: <20200611200807.GC1933365@unreal>
References: <20200611125957.1993741-1-leon@kernel.org>
 <fcd6d2c34c082ee3dd21a1c3bfd558306e566261.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcd6d2c34c082ee3dd21a1c3bfd558306e566261.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:22:41AM -0700, Joe Perches wrote:
> On Thu, 2020-06-11 at 15:59 +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The execution of scripts/checkpatch.pl in folder outside of git produces
> > complains about invalid commit ID, despite having valid one.
>
> There is already a slightly different test for this in -next
> It also uses a environment test for GIT_DIR.

If you are referring to this commit
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/scripts/checkpatch.pl?h=next-20200611&id=5bff933936a76a839e3c7f47f193cbf0d9904543

It didn't work for me, because I'm not setting GIT_DIR environment and
use "--root" switch from checkpatch.pl.

>
> Try that one.

It doesn't make too much sense to have two options to configure git
directory, one is GIT_DIR and another --root.

Thanks

>
>

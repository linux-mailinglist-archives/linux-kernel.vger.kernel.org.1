Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CDC20D2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 21:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgF2SyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgF2SyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:00 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233DC031C40
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:54:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6DA097AEF; Mon, 29 Jun 2020 14:53:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6DA097AEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593456839;
        bh=9XJ9VxQWwlxsT+F/M9dETph4iM5G18Tn6CLcQzWV/sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7yyWnk6AGhuKFpEIuAurEOCqZNusp5gYB9AIsu4DL3I7Rql9Tir1QZZuwzvRbm8F
         +4fWJlEq38nHSusrh0u7hWmT3E8dfqfTl/kbcuFTuOKitlAH8NBOTMUS98F+nqKCqH
         XOefB6ESQxFknvJeOvT266EnForDSORL8GFDkFaU=
Date:   Mon, 29 Jun 2020 14:53:59 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the nfsd tree
Message-ID: <20200629185359.GC2056@fieldses.org>
References: <20200627090317.48bf2578@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627090317.48bf2578@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:03:17AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   886c4fe8bdff ("nfsd4: fix nfsdfs reference count loop")
> 
> Fixes tag
> 
>   Fixes: 2c830dd720 ("nfsd: persist nfsd filesystem across mounts")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long

OK, should be fixed.--b.

>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
> 
> -- 
> Cheers,
> Stephen Rothwell



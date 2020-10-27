Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E43D29A3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 05:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505579AbgJ0E7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 00:59:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46756 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407863AbgJ0E7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 00:59:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXH4i-009eFc-5e; Tue, 27 Oct 2020 04:59:12 +0000
Date:   Tue, 27 Oct 2020 04:59:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20201027045912.GG3576660@ZenIV.linux.org.uk>
References: <20201027151414.2018d5fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027151414.2018d5fd@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 03:14:14PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs tree, today's linux-next build (sparc_defconfig)
> failed like this:
> 
> arch/sparc/lib/memset.S: Assembler messages:
> arch/sparc/lib/memset.S:149: Error: Unknown opcode: `ext(12b, 13b,21f)'
> 
> Caused by commit
> 
>   0e0bbae08a6e ("sparc32: switch __bzero() away from range exception table entries")
> 
> merging badly with commit
> 
>   7780918b3648 ("sparc32: fix a user-triggerable oops in clear_user()")
> 
> from the sparc tree.
> 
> The sparc tree commit above appears as commit
> 
>   80537bbf19d6 ("sparc32: fix a user-triggerable oops in clear_user()")
> 
> in the vfs tree as well.  The patch adds one line which is later removed
> by commit
> 
>   0e0bbae08a6e ("sparc32: switch __bzero() away from range exception table entries")
> 
> in the vfs tree, but the git merge puts the line back again :-(
> 
> I have added the following fix to the vfs tree merge

I'll rebase that branch on top of sparc tree tomorrow (and eventually I'd like
it to go through the sparc tree anyway).

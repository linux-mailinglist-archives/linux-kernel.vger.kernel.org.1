Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6392F09B7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbhAJUeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJUeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:34:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27813C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 12:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bzliTk+pD/abvOFgeWFHUrCNiv7v6oE0Jq+wzAicleU=; b=SmUMYOKtWwCu2E+oKe1i5FMDNi
        MgChyh5CNa1cnjeoeYccApfllv7qjfuA7oDlXFM7SIelYu5DnFupu3L2z5IrSTxEFKt9vu91R1J1k
        UFXFMpl6GG28hZEpM7B3cB0drbgp0DHkZFLFRIU8DMcErvaWcvZopV6+k/Z3GxXGQQpYinkM5QioJ
        7mJDbDIckSputPFqUKtgogkOHWizV3iVdX/LQwXhchjw/4xTGdUXgWPgkNEu+PW/kr5Ao2D0l6qaz
        iwUz4aciXbCOOcEq4Dq9lFj+TN3mO+hBfUOY78IuUZ8wx3H2UJPkKpI3Y8viID3lFSWTcPT8NmQFr
        MUrjSn8w==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kyhOu-0006HN-Rl; Sun, 10 Jan 2021 20:33:26 +0000
Subject: Re: [PATCH] scripts: mod: fix checkpatch.pl warnings
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>, masahiroy@kernel.org,
        michal.lkml@markovi.net
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20210110185702.111538-1-dwaipayanray1@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b11b1e50-bc2a-0037-1f51-fb69300206b1@infradead.org>
Date:   Sun, 10 Jan 2021 12:33:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210110185702.111538-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/10/21 10:57 AM, Dwaipayan Ray wrote:
> Fix the following warnings in file2alias reported by
> checkpatch:
> 
> CHECK: spaces preferred around that '*' (ctx:WxV)
> CHECK: spaces preferred around that '+' (ctx:VxV)
> CHECK: spaces preferred around that '-' (ctx:VxV)
> CHECK: spaces preferred around that '&' (ctx:VxV)
> CHECK: braces {} should be used on all arms of this statement
> CHECK: Unbalanced braces around else statement
> CHECK: Alignment should match open parenthesis
> CHECK: Logical continuations should be on the previous line
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Missing a blank line after declarations
> WARNING: please, no spaces at the start of a line
> WARNING: Block comments use a trailing */ on a separate line
> ERROR: spaces required around that '<' (ctx:VxV)
> ERROR: spaces required around that '=' (ctx:VxV)
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space prohibited before that close parenthesis ')'
> ERROR: code indent should use tabs where possible
> ERROR: "(foo*)" should be "(foo *)"
> 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
> 
> Note: The patch is compile tested only

Couldn't you at least do a kernel build that builds some
loadable kernel modules?

Also you could/should tell us if the before and after .o file
is the same and if not, why not.

> ll file2alias*
-rw-r--r-- 1 rdunlap users 39536 Jan 10 12:10 file2alias.o
-rw-r--r-- 1 rdunlap users 39536 Jan  8 10:06 file2alias.o.b4

> cmp file2alias*
>

Yes, they are the same.
 
>  scripts/mod/file2alias.c | 156 +++++++++++++++++++++------------------
>  1 file changed, 83 insertions(+), 73 deletions(-)


Looks OK to me.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy


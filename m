Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349F5299744
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgJZTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:44:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45272 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgJZTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:44:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id m14so1618606qtc.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZnYVCXpAdxGrITpeg/XVTk5Yy68LhIj/hc9zCI8ypk=;
        b=uGeZxrbKJi6sAOY7r8Tn8eofHKiRQfdpVT0GnYl/5gri+hoMA+6nTS4db4zc4DNNVd
         AF/bO9llDrW/i/WOaYI4/bLgzhsnNleyfOb8XUwrVLZmFWVEe7kRLDh7zd8IX/KLllOl
         cmkaFJfHWaDVWQB/R8q1b1DctxlfkXTRXynGWTD+ARycbLK9di9vnDjZmb8nboBI6tRF
         K5H70sqaEIO5VB3+kKwu06ZnO2gKiDoO5BXIYNEXthZxFCYM9lr0wcpkqiapN4UIcTcq
         dyOVR7s35zMMyZxX+Oa0UfLE6b9lNfIQvcPiFbQMFHnWF/tW6DJTipKqMjWILub2sTMK
         KFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZnYVCXpAdxGrITpeg/XVTk5Yy68LhIj/hc9zCI8ypk=;
        b=tCp/VMg0f/fA5yXhw/bapuYMfL6WtA8xqpde8VRMeowVO+BLp5NesQ05+ikMJTftwY
         pkBC+a8VWVREpYUZSvJU2Lvoco948KOW69D9lCSrCWgWI9cFURtlSjZR76ivMdF8gFSr
         q76B/yfOsEYGEeOL98eQnWNHLP9pfMAYGh6K5B2ADnexC6gMAAQR7JbQII3y0RmcxyRT
         IQes1+s/+waosuahbnpONrFd3RyRRNpbroN0KSA8if/Ev8T1FCw4MZlPCQ0dwVGIU+kT
         kdyM6i/QatLfDVhELOLSpD1PacINT3YBmONqe3aJcmiEEgSvPXmTz27Hy2ynA2/LoZEp
         bt8A==
X-Gm-Message-State: AOAM531+vvLGsHK0Y1HD9IHZfSqVwQgaSjh5HgCE2NVpc0QYHb2sHYLs
        bovtsIdyopFc3k+DYppxaBzCyJJ4ZkM=
X-Google-Smtp-Source: ABdhPJygnMN9Xs9zs5MNqgA1Pujx+ICimDfMyqNVnwOFTwjhGqttXktGFigCOyau3Gp1LJZAE03ymg==
X-Received: by 2002:aed:2338:: with SMTP id h53mr19116043qtc.127.1603741486093;
        Mon, 26 Oct 2020 12:44:46 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45d1:2600::3])
        by smtp.gmail.com with ESMTPSA id v5sm7068456qkv.89.2020.10.26.12.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:44:44 -0700 (PDT)
Date:   Mon, 26 Oct 2020 12:44:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
Message-ID: <20201026194443.GA2879078@ubuntu-m3-large-x86>
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
 <20201026193652.GA77796@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026193652.GA77796@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:36:52PM -0700, Guenter Roeck wrote:
> On Wed, Oct 21, 2020 at 07:36:07PM -0700, Joe Perches wrote:
> > Use a more generic form for __section that requires quotes to avoid
> > complications with clang and gcc differences.
> > 
> > Remove the quote operator # from compiler_attributes.h __section macro.
> > 
> > Convert all unquoted __section(foo) uses to quoted __section("foo").
> > Also convert __attribute__((section("foo"))) uses to __section("foo")
> > even if the __attribute__ has multiple list entry forms.
> > 
> > Conversion done using a script:
> > 
> > Link: https://lore.kernel.org/lkml/75393e5ddc272dc7403de74d645e6c6e0f4e70eb.camel@perches.com/2-convert_section.pl
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@gooogle.com>
> > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> 
> s390 (all builds):
> 
> Error log:
> error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
> make[2]: *** [arch/s390/boot/section_cmp.boot.preserved.data] Error 1
> make[2]: *** Waiting for unfinished jobs....
> error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
> make[2]: *** [arch/s390/boot/section_cmp.boot.data] Error 1
> make[1]: *** [bzImage] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [__sub-make] Error 2
> 
> Reverting this patch fixes the problem.
> 
> Guenter
> 

Seems like this should be fixed by commit 8e90b4b1305a ("s390: correct
__bootdata / __bootdata_preserved macros").

Cheers,
Nathan

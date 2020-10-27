Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCD29A486
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506366AbgJ0GP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506325AbgJ0GOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:14:43 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24B6D207C3;
        Tue, 27 Oct 2020 06:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603779282;
        bh=XC6lIUJAS7He2j6C5xHkSyH+j5s9PGRJjwy1abKG4QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFQh9AFzoK3oLzRuL3gGxYVWbJkUhUOc5XrjgGXy5vZ0eBvp078SO0YsT1JSOSX2P
         /DLUc8ner4GROw3STlQ9Wa4+oElHG4Iq16hSXU8dppi6pbh/WzIqbfJ/n2GbT4LJsJ
         Hbe7KHDgUcnHRmaDg7RIIzaPgE1E6ljlEIIQatZU=
Date:   Tue, 27 Oct 2020 07:14:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hui Su <sh_def@163.com>, rafael@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/hugetable.c: align some prints
Message-ID: <20201027061438.GA206502@kroah.com>
References: <20201009162359.GA19686@rlk>
 <cf3e63c8-836c-1112-c7da-ae375ac43b65@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3e63c8-836c-1112-c7da-ae375ac43b65@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:23:43PM -0700, Mike Kravetz wrote:
> On 10/9/20 9:23 AM, Hui Su wrote:
> > in old code, it shows like:
> > Node 0 ShmemHugePages:        0 kB
> > Node 0 ShmemPmdMapped:        0 kB
> > Node 0 FileHugePages:        0 kB
> > Node 0 FilePmdMapped:        0 kB
> > Node 0 HugePages_Total:     0
> > Node 0 HugePages_Free:      0
> > Node 0 HugePages_Surp:      0
> > 
> > which is not align. So we align it.
> > 
> > Signed-off-by: Hui Su <sh_def@163.com>
> 
> Apologies for the late reply.
> 
> I assume you you just want to make the output look better.  Correct?
> 
> To be honest, I am not sure about the policy for changing the output
> of sysfs files.  My preference would be to not change the output.  Why?
> When the output is changed there is always the possibility that someone
> may have written code that depends on the current format.  It looks like
> the output has been misaligned since the day the code was first written.
> 
> This code was recently changed to use sysfs_emit_at() instead of
> sprintf().  At that time Greg noted that this also violates the sysfs
> rule of one value per file.  So, it appears there may be a bigger issue
> than alignment.
> 
> Greg,
> Is it OK to break up these sysfs files to be one value per file if they
> contained multiple values from day 1 of their existence?  I would prefer
> not to touch them in case some is depending on current format.

You should create multiple files, with a different name, and then remove
this file.  Any tool that uses sysfs should be able to handle a file
going away, don't change the format of the data in the file, otherwise
there's no way for anyone to know what is happening.

thanks,

greg k-h

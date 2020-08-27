Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5404253C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 06:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgH0EA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 00:00:26 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:60686 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgH0EAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:00:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id F125429817;
        Thu, 27 Aug 2020 00:00:20 -0400 (EDT)
Date:   Thu, 27 Aug 2020 13:59:59 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k: Correct some typos in comments
In-Reply-To: <CAMuHMdW7eWtkUURxvAwAz6cAHABLBk4qs4bLUXR3wuowQbn5Fw@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2008271359390.53@nippy.intranet>
References: <f54e99e9bd1e25ad70a6a1d7a7ec9ab2b4e50d68.1595460351.git.fthain@telegraphics.com.au> <CAMuHMdW7eWtkUURxvAwAz6cAHABLBk4qs4bLUXR3wuowQbn5Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020, Geert Uytterhoeven wrote:

> > @@ -2654,7 +2654,7 @@ func_start        mmu_get_page_table_entry,%d0/%a1
> >         jne     2f
> >
> >         /* If the page table entry doesn't exist, we allocate a complete new
> > -        * page and use it as one continues big page table which can cover
> > +        * page and use it as one continuous big page table which can cover
> 
> Usually I use "contiguous", but the dictionary seems to permit both.
> 

Two or more things may be said to be "contiguous". I think this sentence 
refers to only one thing.

> >          * 4MB of memory, nearly almost all mappings have that alignment.
> >          */
> >         get_new_page
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k for-v5.10 branch.
> 

Thanks.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

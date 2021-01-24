Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953AB30192E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 03:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhAXCKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 21:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbhAXCJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 21:09:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FA3B229F0;
        Sun, 24 Jan 2021 02:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611454154;
        bh=NoOjEaGp85QcxUqBSDOe0ipjgea3PrHuHrnXFNVCOGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JupcgCB/e52p8vQoWbH826PMyiDiMnQ6vnNe1BbDf2dY+wnkR5tkKG2eCWovj16mg
         v9GqEW/1Lme9ZLgF+wRxV8qLFFFeMQyby0X3GdKKz03k2DKYNO7IKusRjn0EVhYInL
         RV/vFF0dvv2I1+m5dCnTh4jMCeap8kD7LytqMOAs=
Date:   Sat, 23 Jan 2021 18:09:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     rppt@kernel.org, guro@fb.com, iamjoonsoo.kim@lge.com,
        Ram Pai <linuxram@us.ibm.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        mhocko@kernel.org, riel@surriel.com
Subject: Re: [PATCH v2 2/2] memblock: do not start bottom-up allocations
 with kernel_end
Message-Id: <20210123180911.aafa8404a3a7a30779713456@linux-foundation.org>
In-Reply-To: <20210122043714.266075-1-bauerman@linux.ibm.com>
References: <20201220064959.GB392325@kernel.org>
        <20210122043714.266075-1-bauerman@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 01:37:14 -0300 Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:

> Mike Rapoport <rppt@kernel.org> writes:
> 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > 
> > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> I've seen a couple of spurious triggers of the WARN_ONCE() removed by this
> patch. This happens on some ppc64le bare metal (powernv) server machines with
> CONFIG_SWIOTLB=y and crashkernel=4G, as described in a candidate patch I posted
> to solve this issue in a different way:
> 
> https://lore.kernel.org/linuxppc-dev/20201218062103.76102-1-bauerman@linux.ibm.com/
> 
> Since this patch solves that problem, is it possible to include it in the next
> feasible v5.11-rcX, with the following tag?

We could do this, if we're confident that this patch doesn't depend on
[1/2] "mm: cma: allocate cma areas bottom-up"?  I think it is...

> Fixes: 8fabc623238e ("powerpc: Ensure that swiotlb buffer is allocated from low memory")

I added that.



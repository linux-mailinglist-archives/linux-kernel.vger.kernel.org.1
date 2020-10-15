Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06D28F0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgJOLRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:17:20 -0400
Received: from 8bytes.org ([81.169.241.247]:51998 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgJOLRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:17:19 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 26C4ADE1; Thu, 15 Oct 2020 13:17:18 +0200 (CEST)
Date:   Thu, 15 Oct 2020 13:17:12 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [git pull] IOMMU Updates for Linux v5.10
Message-ID: <20201015111711.GC3635@8bytes.org>
References: <20201013160353.GA19438@8bytes.org>
 <CAHk-=wirdKHYK_T=Pdx7eLP7z04P_q4zrT3uOod=dCWtmYPe8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wirdKHYK_T=Pdx7eLP7z04P_q4zrT3uOod=dCWtmYPe8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 12:15:55PM -0700, Linus Torvalds wrote:
> As a result, "git show" doesn't ever really understand the notion of a
> "merge conflict", and all it shows is really "whee, this end result
> looks like neither side" as a kind of pseudo-conflict diff.

Ah okay, that makes sense. Thanks for the explanation.

> Anyway, thanks for the describing the conflict, it was indeed not
> complicated, this email is just to explain your "but somehow git
> [show|log] didn't show it to me" thing.

Yeah, next time I try to get the diff before commiting the merge, that
probably works better. A diff is better than describing conflict
resolutions verbally.

Regards,

	Joerg

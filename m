Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120E42023FE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 15:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFTNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 09:46:36 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:58527 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFTNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 09:46:34 -0400
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 49pxm66YxDz17f6;
        Sat, 20 Jun 2020 09:46:30 -0400 (EDT)
Date:   Sat, 20 Jun 2020 06:46:27 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Christoph Hellwig <hch@lst.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
In-Reply-To: <20200619074233.GA3723@lst.de>
Message-ID: <alpine.DEB.2.22.394.2006200640370.2845@xps-7390>
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390> <20200619065007.GA3041@lst.de> <alpine.DEB.2.22.394.2006182351090.9276@xps-7390> <20200619074233.GA3723@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > Thing is, there's other examples of the previous version in the kernel tree- any
> > chance there's a usage conflict (Thunderbolt has a ROM in it, maybe something in
> > "probe_roms.c"? (Just guessing, no idea):

On Fri, 19 Jun 2020, Christoph Hellwig wrote:

> Maybe.  But nothing looks strange there.  Just to re-reconfirm, you had to
> revert "maccess: rename probe_kernel_address to get_kernel_nofault",
> "maccess: make get_kernel_nofault() check for minimal type compatibility"
> wasn't enough?

Yeah, the only commit I had to revert was this one. BUT:

> Below is a patch to do a "partial revert" for probe_roms.c.  I'd be
> totally surprised if it changes anything from staring at it for while,
> but anyway..

So, be totally surprised :) I've just booted with "maccess: rename
probe_kernel_address to get_kernel_nofault" intact and your probe_roms.c
patch with no issues.

(Perhaps there's some sort of compiler optimization going on?)

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA

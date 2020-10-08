Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE702870DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgJHImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:42:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:48872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgJHImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 101C0AD32;
        Thu,  8 Oct 2020 08:42:21 +0000 (UTC)
Date:   Thu, 8 Oct 2020 10:42:19 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] x86/head/64: Disable stack protection for
 head$(BITS).o
Message-ID: <20201008084219.GC3209@suse.de>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007195351.776555-6-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:53:51PM -0400, Arvind Sankar wrote:
> On 64-bit, the startup_64_setup_env() function added in
>   866b556efa12 ("x86/head/64: Install startup GDT")
> has stack protection enabled because of set_bringup_idt_handler().
> 
> At this point, %gs is not yet initialized, and this doesn't cause a
> crash only because the #PF handler from the decompressor stub is still
> installed and handles the page fault.

Hmm, that is weird. Can you please share your config with which this
happens? I have a commit in my local branch which disables page-faulting
in the pre-decompression code before jumping to the uncompressed kernel
image, and it did not break anything here.

Also, what compiler did you use to trigger this?


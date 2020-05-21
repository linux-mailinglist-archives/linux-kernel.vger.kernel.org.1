Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3AE1DD6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgEUTIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 15:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbgEUTIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:08:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E0E20814;
        Thu, 21 May 2020 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590088124;
        bh=38ZxvCyni0IynWfLRxWlOV469xNPk/DOr/nCoCNx9Zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aeZlVH+AhFDetfD9NqlUROeK9xxXibQIhbI3iwRwc1OhLgVgQByrGI+wUry8QFla1
         2h2veWD7JLxXV3wpAO0FhxRUCRFWF1otmCjXTsWUqQxE//E45+KtKQku73ZBSzVrbi
         65SxNcUGWTeMDmVX4Gv8uRX9qHuwBYbpEnhMXOw4=
Date:   Thu, 21 May 2020 12:08:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Jan Beulich <jbeulich@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/2] Fix W+X debug feature on x86
Message-Id: <20200521120843.427b7ff33f8ed7f824eb07f9@linux-foundation.org>
In-Reply-To: <20200521152308.33096-1-steven.price@arm.com>
References: <20200521152308.33096-1-steven.price@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 16:23:06 +0100 Steven Price <steven.price@arm.com> wrote:

> Jan alert me[1] that the W+X detection debug feature was broken in x86
> by my change[2] to switch x86 to use the generic ptdump infrastructure.
> 
> Fundamentally the approach of trying to move the calculation of
> effective permissions into note_page() was broken because note_page() is
> only called for 'leaf' entries and the effective permissions are passed
> down via the internal nodes of the page tree. The solution I've taken
> here is to create a new (optional) callback which is called for all
> nodes of the page tree and therefore can calculate the effective
> permissions.
> 
> Secondly on some configurations (32 bit with PAE) "unsigned long" is not
> large enough to store the table entries. The fix here is simple - let's
> just use a u64.

I assumed that a cc:stable was appropriate on both of these(?).

> I'd welcome testing (and other comments), especially if you have a
> configuration which previously triggered W+X warnings as I don't have
> such a setup.

I'll wait a while for such testing.  If nothing happens then I guess we
merge it up and see what then happens.


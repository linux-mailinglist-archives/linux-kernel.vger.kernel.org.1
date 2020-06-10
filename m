Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A601F5597
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgFJNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 09:20:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:37380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbgFJNUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:20:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3CECDAE64;
        Wed, 10 Jun 2020 13:20:08 +0000 (UTC)
Date:   Wed, 10 Jun 2020 15:20:03 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
Subject: Re: [RFC PATCH 7/7] objtool: Make unwind_hints available for all
 architectures
In-Reply-To: <20200608152754.2483-8-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2006101516310.26666@pobox.suse.cz>
References: <20200608152754.2483-1-jthierry@redhat.com> <20200608152754.2483-8-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On Mon, 8 Jun 2020, Julien Thierry wrote:

> Unwind hints are useful to give some information about the call frame
> or stack states in non-standard code.
> 
> Despite unwind hints being used in arch-independent code, the
> unwind_hint structure type itself is define in x86 kernel headers.
> 
> This is because what an unwind hint will describe is very architecture
> specific, both regarding the state and the affected registers.
> 
> To get to share this concept, expose the unwind_hint structure across
> architecutres. However, the hint types remain defined by the
> architecture code. Objtool then needs it's arch specific code to
> "decode" the unwind hint into a cfi_state.

I think it would be nice to split the patch. Something like.

1. current include/linux/frame.h mixes assembly and non-assembly 
definitions, so introduce ASSEMBLY ifdef first seems like a good idea to 
me.

2. move the relevant definitions to frame.h and add the file to 
sync-check

3. the rest of the patch

Would it make sense?

Otherwise, it looks good to me.

Miroslav

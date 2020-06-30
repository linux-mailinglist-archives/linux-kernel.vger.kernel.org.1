Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC540210050
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 01:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgF3XFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 19:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgF3XFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:05:50 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D0E20771;
        Tue, 30 Jun 2020 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593558349;
        bh=7wvKYJjHegtiIXQCxjX/XdD8dbA7iI59ejeA+RBNcZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DDUzWrCnPY63PbbQqYUZI8eKXAHLsP8zU/LU/eNbhO6Sme8sE1IzsrtZ/ZW9M1SzL
         kbAeXeXHtqp5PXiqPO5p3hMrunVLSDh1c2mFKiW8j3ojyGrczTue4/ANl/0pCpSx+p
         eqfvDP6Fzig4QnY395uv/ApFiMVLqz52piRtx+jA=
Date:   Tue, 30 Jun 2020 16:05:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/26] mm: Page fault accounting cleanups
Message-Id: <20200630160548.fc8d1f93148e74e544850bf3@linux-foundation.org>
In-Reply-To: <20200630211155.GA40675@xz-x1>
References: <20200630204501.38468-1-peterx@redhat.com>
        <20200630211155.GA40675@xz-x1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 17:11:55 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Tue, Jun 30, 2020 at 04:45:01PM -0400, Peter Xu wrote:
> > v4:
> > - rebase to linux-next/akpm
> > - picked one more r-b
> 
> I fixed some stuff in the send scripts but definitely broke something else on
> the chaining of the messages.  Andrew, please let me know if you want me to
> resend...  Sorry for that.

Well, the words

: Since v2 changed quite a lot from v1, changelog is omitted, and I also
: didn't have a chance to pick up any r-b in previous version.  I really
: appreciate anyone who has looked at v1.  V1 for reference:

make me think "not yet".  But this patchset is v4, so all confused.

I'm thinking we give this v4 a week for people to check it over, gather
up the revews and acks, incorporate the change suggested by David, redo
and double-check the cover letter then shoot for a v5?

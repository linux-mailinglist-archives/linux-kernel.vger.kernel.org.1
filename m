Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF62AB132
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 07:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgKIGYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 01:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgKIGYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 01:24:12 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AD7A206CB;
        Mon,  9 Nov 2020 06:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604903052;
        bh=cHnOJKkHVIaTzHEI+bYdGP0PeODU7wFkgjyizlQIPVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtcRlj+ZVRhT7Wl2ezNlbhfvLgtKIRq7mrnur2Eu1N8K3CBqnr+jjLwELgd9x/McQ
         dVBQhvMCVd2cX7EdHjuoqbmz/td2aqpkNRrmQdrxk6blX87oN+Zscz3QftR8yEWYQ+
         xvXsUdV5ZnnKOFhDfLrYyUsHxeeNZgWIf4mvUKto=
Date:   Mon, 9 Nov 2020 07:24:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/rt, powerpc: Prepare for PREEMPT_RT
Message-ID: <20201109062407.GA48938@kroah.com>
References: <1604893209-18762-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604893209-18762-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 11:40:08AM +0800, Wang Qing wrote:
> Add PREEMPT_RT output to die().

That says what you did, but not why you are doing this.

Why are you doing this?  That needs to go into the changelog text.

greg k-h

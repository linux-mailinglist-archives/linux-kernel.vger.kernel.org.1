Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3282AD0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgKJIJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJIJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:09:37 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4D020829;
        Tue, 10 Nov 2020 08:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604995777;
        bh=sy7QXvxUfH/3KiKO9Y6BbpTJBIkVN+fQSL9Hr6a0y/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K06u+zu3nrS01+JWe8jentZZLcazBwFJCjZuuCpV9CCCazEU0xPJ8j9z1QmWcuYGO
         AzHgwoesnsoHQ08Feh758/mm5qI/brMyTjUzM43H3xLpIl3mFX1wCGzHHxuyUMzmTS
         al5Wn734Pi2E1ZqceeT9DcpMTp7YbwWTRztjOviM=
Date:   Tue, 10 Nov 2020 09:10:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Michael Neuling <mikey@neuling.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH V2] sched/rt, powerpc: Prepare for PREEMPT_RT
Message-ID: <X6pK+oh3XuusGVFR@kroah.com>
References: <1604995368-29649-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604995368-29649-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 04:02:47PM +0800, Wang Qing wrote:
> PREEMPT_RT is a separate preemption model, CONFIG_PRTTMPT will

Minor typo on this line with your config option :(


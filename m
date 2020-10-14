Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1837C28DDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgJNJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:43:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgJNJnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:43:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C13BB11B;
        Wed, 14 Oct 2020 09:43:13 +0000 (UTC)
Date:   Wed, 14 Oct 2020 11:43:39 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Martin Doucha <mdoucha@suse.cz>
Cc:     ltp@lists.linux.it,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [LTP] [PATCH] syscalls/ptrace10: Add new regression test
Message-ID: <20201014094339.GB31816@yuki.lan>
References: <20200904180030.14838-1-chrubis@suse.cz>
 <6d9b6e46-8337-9614-8fd7-b6ada8fcbe13@suse.cz>
 <20200911153659.GA7234@yuki.lan>
 <eeeae258-d19b-eaaa-850e-6c6260b2447d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeeae258-d19b-eaaa-850e-6c6260b2447d@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > I would like to avoid triggering the "your system may be vunerable"
> > messages on fixed kernel, hence the separate test.
> 
> Good point, go ahead with a separate test then.

Thanks for the review, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz

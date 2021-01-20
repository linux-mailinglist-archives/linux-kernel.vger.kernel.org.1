Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD42FD1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbhATNGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbhATMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:18:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA5C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Njcta8Ohz/oM7v7FWjfeOMFSo3BmvtKn0QcTbNQ9Adc=; b=DG9t1eeuxA/jg5E9pnrVRn7tLG
        NYtYVMzPIpIRAJQ3Ps2gmnQrDwj0Egn7ZxHhJMD1VNU5EvCnhLm1Rz9FWS0RMOGJnLCXIC2ss46qC
        Kz0yb+3jUgW82BZwUCy7RLBK4zEBw5LFbmTi/TaVSohwVjC2VIFVB5UIfZHzH7308ef7gbmIDA5TC
        pIyq6AoDsQ8S9Adx1FWSgBZnQa1xvb2Y5+pKcfeNkntGxNNI1GeKv3D0h/M6z5NwWolzUzs81REJ6
        RwNyr2vYJH0xxIA2Qet5EF6qIRnC1R1I/y79g4dvi3D8iwwbJ7vuY3PAWfeeGKmD0pzP2o2YvFHf5
        vivsGl1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2CQ0-00Fe8s-P6; Wed, 20 Jan 2021 12:17:03 +0000
Date:   Wed, 20 Jan 2021 12:17:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Timur Tabi <timur@kernel.org>, Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        roman.fietze@magna.com, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <20210120121700.GJ2260413@casper.infradead.org>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <202101191135.A78A570@keescook>
 <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org>
 <YAf1lS8zsHwhShCr@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAf1lS8zsHwhShCr@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:19:17AM +0100, Petr Mladek wrote:
> And we should definitely add Linus into CC when sending v2.
> His expected opinion has been mentioned several times in this
> thread. It would be better to avoid these speculations
> and get his real opinion. IMHO, it is too late to add
> him in this long thread.

He was on the cc since the first mail in this thread.

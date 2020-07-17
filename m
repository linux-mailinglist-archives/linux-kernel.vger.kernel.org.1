Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABB223BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 14:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGQMz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 08:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgGQMz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:55:58 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C861620734;
        Fri, 17 Jul 2020 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594990558;
        bh=Y6XnGiof5mCpun2xOmNqnPCEUbw0B+sdJVBNATJLVRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KbPOrEdIMgRkcOfoUUB/exi1y9bWBx3Cr/Dh7CGuVI6ce96Oy3qZES6MWG8tGTkoX
         KYzf5uxoWEbW+7ghVrPfJmE/qVSjt1s8vv60iJ2fsNnTfIvXHD200DITJ/1PDW1aby
         CJofA4JOJCqw1VLq9z4CiQYThq5KKRAEOyqp5Xq0=
Date:   Fri, 17 Jul 2020 14:55:56 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/9] timer: Add comments about calc_index() ceiling work
Message-ID: <20200717125555.GB25465@lenoir>
References: <20200707013253.26770-1-frederic@kernel.org>
 <20200707013253.26770-3-frederic@kernel.org>
 <87tuyav4qx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuyav4qx.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:13:26AM +0200, Thomas Gleixner wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> >  static inline unsigned calc_index(unsigned expires, unsigned lvl)
> >  {
> > +	/*
> > +	 * Time may have past since the clock last reached an index of
> > +	 * this @lvl. And that time, below LVL_GRAN(@lvl), is going to
> > +	 * be substracted from the delta until we reach @expires. To
> > +	 * fix that we must add one level granularity unit to make sure
> > +	 * we rather expire late than early. Prefer ceil over floor.
> 
> This comment confuses the hell out of me.

Me too...

> 
>         /*
>          * The timer wheel has to guarantee that a timer does not fire
>          * early. Early expiry can happen due to:
>          * - Timer is armed at the edge of a tick
>          * - Truncation of the expiry time in the outer wheel levels
>          *
>          * Round up with level granularity to prevent this.
>          */
> 
> Hmm?

That's relieving, I'm updating the patch.

Thanks!


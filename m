Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A662B9809
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgKSQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgKSQde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:33:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E5I6TNShMUfYdB5NSaFer8UPB9kvSWVUKC2nL6ekt8I=; b=rBhQd/vYPRaUU9khhAK1P/vzwN
        0QSz/V9FnrDwTlPMSEdFlAfDcETw/jSC1ueRjA3MlxR7wELE0HOSL85kVY2NQYdAv1V/7zYZT1JQ0
        hCAkI4KkM2CohOxiZV1zivrD5d+txWDojEnMjwXPvPPISGe7+ByIrETQxow+GmnMNXTcdq8eat5iw
        8azSBslnfgKTnk3TRhi3928nyPfCqvi7tXd429g/GyTzEVxLJxXBts/lIDwuODyo2d25DdEl1UCto
        dQVSjdg9fyh5IeSsDsxr1mHEq1NSgSS2sYKqOEce8mC2XuIpWgIEdQQg6G/rwiS67vVoBfhfsJTPu
        UXTsVswg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfmsC-0006tp-TE; Thu, 19 Nov 2020 16:33:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF6713011C6;
        Thu, 19 Nov 2020 17:33:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AF002C36A0D3; Thu, 19 Nov 2020 17:33:27 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:33:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     paulmck@kernel.org, jlayton@redhat.com, willy@infradead.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Can you help diagnose a weird failed wake?
Message-ID: <20201119163327.GT3121392@hirez.programming.kicks-ass.net>
References: <2220347.1605801222@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2220347.1605801222@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:53:42PM +0000, David Howells wrote:

> 		timeo = wait_var_event_timeout(&cookie->stage, cookie_stage_changed(cookie, stage), 10*HZ);

> 			cookie->stage = stage;                                                              
> 			changed = true;                                                                    
> 			break;                                                                              
> 		}                                                                                          
> 		spin_unlock(&cookie->lock);                                                                
> 		if (changed) {                                                                              

smp_mb(); // see comment on wake_up_bit() / wakequeue_active()

> 			wake_up_var(&cookie->stage);                                                        



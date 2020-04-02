Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349EB19C831
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbgDBRjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 13:39:47 -0400
Received: from mail.monom.org ([188.138.9.77]:50030 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388677AbgDBRjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:39:47 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 41E13500590;
        Thu,  2 Apr 2020 19:39:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (b9168fb3.cgn.dg-w.de [185.22.143.179])
        by mail.monom.org (Postfix) with ESMTPSA id BBB0B50050F;
        Thu,  2 Apr 2020 19:39:44 +0200 (CEST)
Date:   Thu, 2 Apr 2020 19:39:44 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RT 2/3] irq_work: Fix checking of IRQ_WORK_LAZY flag set
 on non PREEMPT_RT
Message-ID: <20200402173944.jmztz4vjsepjreye@beryllium.lan>
References: <20200331163453.805082089@goodmis.org>
 <20200331163513.674653275@goodmis.org>
 <20200402172248.GA12483@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402172248.GA12483@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Thu, Apr 02, 2020 at 07:22:49PM +0200, Pavel Machek wrote:
> I'm currently playing with 4.4.X branch, but I'll eventually test it.
> 
> Is it possible that 4.4.X branch needs similar patch? My code review
> suggests so...

I was waiting for Steven to post the final patch. I'll pick it up for
the next v4.4-rt release.

Thanks,
Daniel

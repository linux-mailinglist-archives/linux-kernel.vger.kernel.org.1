Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CF329A992
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898074AbgJ0K0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:26:11 -0400
Received: from mail.monom.org ([188.138.9.77]:54444 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898032AbgJ0K0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:26:04 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id CE53550046C;
        Tue, 27 Oct 2020 11:25:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 8B7F9500299;
        Tue, 27 Oct 2020 11:25:47 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:25:47 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201027102547.y6wop7j2ovzg2tyx@beryllium.lan>
References: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
 <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
 <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:00:49AM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-27 10:36:16 [+0100], Daniel Wagner wrote:
> > On Sat, Oct 24, 2020 at 11:18:38AM +0200, Sebastian Andrzej Siewior wrote:
> > > I'm pleased to announce the v5.9.1-rt19 patch set. 
> > 
> > FWIW, all tests pass in my lab (by avoiding doing the same stupid
> > mistake as last time...)
> 
> glad to hear.

Well, one thing I need to figure out is how to get pi_stress working
correctly on my machines (that is for all -rt trees, so it's nothing
new). It consistently triggers RCU stall warnings with hackbench as
workload. Clark told me the test only works if there are enough CPUs to
run on. Need to look into it.

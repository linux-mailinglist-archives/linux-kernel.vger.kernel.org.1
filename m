Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584082B9281
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgKSMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:18:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgKSMSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:18:05 -0500
Received: from localhost (unknown [176.167.53.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD872224E;
        Thu, 19 Nov 2020 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605788284;
        bh=KHq+av0erckkSGo2Wxd/+KMT06c++ZpkBRbwRwRGlxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsHjAmCjhp908eOurJ4tCBHUDqDkIopOM//kRiZmD+8aHp6P18/7SBWo54oQXi5bA
         QYwWvJV99mn0dfBZTrELgOz/3hI/7vQIv272qLfYEucWfeq/N/4aEnG4vQQGoFMn16
         sE6sud7/uhKrdamVS26I1fPe8wsNZ7Fqu4bm0LqI=
Date:   Thu, 19 Nov 2020 13:18:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch 12/19] softirq: Add RT specific softirq accounting
Message-ID: <20201119121801.GA20115@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.096224353@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113141734.096224353@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 03:02:19PM +0100, Thomas Gleixner wrote:
> RT requires the softirq to be preemptible and uses a per CPU local lock to
> protect BH disabled sections and softirq processing. Therefore RT cannot
> use the preempt counter to keep track of BH disabled/serving.
> 
> Add a RT only counter to task struct and adjust the relevant macros in
> preempt.h.

You may want to describe a bit the reason for this per task counter.
It's not intuitive at this stage.

Thanks.

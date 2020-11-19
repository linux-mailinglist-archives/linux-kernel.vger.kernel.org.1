Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0672B9AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgKSSeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgKSSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:34:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F50CC0613CF;
        Thu, 19 Nov 2020 10:34:15 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605810853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9LDV9DN46jTGHcNLZEidsgCE0mx3aWoCChrRjZhE+0=;
        b=eFNOblJtBE6bhSiDQe9j2/Qm+8xlNxAVdDFXKgDlhFpHoBgxg00f0vDDbjW7sre963LnD8
        FAPLxQ2idf7Q4Ft5OfUOHO6eRvN+rSnn83fIN36Zq6Kiotc+07M0RwuKOXHmkL64Q+oqtx
        TuZen67fPQUg50mEkV/MWM52ab5TNupoZ1XMPoH5kBTO03MaSIPfTf7QLnuhzhFpva/1OW
        T9f5dG2ocNZBIEp0bL5LR/izCuKD662zWPu6Md5OvM/za9USwtWINMS0pq2juzJgo6Tmw2
        JFOTp93S60OL5jIjiv2FEIuMh5MJ5iJ5gLd6cuWn/uz0Y49CmZQKL8UBCJYKWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605810853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9LDV9DN46jTGHcNLZEidsgCE0mx3aWoCChrRjZhE+0=;
        b=GsxTwjmINkc0jisnLRXDARATrVl2X02mGOqPKy1NA0W7K156yE6kX6p9nMO1eFEQfRRJn/
        0gAvTQKhyJrz5HBg==
To:     Frederic Weisbecker <frederic@kernel.org>
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
In-Reply-To: <20201119121801.GA20115@lothringen>
References: <20201113140207.499353218@linutronix.de> <20201113141734.096224353@linutronix.de> <20201119121801.GA20115@lothringen>
Date:   Thu, 19 Nov 2020 19:34:13 +0100
Message-ID: <87ima1p55m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19 2020 at 13:18, Frederic Weisbecker wrote:
> On Fri, Nov 13, 2020 at 03:02:19PM +0100, Thomas Gleixner wrote:
>> RT requires the softirq to be preemptible and uses a per CPU local lock to
>> protect BH disabled sections and softirq processing. Therefore RT cannot
>> use the preempt counter to keep track of BH disabled/serving.
>> 
>> Add a RT only counter to task struct and adjust the relevant macros in
>> preempt.h.
>
> You may want to describe a bit the reason for this per task counter.
> It's not intuitive at this stage.

Something like this:

 RT requires the softirq processing and local bottomhalf disabled regions
 to be preemptible. Using the normal preempt count based serialization is
 therefore not possible because this implicitely disables preemption.

 RT kernels use a per CPU local lock to serialize bottomhalfs. As
 local_bh_disable() can nest the lock can only be acquired on the
 outermost invocation of local_bh_disable() and released when the nest
 count becomes zero. Tasks which hold the local lock can be preempted so
 its required to keep track of the nest count per task.

 Add a RT only counter to task struct and adjust the relevant macros in
 preempt.h.

Thanks,

        tglx

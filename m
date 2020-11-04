Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECBA2A632E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgKDLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:19:53 -0500
Received: from mail.monom.org ([188.138.9.77]:34932 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgKDLTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:19:51 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id E92D0500609;
        Wed,  4 Nov 2020 12:19:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 83C9D500596;
        Wed,  4 Nov 2020 12:19:48 +0100 (CET)
Date:   Wed, 4 Nov 2020 12:19:48 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 11:46:17AM +0100, Sebastian Andrzej Siewior wrote:
> How reproducible are these numbers? If these numbers increase between
> rt3 and rt4 then we have a hand full patches to look at.

Usually signaltest generated reproducible results.

I did see those higher numbers also for v5.10-rc1-rt1 (forgot to post
those). For arm64 the max latency was even higher, around 450us. But I
don't have a lot of data so I wouldn't jump to any conclusion.

> just like that?

Yes, Just fired up signaltest 5 times for arm64 and x86_64 with the
latest release. Keep you posted.

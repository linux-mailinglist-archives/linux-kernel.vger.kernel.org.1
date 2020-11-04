Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C176B2A61FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgKDKiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:38:15 -0500
Received: from mail.monom.org ([188.138.9.77]:34606 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbgKDKiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:38:13 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 76987500609;
        Wed,  4 Nov 2020 11:38:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 18F2F500596;
        Wed,  4 Nov 2020 11:38:10 +0100 (CET)
Date:   Wed, 4 Nov 2020 11:38:09 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 08:57:31PM +0100, Sebastian Andrzej Siewior wrote:
> I'm pleased to announce the v5.10-rc2-rt4 patch set.

All tests on passed in my lab. On arm64 and arm I saw slightly higher
max latency values for signaltest and sigwaittest. Usually they are
below 200us but currently I see up to 350us.

BTW, x86_64 also showed slightly higher numbers for signaltest for the
v5.10-rc1-rt1 release. These are gone now.

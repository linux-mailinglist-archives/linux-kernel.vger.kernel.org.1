Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5E240690
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHJN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 09:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgHJN3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:29:46 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53ADA20729;
        Mon, 10 Aug 2020 13:29:45 +0000 (UTC)
Date:   Mon, 10 Aug 2020 09:29:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] v4.4.231-rt202
Message-ID: <20200810092943.69739f41@oasis.local.home>
In-Reply-To: <20200808140638.GA26582@zipoli.concurrent-rt.com>
References: <159559806551.29587.13643956941367278015@beryllium>
        <3732c1c4-36d4-2cdc-677a-cb58a9507df1@suse.de>
        <20200727151033.7c37df2b@oasis.local.home>
        <20200808140638.GA26582@zipoli.concurrent-rt.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Aug 2020 10:06:38 -0400
Joe Korty <joe.korty@concurrent-rt.com> wrote:

> Ping?

Yes yes, we even discussed this in our last meeting. I'm just trying to
get time to work on it, as the merge window is open and Plumber's is
just around the corner, it's taking a bit longer than expected.

-- Steve


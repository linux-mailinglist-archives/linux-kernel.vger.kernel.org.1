Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871B61B4C82
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 20:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDVSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgDVSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:12:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBACC03C1AA;
        Wed, 22 Apr 2020 11:12:35 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRJrM-0006NN-SH; Wed, 22 Apr 2020 20:12:32 +0200
Date:   Wed, 22 Apr 2020 20:12:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.4-rt3
Message-ID: <20200422181232.a33sfm6udmy2zcvy@linutronix.de>
References: <20200416164510.kbrklqahdng5uhij@linutronix.de>
 <20200422173359.inlikfugjzsjyyp6@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422173359.inlikfugjzsjyyp6@beryllium.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-22 19:33:59 [+0200], Daniel Wagner wrote:
> Hi Sebastian,

Hi Daniel,

> On Thu, Apr 16, 2020 at 06:45:10PM +0200, Sebastian Andrzej Siewior wrote:
> > I'm pleased to announce the v5.6.4-rt3 patch set.
> 
> Finally solved my lab setup issue (NFS wants to use TCP per default now) and
> all looks good. The fallout on rt-tests-migrate was a configuration bug on my
> side. All rt-tests work and pass on my three system (Beaglebone Black 32bit,
> RPi3 64bit and old x86_64 Core2 Duo CPU E8400 box in 64bit mode).

So there is no backtrace of any kind in any configuration (bug or no
bug)?

> The only thing I've observed was higher latency numbers in sigwaittest but
> that could be anything.
> 
> Thanks,
> Daniel

Sebastian

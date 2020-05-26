Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD4D1B4BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 19:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgDVReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 13:34:05 -0400
Received: from mail.monom.org ([188.138.9.77]:46254 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:34:04 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id DA8E750047C;
        Wed, 22 Apr 2020 19:33:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (b9168f17.cgn.dg-w.de [185.22.143.23])
        by mail.monom.org (Postfix) with ESMTPSA id 8291B50029E;
        Wed, 22 Apr 2020 19:33:59 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:33:59 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.4-rt3
Message-ID: <20200422173359.inlikfugjzsjyyp6@beryllium.lan>
References: <20200416164510.kbrklqahdng5uhij@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416164510.kbrklqahdng5uhij@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Apr 16, 2020 at 06:45:10PM +0200, Sebastian Andrzej Siewior wrote:
> I'm pleased to announce the v5.6.4-rt3 patch set.

Finally solved my lab setup issue (NFS wants to use TCP per default now) and
all looks good. The fallout on rt-tests-migrate was a configuration bug on my
side. All rt-tests work and pass on my three system (Beaglebone Black 32bit,
RPi3 64bit and old x86_64 Core2 Duo CPU E8400 box in 64bit mode).

The only thing I've observed was higher latency numbers in sigwaittest but
that could be anything.

Thanks,
Daniel

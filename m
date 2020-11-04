Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72802A64A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgKDMru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:47:50 -0500
Received: from mail.monom.org ([188.138.9.77]:35638 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgKDMrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:47:49 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 3CAF4500609;
        Wed,  4 Nov 2020 13:47:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id EA25B500596;
        Wed,  4 Nov 2020 13:47:46 +0100 (CET)
Date:   Wed, 4 Nov 2020 13:47:46 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201104124746.74jdsig3dffomv3k@beryllium.lan>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:19:48PM +0100, Daniel Wagner wrote:
> Yes, Just fired up signaltest 5 times for arm64 and x86_64 with the
> latest release. Keep you posted.

arm64
  1184  0_signaltest         t0-max-latency      : fail     386.00
  1185  0_signaltest         t0-max-latency      : fail     417.00
  1186  0_signaltest         t0-max-latency      : fail     350.00
  1187  0_signaltest         t0-max-latency      : fail     360.00
  1188  0_signaltest         t0-max-latency      : fail     339.00

I noticed that also the last view 5.9-rt releases have higher values.
For example, version 5.9.0-rc8-rt12 has only 217us.

x86_64
  1189  0_signaltest         t0-max-latency      : fail      50.00
  1190  0_signaltest         t0-max-latency      : pass      46.00
  1191  0_signaltest         t0-max-latency      : pass      45.00
  1192  0_signaltest         t0-max-latency      : pass      47.00
  1193  0_signaltest         t0-max-latency      : fail      52.00

Same thing for version 5.9.0-rc8-rt12, the max value was 40us.

I'll work on getting these reports more useful, the performance trend
seems to be an interesting metric.

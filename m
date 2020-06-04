Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF531EED50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 23:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgFDV3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 17:29:25 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:32068 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgFDV3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:29:25 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id 4A88A203BF;
        Fri,  5 Jun 2020 00:29:23 +0300 (MSK)
Date:   Fri, 5 Jun 2020 00:29:23 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: schedutil issue with serial workloads
Message-ID: <alpine.LNX.2.20.13.2006042341160.3984@monopod.intra.ispras.ru>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a question/bugreport about behavior of schedutil on serial workloads
such as rsync, or './configure', or 'make install'. These workloads are
such that there's no single task that takes a substantial portion of CPU
time, but at any moment there's at least one runnable task, and overall
the workload is compute-bound. To run the workload efficiently, cpufreq
governor should select a high frequency.

Assume the system is idle except for the workload in question.

Sadly, schedutil will select the lowest frequency, unless the workload is
confined to one core with taskset (in which case it will select the
highest frequency, correctly though somewhat paradoxically).

This sounds like it should be a known problem, but I couldn't find any
mention of it in the documentation.

I was able to replicate the effect with a pair of 'ping-pong' programs
that get a token, burn some cycles to simulate work, and pass the token.
Thus, each program has 50% CPU utilization. To repeat my test:

gcc -O2 pingpong.c -o pingpong
mkfifo ping
mkfifo pong
taskset -c 0 ./pingpong 1000000 < ping > pong &
taskset -c 1 ./pingpong 1000000 < pong > ping &
echo > ping

#include <stdio.h>
#include <unistd.h>
int main(int argc, char *argv[])
{
	unsigned i, n;
	sscanf(argv[1], "%u", &n);
	for (;;) {
		char c;
		read(0, &c, 1);
		for (i = n; i; i--)
			asm("" :: "r"(i));
		write(1, &c, 1);
	}
}

Alexander

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C562EB70B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbhAFAtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbhAFAtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:49:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4F79206C0;
        Wed,  6 Jan 2021 00:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894130;
        bh=cmtHQdH/BwSt/OLpSq6NGhscjkN8So2xnhuaaBLevvA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=k4jJjcQretAfmVRlbtJStdDfHGv6cfAX8i0oVtpxcaVQdzYNGws0TwjLCMRCHy4LZ
         LolLLWj6VraAH3mA3mnR5tZD5UEsICmBXP8wzTTm2sWrjCln86xzIrcgAb1yfKwq7A
         aVEUL+xtlBjwy9oDvQ9rO/UauzXYJ0gsMvXX5j35niII9z1eUip+GrUhfSWXZf0/6E
         ohNE9Cchd36NBHRj6l0j85kgGHr9pyST0SsuQgViCPk9mqp+G8LiqPp7a0bqMhuv9p
         pTsAsrKevXJXqYiyBy5q8Mxnq49NHNGSNiM24+yyZAoxxJWczhVHvZuC1Uo5OSAdWO
         AwkrIW+qAM7cg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 80A8835228C6; Tue,  5 Jan 2021 16:48:50 -0800 (PST)
Date:   Tue, 5 Jan 2021 16:48:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com,
        paul.gortmaker@windriver.com, kernel-team@fb.com
Subject: [PATCH RFC cpumask] Allow "all", "none", and "last" in cpumask
 strings
Message-ID: <20210106004850.GA11682@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series allows "all", "none", and "last" to be used in cpumask
strings.  This allows these strings to be less dependent on the underlying
system.  For example, currently a string specifying all but the first
CPU must be "1-7" on an eight-CPU system and "1-15" on a 16-CPU system.
With this series, the single string "1-last" can be used regardless of the
number of CPUs (at least assuming that each system has at least one CPU).

1.	Un-inline cpulist_parse for SMP; prepare for ascii helpers,
	courtesy of Paul Gortmaker.

2.	Make "all" alias global and not just RCU, courtesy of Paul
	Gortmaker.

3.	Add a "none" alias to complement "all", courtesy of Paul
	Gortmaker.

4.	Add "last" alias for cpu list specifications, courtesy of Paul
	Gortmaker.

5.	Use "all" and "last" in "nohz_full" and "rcu_nocbs".

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.rst            |   20 +
 Documentation/admin-guide/kernel-parameters.txt            |    4 
 include/linux/cpumask.h                                    |    8 
 kernel/rcu/tree_plugin.h                                   |   13 -
 lib/cpumask.c                                              |  136 ++++++++++++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot |    2 
 7 files changed, 169 insertions(+), 16 deletions(-)

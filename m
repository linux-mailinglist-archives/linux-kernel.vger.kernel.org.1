Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99382FE872
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbhAULLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:11:24 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49282 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbhAULIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:08:51 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10LB7tpV024188;
        Thu, 21 Jan 2021 12:07:55 +0100
Date:   Thu, 21 Jan 2021 12:07:55 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210121110754.GB24174@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
 <jhjzh1235yr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjzh1235yr.mognet@arm.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:05:48AM +0000, Valentin Schneider wrote:
> This lets me run the following invocation without a hitch:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs "4*SRCU-P" --trust-make
> 
> where before I would get some errors building the initrd due to missing
> __NR_foo.
> 
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thank you Valentin! Much appreciated!

Willy

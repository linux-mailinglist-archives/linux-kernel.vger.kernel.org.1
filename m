Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70BA2FECCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbhAUOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:22:04 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49285 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbhAUOTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:19:03 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10LEI9x2024211;
        Thu, 21 Jan 2021 15:18:09 +0100
Date:   Thu, 21 Jan 2021 15:18:09 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210121141809.GC24174@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
 <20210121111117.GA48431@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121111117.GA48431@C02TD0UTHF1T.local>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:11:17AM +0000, Mark Rutland wrote:
> So FWIW:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]

Perfect, thanks! Paul, may I let you copy-paste the tested-by yourself ?
If you prefer I'm fine with resending a series to you, I just don't want
to needlessly spam you :-)

> It would be great if this could be applied soon so that it's possible to
> use the rcutorture scripts without applying local hacks.

Makes sense. I was wondering, should we mark them for stable ? I don't
know if anyone relies on these tests to validate stable kernels in
fact.

> Willy, thanks for sorting this out, especially so quickly!

You're welcome, and thanks to you for the detailed report and explanations.

Willy

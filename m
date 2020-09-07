Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7D25FE1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgIGQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 12:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbgIGQGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:06:08 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E789217A0;
        Mon,  7 Sep 2020 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494765;
        bh=MX45q2m7qh994ROtuyt5MU6DaDgz4N6Reb6POmo/2G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2m4lHfImU5a5YqjC3joHC+2Mx7eRAsK5kTwTZZpOnIJtoAhkaQYzFNCkG/AkI0SAr
         3Usegs6LbaIxLHFaTKRQSrQcfzSXASEw2ZaMWDPtbl8qV88RYPkAtyRNq70IBoCvfL
         v/R9KpgnjjWeLsKGFcZfqJ/cYnk5QL6mjH+jYX9M=
From:   Will Deacon <will@kernel.org>
To:     james.morse@arm.com, Yue Hu <zbestahu@gmail.com>,
        Dave.Martin@arm.com, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: traps: Add str of description to panic() in die()
Date:   Mon,  7 Sep 2020 17:05:40 +0100
Message-Id: <159947519699.559245.1839869613903040353.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804085347.10720-1-zbestahu@gmail.com>
References: <20200804085347.10720-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 16:53:47 +0800, Yue Hu wrote:
> Currently, there are different description strings in die() such as
> die("Oops",,), die("Oops - BUG",,). And panic() called by die() will
> always show "Fatal exception" or "Fatal exception in interrupt".
> 
> Note that panic() will run any panic handler via panic_notifier_list.
> And the string above will be formatted and placed in static buf[]
> which will be passed to handler.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: traps: Add str of description to panic() in die()
      https://git.kernel.org/arm64/c/b4c971245925

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

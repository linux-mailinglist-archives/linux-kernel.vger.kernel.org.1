Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96BA29F58C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgJ2Trl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJ2Trj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:47:39 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68FE20727;
        Thu, 29 Oct 2020 19:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604000859;
        bh=OLlL22ROQ8H9aoFZu++uTtV5Tdd5I9l+ZNwd7xWy4mo=;
        h=Date:From:To:Cc:Subject:From;
        b=kPZMGM6lMqZX5Yj/z9yEy3foR5HrSrVf7ZINWnvBn70rZ9nC3u8EnMHK4BjQ/YeaV
         yNpjN0JzKv7xN2kG+IzkgBAetnp3dhqgrYKFz7oaEPAur0gHhUnb/y6dF0NrotSg+6
         QqttacQY19nqqqa4QpZt/orJOc9s4hoIRnJaJcog=
Date:   Thu, 29 Oct 2020 13:47:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for Clang for 5.10-rc2
Message-ID: <20201029184702.GA10611@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.10-rc2

for you to fetch changes up to 4169e889e5889405d54cec27d6e9f7f0ce3c7096:

  include: jhash/signal: Fix fall-through warnings for Clang (2020-10-29 13:17:58 -0500)

----------------------------------------------------------------
fallthrough fixes for Clang for 5.10-rc2

Hi Linus,

Please, pull the following patch that fixes almost 40,000 fall-through
warnings when building Linux 5.10-rc1 with Clang 12.0.0 and this[1]
change reverted. Notice that in order to enable -Wimplicit-fallthrough
for Clang, such change[1] is meant to be reverted at some point. So,
this patch helps to move in that direction.

- include: jhash/signal: Fix fall-through warnings for Clang

[1] commit e2079e93f562c ("kbuild: Do not enable -Wimplicit-fallthrough for clang for now")

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      include: jhash/signal: Fix fall-through warnings for Clang

 include/linux/jhash.h  | 2 ++
 include/linux/signal.h | 2 ++
 2 files changed, 4 insertions(+)

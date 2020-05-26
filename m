Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3276A1A319B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgDIJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 05:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgDIJN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:13:27 -0400
Received: from linux-8ccs (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB1A20A8B;
        Thu,  9 Apr 2020 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586423607;
        bh=aKSM79BkmxP5Uhkn0jXZmlAGRE85asa04JTnqLZ24V4=;
        h=Date:From:To:Cc:Subject:From;
        b=XMFAzdOjxs+WiA+TYbEFQU7Y4Peb0unmh8Uost7iKEpwIQzhqTh9NZb5DQedX1nuL
         GlnK3DjCCw+WCEtK1qstSarl6rDqf8qS88wSJa2zq9se7wtYB2yIZOyQ5HqyjBLFtj
         G1/qVuWN72/kKO0vDQEZQsMq5Z3G50/72qL+/kKE=
Date:   Thu, 9 Apr 2020 11:13:23 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.7
Message-ID: <20200409091323.GC26619@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the 5.7 merge window.
Only a small cleanup this time around.

Thanks,

Jessica

---
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.7

for you to fetch changes up to 0f74226649fb2875a91b68f3750f55220aa73425:

  kernel: module: Replace zero-length array with flexible-array member (2020-02-17 21:40:55 +0100)

----------------------------------------------------------------
Modules updates for v5.7

Summary of modules changes for the 5.7 merge window:

- Trivial zero-length array to flexible-array cleanup

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      kernel: module: Replace zero-length array with flexible-array member

 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

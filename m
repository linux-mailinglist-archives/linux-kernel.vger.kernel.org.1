Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB219FD0C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDFSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 14:24:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57950 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgDFSYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:24:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9E96D15DADD1E;
        Mon,  6 Apr 2020 11:24:10 -0700 (PDT)
Date:   Mon, 06 Apr 2020 11:24:10 -0700 (PDT)
Message-Id: <20200406.112410.1593839462932058.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] IDE
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Apr 2020 11:24:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As usual, very quiet in this subsystem.  Just a
list_for_each_entry_safe() conversion.

Please pull, thanks a lot!

The following changes since commit bef7b2a7be28638770972ab2709adf11d601c11a:

  Merge tag 'devicetree-for-5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2020-04-02 17:32:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 78a515f9faf3af43cf9c4f61254dd1c5b3cb2d0b:

  drivers/ide: Fix build regression. (2020-04-04 18:07:59 -0700)

----------------------------------------------------------------
David S. Miller (1):
      drivers/ide: Fix build regression.

chenqiwu (1):
      drivers/ide: convert to list_for_each_entry_safe()

 drivers/ide/ide-scan-pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7142C12F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgKWSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgKWSOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:14:33 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86BAC204FD;
        Mon, 23 Nov 2020 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606155273;
        bh=LXh1b+vIL6VC1SJbTVJPWm/iAsmWuQW9UQbdX/CRZe4=;
        h=Date:From:To:Cc:Subject:From;
        b=l9kJjGZG7kgtoPzbzQPZSDHBrudL5Q4f6Yze8+32Ifog36L4zEunMbUDDmtVdzt3b
         moksugz0HczckRRVNlPDqXK+G3MYYchpq16DNKLYHYhwEz7KLjooIwIDzlDu+m/Ro3
         05FvYoGSFfmYEGggzOAyKlGdVMMUjiXfY9vkUw8o=
Date:   Mon, 23 Nov 2020 20:14:29 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.10-rc6
Message-ID: <20201123181429.GA11733@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains a single small fix for 5.10-rc6. Details are in
the tag.

Thanks,
Oded

The following changes since commit ef3f0caf243075ac255b69054cbf48b65eadb0d4:

  Merge tag 'icc-5.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus (2020-11-23 17:35:57 +0100)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-11-23

for you to fetch changes up to 652b44453ea953d3157f02a7f17e18e329952649:

  habanalabs/gaudi: fix missing code in ECC handling (2020-11-23 20:08:43 +0200)

----------------------------------------------------------------
This tag contains the following habanalabs driver fix for 5.10-rc6:

- Add missing statements and break; in case switch of ECC handling. Without
  this fix, the handling of that interrupt will be erroneous.

----------------------------------------------------------------
Oded Gabbay (1):
      habanalabs/gaudi: fix missing code in ECC handling

 drivers/misc/habanalabs/gaudi/gaudi.c | 2 ++
 1 file changed, 2 insertions(+)

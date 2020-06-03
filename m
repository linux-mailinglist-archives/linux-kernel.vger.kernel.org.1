Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03D41ED742
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 22:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFCUUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:20:30 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC0BC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 13:20:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jgZsB-002eaq-Iz; Wed, 03 Jun 2020 20:20:27 +0000
Date:   Wed, 3 Jun 2020 21:20:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] [regression fix] uaccess.csum ia64 braino
Message-ID: <20200603202027.GB23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 001c1a655f0a4e4ebe5d9beb47466dc5c6ab4871:

  default csum_and_copy_to_user(): don't bother with access_ok() (2020-05-29 16:11:50 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.csum

for you to fetch changes up to 174e1ea8a2f6140078b6c61068b478cf3c4aa74f:

  fix a braino in ia64 uaccess csum changes (2020-06-03 16:18:09 -0400)

----------------------------------------------------------------
Al Viro (1):
      fix a braino in ia64 uaccess csum changes

 arch/ia64/lib/csum_partial_copy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

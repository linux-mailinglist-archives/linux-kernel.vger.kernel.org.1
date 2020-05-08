Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70C1CB18E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgEHOSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 10:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgEHOSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:18:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E615424956;
        Fri,  8 May 2020 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588947490;
        bh=dalLpG2qXUyifTblLMB27QL5WmDLpxUMYVlIpkzVgdI=;
        h=Date:From:To:Cc:Subject:From;
        b=XlLSTX2tzk42FA3Bdt2GbPcehjovY7FjHocDjy4OEv+kDJRDddhl07qUXcMd4kD+7
         ai6nMwOcSHt9Fm9AwfWVQnh7A7pCJCjniu4YsCwxM7XJp/s5siLH+sPKGJlgn7VMGl
         IwWUtz4zGTduGpd5GvJ70bS27nGPXOqhwVAhhg3o=
Date:   Fri, 8 May 2020 16:18:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.7-rc5
Message-ID: <20200508141807.GA353767@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.7-rc5

for you to fetch changes up to 769acc3656d93aaacada814939743361d284fd87:

  staging: gasket: Check the return value of gasket_get_bar_index() (2020-05-05 12:36:05 +0200)

----------------------------------------------------------------
Staging driver fixes for 5.7-rc5

Here are 3 small driver fixes for 5.7-rc5.

Two of these are documentation fixes:
	- MAINTAINERS update due to removed driver
	- removing Wolfram from the ks7010 driver TODO file
The other patch is a real fix:
	- fix gasket driver to proper check the return value of a call

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Lukas Bulwahn (1):
      MAINTAINERS: remove entry after hp100 driver removal

Oscar Carter (1):
      staging: gasket: Check the return value of gasket_get_bar_index()

Wolfram Sang (1):
      staging: ks7010: remove me from CC list

 MAINTAINERS                          | 5 -----
 drivers/staging/gasket/gasket_core.c | 4 ++++
 drivers/staging/ks7010/TODO          | 1 -
 3 files changed, 4 insertions(+), 6 deletions(-)

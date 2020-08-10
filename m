Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1058F240CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgHJS3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 14:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgHJS3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:29:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC0F207FF;
        Mon, 10 Aug 2020 18:29:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k5CXc-0071W2-W2; Mon, 10 Aug 2020 14:29:00 -0400
Message-ID: <20200810182836.746909615@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 10 Aug 2020 14:28:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-linus][PATCH 0/2] ktest: A couple more updates before asking for a pull request
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: ff131efff141fc679cccde28bc265f4c79cbe329


Colin Ian King (1):
      ktest.pl: Fix spelling mistake "Cant" -> "Can't"

Steven Rostedt (VMware) (1):
      ktest.pl: Change the logic to control the size of the log file emailed

----
 tools/testing/ktest/ktest.pl | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

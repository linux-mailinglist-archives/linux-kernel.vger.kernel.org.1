Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A136F2DE797
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgLRQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgLRQqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:46:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC9323A9F;
        Fri, 18 Dec 2020 16:45:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kqIsc-0019Wf-9Z; Fri, 18 Dec 2020 11:45:22 -0500
Message-ID: <20201218164442.597085865@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Dec 2020 11:44:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-linus][PATCH 0/2] ktest.pl: A couple of fixes for sending email results
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt (VMware) (2):
      ktest.pl: If size of log is too big to email, email error message
      ktest.pl: Fix the logic for truncating the size of the log file for email

----
 tools/testing/ktest/ktest.pl | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

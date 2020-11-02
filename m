Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646892A3496
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKBTwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:52:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgKBTvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:51:13 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98ADF20731;
        Mon,  2 Nov 2020 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346672;
        bh=D/QMXjFWc/Q7A4ZDxUVj8ORBmj5yG+trUK4Sfex4NCA=;
        h=From:To:Cc:Subject:Date:From;
        b=s1ZfRRTLflQHzsTlOuGDd3248ZjJeVXQpKd/VIMJeRJz4c12D7/E/48iQF2kQxVXi
         Cfg9TIBqHjYmu6RpNPGdXnYOGs2ZmfCRn8hQFZoctrXT164fPI6urZH8b/Z7uEKOsf
         tCrRqUSEkXOjFiCNyiO1MxZnNz24NALXWH909uuY=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/2] selftests/x86: Minor fixes
Date:   Mon,  2 Nov 2020 11:51:09 -0800
Message-Id: <cover.1604346596.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two bugs fixed.

Andy Lutomirski (2):
  selftests/x86/fsgsbase: Fix GS == 1, 2, and 3 tests
  selftests/x86: Add missing .note.GNU-stack sections

 tools/testing/selftests/x86/fsgsbase.c              | 12 ++++++++++--
 tools/testing/selftests/x86/raw_syscall_helper_32.S |  2 ++
 tools/testing/selftests/x86/thunks.S                |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D22535A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHZRAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 13:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgHZRAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:00:49 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A974206F0;
        Wed, 26 Aug 2020 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598461248;
        bh=RnU9Q4Xdz50gqo0uAJq7I+ukQjkaoJk+xgR9olQlcJA=;
        h=From:To:Cc:Subject:Date:From;
        b=mZvfBceBaSCEYkYoJDFbtl85vsrqwMgaWcB9R68IGJPppz9ULwB/faWycTcNNEupC
         +BHAm6D5rRLAJOwbVsINhHWj9QhLcOqxd0uk+7I0oRZZnw+UM6ZNX5OwpqfSaiMgD4
         JjH74naDARNp0cHiZLdBej/h0OzPN+bgPcB080TI=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/2] selftests/x86: fsgsbase test updates
Date:   Wed, 26 Aug 2020 10:00:44 -0700
Message-Id: <cover.1598461151.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a minor bug and adds a test for the recent NULL pointer
dereference.

Andy Lutomirski (2):
  selftests/x86/fsgsbase: Reap a forgotten child
  selftests/x86/fsgsbase: Test PTRACE_PEEKUSER for GSBASE with invalid
    LDT GS

 tools/testing/selftests/x86/fsgsbase.c | 68 ++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

-- 
2.25.4


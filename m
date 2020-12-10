Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893E42D50E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgLJCeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgLJCeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:34:25 -0500
From:   Stephen Boyd <sboyd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] SPMI queue for next merge window
Date:   Wed,  9 Dec 2020 18:33:40 -0800
Message-Id: <20201210023344.2838141-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply these SPMI patches for the next merge window.
I've collected the few patches that were ready and setup a git
tree on kernel.org to push them to.

Hsin-Hsiung Wang (1):
  spmi: Add driver shutdown support

Mauro Carvalho Chehab (2):
  spmi: get rid of a warning when built with W=1
  spmi: fix some coding style issues at the spmi core

Stephen Boyd (1):
  MAINTAINERS: Mark SPMI as maintained

 MAINTAINERS          |  6 ++++--
 drivers/spmi/spmi.c  | 19 ++++++++++++++-----
 include/linux/spmi.h |  1 +
 3 files changed, 19 insertions(+), 7 deletions(-)


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


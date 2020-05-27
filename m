Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE841E481D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgE0Pr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 11:47:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgE0Pr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:47:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C55962A3AAF
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/4] futex: Minor code improvements
Date:   Wed, 27 May 2020 12:47:43 -0300
Message-Id: <20200527154747.36931-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series aims to make some small code improvements that I found in
futex.c, removing some lines and trying to make the code easier to read
and understand.

All commits tested with futex tests from kselftest.

André Almeida (4):
  futex: Remove put_futex_key()
  futex: Remove needless goto's
  futex: Remove unused or redundant includes
  futex: Consistently use fshared as boolean

 kernel/futex.c | 115 +++++++++++--------------------------------------
 1 file changed, 26 insertions(+), 89 deletions(-)

-- 
2.26.2


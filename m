Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF09202AB2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 15:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgFUNUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 09:20:24 -0400
Received: from foss.arm.com ([217.140.110.172]:40274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgFUNUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:20:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D05DC0A;
        Sun, 21 Jun 2020 06:20:22 -0700 (PDT)
Received: from e110176-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 498CA3F71F;
        Sun, 21 Jun 2020 06:20:21 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ofir Drang <ofir.drang@arm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 0/3] fixes and update to essiv support
Date:   Sun, 21 Jun 2020 16:20:11 +0300
Message-Id: <20200621132011.7966-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small fixes and adapt essiv support to the new template format

---
Changes from v1:
- Incorporate coding style fixes suggested by Markus Elfring.

Gilad Ben-Yossef (3):
  crypto: ccree: fix resource leak on error path
  crypto: ccree: adapt ccree essiv support to kcapi
  crypto: ccree: remove unused field

 drivers/crypto/ccree/cc_cipher.c | 149 ++++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 41 deletions(-)

-- 
2.27.0


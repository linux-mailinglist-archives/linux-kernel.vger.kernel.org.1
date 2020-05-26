Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46C1BA274
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 13:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD0LgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 07:36:21 -0400
Received: from foss.arm.com ([217.140.110.172]:34144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0LgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:36:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD24C1FB;
        Mon, 27 Apr 2020 04:36:20 -0700 (PDT)
Received: from ssg-dev-vb.arm.com (E111385.Arm.com [10.50.65.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 632BB3F73D;
        Mon, 27 Apr 2020 04:36:17 -0700 (PDT)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hadar Gat <hadar.gat@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>
Subject: [PATCH v3 0/3] hwrng: cctrng kconfig updates
Date:   Mon, 27 Apr 2020 14:36:01 +0300
Message-Id: <1587987364-4566-1-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fixes in Kconfig for cctrng:
 + add missing dependency on OF
 + change default to 'n'
 + improve inaccurate help description

v3 change: fixed compilation issue
v2 changes:
  + remove unneeded depends on HW_RANDOM.
  + remove unneeded line 'default n' in order to follow the convention.
  + in help description changed to: If unsure, say 'N'

Hadar Gat (3):
  hwrng: cctrng - Add dependency on OF
  hwrng: cctrng - change default to n
  hwrng: cctrng - update help description

 drivers/char/hw_random/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4


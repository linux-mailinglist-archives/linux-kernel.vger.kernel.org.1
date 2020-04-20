Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B91B06CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 12:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDTKnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 06:43:49 -0400
Received: from foss.arm.com ([217.140.110.172]:46388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTKnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:43:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732EF1FB;
        Mon, 20 Apr 2020 03:43:48 -0700 (PDT)
Received: from ssg-dev-vb.arm.com (unknown [10.57.26.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 646EC3F73D;
        Mon, 20 Apr 2020 03:43:46 -0700 (PDT)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>
Subject: [PATCH] MAINTAINERS: sort field names for CCTRNG
Date:   Mon, 20 Apr 2020 13:43:33 +0300
Message-Id: <1587379413-12361-1-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch that added this entry in MAINTAINERS was applied only
after Linus had sort all fields in it.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82a9d3d..d550582 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3898,10 +3898,10 @@ CCTRNG ARM TRUSTZONE CRYPTOCELL TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
 M:	Hadar Gat <hadar.gat@arm.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
+W:	https://developer.arm.com/products/system-ip/trustzone-cryptocell/cryptocell-700-family
 F:	drivers/char/hw_random/cctrng.c
 F:	drivers/char/hw_random/cctrng.h
 F:	Documentation/devicetree/bindings/rng/arm-cctrng.txt
-W:	https://developer.arm.com/products/system-ip/trustzone-cryptocell/cryptocell-700-family
 
 CEC FRAMEWORK
 M:	Hans Verkuil <hverkuil-cisco@xs4all.nl>
-- 
2.7.4


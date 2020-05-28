Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4276F1E685B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405431AbgE1RJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 13:09:41 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:43177 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405408AbgE1RJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:09:38 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 8441592B4F;
        Thu, 28 May 2020 17:09:32 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 49XvM02CXjz3V8x;
        Thu, 28 May 2020 17:09:32 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id 3486217562; Thu, 28 May 2020 17:09:32 +0000 (UTC)
From:   Ed Maste <emaste@freefall.freebsd.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ed Maste <emaste@freebsd.org>, Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        acme@kernel.org
Subject: [RESEND PATCH v2] perf tools: correct license on jsmn json parser
Date:   Thu, 28 May 2020 17:08:59 +0000
Message-Id: <20200528170858.48457-1-emaste@freefall.freebsd.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20191213154625.41064-1-emaste@FreeBSD.org>
References: <20191213154625.41064-1-emaste@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

This header is part of the jsmn json parser, introduced in 867a979a83.
Correct the SPDX tag to indicate that it is under the MIT license.

Signed-off-by: Ed Maste <emaste@freebsd.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/pmu-events/jsmn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jsmn.h b/tools/perf/pmu-events/jsmn.h
index c7b0f6ea2a31..1bdfd55fff30 100644
--- a/tools/perf/pmu-events/jsmn.h
+++ b/tools/perf/pmu-events/jsmn.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: MIT */
 #ifndef __JSMN_H_
 #define __JSMN_H_
 
-- 
2.24.0


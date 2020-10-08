Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B602870FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgJHI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:57:33 -0400
Received: from ns.lineo.co.jp ([203.141.200.203]:38806 "EHLO mail.lineo.co.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgJHI5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:57:33 -0400
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2020 04:57:33 EDT
Received: from [172.31.78.0] (unknown [203.141.200.204])
        by mail.lineo.co.jp (Postfix) with ESMTPSA id 4DEDE80535E2B;
        Thu,  8 Oct 2020 17:47:50 +0900 (JST)
From:   Naoki Hayama <naoki.hayama@lineo.co.jp>
Subject: [PATCH 6/6] scripts/spelling.txt: Add "arbitrary" typo
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>
Message-ID: <6bf6520d-787d-5749-09b5-ff92185f501f@lineo.co.jp>
Date:   Thu, 8 Oct 2020 17:47:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "abitrary||arbitrary".

Signed-off-by: Naoki Hayama <naoki.hayama@lineo.co.jp>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index feb2efaaa5e6..a77b628e3af0 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -9,6 +9,7 @@
 #
 abandonning||abandoning
 abigious||ambiguous
+abitrary||arbitrary
 abitrate||arbitrate
 abnornally||abnormally
 abnrormal||abnormal
-- 
2.17.1

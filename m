Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637A2868C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgJGUBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:01:09 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJGUBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:01:09 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1JJC-1kNUSg3JWM-002rQe; Wed, 07 Oct 2020 22:00:56 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH 1/4] timens: additional helper function to add boottime in nsec
Date:   Wed,  7 Oct 2020 22:00:12 +0200
Message-Id: <20201007200015.30868-2-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
References: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WYc3jloml7nVrvQBGg4/G77uhYgCNwcjwVNBu9it2LaLpFpSzHJ
 e94r98U0nNlAIB6LMnGIHWg8WKwQ5kdCxnwSU4FXjkBjHPhowr0ZLqwctorkdJQex38JVIE
 NuxJB1VRhMiK+33HtAEuNyhOxZzfnbZRTjEcja4jB7ELwqg/BprqON7jnxSx9tlgkj/GU3E
 yo+tqHooIPSPrECqP278g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R6J8+SfrVpc=:vcnkzEnZdKgfIkO/GWAzNX
 nDR9ilMS0wlHnHpzof1z4KyfAQjN4InisGs94Flu1jvTmImOu1gUZOGM1yeElsb69SS6j6nV5
 HIjahxZTNSg5Bpj6MBPUxLt6chOSCRlvIN+cj9fzm+YwJLb8WadnKPZchuGN7UMt5M1P6Mfb1
 fRXjXG7YR8ev9McomO4FFtR/BrUJsKHVGVa7g9motBFp/H3kTOSk5RcUuGXuvFacTmsTT/lqU
 p1ywFrmaa3X9l8rm2zwTyqrS00U9As/g8u0S2EI+JBu3Vxw9ySB2yFmw6kXDXPHyrwWt7VRx0
 Zht3e8Q744Lc7clS6aGIn5hzAPMS2ME75prS3E4H5vDr3qAnGOhYK9m8NCmb59fyF0Z1lRYKs
 K7Y1rjDmtVbiR3BOJ0ZfDruREUZMkKTAeB1cw9ofW7TmlzqYDouy/MitQAjdD6muqjkoYRxYB
 1BwwPvxeKXqwE0qO/uehangUwoGx+S0BnFVZi0ji9Auv1cH3P+EH/lkSfYQaAj6Hxge05Mkhf
 LvdvzkT+1khzZhR6q1cCObw2F5r/u7O4qWKUgqJnuFMTf5pDTmXsziPDM3dntaM0qju2laRdP
 tlFQpB/YBb1GlIyt2BvqEoTSVX2qbKG99MPwXG8Ka0agsnaHZohnl+oVwpY/t2pPfck4S8+nC
 eMEAVLHai0kXsHCR7J7YbOJMyEUiB5B3MAMXIjE4Qg5LTRk0mm1Xe7XWxxDdqvlL5N0RagHzO
 Tku7azp9CKy24ri8gaB7qu+X/KE6au9WxeEx1gL94zpWlbV6ziT3NlQNmbFHQy47oaxEowFXH
 idHuzvrevE9zlzPX3BYwAcnGFJRKuHCK7FhoYxMJog6kUEFFxMBTB0eDXAyuzJEQIfxl28JQW
 tujYOzFx2rg2xu2zmaHA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a helper function to apply the boottime offset to u64 types
in nanoseconds.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/time_namespace.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 5b6031385db0..db02ec7dae8a 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -77,6 +77,13 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 	*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+static inline u64 timens_add_boottime_ns(u64 nsec)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	return nsec + timespec64_to_ns(&ns_offsets->boottime);
+}
+
 ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
 				struct timens_offsets *offsets);
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8326C26D980
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIQKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgIQKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:48:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:48:50 -0700 (PDT)
Message-Id: <20200917094202.301694311@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600339719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rAiXVu2/80mEDZ2pxbkyXmr9RtaH8aUHBfRtOj6YGGI=;
        b=KKVohBAXsBpEYESGlFngdoRJlYiOAGH3f/UwPPEiD5vHfz2uAWXshdoEfu7eQCNjtXQ+UA
        HyyyA5/nk+phI1IOKPBv3+/W7kXMJpSbijq99I6sZOVlTRPY1dpDmaQNBH16Kh6oiqfPhv
        W4SHvjAFJsGT9iZhgzTDnvMZSFdUqXGxC2t+piuGiYuR15DDlkYJobRi7KJ6J21gMj4w2E
        gVxTsdZch17yFY3ZfNRi6QDGe3oW6KKFv1kpCa+Y10vX2YiVY10UrmHsXQ6uIHrtAnults
        w6r7Jk4Dq8b6ENMV7isMhv6AuUKtmn9Bf0D4PywQj570Wwy2KTNKlMxh5efSgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600339719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rAiXVu2/80mEDZ2pxbkyXmr9RtaH8aUHBfRtOj6YGGI=;
        b=MgV5vY60ehR/NADlVDExQfq5z+5o1fe/cekduxWXm84M+iWEXRGa4Zbn9XNQp+slnIGgYp
        luMsymjHbE65hJDw==
Date:   Thu, 17 Sep 2020 11:42:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [patch 00/10] sched: Migrate disable support for RT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gUlQgZW5hYmxlZCBrZXJuZWxzIG1vc3Qgb2YgdGhlIGNvZGUgaW5jbHVkaW5nIHNwaW4vcncg
bG9jayBoZWxkIHNlY3Rpb25zCmFyZSBwcmVlbXB0aWJsZSwgd2hpY2ggYWxzbyBtYWtlcyB0aGUg
dGFza3MgbWlncmF0ZWFibGUuIFRoYXQgdmlvbGF0ZXMgdGhlCnBlciBDUFUgY29uc3RyYWludHMu
IFJUIG5lZWRzIHRoZXJlZm9yZSBhIG1lY2hhbmlzbSB0byBjb250cm9sIG1pZ3JhdGlvbgppbmRl
cGVuZGVudCBvZiBwcmVlbXB0aW9uLgoKVGhpcyBzZXJpZXMgaXMgcHJvdmlkaW5nIGEgbW9zdGx5
IHJld3JpdHRlbiB2ZXJzaW9uIG9mIHRoZSBSVCBjb2RlIGJhc2VkIG9uCnRoZSBuZXdlc3Qgc2No
ZWR1bGVyIGJpdHMgYW5kIGluY2x1ZGVzIGFuZCBkZXBlbmRzIG9uIFBldGVyJ3MgJ2xldCB0YXNr
cwpraWNrIHRoZW1zZWxmIG9mZiB0aGUgb3V0Z29pbmcgQ1BVJyBmZWF0dXJlLgoKV2hpbGUgbWln
cmF0ZSBkaXNhYmxlL2VuYWJsZSBhcmUgdHJpdmlhbCBpbiBwcmluY2lwbGUgdGhlIHRyaWNreSBw
YXJ0IGlzCnRoZSBjb29yZGluYXRpb24gYW5kIHNlcmlhbGl6YXRpb24gYWdhaW5zdCBjb25jdXJy
ZW50IGFmZmluaXR5IGNoYW5nZXMsCmUuZy4gc2NoZWRfc2V0YWZmaW5pdHkoMiksIGFuZCBDUFUg
aG90cGx1Zy4KClRoYW5rcywKCgl0Z2x4Cg==

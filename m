Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87142B700A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKQU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:28:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQU2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:28:32 -0500
Message-Id: <20201117202333.869470686@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605644910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HIsDjyXeSLNWc9myZP2CX9aTSUUuBu9+OX3PukPNpBU=;
        b=FG2IAC4brZfwgtuDJxHNa+2yayXz4baTqTda+vPWEjEUXym7LR2hWzjQFvoVlqZG9Z7xf+
        VG8Iq5sukJ1fKteneTRreabeUwPcWhhePBnXgyIIFTW19HMg+QL8Grz1uGxpIy6+X98qVP
        U4nSQeRvHu3ZZuPN6rKyrSDSYyZdZo5MiJ/Bb8MgvP9nbD6LmuxvkXJT5NmhZQD18K+soD
        r6zB2QUPJrS+CGfF+Q3Nrpht8lNLGgKnBGFKgNt3xYDDT+dlazMfPF+M9x+OVPWGTeYlvs
        lcazUsHaNNKWYb/lk29FH58ugD6LsUcsPcTiIuD662cFOZmQAAzgV4dEWbv6eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605644910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HIsDjyXeSLNWc9myZP2CX9aTSUUuBu9+OX3PukPNpBU=;
        b=ZS4I/54shUyhwEEItaNpy5a2joXkWkjrbgX88+oojcgTQU+/3yFx+T/Ji2O/rcKXIXOzLN
        bkM2OU3ysNdam8DQ==
Date:   Tue, 17 Nov 2020 21:23:33 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Mark Mossberg <mark.mossberg@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Jann Horn <jannh@google.com>, kyin@redhat.com
Subject: [patch v2 0/2] x86/dumpstack: Prevent access to foreign tasks user space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB0aGUgc2Vjb25kIHZlcnNpb24gb2YgdGhlIHBhdGNoIHRvIHByZXZlbnQgYWNjZXNz
IHRvIGEgZm9yZWlnbgp0YXNrcyB1c2VyIHNwYWNlIGluIGNvcHlfY29kZSgpLiBJdCBhZGRyZXNz
ZXMgdGhlIHJldmlldyBjb21tZW50cyBmcm9tCkJvcmlzIGFuZCBhZGRzIGEgbmV3IHBhdGNoIHdo
aWNoIHByb3ZpZGVzIGRvY3VtZW50YXRpb24gZm9yCmNvcHlfZnJvbV91c2VyX25taSgpIHRvIGF2
b2lkIGZ1cnRoZXIgY29uZnVzaW9uIGFib3V0IGl0J3MgdXNhZ2UuCgpWMSBjYW4gYmUgZm91bmQg
aGVyZToKCiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzg3YmxmeHg4cHMuZnNmQG5hbm9zLnRl
Yy5saW51dHJvbml4LmRlCgpUaGFua3MsCgoJdGdseAoKCg==

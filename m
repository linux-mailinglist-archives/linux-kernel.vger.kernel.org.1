Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804D62CF2C8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbgLDRKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:10:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgLDRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:29 -0500
Message-Id: <20201204170151.960336698@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607101787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iBxCCLNEjEdz1puiqLIODUIGst9hCV4CFnNIpRx7mxg=;
        b=RsacuS6Cc5XdjjUpYV7VDzKBZQ5ret73dBrpjOm8oJtYE+tV2WWKkQbUry6rKaOMYa34rT
        iL8KGLNNxGsfsKd0GUd06+Hy2gWrOFvkfrku3nVjSwIWkcG4XReS4R60HdKaUn7+f1AHMf
        yeWF2MDIqFvRDneYZObREVdBrGwLAkU9COwMDYmWtTnvlVGhCN1ZM93AtNyzOPv4mxdpSr
        V5RYvqcR4IHDMAJfY64WtwJNx3X6yURicGZ2X5w43asDFPl11/2eFhY2r95ZHwdAKkAQPD
        40iev9npCzv9k8rj0MQcEsL+3/zp9mk9HV3QMKNGgiAJTtAPiNBedgqhjVyRKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607101787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iBxCCLNEjEdz1puiqLIODUIGst9hCV4CFnNIpRx7mxg=;
        b=xu8T0QWVorpmfaNC/ql1fcw4GFi8mwTsOu2gFO6bQNXYZ5byFZQnpxrpC9HBvnaGjh9FhL
        eomNnJdXBaIk6gBQ==
Date:   Fri, 04 Dec 2020 18:01:51 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 0/9] softirq: Make it RT aware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UlQgcnVucyBzb2Z0aXJxIHByb2Nlc3NpbmcgYWx3YXlzIGluIHRocmVhZCBjb250ZXh0IGFuZCBp
dCByZXF1aXJlcyB0aGF0CmJvdGggdGhlIHNvZnRpcnEgZXhlY3V0aW9uIGFuZCB0aGUgQkggZGlz
YWJsZWQgc2VjdGlvbnMgYXJlIHByZWVtcHRpYmxlLgoKVGhpcyBpcyBhY2hpZXZlZCBieSBzZXJp
YWxpemF0aW9uIHRocm91Z2ggcGVyIENQVSBsb2NhbCBsb2NrcyBhbmQKc3Vic3RpdHV0aW5nIGEg
ZmV3IHBhcnRzIG9mIHRoZSBleGlzdGluZyBzb2Z0aXJxIHByb2Nlc3NpbmcgY29kZSB3aXRoCmhl
bHBlciBmdW5jdGlvbnMuCgpUaGUgc2VyaWVzIGFwcGxpZXMgb24gdG9wIG9mCgogIGdpdDovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90aXAvdGlwLmdpdCBpcnEvY29y
ZQoKd2hpY2ggYWxyZWFkeSBjb250YWlucyB0aGUgaXJxc3RhdCBjbGVhbnVwcyBhbmQgRnJlZGVy
aWMncyBpcnEgdGltZQphY2NvdW50aW5nIGNoYW5nZXMuCgpDaGFuZ2VzIHRvIFYxIHdoaWNoIGNh
biBiZSBmb3VuZCBoZXJlOgoKICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAxMTEzMTQw
MjA3LjQ5OTM1MzIxOEBsaW51dHJvbml4LmRlCgogLSBSZWJhc2Ugb24gdG9wIG9mIEZyZWRlcmlj
J3MgaXJxIHRpbWUgYWNjb3VudGluZyBjaGFuZ2VzCiAtIEFkZHJlc3NpbmcgdGhlIHJldmlldyBj
b21tZW50cwogLSBGaXhpbmcgdGhlIGZhbGxvdXQgZnJvbSB0aGUgaXJxIHRpbWUgYWNjb3VudGlu
ZyB1cGRhdGVzCgpUaGUgUlQgdmFyaWFudCBoYXMgc3VjZXNzZnVsbHkgYmVlbiB0ZXN0ZWQgaW4g
dGhlIGN1cnJlbnQgNS4xMC1ydApwYXRjaGVzLiBGb3Igbm9uLVJUIGtlcm5lbHMgdGhlcmUgaXMg
bm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpUaGFua3MsCgoJdGdseAotLS0KIGluY2x1ZGUvbGludXgv
Ym90dG9tX2hhbGYuaCB8ICAgIDggKwogaW5jbHVkZS9saW51eC9oYXJkaXJxLmggICAgIHwgICAg
MSAKIGluY2x1ZGUvbGludXgvaW50ZXJydXB0LmggICB8ICAgMTMgLS0KIGluY2x1ZGUvbGludXgv
cHJlZW1wdC5oICAgICB8ICAgIDYgCiBpbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmggICAgfCAgICAz
IAogaW5jbHVkZS9saW51eC9zY2hlZC5oICAgICAgIHwgICAgMyAKIGtlcm5lbC9zY2hlZC9jcHV0
aW1lLmMgICAgICB8ICAgIDQgCiBrZXJuZWwvc29mdGlycS5jICAgICAgICAgICAgfCAgMjgwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiBrZXJuZWwvdGltZS90
aWNrLXNjaGVkLmMgICAgfCAgICAyIAogOSBmaWxlcyBjaGFuZ2VkLCAyOTEgaW5zZXJ0aW9ucygr
KSwgMjkgZGVsZXRpb25zKC0pCgoK

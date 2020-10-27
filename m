Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E657829A957
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897699AbgJ0KQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:16:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897686AbgJ0KQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:16:29 -0400
Message-Id: <20201027100949.181320853@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603793787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mrQLtTTAm136gR3sk3u5E9tLELNknAC/xlx21X4aXc4=;
        b=KR4O1HHtzc2r7gW9CL6pwxe3YLAF8u+mVV26knOs5qpI5yiZ0SScxAOY+R0SQEXDdJOIri
        UcBSw1IIQSo6QBnBppXNIvd0oj/RCLjMKFKHiQblcGVxAP7ZEB5fUpLbRmFzqa1ZMXz4FM
        gMo8Qdo8Pri+/PUmsFWpYNKtGNhN70DZLILYtpGzh2p+bExqameDlrw8v7arjcIK4eSPGx
        exD+W0iujI5EGg12aX4BS86dnE3AtvsOp4s0dtKaNJnDOZzESE70jMw4wXaQtIIT27/lXv
        6fzCYs51Z30qev1m3ZIonPex/X3jir9y/vRtUTx8HGup9/Aj7kLgoq3UAz8pUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603793787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mrQLtTTAm136gR3sk3u5E9tLELNknAC/xlx21X4aXc4=;
        b=v/zcQb6qNHGWs3ohZtSDXd5g80kHL5kXR1zeaZZ8nLszRUjDsYB7baGY4Fit3slUYIFoI8
        EMA03OU1dA6zLdDg==
Date:   Tue, 27 Oct 2020 11:09:49 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 0/2] x86/fpu: Make fpu_lock() RT compliant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RlBVIHNlcmlhbGl6YXRpb24gdXNlcwoKICAgIHByZWVtcHRfZGlzYWJsZSgpOyBsb2NhbF9iaF9k
aXNhYmxlKCk7Cgp3aGljaCBpcyBzaWxseSBiZWNhdXNlIGxvY2FsX2JoX2Rpc2FibGUoKSBpbXBs
aWNpdGx5IGRpc2FibGVzCnByZWVtcHRpb24uIFNvIHRoaXMgY2FuIGJlIHJlZHVjZWQgdG8gbG9j
YWxfYmhfZGlzYWJsZSgpLgoKQnV0IHRoaXMgZG9lcyBub3Qgd29yayBvbiBSVCBrZXJuZWxzIGJl
Y2F1c2UgbG9jYWxfYmhfZGlzYWJsZSgpIG9ubHkKc2VyaWFsaXplcyBib3R0b20gaGFsZiByZWxh
dGVkIHByb2Nlc3NpbmcgdmlhIGEgbG9jYWwgbG9jaywgYnV0IGRvZXMgbm90CmRpc2FibGUgcHJl
ZW1wdGlvbi4KCk9uIFJUIGtlcm5lbHMgcHJlZW1wdF9kaXNhYmxlKCkgaXMgdGhlIHJpZ2h0IGNo
b2ljZSBiZWNhdXNlIG9uIFJUIGJvdHRvbQpoYWxmIHByb2Nlc3NpbmcgaXMgYWx3YXlzIGluIHRo
cmVhZCBjb250ZXh0LCBzbyBwcmVlbXB0X2Rpc2FibGUoKQppbXBsaWNpdGx5IHByb3RlY3RzIGFn
YWluc3QgYm90dG9tIGhhbGYgcHJvY2Vzc2luZyB0aGVyZS4KClRoYW5rcywKCgl0Z2x4Cgo=

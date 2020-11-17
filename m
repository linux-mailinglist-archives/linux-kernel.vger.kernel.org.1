Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80372B674A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgKQOYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48746 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:14 -0500
Message-Id: <20201117131942.515430545@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605623052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SxIWC5IZJPbNDPJ9GcOv4uPsKCs93p4x0BLT+1i0zpI=;
        b=TkfAeM27ZT+k4CHSTIUU8aQpTGpCv1gyog3+45ttar3avnwbn4k533cd7RPZESJTZVvZms
        zkhwEU56yF33wt+tbKan9bVnVOEX852hftnAfISAnm3Utnppu7AXveiikRYedsA92Ncq4Q
        W1aEVvwWXnai1ge4Aovl1eBVRzM/CE3DyQLa7fbCcrGxvJQfCkodDs7V/U61yqm94/TOjZ
        olq+t9GkzocK+sotIYn+PmhKpHTCvrpQmS4mQ14bzKDkguZ2y9Kj7a8LK6/rgB7hMM4FDe
        RO80bHFgHVweNDdmcfl4wvYA63B9ddhY+YGOcWAlhK02N3qKyxJer4LNQ8gAvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605623052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SxIWC5IZJPbNDPJ9GcOv4uPsKCs93p4x0BLT+1i0zpI=;
        b=UizHtkBGPgHP3wDow/k630bvrOL/Q/WjdeDJw9E+xv399duLQb9+VhPR8x/PEF32bEbwhw
        IRN+H7u+srt3DnDQ==
Date:   Tue, 17 Nov 2020 14:19:42 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [patch 0/7] tick: Cleanups and reduce jiffies_seq held times
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WXVuZmVuZyBwcm9wb3NlZCBhIGNoYW5nZSB0byB0aWNrX2RvX3VwZGF0ZV9qaWZmaWVzNjQoKSB0
byByZWR1Y2UgdGhlCmNvbnRlbnRpb24gb24gamlmZmllc19zZXEgc2VxdWVuY2UgY291bnRlcjoK
CiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9hYzgyMmM3Mi02NzNlLTczZTEtOTYyMi1jNWYx
MjU5MWIzNzNAaHVhd2VpLmNvbQoKVGhpcyBtYWRlIG1lIGxvb2sgZGVlcGVyIGFuZCB0aGVyZSBh
cmUgbG90cyBvZiBvdGhlciB0aGluZ3MgdG8gb3B0aW1pemUsCmJ1dCBhbHNvIHRoaW5ncyB0byBk
b2N1bWVudCB3aGljaCBhcmUgY29tcGxldGVseSB1bmRvY3VtZW50ZWQgdG9kYXkuCgpUaGUgbG90
IGlzIGJhc2VkIG9uIAoKICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RpcC90aXAuZ2l0IHRpbWVycy9jb3JlCgphbmQgYWxzbyBhdmFpbGFibGUgdmlhIGdp
dCBmcm9tOgoKICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RnbHgvZGV2ZWwuZ2l0IHRpY2sKClRoYW5rcywKCgl0Z2x4Cgo=

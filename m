Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412FC22EA47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgG0Kqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 06:46:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgG0Kqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:46:39 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k00eT-00077R-By; Mon, 27 Jul 2020 10:46:37 +0000
Date:   Mon, 27 Jul 2020 12:46:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: bpfilter logging write errors in dmesg
Message-ID: <20200727104636.nuz3u4xb7ba7ue5a@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Christoph,

Seems that commit
6955a76fbcd5 ("bpfilter: switch to kernel_write")
causes bpfilter to spew these useless messages in dmesg?

[   26.356824] Started bpfilter
[   26.357059] bpfilter: write fail -22
[   26.396244] Started bpfilter
[   26.396325] bpfilter: Loaded bpfilter_umh pid 637
[   26.396542] bpfilter: write fail -22
[   26.409588] bpfilter: Loaded bpfilter_umh pid 638
[   26.410790] Started bpfilter
[   26.410960] bpfilter: write fail -22
[   26.445718] Started bpfilter
[   26.445799] bpfilter: Loaded bpfilter_umh pid 640
[   26.445983] bpfilter: write fail -22
[   26.451122] bpfilter: read fail 0
[   26.496497] bpfilter: Loaded bpfilter_umh pid 648
[   26.497889] Started bpfilter
[   26.750028] bpfilter: write fail -22
[   26.768400] Started bpfilter
[   26.768496] bpfilter: Loaded bpfilter_umh pid 661
[   26.768699] bpfilter: write fail -22
[   26.806550] Started bpfilter
[   26.806616] bpfilter: Loaded bpfilter_umh pid 663
[   26.864708] bpfilter: write fail -22
[   26.872345] bpfilter: Loaded bpfilter_umh pid 666
[   26.873072] Started bpfilter
[   26.873194] bpfilter: write fail -22
[   27.295514] kauditd_printk_skb: 22 callbacks suppressed

This is on a pure v5.8-rc7 via make bindep-pkg. I'm not using bpfilter
in any shape or form afaict and haven't seen those messages before and
this seems to be the last change I see.

Thanks!
Christian

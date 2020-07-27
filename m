Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1E22EF23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgG0ONo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 10:13:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43558 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgG0ONk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:13:40 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k03sn-0002Sy-Th; Mon, 27 Jul 2020 14:13:38 +0000
Date:   Mon, 27 Jul 2020 16:13:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: bpfilter logging write errors in dmesg
Message-ID: <20200727141337.liwdfjxq4cwvt5if@wittgenstein>
References: <20200727104636.nuz3u4xb7ba7ue5a@wittgenstein>
 <20200727132855.GA28165@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727132855.GA28165@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 03:28:55PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 27, 2020 at 12:46:36PM +0200, Christian Brauner wrote:
> > Hey Christoph,
> > 
> > Seems that commit
> > 6955a76fbcd5 ("bpfilter: switch to kernel_write")
> > causes bpfilter to spew these useless messages in dmesg?
> > 
> > [   26.356824] Started bpfilter
> > [   26.357059] bpfilter: write fail -22
> > [   26.396244] Started bpfilter
> > [   26.396325] bpfilter: Loaded bpfilter_umh pid 637
> > [   26.396542] bpfilter: write fail -22
> > [   26.409588] bpfilter: Loaded bpfilter_umh pid 638
> > [   26.410790] Started bpfilter
> > [   26.410960] bpfilter: write fail -22
> > [   26.445718] Started bpfilter
> > [   26.445799] bpfilter: Loaded bpfilter_umh pid 640
> > [   26.445983] bpfilter: write fail -22
> > [   26.451122] bpfilter: read fail 0
> > [   26.496497] bpfilter: Loaded bpfilter_umh pid 648
> > [   26.497889] Started bpfilter
> > [   26.750028] bpfilter: write fail -22
> > [   26.768400] Started bpfilter
> > [   26.768496] bpfilter: Loaded bpfilter_umh pid 661
> > [   26.768699] bpfilter: write fail -22
> > [   26.806550] Started bpfilter
> > [   26.806616] bpfilter: Loaded bpfilter_umh pid 663
> > [   26.864708] bpfilter: write fail -22
> > [   26.872345] bpfilter: Loaded bpfilter_umh pid 666
> > [   26.873072] Started bpfilter
> > [   26.873194] bpfilter: write fail -22
> > [   27.295514] kauditd_printk_skb: 22 callbacks suppressed
> > 
> > This is on a pure v5.8-rc7 via make bindep-pkg. I'm not using bpfilter
> > in any shape or form afaict and haven't seen those messages before and
> > this seems to be the last change I see.
> 
> I don't see any of those on 5.8-rc, just:
> 
> root@testvm:~# dmesg | grep bpf
> [    6.692550] bpfilter: Loaded bpfilter_umh pid 1849

Hm, odd

> 
> That debug patch below should help to pintpoint what is going on for
> you:

Thanks for the debug patch! Applied and ran a kernel and I'm getting:

[   21.919851] bpfilter: Loaded bpfilter_umh pid 619
[   22.000229] rw_verify_area
[   22.000235] bpfilter: write fail -22
[   22.014686] Started bpfilter

I'm also seeing some other failures later:

[  236.898220] bpfilter: write fail -22
[  236.899255] bpfilter: write fail -32
[  236.922557] bpfilter: Loaded bpfilter_umh pid 1101
[  236.923310] Started bpfilter
[  236.923521] rw_verify_area
[  236.923524] bpfilter: write fail -22
[  236.925273] bpfilter: read fail 0
[  236.945117] bpfilter: Loaded bpfilter_umh pid 1103
[  236.945925] Started bpfilter
[  236.946123] rw_verify_area
[  236.946126] bpfilter: write fail -22
[  236.947641] bpfilter: read fail 0
[  236.968143] bpfilter: Loaded bpfilter_umh pid 1105
[  236.968734] Started bpfilter
[  236.987777] rw_verify_area
[  236.987781] bpfilter: write fail -22
[  236.990072] bpfilter: read fail 0

Seems I can trigger this via iptables:

[  437.922719] bpfilter: write fail -22
[  437.924488] bpfilter: read fail 0
root@g1-vm:~# iptables -S
iptables v1.8.4 (legacy): can't initialize iptables table `filter': Bad address
Perhaps iptables or your kernel needs to be upgraded.

I have
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP6_NF_IPTABLES=m
maybe I'm just missing another kernel option or something and I have no
idea how this bpfilter thing and iptables relate to each other. So maybe
it's not worth the effort and it's just my setup being broken somehow.

Christian

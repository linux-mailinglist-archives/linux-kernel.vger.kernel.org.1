Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031DF22DFA1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgGZOQC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Jul 2020 10:16:02 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:53338 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbgGZOQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:16:01 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21936675-1500050 
        for multiple; Sun, 26 Jul 2020 15:15:49 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200726073052.284dadb2@x1.home>
References: <30452714b2935b530b9c2bbf2d20854a@hostfission.com> <20200726073052.284dadb2@x1.home>
Subject: Re: Poor windows VFIO performance, GPU stalls (bisected)
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     hdanton@sina.com, tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
To:     Alex Williamson <alex.williamson@redhat.com>,
        Geoffrey McRae <geoff@hostfission.com>
Date:   Sun, 26 Jul 2020 15:15:49 +0100
Message-ID: <159577294913.1157.91069469417568930@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Williamson (2020-07-26 14:30:52)
> On Sun, 26 Jul 2020 17:49:07 +1000
> Geoffrey McRae <geoff@hostfission.com> wrote:
> 
> > Hi All,
> > 
> > The commit 22540ca3d00d2990a4148a13b92209c3dc5422db causes a Windows KVM 
> > guest running under QEMU with a VFIO passthrough GPU to randomly stall 
> > when using the GPU leading to the guest assuming that the driver has 
> > hung. Reverting this commit resolves the problem.
> 
> Please double check this commit ID, I can't find it in mainline or
> linux-next.  Thanks,

See commit aa202f1f5696 ("workqueue: don't use wq_select_unbound_cpu()
for bound works"). 22540ca3 is the cherry-pick into v5.4.26
-Chris

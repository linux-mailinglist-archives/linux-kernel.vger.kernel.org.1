Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F871FAB89
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFPIoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:44:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1956CC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:44:15 -0700 (PDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jl7CK-0008N3-TL; Tue, 16 Jun 2020 10:44:00 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 72FEA10154B; Tue, 16 Jun 2020 10:44:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it
Subject: Re: [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <20200616075533.GL5653@shao2-debian>
References: <20200616075533.GL5653@shao2-debian>
Date:   Tue, 16 Jun 2020 10:44:00 +0200
Message-ID: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <rong.a.chen@intel.com> writes:
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Is the head of linux.git exposing the same problem or is this an
intermittent failure, which only affects bisectability?

Thanks,

        tglx

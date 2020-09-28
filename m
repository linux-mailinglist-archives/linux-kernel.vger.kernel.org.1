Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFDF27B093
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI1PNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgI1PNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:13:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C102207F7;
        Mon, 28 Sep 2020 15:13:43 +0000 (UTC)
Date:   Mon, 28 Sep 2020 11:13:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [Bug 209317] ftrace kernel self test failure on RISC-V on 5.8,
 regression from 5.4.0
Message-ID: <20200928111341.7eaa98a8@oasis.local.home>
In-Reply-To: <bug-209317-8243-E6Z0ICootN@https.bugzilla.kernel.org/>
References: <bug-209317-8243@https.bugzilla.kernel.org/>
        <bug-209317-8243-E6Z0ICootN@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 22:02:35 +0000
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=209317
> 
> --- Comment #4 from Colin Ian King (colin.king@canonical.com) ---
> Issue still in 5.9-rc6
> 


Atish,

As the issues bisects down to your commit, care to take a look at this.
(And take ownership of this bug)

-- Steve

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37182C95C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgLADZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbgLADZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:25:58 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF23320705;
        Tue,  1 Dec 2020 03:25:16 +0000 (UTC)
Date:   Mon, 30 Nov 2020 22:25:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Libo Chen <libo.chen@oracle.com>, linux-kernel@vger.kernel.org,
        m.mizuma@jp.fujitsu.com
Subject: Re: [PATCH 1/1] ktest.pl: Fix incorrect reboot for grub2bls
Message-ID: <20201130222514.0949e3cc@oasis.local.home>
In-Reply-To: <20201130013256.oryyz4wxd356n74o@gabell>
References: <20201121021243.1532477-1-libo.chen@oracle.com>
        <20201130013256.oryyz4wxd356n74o@gabell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Nov 2020 20:32:56 -0500
Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> On Fri, Nov 20, 2020 at 06:12:43PM -0800, Libo Chen wrote:
> > This issue was first noticed when I was testing different kernels on
> > Oracle Linux 8 which as Fedora 30+ adopts BLS as default. Even though a
> > kernel entry was added successfully and the index of that kernel entry was
> > retrieved correctly, ktest still wouldn't reboot the system into
> > user-specified kernel.
> > 
> > The bug was spotted in subroutine reboot_to where the if-statement never
> > checks for REBOOT_TYPE "grub2bls", therefore the desired entry will not be
> > set for the next boot.
> > 
> > Add a check for "grub2bls" so that $grub_reboot $grub_number can
> > be run before a reboot if REBOOT_TYPE is "grub2bls" then we can boot to
> > the correct kernel.
> > 
> > Fixes: ac2466456eaa ("ktest: introduce grub2bls REBOOT_TYPE option")
> > 
> > Signed-off-by: Libo Chen <libo.chen@oracle.com>  
> 
> Thank you for the fix!
> I tested the patch with fedora33. It works well.
> 
> Please feel free to add:
> 
> 	Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
>

Thanks.

I may push this upstream by the end of the week.

-- Steve

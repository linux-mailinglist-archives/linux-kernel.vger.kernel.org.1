Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8F2D6CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgLKAqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:46:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394565AbgLKApu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:45:50 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118A923DE3;
        Fri, 11 Dec 2020 00:45:05 +0000 (UTC)
Date:   Thu, 10 Dec 2020 19:45:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, m.mizuma@jp.fujitsu.com,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH 1/1] ktest.pl: Fix incorrect reboot for grub2bls
Message-ID: <20201210194504.3d9fb132@oasis.local.home>
In-Reply-To: <37123326-8e04-dce4-502a-410c3e979974@oracle.com>
References: <20201121021243.1532477-1-libo.chen@oracle.com>
        <20201130013256.oryyz4wxd356n74o@gabell>
        <20201130222514.0949e3cc@oasis.local.home>
        <37123326-8e04-dce4-502a-410c3e979974@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 15:09:46 -0800
Libo Chen <libo.chen@oracle.com> wrote:


> Hi Steven,
> 
> 
> Just wanna check in and check on the status of it.

I have it applied in my local repo (even in my for-next, which I forgot
to push :-p)

I've been testing it on all my build machines along with my own patches.

Anyway, it's in my queue (with two of my own patches) that I was
thinking of pushing to Linus during the next merge window. But I can
send your patch now, and see if he's willing to take it.

Thanks for pinging me.

-- Steve

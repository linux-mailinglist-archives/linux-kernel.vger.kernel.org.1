Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5F2831DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJEIZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:25:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58897 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEIZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:25:29 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C4YZD5F9Jz1qs0n;
        Mon,  5 Oct 2020 10:25:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C4YZC6ySnz1qyX8;
        Mon,  5 Oct 2020 10:25:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 20RLGyIoJIhc; Mon,  5 Oct 2020 10:25:22 +0200 (CEST)
X-Auth-Info: RJk2R64A7dwhmZJnCEYI/TAtxilQoLVj9TjvCdKUXvl1KRi7AS6cLgi9JR91QNDM
Received: from igel.home (ppp-46-244-175-195.dynamic.mnet-online.de [46.244.175.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  5 Oct 2020 10:25:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 58B1F2C28B7; Mon,  5 Oct 2020 10:25:22 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
        <1593266228-61125-2-git-send-email-guoren@kernel.org>
        <20200911204512.GA2705@aurel32.net>
        <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
        <20200914103836.GB2705@aurel32.net>
X-Yow:  Leona, I want to CONFESS things to you..
 I want to WRAP you in a SCARLET ROBE trimmed with POLYVINYL CHLORIDE..
 I want to EMPTY your ASHTRAYS...
Date:   Mon, 05 Oct 2020 10:25:22 +0200
In-Reply-To: <20200914103836.GB2705@aurel32.net> (Aurelien Jarno's message of
        "Mon, 14 Sep 2020 12:38:36 +0200")
Message-ID: <87lfglt6z1.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14 2020, Aurelien Jarno wrote:

> How should we proceed to get that fixed in time for 5.9? For the older
> branches where it has been backported (so far 5.7 and 5.8), should we
> just get that commit reverted instead?

Why is this still broken?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

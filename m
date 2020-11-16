Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2AB2B4FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbgKPSa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 13:30:56 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:47536 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388599AbgKPSat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 13:30:49 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CZd1L2sZ4z1qtQ4;
        Mon, 16 Nov 2020 19:30:46 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CZd1L1fr5z1qqkD;
        Mon, 16 Nov 2020 19:30:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2sLldMLemxsg; Mon, 16 Nov 2020 19:30:45 +0100 (CET)
X-Auth-Info: wpRWNF213h3MGa7UAqzEQHN5/HEAVynfkwBs7YWsrYdgY7k3jknJXYi1b/kpiH+r
Received: from igel.home (ppp-46-244-169-244.dynamic.mnet-online.de [46.244.169.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 16 Nov 2020 19:30:45 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id F11F62C3359; Mon, 16 Nov 2020 19:30:44 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
        <87sg999ot0.fsf@igel.home>
        <0dbaca2d-9ad0-8c1a-a280-97be01cac2bd@infradead.org>
X-Yow:  Actually, what I'd like is a little toy spaceship!!
Date:   Mon, 16 Nov 2020 19:30:44 +0100
In-Reply-To: <0dbaca2d-9ad0-8c1a-a280-97be01cac2bd@infradead.org> (Randy
        Dunlap's message of "Mon, 16 Nov 2020 09:53:46 -0800")
Message-ID: <87k0ul9msr.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 16 2020, Randy Dunlap wrote:

> What kernel version are you building?

5.10-rc4

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

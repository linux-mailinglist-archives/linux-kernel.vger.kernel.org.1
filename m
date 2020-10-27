Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F629CCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgJ1Bif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:38:35 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42060 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832999AbgJ0X0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:26:21 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CLSWZ43TGz1qrf4;
        Wed, 28 Oct 2020 00:26:18 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CLSWZ2sGWz1qxh0;
        Wed, 28 Oct 2020 00:26:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5rzp0rheSnFs; Wed, 28 Oct 2020 00:26:17 +0100 (CET)
X-Auth-Info: RS9aI4PlyTCBHGWJrSWEDVriYnK+Ge5YcPCqkwJrXrVC6IGL/CAq2pX641Nc5O6k
Received: from igel.home (ppp-46-244-161-64.dynamic.mnet-online.de [46.244.161.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 28 Oct 2020 00:26:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id E56742C2B09; Wed, 28 Oct 2020 00:26:16 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/uaccess: Switch __put_user_size_allowed()
 to __put_user_asm_goto()
References: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy__44535.5968013004$1599217383$gmane$org@csgroup.eu>
X-Yow:  Here we are in America...  when do we collect unemployment?
Date:   Wed, 28 Oct 2020 00:26:16 +0100
In-Reply-To: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy__44535.5968013004$1599217383$gmane$org@csgroup.eu>
        (Christophe Leroy's message of "Fri, 4 Sep 2020 11:01:30 +0000 (UTC)")
Message-ID: <87mu079ron.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 04 2020, Christophe Leroy wrote:

> __put_user_asm_goto() provides more flexibility to GCC and avoids using
> a local variable to tell if the write succeeded or not.
> GCC can then avoid implementing a cmp in the fast path.

That breaks CLONE_CHILD_SETTID.  I'm getting an assertion failure in
__libc_fork (THREAD_GETMEM (self, tid) != ppid).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

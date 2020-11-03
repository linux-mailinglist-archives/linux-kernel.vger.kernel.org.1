Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BFD2A3F72
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgKCI4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:56:19 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49229 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgKCI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:56:14 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CQNtM1q3Rz1qskD;
        Tue,  3 Nov 2020 09:56:11 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CQNtM0hHLz1qsXH;
        Tue,  3 Nov 2020 09:56:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id SDMu4oGfesLj; Tue,  3 Nov 2020 09:56:10 +0100 (CET)
X-Auth-Info: sHICAG11RsFQw+5TyO6xl3Jx8LOun4E1lLjyjFL2Spju6btWZWkQjQpGeB/qTFzs
Received: from igel.home (ppp-46-244-185-52.dynamic.mnet-online.de [46.244.185.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  3 Nov 2020 09:56:10 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id CFB562C362F; Tue,  3 Nov 2020 09:56:09 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
        <87wnz8vizm.fsf@igel.home> <87y2jouw8k.fsf@mpe.ellerman.id.au>
        <87v9esaxlv.fsf@igel.home>
        <20201030140047.Horde.TJJqKGzG9vSGbMRNIj-MPg7@messagerie.c-s.fr>
        <87pn4zc0zl.fsf@igel.home>
        <1f8494cd-36db-e3a2-8ea4-28fb976468e7@csgroup.eu>
X-Yow:  ..  I want a COLOR T.V. and a VIBRATING BED!!!
Date:   Tue, 03 Nov 2020 09:56:09 +0100
In-Reply-To: <1f8494cd-36db-e3a2-8ea4-28fb976468e7@csgroup.eu> (Christophe
        Leroy's message of "Tue, 3 Nov 2020 08:41:38 +0100")
Message-ID: <87k0v2es46.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 03 2020, Christophe Leroy wrote:

> Would you mind checking that with that patch reverted, you are able to
> boot a kernel built with CONFIG_KASAN ?

That doesn't exist.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

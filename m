Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3F29F69F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJ2VHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:07:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39349 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJ2VHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:07:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CMdLl6MhFz1qs3l;
        Thu, 29 Oct 2020 22:07:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CMdLl5TXRz1qrDX;
        Thu, 29 Oct 2020 22:07:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id k699Cd7e8b5J; Thu, 29 Oct 2020 22:07:42 +0100 (CET)
X-Auth-Info: NJWoqHmsJh1N4XDFuSowjw7hTV+tPs+CbVlv+oxQcW2k8guG3gADYzfsi21Nimha
Received: from igel.home (ppp-46-244-169-42.dynamic.mnet-online.de [46.244.169.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 29 Oct 2020 22:07:42 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id E3DE12C0B1B; Thu, 29 Oct 2020 22:07:41 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
X-Yow:  Are we THERE yet?!
Date:   Thu, 29 Oct 2020 22:07:41 +0100
In-Reply-To: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
        (Christophe Leroy's message of "Thu, 1 Oct 2020 15:35:38 +0000 (UTC)")
Message-ID: <87wnz8vizm.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 01 2020, Christophe Leroy wrote:

> At the time being, an early hash table is set up when
> CONFIG_KASAN is selected.
>
> There is nothing wrong with setting such an early hash table
> all the time, even if it is not used. This is a statically
> allocated 256 kB table which lies in the init data section.
>
> This makes the code simpler and may in the future allow to
> setup early IO mappings with fixmap instead of hard coding BATs.
>
> Put create_hpte() and flush_hash_pages() in the .ref.text section
> in order to avoid warning for the reference to early_hash[]. This
> reference is removed by MMU_init_hw_patch() before init memory is
> freed.

This breaks booting on the iBook G4.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

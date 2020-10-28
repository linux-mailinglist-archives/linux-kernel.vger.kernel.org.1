Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE82729D499
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgJ1Vx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:53:28 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36732 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ1VxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:53:23 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CLgvx6Dwnz1qs0h;
        Wed, 28 Oct 2020 08:59:41 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CLgvx4VDmz1qy5f;
        Wed, 28 Oct 2020 08:59:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id F6Ke24xfduVy; Wed, 28 Oct 2020 08:59:40 +0100 (CET)
X-Auth-Info: g6YLjoFgv0DoaMRKZby0YxkPV7g+CL2IBGQ4YndSz+j/jsZQYZy8k8hrvsK+kosi
Received: from igel.home (ppp-46-244-182-148.dynamic.mnet-online.de [46.244.182.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 28 Oct 2020 08:59:40 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 65E8C2C082A; Wed, 28 Oct 2020 08:59:40 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/uaccess: Switch __put_user_size_allowed()
 to __put_user_asm_goto()
References: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy__44535.5968013004$1599217383$gmane$org@csgroup.eu>
        <87mu079ron.fsf@igel.home> <87imav9r64.fsf@igel.home>
        <87pn53vsep.fsf@mpe.ellerman.id.au>
X-Yow:  YOW!!  I'm in a very clever and adorable INSANE ASYLUM!!
Date:   Wed, 28 Oct 2020 08:59:40 +0100
In-Reply-To: <87pn53vsep.fsf@mpe.ellerman.id.au> (Michael Ellerman's message
        of "Wed, 28 Oct 2020 16:19:42 +1100")
Message-ID: <87blgm3hn7.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 28 2020, Michael Ellerman wrote:

> What config and compiler are you using?

gcc 4.9.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

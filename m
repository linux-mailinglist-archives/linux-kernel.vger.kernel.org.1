Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B302A4FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgKCTII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:08:08 -0500
Received: from depni-mx.sinp.msu.ru ([213.131.7.21]:25 "EHLO
        depni-mx.sinp.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:08:07 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2020 14:08:06 EST
Received: from spider (unknown [176.192.246.239])
        by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id 4CE1F1BF450;
        Tue,  3 Nov 2020 21:58:22 +0300 (MSK)
From:   Serge Belyshev <belyshev@depni.sinp.msu.ru>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
        <87wnz8vizm.fsf@igel.home> <87y2jouw8k.fsf@mpe.ellerman.id.au>
        <87v9esaxlv.fsf@igel.home>
        <20201030140047.Horde.TJJqKGzG9vSGbMRNIj-MPg7@messagerie.c-s.fr>
        <87pn4zc0zl.fsf@igel.home>
        <1f8494cd-36db-e3a2-8ea4-28fb976468e7@csgroup.eu>
Date:   Tue, 03 Nov 2020 21:58:17 +0300
In-Reply-To: <1f8494cd-36db-e3a2-8ea4-28fb976468e7@csgroup.eu> (Christophe
        Leroy's message of "Tue, 3 Nov 2020 08:41:38 +0100")
Message-ID: <875z6mmfna.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would you mind checking that with that patch reverted, you are able to
> boot a kernel built with CONFIG_KASAN ?

I can reproduce the same problem on a powerbook G4, and no,
CONFIG_KASAN=y kernel with that patch reverted also does not boot with
the same symptom: white screen at the bootloader right after "Booting Linux
via __start() @ 0x0140000 ..."

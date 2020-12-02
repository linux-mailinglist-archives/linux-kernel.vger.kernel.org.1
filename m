Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5662CC4A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbgLBSKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbgLBSKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:10:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A218C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:10:09 -0800 (PST)
Received: from zn.tnic (p200300ec2f161b00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E10E81EC04DB;
        Wed,  2 Dec 2020 19:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606932608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MtASgyvlr76Dpn4OvnF8VBFRlFtBFT2ievvOIOzSaZg=;
        b=emO6ydC7ipcgMAmsz42cdKbUyVth+vDSpm3f/UCra7Z272bHAwYlM87mVfV9PWNaSV3khs
        KtuubNtGKcpuAmk/CXtHeylps5+zuHHwockj021IPKBUGWPo13sLWTTWqbaEN0y/N4piku
        GEPO5wsXps7e266AcT55RHzJLOQ3Krc=
Date:   Wed, 2 Dec 2020 19:10:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, Pu Wen <puwen@hygon.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/amd: Remove dead code for TSEG region remapping
Message-ID: <20201202181008.GI2951@zn.tnic>
References: <20201127171324.1846019-1-nivedita@alum.mit.edu>
 <20201127172747.GE13163@zn.tnic>
 <b726e0d7-7dfb-d902-652f-8aab4bf43e89@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b726e0d7-7dfb-d902-652f-8aab4bf43e89@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:58:15AM -0600, Tom Lendacky wrote:
> I believe this is geared towards performance. If the TSEG base address is
> not 2MB aligned, then hardware has to break down a 2MB TLB entry if the OS
> references the memory within the 2MB page that is before the TSEG base
> address. This can occur whenever the 2MB TLB entry is re-installed because
> of TLB flushes, etc.

And if this gets reinstated properly, then that explanation belongs over
it because nothing else explains what that thing did. So thanks for
digging it out.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

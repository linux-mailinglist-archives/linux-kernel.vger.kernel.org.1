Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B542CDB7A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgLCQo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:44:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgLCQo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:44:57 -0500
Received: from zn.tnic (p200300ec2f0dc5004496c992b512bfd2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:4496:c992:b512:bfd2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F1261EC0434;
        Thu,  3 Dec 2020 17:44:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607013856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/DmkWKu0h3mwMioedlGpNuFallczqE7TKT9kOW5E40c=;
        b=JZtCYM726FRpT80jAPoqR+Rcwj93drucEOd0Nx8xaqQ034meCQ8vcPWUcLQMGLdKH5BFRe
        u2gAu3xdfS3WL/7Q4xu5kkZWo4dh/DuExxa0enp6U1ALIJRXhmvUJVSG6v3zv0mQZ3k6hs
        W9Uu02t9En7V9Ip68K1aJhweDgPLRQ8=
Date:   Thu, 3 Dec 2020 17:44:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, Pu Wen <puwen@hygon.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/amd: Remove dead code for TSEG region remapping
Message-ID: <20201203164411.GK3059@zn.tnic>
References: <20201127171324.1846019-1-nivedita@alum.mit.edu>
 <20201127172747.GE13163@zn.tnic>
 <b726e0d7-7dfb-d902-652f-8aab4bf43e89@amd.com>
 <X8gWAJ+Pc6KxfYEB@rani.riverdale.lan>
 <20201203084857.GD3059@zn.tnic>
 <X8kOzpXyDXNo2PE7@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8kOzpXyDXNo2PE7@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:14:06AM -0500, Arvind Sankar wrote:
> Do any of them have it mapped at all, regardless of the alignment? There
> seems to be nothing else in the kernel that ever looks at the TSEG MSR,
> so I would guess that it has to be non-RAM in the E820 map, otherwise
> nothing would prevent the kernel from allocating and using that space.

Ha, that's a very good question. If all those BIOSes from K8 onwards
would put the TSEG in a non-RAM area and after

  66520ebc2df3 ("x86, mm: Only direct map addresses that are marked as E820_RAM")

(great investigative work, btw, thanks for that!) then we can simply say
that that splitting is not needed anymore.

Maybe Tom can ask BIOS people whether they always did that - that being
to put the TSEG into a non-RAM area. I can boot my debug patch on my
boxes here but that doesn't mean a whole lot...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99919290AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390824AbgJPRcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:32:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54232 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390222AbgJPRcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:32:43 -0400
Received: from zn.tnic (p200300ec2f0d0d00cf555b949331184a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:cf55:5b94:9331:184a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E96B1EC050F;
        Fri, 16 Oct 2020 19:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602869562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0NLyMweBggshxzEciIwNhF1SJE8e5fohldSRSEPkXgA=;
        b=U4mgKYNMd83fpahxwb2X0oa6Bl+BhiWipinDv6H646uf/8Ua2mCslxMZ+nGspdK/eKNxkA
        GBmlDUupUGGdPv2a/mdwnoh32Y0yiUprM8KcksEl62YlrFKcs2cxaYBEWxU4Bt/eio4uFE
        SpQojFfmGz4uw+sg5uoLvbyOXwP/4AA=
Date:   Fri, 16 Oct 2020 19:32:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201016173232.GI8483@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-5-nivedita@alum.mit.edu>
 <20201016162759.GG8483@zn.tnic>
 <20201016164755.GA1185111@rani.riverdale.lan>
 <20201016170726.GH8483@zn.tnic>
 <20201016172058.GA1246432@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016172058.GA1246432@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 01:20:58PM -0400, Arvind Sankar wrote:
> This patch depends on 1 to initialize boot_params before
> initialize_identity_maps() is called. You want me to rework it to avoid
> that?

Yes please. If it doesn't become too ugly, that is. If it does, then
we'll have to think of something else...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

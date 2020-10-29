Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F629F5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgJ2UF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:05:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52962 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ2UF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:05:56 -0400
Received: from zn.tnic (p200300ec2f0ce9003d743c4902fedd6b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e900:3d74:3c49:2fe:dd6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C22B1EC03C1;
        Thu, 29 Oct 2020 21:05:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604001955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wySorEWnvqfDqBPGFoIR+8bvkxNawgD+WBLZ89pwVuM=;
        b=KdBCXZwLWMhWrZApSLzCJVxiwpF6oIsfV/rCBlXBovA3qhJ3Q/kHGQhe4KNTQRbmJk5cZv
        WKEWi/h+YJgIqQdD6WE5Wv5sxlhLYZJ/AnrB5yjdnExabjK8G6gKqIU7Dm2P8UBuzQMXLl
        EWrz/vNvirbA5nDxg0Rn85G72xgkPko=
Date:   Thu, 29 Oct 2020 21:05:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Fix vmlinux size check on 64-bit
Message-ID: <20201029200546.GE31903@zn.tnic>
References: <20201005151539.2214095-1-nivedita@alum.mit.edu>
 <20201027200803.GL15580@zn.tnic>
 <20201027211422.GC1833548@rani.riverdale.lan>
 <20201028133909.GA27112@zn.tnic>
 <20201028164551.GA1989568@rani.riverdale.lan>
 <20201028194355.GB27112@zn.tnic>
 <20201028204549.GA2231038@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201028204549.GA2231038@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 04:45:49PM -0400, Arvind Sankar wrote:
> It's become ABI I think: looks like it's included by that name in
> vmcoreinfo for kexec crash dumps.

Yeah, last time we had the ABI discussion we agreed with the kexec/crash
folks that this is not an ABI and that crash is "tied" more or less to a
kernel version. So I wouldn't worry about that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

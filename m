Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E05292CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgJSRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:31:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44146 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgJSRb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:31:28 -0400
Received: from zn.tnic (p200300ec2f078400d45a7d41b12f2c14.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8400:d45a:7d41:b12f:2c14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F1C11EC034B;
        Mon, 19 Oct 2020 19:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603128686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3YHbgyNgAmFxHwlnI7lrzBawdFEkoOiENdwIR/VRDTg=;
        b=q6SxtMU6B+KGG3fLhEvb5TpdQYLdyuH3Ri457gOxZ+I9k7x7UCTL+K7Cefyp1eG20FzPc2
        nYgvlVL0/Yra+kaRfBAXZPbrxq152y/NXzfaQdJdTUvmb8LFcEigF77roHafz34AAyV+We
        phjystBo+QZJv+3K/1uvVBj62zvuegM=
Date:   Mon, 19 Oct 2020 19:31:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201019173115.GG24325@zn.tnic>
References: <20201016173232.GI8483@zn.tnic>
 <20201016200404.1615994-1-nivedita@alum.mit.edu>
 <20201019145115.GB24325@zn.tnic>
 <20201019171259.GC2701355@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019171259.GC2701355@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 01:12:59PM -0400, Arvind Sankar wrote:
> No real reason. This will disappear anyway in the cleanup patch.

Ok, I'll change it to the MOV as it is less confusing, at least to me
:), this way.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

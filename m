Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BEB2A4E44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgKCSUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:20:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2FFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:20:31 -0800 (PST)
Received: from zn.tnic (p200300ec2f10e000b5af706e7587131c.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:e000:b5af:706e:7587:131c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A646D1EC03EA;
        Tue,  3 Nov 2020 19:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604427629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uvEkArjin3P6HQHGtpbwL5YorsdY6qVcP4gVK/bwu3o=;
        b=DlwdMmWPFlBWAcv+V0IBO9GGcmrUOUMSF9pFzehsS41E1Iu3fd8jW77q6eu9KlUREMRwJy
        818ow42QbJM7Q/KvFpspS3v2vrTxX0WMJz/5TV/dcXbZ21BHxg2ZqOqRgQTZKeEyh6bUGd
        gsb1UPv6u0lPktuzSEpJrL8IBmG5KNs=
Date:   Tue, 3 Nov 2020 19:20:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mark Mossberg <mark.mossberg@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jannh@google.com, kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
Message-ID: <20201103182018.GE4111@zn.tnic>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com>
 <20201103171537.GC4111@zn.tnic>
 <20201103174744.GB23992@redhat.com>
 <20201103175237.GD4111@zn.tnic>
 <20201103181114.GC23992@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103181114.GC23992@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 07:11:15PM +0100, Oleg Nesterov wrote:
> > I'm thinking copy_code() should not use copy_from_user_nmi() if former
> > can be called in non-atomic context too.
> 
> I understand, but why do you think this makes sense?

Because the copy_from_user_nmi()'s name tells me that it is at least
supposed to be called in atomic context. At least this is how I
understand it. And in atomic context regs is supposed to belong to
current, right?

So I kinda agree with what you're proposing but if copy_from_user_nmi()
can be "tricked" into reading off from the weeds, then there should be
a big fat warning above it at least so that users are warned to do the
appropriate checks.

Or there should be another wrapper around it which does the
regs-belongs-to-current checks, etc and copy_code() should use that
wrapper...

AFAICT at least.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

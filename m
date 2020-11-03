Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2F2A4D80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgKCRwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:52:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgKCRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:52:45 -0500
Received: from zn.tnic (p200300ec2f10e0004a3cb1c0cad06673.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:e000:4a3c:b1c0:cad0:6673])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 638221EC0411;
        Tue,  3 Nov 2020 18:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604425964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JuAS/WMFhMgTgvm0yrkYBPosDiEnWCftPzoVvXq1hEE=;
        b=BlxJmhDVoxOJw/ECik1BpdE1+VlsG4VwkizwjssaSMRdUsFqj7BQGJCsU1lQ6v/yMokVoa
        yww1OwDWg5JRykzO2k8tB/u51UIiRNMtKshbGyQ8OhjOWYNBgWoi2vjx0I6dIMlSGQbKRh
        JO0l6VaR/o5qiLwnphSU163PkB5Gwrs=
Date:   Tue, 3 Nov 2020 18:52:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mark Mossberg <mark.mossberg@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jannh@google.com, kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
Message-ID: <20201103175237.GD4111@zn.tnic>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com>
 <20201103171537.GC4111@zn.tnic>
 <20201103174744.GB23992@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103174744.GB23992@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 06:47:44PM +0100, Oleg Nesterov wrote:
> > I'm thinking this should not use the atomic variant if it can get called
> > in !atomic context too.
> 
> For what?

I'm thinking copy_code() should not use copy_from_user_nmi() if former
can be called in non-atomic context too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

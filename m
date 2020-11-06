Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1BA2A9874
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKFPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:22:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgKFPW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:22:59 -0500
Received: from zn.tnic (p200300ec2f0d1f00a4cc36f619593225.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1f00:a4cc:36f6:1959:3225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 874C71EC03EA;
        Fri,  6 Nov 2020 16:22:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604676178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4S5KHTu0b7/e9t7QGnVTVE/CYcplYeRZTP1PGG4sVWk=;
        b=Tt+0MwXsM/5V0Ja26+sniWCJzCuxTz/+HS9btYCJ3duW2v4yPgtiWlWibnfCKJt907/Ajm
        R+P2n/+E3rXsPeU0SHl6qekZFfKBZ7R6a5jyHuCmuyyYCMQkKmzQEYTseJpga3MRb7HtYH
        mZNCBhf1Tse+Qtd4UavjuhJqTqUjB4E=
Date:   Fri, 6 Nov 2020 16:22:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hewenliang <hewenliang4@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        osandov@fb.com, rppt@kernel.org, lijiang@redhat.com,
        linux-kernel@vger.kernel.org, hushiyuan@huawei.com
Subject: Re: [PATCH] x86/kexec: Initialize the value of ident mapping offset
Message-ID: <20201106152244.GE14914@zn.tnic>
References: <20201106033005.2354-1-hewenliang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106033005.2354-1-hewenliang4@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 10:30:05PM -0500, Hewenliang wrote:
> From: hewenliang <hewenliang4@huawei.com>
> 
> It is necessary to initialize the value of ident mapping offset.

Why is it necessary?

> This can not only avoid using dirty data,

What happens to designated initializers when some of the members are not
explicitly mentioned?

Hint:

$ make arch/x86/kernel/machine_kexec_64.s

and look at that file before your patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

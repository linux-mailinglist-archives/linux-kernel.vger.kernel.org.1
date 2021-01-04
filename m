Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF72E92CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhADJuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:50:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbhADJux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:50:53 -0500
Received: from zn.tnic (p200300ec2f086c001ffa80bfe662d8cb.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6c00:1ffa:80bf:e662:d8cb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89E061EC0328;
        Mon,  4 Jan 2021 10:50:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609753812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YTPxs9+hg01r4pZyGJdYXFPbnmjQILZod1WigUHlpyU=;
        b=qbTvD+58L+drlF9a20wb2vgQ6NIqOLnFoaAuHn+SBrgq+Lcru+8jRHQcoMMnu20QficIr6
        d3a6Tyxhg2c6bbp+HmbcYaWzBdvvJPHImlt00aGJFw55Wq+OHgcPWOG8Ix9qyBGL4vj5TX
        mVoK35+HCQraJrxWHY4YjAQBSW/bOww=
Date:   Mon, 4 Jan 2021 10:50:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CPU hotplug leads to NULL pointer dereference with RAPL
 enabled on AMD 2990WX
Message-ID: <20210104095010.GA32151@zn.tnic>
References: <151f54e9-5b45-5624-681c-754224b6c263@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151f54e9-5b45-5624-681c-754224b6c263@gmx.at>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 12:02:44AM +0100, Johnathan Smithinovic wrote:
> CPU hotplug leads to NULL pointer dereference with RAPL enabled on AMD 2990WX
> 
> 
> When hot-plugging CPUs (e.g. manually or on suspend) I get a NULL
> pointer dereference in rapl_cpu_offline() for CPUs 16 and 24.
> It *seems* to me that this has to do with commit
> 700d098acec5271161606f3c0086b71695ea2ef8
> ("x86/CPU/AMD: Save AMD NodeId as cpu_die_id").
> When reverting said commit hotplug works again.

Yeah, known issue and I'm working on it.

Thx for reporting.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

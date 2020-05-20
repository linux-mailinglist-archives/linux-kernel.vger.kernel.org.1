Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E19A1DBCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgETSfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 14:35:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57800 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETSfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:35:20 -0400
Received: from zn.tnic (p200300ec2f0bab0028d24a65f02999fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ab00:28d2:4a65:f029:99fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E5371EC02CF;
        Wed, 20 May 2020 20:35:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589999718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7HjMn/eYtC1l7LDL2oV16GubcFZH4crCiZ55n4hNNe8=;
        b=ZVk5iqVvU1rAEjCoCiW56BBXsnHm8Fp6sKwgdC7pvYCro/hQX4zPdYSJB6aeh6QNylUuSQ
        9hDgKK3huUZL4EFaeOgrTF6IN/L1bVWBRabsKG7Bpl8ZwwwOjTjQC7ReZfpfDglohCv0VU
        iD3CCkci2yH1TSwqlkpRWHoJaEgAsMk=
Date:   Wed, 20 May 2020 20:35:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 0/4] x86/resctrl: Enable user to view and select
 thread throttling mode
Message-ID: <20200520183508.GI1457@zn.tnic>
References: <cover.1589922949.git.reinette.chatre@intel.com>
 <20200519213516.GF444@zn.tnic>
 <1d9ee0f0-8078-e8b6-ce66-6c0bf51cb3b4@intel.com>
 <20200520071109.GA1457@zn.tnic>
 <5c044d17-e42e-1493-28a5-3ecac043c8f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c044d17-e42e-1493-28a5-3ecac043c8f1@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 10:32:02AM -0700, Reinette Chatre wrote:
> I was told that these enhancements really needed to get into v5.8,
> otherwise the OSV intercepts will be much further out. Certainly not of
> concern to you and not your problem, I am just answering your question
> as an explanation for my goal for inclusion into v5.8.

I believe under "OSV" fall distros too and I, with my distro hat on, can
tell you that at least for us, SUSE, it suffices if the patches are in a
maintainer tree on their way upstream to start backporting them.

Which means, if they get queued in tip after 5.8 releases, that would be
like a couple of weeks later.

Dunno if the other OSVs you work with have such relaxed requirements
- just pointing out that if they do, a couple of weeks later is not a
whole cycle later.

> It seems inappropriate that I have the title of maintainer and not be
> able to have patches considered for inclusion during an entire release
> cycle.

Well, we try very hard to be fair when looking at patchsets. In your
case, I already took a patchset from you this cycle and there are other
patchsets waiting for a lot longer than yours - even patchsets from your
colleagues at Intel.

So I understand that you think it might be inappropriate but please try
to understand it also from our standpoint in that we try to round-robin
between everyone as fair as possible.

So I will try to look at yours in the next days but I cannot promise you
anything.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

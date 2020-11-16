Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C162B4BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgKPQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:55:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49964 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbgKPQzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:55:51 -0500
Received: from zn.tnic (p200300ec2f07680050d12d82a515c0a8.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:6800:50d1:2d82:a515:c0a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 579231EC0391;
        Mon, 16 Nov 2020 17:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605545750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mP17by/35hnZwkxXmR9HMZFcsob75Ss7BHNoFkg72Cw=;
        b=I/RzRMHWwzBz5/YAzonMHKHsT9QTtB6SzIO58E79BqceFZYAQVhk8gB6n4TCXXEVYY9EKI
        E6qgh16FM62Ym0R9IlgXbVpD9911Q3XuCCojAHcvyItlAvw+/mkyBJVomfTjs5b7NCErq2
        Yy+Xv552Bb5nYnADQJQDA4sJhKgFSXo=
Date:   Mon, 16 Nov 2020 17:55:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v41 00/24] Intel SGX foundations
Message-ID: <20201116165544.GC1131@zn.tnic>
References: <20201112220135.165028-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201112220135.165028-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:01:11AM +0200, Jarkko Sakkinen wrote:
> Sean Christopherson is a major contributor to this series.  However, he
> has left Intel and his @intel.com address will soon be bouncing.  He
> does not have a email he wants us to substitute or put in .mailmap for
> now.  To avoid subjecting everyone to bounces, we have commented out his
> tag lines in the commit messages.

Don't do that - there's a --suppress-cc=<category> cmdline switch to
git-send-email for exactly those things.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

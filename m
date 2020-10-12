Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41028BAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbgJLOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:37:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34712 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgJLOhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:37:13 -0400
Received: from zn.tnic (p200300ec2f06920008362ea164c1c332.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:836:2ea1:64c1:c332])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E98891EC0354;
        Mon, 12 Oct 2020 16:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602513432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p9v0SyOf5SNHbEM+QinvH46YOkzsyIKt+QyfqVIHc3Q=;
        b=mg+4AGvv4z5UT6r5IHZ5CoYMfgV33DG3Ca7hB9YP534Su7RoE4Sp6iMs3sbpHBngXWLNpI
        SvUSjGwxWWaUrQOVWJfhaQZn2opLQuLDArYr0TKIxETUs8687Ou78/sf1Dm+8st8UpOBIq
        iVRPH/tIj9sEDJJ+vaXxYteB3al0m2M=
Date:   Mon, 12 Oct 2020 16:37:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/pti] BUILD SUCCESS WITH WARNING
 767d46ab566dd489733666efe48732d523c8c332
Message-ID: <20201012143708.GD22829@zn.tnic>
References: <5f62b7f2.Q9ixRaxJwQpWTURd%lkp@intel.com>
 <20200917061220.GB31960@zn.tnic>
 <20200917073620.GA4946@intel.com>
 <20200917080044.GD31960@zn.tnic>
 <20200917133722.GA21986@intel.com>
 <c06bc69c-e3f6-2902-5df7-15cf2c9ea9d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c06bc69c-e3f6-2902-5df7-15cf2c9ea9d7@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:16:54PM +0800, Rong Chen wrote:
> We have added the reported links in the report, you can find it in the
> latest tip report:
> 
> [tip:master] BUILD REGRESSION 820e6f502f021417140bc8ee11f9c7be148ea844
> 
> tree/branch:https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git   master
> branch HEAD: 820e6f502f021417140bc8ee11f9c7be148ea844  Merge branch 'efi/core'
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/lkml/202010112007.JDl1BSci-lkp@intel.com

Thanks, that link has all the info needed to reproduce AFAICT, as long
as you make sure to send it to a mailing list which gets archived by
lore.kernel.org - otherwise the redirection won't work.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA81426B796
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgIPA0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIOOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:12:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E03C0611C3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:55:26 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e42005feaf7d7c7b8ac70.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:5fea:f7d7:c7b8:ac70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 672751EC0268;
        Tue, 15 Sep 2020 15:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600178125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y1Z2Np7SwDmrvGMIEXunVtCZTNavKQh+rI+ulRZ3wIo=;
        b=SnCwPCEqaWaz/ip5FU55BIXPnXcpKqocL6fk5B6xaFB+AJarMnheb8UsAfD4xAlQGf4pGv
        3vcpzw9FfxsfDCO4Jy57W9TYk0QZtUQaHGGLgWvvy55PsrHGlO1lxR8zcCjGmA4+55fMLo
        KO+CfYz4fKLLOWAxMEW9jYJnq0ORFg8=
Date:   Tue, 15 Sep 2020 15:55:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>,
        Rong Chen <rong.a.chen@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915135519.GJ14436@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:42:56PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  x86/seves
> branch HEAD: e6eb15c9ba3165698488ae5c34920eea20eaa38e  KVM: nSVM: Avoid freeing uninitialized pointers in svm_set_nested_state()
> 
> Warning in current branch:
> 
> arch/x86/kernel/sev-es.o: warning: objtool: ist_exc_vmm_communication()+0x12: unreachable instruction
> 
> Warning ids grouped by kconfigs:
> 
> clang_recent_errors
> `-- x86_64-randconfig-r001-20200913
>     `-- arch-x86-kernel-sev-es.o:warning:objtool:ist_exc_vmm_communication():unreachable-instruction

Guys, can you get me that config pls?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

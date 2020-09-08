Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED944261CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgIHTZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731078AbgIHQAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79EDC06123D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:26:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f10bf00716ea70263de84d4.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:716e:a702:63de:84d4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BF651EC0284;
        Tue,  8 Sep 2020 17:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599578745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tnjt7ngho1DKnqWxjc7ecHrXFfdKVeNz1CnHxEHCMvM=;
        b=d5Ro0OR8lEypRyNqOEG+7RqAkGUIpkToBaG9EcdUKiOm13l5E+i8kwKPebPqGcV/FWy7zR
        V9jaIgvktD5RJPSU9uPiSkdOLmdWBctfYF9CKhVB/uH/38SfNFRJ9XTk4tnYCKdaLIjcY3
        PBwOnUOvN8Vt8gO7Y4CzFMRPclXBDs4=
Date:   Tue, 8 Sep 2020 17:25:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200908152539.GE25236@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
 <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 03:07:05PM +0000, Luck, Tony wrote:
> We can even get a nice diagnostic message since the handler
> has access to "regs". It can print which MSR (regs->cx) and
> where it happened (regs->ip).
> 
> Which sounds like you might want a specific ex_handler_rdmsr
> function rather than a generic ex_handler_panic.
> 
> Maybe same deal for wrmsr() too? That would also print edx:eax
> so you could see what was being written.

Sounds good. Lemme try to come up with something these days.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

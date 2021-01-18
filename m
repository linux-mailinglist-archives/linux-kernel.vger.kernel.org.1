Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5B2F9F45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391261AbhARMPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391119AbhARMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:14:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B808C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:13:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f069f00ce44ca2515680e14.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9f00:ce44:ca25:1568:e14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A6F6C1EC0323;
        Mon, 18 Jan 2021 13:13:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610972028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nmMs60CXg56bKcV+GG3WyH3X0YvRDV08g9jfvgGBRrY=;
        b=dZYArGl7SPgmbAjVaIaBNagYjXmYwyeuU0EJQjzf9Wt0WhmLSkvO8U444KtXlR34lFMPZa
        TrBR7FIOE6aowvA0pYuQ+jt1Y8QZLWcWufy6GToueCDDvxYiqai7KUAWVc1VzP9HHPCq+5
        JqRo5V5yZs87A4K4I3YL5cEl8jIYddk=
Date:   Mon, 18 Jan 2021 13:13:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] x86/fpu: Make the EFI FPU calling convention explicit
Message-ID: <20210118121327.GB30090@zn.tnic>
References: <cover.1610950681.git.luto@kernel.org>
 <49aeb632f155569c75ea3cd78e9028cf7ba776fe.1610950681.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49aeb632f155569c75ea3cd78e9028cf7ba776fe.1610950681.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 10:20:40PM -0800, Andy Lutomirski wrote:
> EFI uses kernel_fpu_begin() to conform to the UEFI calling convention.
> This specifically requires initializing FCW, whereas no sane 64-bit kernel
> code should use legacy 387 operations that reference FCW.
> 
> Add KFPU_EFI to make this self-documenting, and use it in the EFI code.

I'd prefer if you slap a comment over the kernel_fpu_begin() calls in
efi instead of adding a separate define etc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

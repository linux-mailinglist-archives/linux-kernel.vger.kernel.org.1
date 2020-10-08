Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1977287185
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgJHJax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:30:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EBCC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 02:30:52 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a90008b2588e9c28ae899.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9000:8b25:88e9:c28a:e899])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A54C91EC0409;
        Thu,  8 Oct 2020 11:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602149450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6beFj2UnhDCX3evJi2LywZoGkp9gliipgFfCKDdVez4=;
        b=qLDyB9wvmGT0gyBeU2w/UiqmPt6wQjIsBFnQKsdXzj99xm/D+exLuANB9HKyUZJQin/GbP
        2WFm0cG9Cg3CKSDVMh3E47qFbiCPDzpo08107MlOVYx6Vw5ty+7ODiU99rBOxBxyfK6fwd
        i9ACg4we0xbIVCQe4E2VM7I/J8G7YNw=
Date:   Thu, 8 Oct 2020 11:30:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] x86/boot: Move get_cmd_line_ptr() and
 COMMAND_LINE_SIZE into misc.h
Message-ID: <20201008093042.GA6491@zn.tnic>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007195351.776555-3-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:53:48PM -0400, Arvind Sankar wrote:
> Move get_cmd_line_ptr() and COMMAND_LINE_SIZE into misc.h for easier
> use from multiple files.

Well, I don't like that. cmdline.c *is* for cmdline-related things.
misc.h is a dumping ground for everything but the kitchen sink.

Why can't you leave it there and make it visible to other compilation
units?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

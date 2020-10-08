Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026C92876D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgJHPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730843AbgJHPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:10:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C85C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:10:52 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a9000bfab7746bad7d6a7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9000:bfab:7746:bad7:d6a7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD73B1EC047E;
        Thu,  8 Oct 2020 17:10:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602169850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=04cZsQfKzTfQN0B6z+PUGGKYvOq91/ycjZEHztk+12I=;
        b=akJaisRsFP+XQyfDRYBAaT8uvOrB7fzB1bQNEER/2tb9tgajsp7p8sQAtUU/SopqBDlMv0
        DcXkWOqlOPP+sJKnHaH25om3mbrzvZE/FmEvQSbdiLFK0v+hkrfz7qn0jCWbiZkZG2O4Sk
        8hxuShhoj976FO2/UiAJRL5Ke+LeHgQ=
Date:   Thu, 8 Oct 2020 17:10:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] x86/boot: Move get_cmd_line_ptr() and
 COMMAND_LINE_SIZE into misc.h
Message-ID: <20201008151047.GB5505@zn.tnic>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-3-nivedita@alum.mit.edu>
 <20201008093042.GA6491@zn.tnic>
 <20201008134723.GB2429573@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008134723.GB2429573@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 09:47:23AM -0400, Arvind Sankar wrote:
> Are you ok with the include of setup.h?

Or you could simply add cmdline.h and include that. It is high time we
started cleaning up that include hell in compressed/ and all facilities
there be nicely separated. Recently I started untangling it but it is a
serious mess. And kernel proper includes leak in there, yuck.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

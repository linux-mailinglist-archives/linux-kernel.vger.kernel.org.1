Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042B51C3C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgEDOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 10:12:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgEDOMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:12:12 -0400
Received: from zn.tnic (p200300EC2F08AF0065867C3890225131.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:af00:6586:7c38:9022:5131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAD3A1EC02D7;
        Mon,  4 May 2020 16:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588601530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jqNEJeClk0fD3e9raI/nN92sfg9dR537GZRqBqcLJMU=;
        b=m86nvddWot3EcYIXIrl17FsHoISKOLptDLfan4QVUUiG7bhNat43J1orvnyYDl6GCm5Xte
        aELeaeg6LRRPzrBFX7C3O4WxlEHhHA9M9ZF5nQ4KXURyWL6KoeABSI+nWTzWLwEgtLJzLb
        KKHnE+PG3BlKy5efln71RhRmQVJ0xWU=
Date:   Mon, 4 May 2020 16:12:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] x86: microcode: intel: read microcode metadata
 file
Message-ID: <20200504141211.GG15046@zn.tnic>
References: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
 <1587972479-10971-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1587972479-10971-2-git-send-email-mihai.carabas@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH RFC 1/3] x86: microcode: intel: read microcode metadata file

For the future, do:

git log <file I'm changing under arch/x86/>

to figure out what commit title prefix to use for the tip tree.

On Mon, Apr 27, 2020 at 10:27:57AM +0300, Mihai Carabas wrote:
> Try to read the microcode metadata file in order to see what features
> are added or remove by the new microcode blob. If the metadata file
> does not exists passthrough normal loading with a warning message.

So this file must be signed by the microcode vendors and that signature
then must be verified by the loader before we even look at the metadata.
We don't trust luserspace.

Also, I don't like it being a separate file - it could just as well be
appended to the microcode blob and parsed properly by the loader.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

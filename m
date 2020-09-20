Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8786E271864
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgITWiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITWiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:38:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F69C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 15:38:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f295d00040ddf3aa303c705.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:5d00:40d:df3a:a303:c705])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A17D1EC0350;
        Mon, 21 Sep 2020 00:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600641527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fAOoNGRO8ZXCSRobVipxm240xT77dFmiGqPfiEsPniQ=;
        b=HTF5m0/Wml78qiwOhOqkz+9bCtWyI+Haa4Fq0KZZKT2JCsxADBIuJYzF6X9GM4J9JdYzgK
        UxMjbQbdO5cXRyhhWgB08tl7ckgSN16YrZOBh1MJu9DuMIzqoNGr65i3WNM2MkNqK/lZMy
        5o0a7MjIo6jXr0IDSixLkZdxHjkrHYY=
Date:   Mon, 21 Sep 2020 00:38:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] efi/urgent for v5.9-rc6
Message-ID: <20200920223841.GE7473@zn.tnic>
References: <20200920193312.GD13044@zn.tnic>
 <CAHk-=witaxLCP4ZoxywTkJrcd3n+yBBJ46j3obsSFrcWK2Yjpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=witaxLCP4ZoxywTkJrcd3n+yBBJ46j3obsSFrcWK2Yjpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 03:25:12PM -0700, Linus Torvalds wrote:
> On Sun, Sep 20, 2020 at 12:33 PM Borislav Petkov <bp@suse.de> wrote:
> >
> > I'm simply forwarding Ard's tag, I hope that's ok.
> 
> That's ok, although it shows perhaps a weakness in our model.
> 
> Git actually would have allowed you to create a signed tag pointing to
> Ard's tag, and we'd have had the signature chain that way. Although
> I'm not even sure the commit signature code has then ever been tested
> with that kind of odd situation.

I just tried to sign the local version of the efi/urgent branch I had
which had Ard's tag ontop, using latest git 2.28.0. It worked and in
gitk, when clicking on the tag - it says "2 tags... " by the way -
shows, see '*' at the end of mail. I.e., two tags signing the same
object.

And tglx has done this with the previous efi/urgent pull, see '**'
below. Both tagging the same object and with two tag messages. Me being
lazy thought that since Ard has already written one, why should I even
try... :-)

> But that might have technically been the best way of doing things
> (kind of like sign-offs on commits when forwarding them in email), but
> I don't think it really matters.

I can do that if you prefer - it is trivial. Ard's stuff goes through
tip so we will have to forward tags soon again.

> I just mentioned this odd tag forwarding in the merge commit instead.
> It all looks fine, it's just a bit unusual.

Yeah, I thought I should ask because I don't remember seeing something
like that being done before.

Thx.

*
---
Tag: efi-urgent-for-v5.9-rc5
object 46908326c6b801201f1e46f5ed0db6e85bef74ae
type commit
tag efi-urgent-for-v5.9-rc5
tagger Ard Biesheuvel <ardb@kernel.org> 1600260469 +0300

Single EFI fix for v5.9-rc:
- ensure that the EFI bootloader control module only probes successfully
  on systems that support the EFI SetVariable runtime service
-----BEGIN PGP SIGNATURE-----

...

-----END PGP SIGNATURE-----

Tag: efi_tag_signed_by_me
object 46908326c6b801201f1e46f5ed0db6e85bef74ae
type commit
tag efi_tag_signed_by_me
tagger Borislav Petkov <bp@suse.de> 1600640988 +0200

Test tag signing
-----BEGIN PGP SIGNATURE-----

...

-----END PGP SIGNATURE-----



**
---
Tag: efi-urgent-2020-08-23
object fb1201aececc59990b75ef59fca93ae4aa1e1444
type commit
tag efi-urgent-2020-08-23
tagger Thomas Gleixner <tglx@linutronix.de> 1598170304 +0200

A set of EFI fixes:

 - Enforce NX on RO data in mixed EFI mode
 - Destroy workqueue in an error handling path to prevent UAF
 - Stop argument parser at '--' which is the delimiter for init
 - Treat a NULL command line pointer as empty instead of dereferncing it
   unconditionally.
 - Handle an unterminated command line correctly
 - Cleanup the 32bit code leftovers and remove obsolete documentation
-----BEGIN PGP SIGNATURE-----

...

-----END PGP SIGNATURE-----

Tag: efi-urgent-for-v5.9-rc1
object fb1201aececc59990b75ef59fca93ae4aa1e1444
type commit
tag efi-urgent-for-v5.9-rc1
tagger Ard Biesheuvel <ardb@kernel.org> 1597915176 +0200

EFI fixes for v5.9-rc1:
- Some followup fixes for the UV1 and EFI old_map removal
- EFI stub command line fixes from Arvind
- Stop mapping the kernel's .rodata executable in the mixed mode EFI page tables
- Add missing cleanup on the efisubsys_init() error path
-----BEGIN PGP SIGNATURE-----

...

-----END PGP SIGNATURE-----
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

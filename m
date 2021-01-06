Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D063A2EC3DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbhAFTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:25:10 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:34709 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbhAFTZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1609961108; x=1641497108;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=h0ZVSEFSTf68H0QCRi+x8r0lRisnqFsdYsZ2kex77Mw=;
  b=nVmJGzNf0cuJVk5ZbEwQFUHHccZvMZolnQh6D4Y+wqIQIkjMD3FL0mAH
   h3lEMPGOwNajTG/7m+f1cPSDfhHGVcFDEQeoamrbNkx4p4/CCE+2dvrdv
   XZZktV8mwtNrg5K9E8M4QoCrW7h/MvJEE07hlwa9tjIqWksZCiw4EovPP
   k=;
X-IronPort-AV: E=Sophos;i="5.79,327,1602547200"; 
   d="scan'208";a="108782938"
Subject: Re: [PATCH] module: harden ELF info handling
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 06 Jan 2021 19:24:28 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 20D31A02B5;
        Wed,  6 Jan 2021 19:24:28 +0000 (UTC)
Received: from EX13D23UWC001.ant.amazon.com (10.43.162.196) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 6 Jan 2021 19:24:27 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D23UWC001.ant.amazon.com (10.43.162.196) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 6 Jan 2021 19:24:26 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 6 Jan 2021 19:24:26 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id E4266C1368; Wed,  6 Jan 2021 19:24:26 +0000 (UTC)
Date:   Wed, 6 Jan 2021 19:24:26 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Jessica Yu <jeyu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Message-ID: <20210106192426.GA29829@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201221234921.31129-1-fllinden@amazon.com>
 <20210105133928.GA27293@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210105133928.GA27293@linux-8ccs.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 02:39:28PM +0100, Jessica Yu wrote:
> Hi Frank,
> 
> Sorry for the delay. I've just gotten back from vacation :-)

No problem - I figured you were :-)

Comments inline -
> 
> +++ Frank van der Linden [21/12/20 23:49 +0000]:
> > 5fdc7db644 ("module: setup load info before module_sig_check()")
> > moved the ELF setup, so that it was done before the signature
> > check. This made the module name available to signature error
> > messages.
> > 
> > However, the checks for ELF correctness in setup_load_info
> > are not sufficient to prevent bad memory references due to
> > corrupted offset fields, indices, etc.
> > 
> > So, there's a regression in behavior here: a corrupt and unsigned
> > (or badly signed) module, which might previously have been rejected
> > immediately, can now cause an oops/crash.
> > 
> > Harden ELF handling for module loading by doing the following:
> > 
> > - Move the signature check back up so that it comes before ELF
> >  initialization. It's best to do the signature check to see
> >  if we can trust the module, before using the ELF structures
> >  inside it. This also makes checks against info->len
> >  more accurate again, as this field will be reduced by the
> >  length of the signature in mod_check_sig().
> > 
> >  The module name is now once again not available for error
> >  messages during the signature check, but that seems like
> >  a fair tradeoff.
> 
> I vaguely remember that I had made the module name available in
> response to a one-off request, IIRC someone had wanted the module name
> logged to be able to figure out which module(s) had failed signature
> verification. But I do agree with your line of reasoning, that we
> should probably not access internal module structures until we have
> verified that we can trust the module. It is a chicken and egg problem
> unfortunately. Although, it is probably worth it to trade ease of
> debugging for a more hardened approach.

Cool, thanks, I'm glad you agree/
> 
> > - Check if sections have offset / size fields that at least don't
> >  exceed the length of the module.
> > 
> > - Check if sections have section name offsets that don't fall
> >  outside the section name table.
> > 
> > - Add a few other sanity checks against invalid section indices,
> >  etc.
> > 
> > This is not an exhaustive consistency check, but the idea is to
> > at least get through the signature and blacklist checks without
> > crashing because of corrupted ELF info, and to error out gracefully
> > for most issues that would have caused problems later on.
> > 
> > Fixes: 5fdc7db644 ("module: setup load info before module_sig_check()")
> > Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> > ---
> > kernel/module.c           | 143 +++++++++++++++++++++++++++++++++-----
> > kernel/module_signature.c |   2 +-
> > kernel/module_signing.c   |   2 +-
> > 3 files changed, 126 insertions(+), 21 deletions(-)
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 4bf30e4b3eaa..ef7681a22a1a 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2964,7 +2964,7 @@ static int module_sig_check(struct load_info *info, int flags)
> >       }
> > 
> >       if (is_module_sig_enforced()) {
> > -              pr_notice("%s: loading of %s is rejected\n", info->name, reason);
> > +              pr_notice("loading of %s is rejected\n", reason);
> 
> Small nit: Let's start with a capital letter perhaps? Just to be
> consistent with the other log messages that don't start with a prefix.
> Same goes for the other pr_err()s below.

Sure, will do.

> 
> >               return -EKEYREJECTED;
> >       }
> > 
> > @@ -2977,9 +2977,33 @@ static int module_sig_check(struct load_info *info, int flags)
> > }
> > #endif /* !CONFIG_MODULE_SIG */
> > 
> > -/* Sanity checks against invalid binaries, wrong arch, weird elf version. */
> > -static int elf_header_check(struct load_info *info)
> > +static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
> > {
> > +      unsigned long secend;
> > +
> > +      /*
> > +       * Check for both overflow and offset/size being
> > +       * too large.
> > +       */
> > +      secend = shdr->sh_offset + shdr->sh_size;
> > +      if (secend < shdr->sh_offset || secend >= info->len)
> 
> Should this not be secend > info->len?

Yep, good catch, will fix that.

> 
> > +              return -ENOEXEC;
> > +
> > +      return 0;
> > +}
> > +
> > +/*
> > + * Sanity checks against invalid binaries, wrong arch, weird elf version.
> > + *
> > + * Also do basic validity checks against section offsets and sizes, the
> > + * section name string table, and the indices used for it (sh_name).
> > + */
> > +static int elf_validity_check(struct load_info *info)
> > +{
> > +      unsigned int i;
> > +      Elf_Shdr *shdr, *strhdr;
> > +      int err;
> > +
> >       if (info->len < sizeof(*(info->hdr)))
> >               return -ENOEXEC;
> > 
> > @@ -2989,11 +3013,78 @@ static int elf_header_check(struct load_info *info)
> >           || info->hdr->e_shentsize != sizeof(Elf_Shdr))
> >               return -ENOEXEC;
> > 
> > +      /*
> > +       * e_shnum is 16 bits, and sizeof(Elf_Shdr) is
> > +       * known and small. So e_shnum * sizeof(Elf_Shdr)
> > +       * will not overflow unsigned long on any platform.
> > +       */
> >       if (info->hdr->e_shoff >= info->len
> >           || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
> >               info->len - info->hdr->e_shoff))
> >               return -ENOEXEC;
> > 
> > +      info->sechdrs = (void *)info->hdr + info->hdr->e_shoff;
> > +
> > +      /*
> > +       * Verify if the section name table index is valid.
> > +       */
> > +      if (info->hdr->e_shstrndx == SHN_UNDEF
> > +          || info->hdr->e_shstrndx >= info->hdr->e_shnum)
> > +              return -ENOEXEC;
> > +
> > +      strhdr = &info->sechdrs[info->hdr->e_shstrndx];
> > +      err = validate_section_offset(info, strhdr);
> > +      if (err < 0)
> > +              return err;
> > +
> > +      /*
> > +       * The section name table must be NUL-terminated, as required
> > +       * by the spec. This makes strcmp and pr_* calls that access
> > +       * strings in the section safe.
> > +       */
> > +      info->secstrings = (void *)info->hdr + strhdr->sh_offset;
> > +      if (info->secstrings[strhdr->sh_size - 1] != '\0')
> > +              return -ENOEXEC;
> > +
> > +      /*
> > +       * The code assumes that section 0 has a length of zero and
> > +       * an addr of zero, so check for it.
> > +       */
> > +      if (info->sechdrs[0].sh_type != SHT_NULL
> > +          || info->sechdrs[0].sh_size != 0
> > +          || info->sechdrs[0].sh_addr != 0)
> > +              return -ENOEXEC;
> > +
> > +      for (i = 1; i < info->hdr->e_shnum; i++) {
> > +              shdr = &info->sechdrs[i];
> > +              switch (shdr->sh_type) {
> > +              case SHT_NULL:
> > +              case SHT_NOBITS:
> > +                      continue;
> > +              case SHT_SYMTAB:
> > +                      if (shdr->sh_link == SHN_UNDEF
> > +                          || shdr->sh_link >= info->hdr->e_shnum)
> > +                              return -ENOEXEC;
> > +                      fallthrough;
> > +              default:
> > +                      err = validate_section_offset(info, shdr);
> > +                      if (err < 0) {
> > +                              pr_err("invalid ELF section in module num %u type %u\n",
> > +                                      i, shdr->sh_type);
> 
> Same as the first comment here. Also, this is personal preference but I
> think the "in module num %u type %u" reads a bit awkwardly. Maybe
> something like "Invalid ELF section in module (section ndx %u type %u)"?
> 
> > +                              return err;
> > +                      }
> > +
> > +                      if (shdr->sh_flags & SHF_ALLOC) {
> > +                              if (shdr->sh_name >= strhdr->sh_size) {
> > +                                      pr_err("invalid ELF section name in module num %u type %u\n",
> > +                                             i, shdr->sh_type);
> 
> Same here.

Yup, will change that.

Thanks - I'll send v2 today or tomorrow.

- Frank

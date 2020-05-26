Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707A21C1F21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 23:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgEAU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 16:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgEAU5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:57:40 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F52C208DB;
        Fri,  1 May 2020 20:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588366659;
        bh=zQmw8TbV6rcDNsLeJ9F8FOdkMTGIKtNq4ynWn7aeG6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJrOsfG54lH/5iT4LJGsZVvBobr/BVhEDqwOCe0/S5MOBZSKNYFyrxyUHWYUrsfcC
         McZLRJYs9dVMs92X+SmecC1U0Ym7h3sK4u9sTi6n3ufcRYkRTHYkdrHyZCSUzmbvDg
         egc92ej29iM0zVZH4TUEGfCkIc/aL354VLXA5j5s=
Received: by pali.im (Postfix)
        id D011FA55; Fri,  1 May 2020 22:57:36 +0200 (CEST)
Date:   Fri, 1 May 2020 22:57:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 09/15] udf: avoid gcc-10 zero-length-bounds warnings
Message-ID: <20200501205736.uztnq4wlr4ckkhvm@pali>
References: <20200430213101.135134-1-arnd@arndb.de>
 <20200430213101.135134-10-arnd@arndb.de>
 <20200430215450.anfwm4zikvhy2bt5@pali>
 <CAK8P3a0_BuKDK7X8dTHyx7t++CGjy3jhDVvL=Jo5=kcUxmtobg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0_BuKDK7X8dTHyx7t++CGjy3jhDVvL=Jo5=kcUxmtobg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 May 2020 22:30:27 Arnd Bergmann wrote:
> On Thu, Apr 30, 2020 at 11:54 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Thursday 30 April 2020 23:30:51 Arnd Bergmann wrote:
> > > gcc-10 warns about writes to the empty freeSpaceTable[] array, with
> > > many instances like:
> > >
> > > fs/udf/balloc.c: In function 'udf_bitmap_new_block':
> > > fs/udf/balloc.c:101:36: error: array subscript 65535 is outside the bounds of an interior zero-length array '__le32[0]' {aka 'unsigned int[0]'} [-Werror=zero-length-bounds]
> > >   101 |  le32_add_cpu(&lvid->freeSpaceTable[partition], cnt);
> > >       |                ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> > > In file included from fs/udf/udfdecl.h:7,
> > >                  from fs/udf/balloc.c:22:
> > > fs/udf/ecma_167.h:363:11: note: while referencing 'freeSpaceTable'
> > >   363 |  __le32   freeSpaceTable[0];
> > >       |           ^~~~~~~~~~~~~~
> >
> > Hi Arnd! This looks like a false-positive warning.
> 
> Right, sorry for not making that clearer in the changelog.
> 
> > > These can all be avoided by using a flexible array member instead.
> > >
> > > Another warning is a bit more obscure:
> > >
> > > fs/udf/super.c: In function 'udf_count_free':
> > > fs/udf/super.c:2521:26: warning: array subscript '(<unknown>) + 4294967295' is outside the bounds of an interior zero-length array '__le32[0]' {aka 'unsigned int[0]'} [-Wzero-length-bounds]
> > >  2521 |      lvid->freeSpaceTable[part]);
> > >
> > > Work around this one by changing the array access to equivalent
> > > pointer arithmetic, as there cannot be multiple flexible-array
> > > members in a single struct.
> >
> 
> > > @@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
> > >       uint8_t                 logicalVolContentsUse[32];
> > >       __le32                  numOfPartitions;
> > >       __le32                  lengthOfImpUse;
> > > -     __le32                  freeSpaceTable[0];
> > >       __le32                  sizeTable[0];
> > >       uint8_t                 impUse[0];
> > > +     __le32                  freeSpaceTable[];
> >
> > Please do not change order of members in these structures. Order is
> > strictly defined by ECMA 167 standard and changing them you would just
> > confuse reader. In LVID is free space table before size table.
> 
> Ok
> 
> > If you do not like GNU C extension for zero-length arrays then just
> > replace it by standard C99 flexible arrays. I think that there is no
> > reason to not use standard C99 language constructions, just nobody had
> > motivation or time to change (working) code.
> 
> No, the problem is that only the last member can be a flexible array,

I know, that is why I replaced those 3 zero-length arrays by just one
flexible array in udftools project.

> so when impUse[] is the last member, freeSpaceTable has to be a zero
> length array.
> 
> > Also this file is semi-synchronized with udftools project in which I
> > already replaced all GNU C zero-length arrays by C99 flexible arrays.
> >
> > You can take inspiration what I did with logicalVolIntegrityDesc:
> > https://github.com/pali/udftools/commit/f851d84478ce881d516a76018745fa163f803880#diff-1e1a5b89f620d380f22b973f9449aeaeL381-R384
> 
> Right, this is likely the best workaround.
> 
> > Anyway, if you have a better idea what to do with such on-disk structure
> > and how to represent it in C struct syntax, let me know as it could be
> > updated also in udftools project.
> 
> The trick I used for impUse[] would also work for freeSpaceTable[] to avoid
> the gcc warning, it's still not great, but maybe you like this better:
> 
> arnd@threadripper:~/arm-soc$ git diff
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index 02f03fadb75b..666d022eb00b 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -98,7 +98,7 @@ static void udf_add_free_space(struct super_block
> *sb, u16 partition, u32 cnt)
>                 return;
> 
>         lvid = (struct logicalVolIntegrityDesc *)sbi->s_lvid_bh->b_data;
> -       le32_add_cpu(&lvid->freeSpaceTable[partition], cnt);
> +       le32_add_cpu(lvid->freeSpaceTable + partition, cnt);
>         udf_updated_lvid(sb);
>  }
> 
> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index 14ffe27342bc..215d97d7edc4 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
>         uint8_t                 logicalVolContentsUse[32];
>         __le32                  numOfPartitions;
>         __le32                  lengthOfImpUse;
>         __le32                  freeSpaceTable[0];
>         __le32                  sizeTable[0];
> -       uint8_t                 impUse[0];
> +       uint8_t                 impUse[];
>  } __packed;
> 
>  /* Integrity Type (ECMA 167r3 3/10.10.3) */
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 379867888c36..a1fc51c2261e 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2517,8 +2517,8 @@ static unsigned int udf_count_free(struct super_block *sb)
>                         (struct logicalVolIntegrityDesc *)
>                         sbi->s_lvid_bh->b_data;
>                 if (le32_to_cpu(lvid->numOfPartitions) > part) {
> -                       accum = le32_to_cpu(
> -                                       lvid->freeSpaceTable[part]);
> +                       accum = le32_to_cpup(
> +                                       (lvid->freeSpaceTable + part));
>                         if (accum == 0xFFFFFFFF)
>                                 accum = 0;
>                 }
> 

This is much better as it does not change order of members in LVID
structure. I'm fine with it.

> This version could easily be backported to stable kernels to let them be
> compiled with gcc-10

I do not know what triggers that false-positive warning. But if you
think that this change is enough to "hide" that warning, you can add my
Acked-by: Pali Rohár <pali@kernel.org>

For sure it is better to have just small changes needed for backporting.

> and then synchronizing with the udftools version of
> the header needs additional changes on top, which do not need to be
> backported.

Both header files (ECMA and OSTA) should be in-sync with udftools since
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=614644676394951e73194ea96b3f026c1adf5443
Differences in kernel code are: usage of zero-length array members,
usage of integer types and usage of structure attributes.

If you are planning in future to do some changes in those ECMA or OSTA
header files, please send updates also for udftools. So we will have
header files synchronized as much as possible.

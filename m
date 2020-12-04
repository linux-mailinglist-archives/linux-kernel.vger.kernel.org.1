Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE05D2CE732
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 06:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgLDFBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 00:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLDFBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 00:01:32 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A605C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 21:00:46 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o24so5164880ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 21:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NB7a1URi7J1NhIdBjSg3g739eJT9Q7vOhVIT0jhMEIA=;
        b=na0+RLGiw3vnnbJVf1HfSi0qDJwPYHOpUcGGhPLf8C1AQbhloiewQj5q2CrC+Gh0Fu
         q/8E42G59IAndHZQFwLA68AlryZ8Kv9nf0j25HpU4Aw4Z61hHlp6genfgibvTqNHy+eo
         FaaQXFaxOAG4FXmQaHlP4r5U3ChTANtjPSOEdmEcPsXnd8miWyeSwItkPeYUtZU0kRLi
         45L2yi4PWg1AGDiGaTlQlA/tHMo5cOljDgqMN1qbnd7o9JUSKlbZkWMkBdjZosusBa9n
         CEJl6qaPZyKoOuc7/wLynyNh4+9B8CrFqyNkWshbPYBxZXpiomo0SVMeWm5BbMorUSEg
         FKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NB7a1URi7J1NhIdBjSg3g739eJT9Q7vOhVIT0jhMEIA=;
        b=JCbt1WJka6YtiEbT9zpPQoQU21uVw8WGfl0+DQ4WHGlo6qhuHMKEgYoBU4lJgizdWq
         Uevum/eVDRiomA4bScmEh5P9C9zxf9apTCaUh91LX5OyzXgqJfQvBDxe9Q9J6Gg0PAzW
         i1PLWiI4aKN4mcpT/fkvtm73lFA56K6vGn6DleB8zphIiIw7mlrcXuCmR1wIfLAnGK2l
         QWmpkU24rcRZJ+PEhP8tGntwxvtgLy/hYiwIUZP1zl+1jISRllbT9kxraeJ/pgNgH1qv
         QPaXAK/rOCQHT7HP8azGeAdxyXWo9cIkblK1GtWtO3+PMW1XKe8NXhaoHtK+CxVBn2Sy
         BB9A==
X-Gm-Message-State: AOAM532vO+x5Aco1iDMq7B+5wyG/kUJOW3CKxfIOdjoPykoj3DeCpYp9
        RTaHqVZDOgSixCC9JpwCU/mRJuFz/BPsFBhhhXHU9kdcem0=
X-Google-Smtp-Source: ABdhPJw0w4Y4MJAlX+VS7xk9I3surizC/4XweFukPWvSzHL2//jEgEwhQB2iIIMuNc1heJgdXeMgKd9IJ4N+49i98xM=
X-Received: by 2002:a2e:9654:: with SMTP id z20mr2543089ljh.335.1607058044958;
 Thu, 03 Dec 2020 21:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20201204005847.654074-1-daeho43@gmail.com> <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain> <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
 <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com> <X8nAParf9GW9LaGV@sol.localdomain>
In-Reply-To: <X8nAParf9GW9LaGV@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 4 Dec 2020 14:00:34 +0900
Message-ID: <CACOAw_wOShYf23Y0txs6Fk_Qq9JGEjXGRb0MzMxrBxJpzCfLmA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in decompression
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I don't understand how verity works.
Right after verity is enabled on a file, is the verity logic working
for the whole file data area?
Or it's just working for the data area which is updated after verity is ena=
bled?

2020=EB=85=84 12=EC=9B=94 4=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 1:51, E=
ric Biggers <ebiggers3@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Dec 04, 2020 at 01:48:24PM +0900, Daeho Jeong wrote:
> > Eric,
> >
> > I have another question.
> > I understand enabling the verity can be possible in the middle of I/O.
> > Is the opposite way also possible? Actually, I couldn't find any
> > disabling function of it, though.
> >
>
> No, disabling fs-verity on a file isn't possible.
>
> - Eric

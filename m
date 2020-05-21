Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA31DC483
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 03:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgEUBU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 21:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgEUBUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:20:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C93C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:20:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f13so5773948qkh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KMXAzH/Kv71HtUNnaKyhHOguIQwCV7+n2NDcWkB9O5g=;
        b=b3Qufz9Bme30CIB0oGj0m8BNMRnDWpRbJB9ckcOznK0iSOX5QCddKpwsRCwpHUByOu
         lie7SldmpLexNaRE4VlWEinTyQWUR20021doAnVkcQMDtmI/jv/gtvr1J95VnfQQdGiy
         UIjSeH6duas3tS51hAoKS+cc5OR5GZGwO16VVFu/aVG/rIafQR0Rlo/bkwdcTR6CNQpU
         4lAKfbLgBaVpSnvdemRH0+XN1TPBVGQ7DJZHaKodQGVVjZMqvs6PKcou3smR9yGNDfQw
         4+FSxLIeg5eXqaO1iS1CKGptB7B8iRirue/eXFVUkLVKKWA+FbUXpCecx7slTpMBCrPZ
         5FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KMXAzH/Kv71HtUNnaKyhHOguIQwCV7+n2NDcWkB9O5g=;
        b=avlcAYygWdY1/P5U36tbHbuNSwfUhaaDgWR6BxSuZtC2+KSrCTYAPXv9biCvFl2PHr
         01CijQomYYnlas3/jHcDsAjHpHpSHYlQQCsANzYeL4EDDIYNiLb1CyNYXu0LFQbkpBXy
         SFIPZcBnK1VWf2ehEa4niPI7W8aMueYkSWrsFuQ44PeID8yBXP83uZmOx1/F76mGtwc7
         WWVU7xwws56pI+3m0jeJWmRe+iRPVTP9XP4Bku+7MBMhnh0P9iNFtsvp7vK1cZZjcqCc
         GZWuDSiPRanmL+cPmALIRzY0m6ZX3sRFguGjdc0/k2LzTpNf81qZFwT4EszdhPuT+7L9
         tC1g==
X-Gm-Message-State: AOAM5333XPSNMKtcHavcvxeHkwm0p5t/VuCl9k2RI8uHewxi6zFAMyFT
        YBVPyU4vhmtjbECLTuNRMYusYYFWuVnaYU5S3zw=
X-Google-Smtp-Source: ABdhPJxf56ExTuAT79VbjVY9YiXT3HT0IYTGfEIgMEVu94RqzG0+k695G4NT+a1bQxBXlgQ4ScLvAEU5DiLWN3pAqBo=
X-Received: by 2002:a37:d245:: with SMTP id f66mr6877706qkj.452.1590024054857;
 Wed, 20 May 2020 18:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-4-git-send-email-iamjoonsoo.kim@lge.com> <20200521004324.GB317575@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200521004324.GB317575@carbon.dhcp.thefacebook.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 21 May 2020 10:20:41 +0900
Message-ID: <CAAmzW4PomH2nL9M1G9A3g0fkMUtsizhZ6w-x4909z=NOx23iWw@mail.gmail.com>
Subject: Re: [PATCH 03/11] mm/hugetlb: introduce alloc_control structure to
 simplify migration target allocation APIs
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 9:43, R=
oman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, May 18, 2020 at 10:20:49AM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Currently, page allocation functions for migration requires some argume=
nts.
> > More worse, in the following patch, more argument will be needed to uni=
fy
> > the similar functions. To simplify them, in this patch, unified data
> > structure that controls allocation behaviour is introduced.
>
> Is it all about huge pages only? If so, maybe adding huge_page suffix/pre=
fix
> to struct alloc_control? E.g. huge_alloc_control or something like this.

No, it will be used for other migration target allocation functions. You ca=
n
see it on following patches.

> >
> > For clean-up, function declarations are re-ordered.
> >
> > Note that, gfp_mask handling on alloc_huge_page_(node|nodemask) is
> > slightly changed, from ASSIGN to OR. It's safe since caller of these
> > functions doesn't pass extra gfp_mask except htlb_alloc_mask().
>
> Changes make sense to me, but it feels like this patch is doing several
> thing simultaneously. Do you mind splitting it into few?

I will try to split it on next spin.

Thanks.

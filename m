Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B75E2CE85E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgLDHCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLDHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:02:47 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F049C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 23:02:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id o24so5416960ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DGtZLLbFDWoCQqYx9LfvjHPyF73CfxgpUXIf4y83koQ=;
        b=PKdyv27y3AZcNIpFmJN4IexnpXLeYF7dsYQD0hLr6Re40GrmkO6dSIBUQzFksxPrWy
         qnQaRAqgM85WhG4I9zWQzxu1CbBtXf052bshXLmR8KcrOFQ/tIQKFmuTsOrb8ZqC+yyj
         9HwEYGuufCYCuuZsY9BEBI/tY/d5bmrUYc/LfRQpQil7msHn33KHeb7m8ftfYc5oEkqJ
         qV41Jfn0skzideGxiH9UXZILkWCwerJAqj1u60Y3UI/A8G1e77kqiAqbXiWeGcdmbJUn
         fjnffPmoeZUmL8IuMGKce+brMxyVYtbwiCVRD/nKUEhOHT70MK8G0rSunGqISv0e5gx5
         UO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DGtZLLbFDWoCQqYx9LfvjHPyF73CfxgpUXIf4y83koQ=;
        b=eJHTnOKoKl88smE4JwNSMXikql3294Vuyzp81ebT741h5fcLbXXAOIUqjOCFMlMHpR
         BRY3M2G+wxo+XE91wpICYqc/gbyB/E9Kv6CtcxOnC19QKPComjPSft5/3I7Jc+HfTjsC
         tbkIqHrfFsAIxgZTZtvzyEe5fRS8T1oGozjIUMNvOkse3GYiLY5iCOvUjnX9DA6GFXrO
         /CXAFOXg+FhR5irsmaUeZ67+AnCCuN2v75Sztdekh7N5iWSI8DofNxZqnD7PjX7oTVR7
         NSy/wsY9BJAR1HhqNZjaiYFHUezd3Qj1hRXMkLopKbnOHXEllFWnNPOcAqSmqfP4XWQ/
         jYsg==
X-Gm-Message-State: AOAM530/fcFe1byCw56hUQHnu8y75K/H7knZ/3Gc6L6owzI/A+u86KoR
        ySJxE0rRelkIn2t3ySsZPCkq1cGy+x3lnFJ9K38=
X-Google-Smtp-Source: ABdhPJx03vml2qZJmzdaER4GawRDs1zl5iA2sew69N6FEp9q2vwnZucI8MjZIGzQkHAh4gRehD7/1CHLqBps1MLJDB8=
X-Received: by 2002:a2e:9707:: with SMTP id r7mr2658587lji.265.1607065324902;
 Thu, 03 Dec 2020 23:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20201204005847.654074-1-daeho43@gmail.com> <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain> <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
 <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
 <X8nAParf9GW9LaGV@sol.localdomain> <CACOAw_wOShYf23Y0txs6Fk_Qq9JGEjXGRb0MzMxrBxJpzCfLmA@mail.gmail.com>
 <X8nGvfEeTDTLa6FL@sol.localdomain>
In-Reply-To: <X8nGvfEeTDTLa6FL@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 4 Dec 2020 16:01:54 +0900
Message-ID: <CACOAw_wfew8xER-CibUtddRKVtcr3k_iGzjQ-bVYxqRUuEVCcw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in decompression
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explanation about verity.
I got your point. Thanks~

2020=EB=85=84 12=EC=9B=94 4=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 2:18, E=
ric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Dec 04, 2020 at 02:00:34PM +0900, Daeho Jeong wrote:
> > I think I don't understand how verity works.
> > Right after verity is enabled on a file, is the verity logic working
> > for the whole file data area?
> > Or it's just working for the data area which is updated after verity is=
 enabled?
> >
>
> It's for the whole file.
>
> My point is just that if there is a bio that saw that verity isn't enable=
d yet
> when it started and therefore STEP_VERITY didn't get set in the
> bio_post_read_ctx (or the bio_post_read_ctx didn't get allocated due to o=
ne not
> being needed), then the filesystem shouldn't change its mind and try to v=
erify
> the pages when the bio completes if verity happened to be enabled concurr=
ently.
> It's too late for that bio.
>
> - Eric

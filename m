Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2129D538
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgJ1V7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgJ1V56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:57:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:57:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so632075wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uP/JEghnSGmj7e6AesSlvrZCV6WUBdPW7UyUOd9YPjI=;
        b=xGxWf1sYuQimA8Pb3JOW0Wj0BHMIJCwn1gMWtOQy75nP6RaEoOq5C/GkmXVi7pHKQj
         JQ7bvUzAW0JZrXHMEn6KLifhrkFXf/U+agkeQOIAgrfBy0MRN1A7wsUEVG/59kaV8fJG
         BuzwSFP8yoA5JQmdAV/2ctelQ4BILa1EQC4ju8/13mBjAWU+WvL2gkKqqiBJHgwYWfLt
         JdZRj5Gs/OERhjmHPr+eDxQN87UPieTnau6amvhohFijsraX4+FiMqA24NPddFbiG83O
         DEN322EhEyA2xNoTK71H29NH8ZgHWk8I0D6k3VymVMJP3jgQ2rL9e825nsEH+EaHXORU
         oI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uP/JEghnSGmj7e6AesSlvrZCV6WUBdPW7UyUOd9YPjI=;
        b=t6srV07nV5eRYkMUb2b+ihPuZAM7hp1g7CiZN+DbxePkvij5Bd2ej/hTDwyh3esz0z
         9xdp+LtGGy0Xrh3IcyvnmI8Aa6+164RKtnIkyV9tN/S8pqcOH/BB1SHnWVcVCCxQT1Kp
         cN6PYH0LTM6OL4IhcqE/OF3yLeN9U3X4IJYAMb6JxFtNi+kZTaOycQ7pM6T5zBF30aY5
         lSRGCVC43LR4WPp4Aj1FIhpJC5UpLImvBm7qZHNXkT9DifVzjWxt9waPFZZtZK4nG9Z0
         Hqhe+AK3GFqP9WCQWopkqT+75FR5pk5rneLGzXAO5gxO9GK9FD4ohQiZJO5+I4HE3SoG
         ACqA==
X-Gm-Message-State: AOAM530BokDkhEqwR273EILeL+9r4aR2PgD4EaM3LoTh3aegR9PJTkWJ
        Nd2H913qN2S6fgsDJ53N5vZS2hMiPcX2C7rL0rImi2wPaw==
X-Google-Smtp-Source: ABdhPJxy3tTKM5QLQXt5ygim35ZXlLtmSNyEsb2Vs87VSTGD8dpJf1fiQCjE/MH+lUa0LAsHp33dW1sarczD6VGn2D8=
X-Received: by 2002:a17:906:25cc:: with SMTP id n12mr4949548ejb.488.1603846795601;
 Tue, 27 Oct 2020 17:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <8c04d5c5d0144019c2c38d7c3f31061d6b35d360.1603469755.git.mchehab+huawei@kernel.org>
 <CAHC9VhQ88cuU-0QdpYJyJZE3FU-3graP=N9n9eiG4Kj2tDbiBQ@mail.gmail.com> <20201025233820.7f946e1c@coco.lan>
In-Reply-To: <20201025233820.7f946e1c@coco.lan>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Oct 2020 20:59:44 -0400
Message-ID: <CAHC9VhTZtTXO8Woo_cCdBbg9Nq5A-vBdoOJo7gNUk+RRNBbeaw@mail.gmail.com>
Subject: Re: [PATCH v3 51/56] audit: fix a kernel-doc markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 6:38 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
> Em Sun, 25 Oct 2020 18:10:44 -0400
> Paul Moore <paul@paul-moore.com> escreveu:
>
> > On Fri, Oct 23, 2020 at 12:33 PM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > typo:
> > >         kauditd_print_skb -> kauditd_printk_skb
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  kernel/audit.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Looks good to me, nice catch.  Would you like me to pull this into the
> > audit tree or are you intending this to get pulled in as part of the
> > larger patchset somewhere else?
>
> Feel free to apply it directly via audit tree.

I just merged it into audit/next, you should see it shortly.  Thanks!

-- 
paul moore
www.paul-moore.com

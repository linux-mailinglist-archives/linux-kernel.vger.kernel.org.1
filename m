Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF628E13C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgJNNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgJNNZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:25:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3942C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:25:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c141so3675140lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKFq6iwfvEkroibpmULLRLiQ1H931GZCc/Lu/Ysbxus=;
        b=gm7JdoEUZtN9HQCSRKe3cLDHs2mUxvk2g1hCrMvKdnYkdNFEHx8JeZOhujiGzMFi7t
         IScT5UvNf6Iuc2dfCJkq7h6Q9mG2eQbxmmaisk3ldX+OyPouie0QOdt6TG73eZL5NL56
         PBRoaCEchoKvs2H2oXJy32RsRulN0yTFdDkARAtNZY4WeWGnpnilumB5tHXFyrsp7glt
         ytkHlivCwSZbqrvREVvqIRcqDsTIQzKXCN8+ThSbI0QwOdkS9RoB8AViOSu1OUreXIW4
         1XeTHOlMsMhVnv4SNnXVvHcnylVtqIu4Rn1SNUJfxjWL201oaxlMhsXRDsbxcwexWvhd
         Uk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKFq6iwfvEkroibpmULLRLiQ1H931GZCc/Lu/Ysbxus=;
        b=KbkR+IjeEo2ThAuXWBVfEwMC49IQM+3+HQi33BTdKAsvlZQD9BGRUutSmKakyaOJ1r
         v01TuvEZtp3eeeqS2+knBaMP1vlH7lGK/4eZ/jVY9t1/q1HhStaEBotRUxNZMmJpe3vt
         1VipaYCf39VqLqIsZfKjwaKKCS9uFQRxQExvOL4Ndh0yeMH8oFFXu4d0KW02nquFvjHG
         oL7NUDWjbr+y+Ld0par/j9jUyvwh8EUUVKwT5RAhagb9cnwOjWhwSHdtOuBN9ZzLMuPI
         7hXZfglUC0PlAF6R4k6Z//BPp/XmE3fK/pGIXDK5p66EBxBR+9cFvrRsCEMCbmf6rogd
         qJ6A==
X-Gm-Message-State: AOAM531uV3C3wubbqK/rTA/rOVrL3dz9aJMQ/xVDu2bamGYZS/AV2oDO
        vcmP+PVPnzmMu352Z5orQdGvKtL+QMn97rLyRVA=
X-Google-Smtp-Source: ABdhPJwulrqs2A1OwJl/ciD0ZDmCvYFr1xNNHp0xX0kyXd17jU0DVKvM+U1lUNcFP/8HGFI3MD3JXtZv7707iMXArNI=
X-Received: by 2002:a19:40ca:: with SMTP id n193mr1250337lfa.96.1602681935224;
 Wed, 14 Oct 2020 06:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201013152648.438887-1-anant.thazhemadam@gmail.com> <d75dc535-00be-3aa7-addb-c2615b202b56@redhat.com>
In-Reply-To: <d75dc535-00be-3aa7-addb-c2615b202b56@redhat.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Wed, 14 Oct 2020 21:25:24 +0800
Message-ID: <CAC2o3DJ1qBO+dhFVgGk_u5X2K0_G-pxQVjT32z=dsPL=4jr1_w@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH] fs: gfs2: prevent OOB access in gfs2_read_sb()
To:     Andrew Price <anprice@redhat.com>
Cc:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Oct 14, 2020 at 9:04 PM Andrew Price <anprice@redhat.com> wrote:
> Just a heads-up to avoid duplication of effort: Fox Chen (CCed) has
> attempted to fix this also[1], but I don't know if they plan to send
> another patch.

Oh, I thought it was solved by someone else as you've pointed out the
correct solution the other day. https://lkml.org/lkml/2020/10/5/538

I'm solving another bug right now, I will leave this to Anant. :)


thanks,
fox

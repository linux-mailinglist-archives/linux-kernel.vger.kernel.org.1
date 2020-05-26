Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906BF1CEC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgELFzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 01:55:36 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:19213 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgELFzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 01:55:35 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 04C5tNiR004068
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:55:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 04C5tNiR004068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589262924;
        bh=R1QyXhhfi6uyVISRMA353yWXmI83w82IGzf0lqkZ32g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YOi9zu/tAzeXRtqq4nr6XnAPOx019n+87/gbNmPG70ira4CC+pRfweZJ9djbiCZPK
         VZufngkacRsVURSLzA/nCVZPjoiGHayewU7Fc9CdYMyAyAdY+tNN9HeWmUtwj0jT2I
         bDASttsRnCLSwoUuGMAmEEI4H3tM78G4yrwGrZujzfqIHH+cqRm4cVIRMQjLAaD3Zj
         00VZyOFRx1PPOd7sgqtCT6OguHHbao6Ade90TN0l6p+jOlnpiipCXU+2v6R+CgV7Bi
         3+v4QXBbAUqZAQSWwPSYLE/klYd9BMaPlJJRFWL3S2NzsuawfgPo1Tr8PTFtIQ49qI
         QqcZjgyyZECZw==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id s5so4319205uad.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 22:55:23 -0700 (PDT)
X-Gm-Message-State: AOAM530cHdeBdeqhePhSPx5R88HeCOOF6MXoUnCBZYPAZs9Q9hnQBXTg
        /Ht7OOmX85ysM7UH9TyuJbrsKdxQGEW8VSeN0co=
X-Google-Smtp-Source: ABdhPJx6QiE8Lap+c9ItB/310joi8PjtYGhGB5b6X8mQGrfGWqo3dxH7g3ctBHE8D1Rp1QxbplEz2g/cB/p3dnllGZs=
X-Received: by 2002:ab0:3245:: with SMTP id r5mr1774480uan.109.1589262922884;
 Mon, 11 May 2020 22:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200510020044.958018-1-masahiroy@kernel.org> <202005091914.4B8CACB91@keescook>
In-Reply-To: <202005091914.4B8CACB91@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 May 2020 14:54:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAShqo4=YJ9AxqZqHU9t4Axnmn2AdY4sOTTM5TEXVXTNzA@mail.gmail.com>
Message-ID: <CAK7LNAShqo4=YJ9AxqZqHU9t4Axnmn2AdY4sOTTM5TEXVXTNzA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: remove always false $(if ...) in Makefile
To:     Kees Cook <keescook@chromium.org>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 11:14 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, May 10, 2020 at 11:00:44AM +0900, Masahiro Yamada wrote:
> > This is the remnant of commit c17d6179ad5a ("gcc-plugins: remove unused
> > GCC_PLUGIN_SUBDIR").
> >
> > $(if $(findstring /,$(p)),...) is always false because none of plugins
> > contains '/' in the file name.
> >
> > Clean up the code.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>


Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada

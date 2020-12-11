Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2030C2D6D31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404512AbgLKBTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404495AbgLKBTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:19:13 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4103C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:17:34 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 186so7032188qkj.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JHA1SclwwNflc1fMREqK5MdJqK9jjD1N+6vraV7m6o8=;
        b=JukTSVza+dhKaOGY0Riuy1AeE4K29MqyTB0kpsTnWcIvTb7y0NLrf/+fMWi8nagH/N
         Uf06kBkKtOQRCd5X3PYJ1pxq3MOolofLSpKwqgknsxRP0QGLH6cJSU/+TjNanTsvItep
         nGTYn76RwblxaSUV95Bm4ZXospXaAI7sD6Vg0sZqm3q4T+AxH/AeMmjEgmRIGNF9AhHw
         cRu32e7P1gGzQFM7LfgAH5KDG3I7IKNjKzqBpQnn3eQRlUDnQWYCyDE8rGNr48LkDe61
         r3HM7sSlbUKfCiHTSEI+vDjPzIDPo3TAJC2UsXVLkWnDVqobOk7gGIYRyIKGVh051Fxn
         ZcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JHA1SclwwNflc1fMREqK5MdJqK9jjD1N+6vraV7m6o8=;
        b=NMNoupFhbuFArZ/iI4nhBrzRFvK1QVPPBh06/8GTN4pg4nhuSfFqioKQ6TgHxoi/Ge
         My+DthYrdTfEXKjTfD61BaO5WRg6Z/N+fVSDooz5q2Nns5hRjDqBHk2b49a6v8thDwf0
         /1guM2n5Odq97m9uvyPLkCXmwuCFwfd7PJNtqyhCuBX+XK+VypqHTkvyo0c4Hb9hzCmt
         xkiuHLaKB3Osd6X8T3o26/bf2JuQ9TuGefcakoJ+kPXrEG52UrObt9oS1BRcm/v4N5pm
         jlV9g+XYcvlGBsnk9EI3nh7vc4A2oXMrHr216uxjdpnrIQAfmiJAlpNZYjcGtbsj+eLH
         82QQ==
X-Gm-Message-State: AOAM533aXnFOWPEUDgiHTXcdJBEo6uKHtO3fM10xq7sOKQ7eUe5+T9Cn
        wz6TKyWQG83pt2IlkPeU3FL7Ez3wvWvHXfgcelE=
X-Google-Smtp-Source: ABdhPJz0NbWA5ixjUmeoJ+V6ZkZQhFCIoBmihIRYU44UowbtdmtRSdHyokna7qrWukLxHu6pDZSgeXKN7NvzOJNfL0Q=
X-Received: by 2002:ae9:c013:: with SMTP id u19mr11921227qkk.59.1607649454106;
 Thu, 10 Dec 2020 17:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20201210183729.1261524-1-alex.popov@linux.com>
In-Reply-To: <20201210183729.1261524-1-alex.popov@linux.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 11 Dec 2020 10:17:23 +0900
Message-ID: <CAAmzW4PbivLRBMDR1HykzpFS_ekF4Z-pkAm3n_a5En-TArZuPQ@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: Perform init_on_free earlier
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 12=EC=9B=94 11=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 3:37, =
Alexander Popov <alex.popov@linux.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> Currently in CONFIG_SLAB init_on_free happens too late, and heap
> objects go to the heap quarantine not being erased.
>
> Lets move init_on_free clearing before calling kasan_slab_free().
> In that case heap quarantine will store erased objects, similarly
> to CONFIG_SLUB=3Dy behavior.
>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

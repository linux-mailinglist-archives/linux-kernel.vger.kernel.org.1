Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC02D6D30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404480AbgLKBTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404468AbgLKBTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:19:03 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FDC08C5C4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:17:16 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z20so5364376qtq.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2n25eVeYwJwJEQSpBnUbsA/VYusbzI2FjI83kAbMkUM=;
        b=OoidibmzJM8FY+fLVy5oGNIhE+hZQvybpZraGbmZGbLTYsX+lK5IBoySlrDDMdzTXV
         XJjICjohp12ZWQt4DbTgStQYqNYDpL5qpthTob4AT1pFXGgdalG8qBXSD9hV9923BspI
         Qmm4cct6as6nyyQD5gBjGXRTQEGsDS+a0bsmTOV/52EcbgooOETiSvoaJkdL2bklur+y
         2755FgXlRXBMnioLw+WVy/h/vC8XeWZzj6ng9+5GHh+wKAMu5oCVlSgNCK0AMFhs4Cs0
         OfkKejJ7/EQJuum+nIU5MjSwUOaCxf+9nCtD+O+wx+yHXBN9piQ26swMloQgPpVLevcV
         dmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2n25eVeYwJwJEQSpBnUbsA/VYusbzI2FjI83kAbMkUM=;
        b=BzVzcBQ5eQyfAX6kYeHXe/8Z30mrT6ceAYffE6Gs1M89E5aDHHQy+ofDz/XHCm0bIp
         qja57lBrSBvtAZePJycu2eZE4PQ4Qzr6rzsF0Ozpf7FqNIaOamQN24wbSTGDu3kSazaM
         rtt2RxIoDKLt72//FrCtb28lby40r/UvN/iwI9Mu2PaLvFF0uKpFD8Cw6PlhdLNwWCjb
         rFRk92F3UyhhU44Fq3vLtjI+6iqiTE1/2LLRlyeUFFYoLsbncBVXcVWO4TWVgH1qYaJE
         32ym8uUyRhotls9px9XBlNO85wEETspUdQAG4lCBCawwgxVybRlz2C6ijtsxFj7gBPh/
         OYCw==
X-Gm-Message-State: AOAM532of9pko2XnwXhjWebrAtpbNIgR3N1lsGcIxW0a0l/wZgKHWfE/
        7u1/dVJwtjpQQh80BFRYEmzvWIVwsjHzn184FLQ=
X-Google-Smtp-Source: ABdhPJwKxmvuVC716F8eCTuGBPdQQHJBDcAFCAVQxZMSphn8ehOHVaQEpEZFFtr33WIPaT39hFpJAoHX5vS2OS1yHtk=
X-Received: by 2002:ac8:6e81:: with SMTP id c1mr12501578qtv.36.1607649436049;
 Thu, 10 Dec 2020 17:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20201210160020.21562-1-vbabka@suse.cz>
In-Reply-To: <20201210160020.21562-1-vbabka@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 11 Dec 2020 10:17:05 +0900
Message-ID: <CAAmzW4M0qS7XBQ1L+iWLWoLh2R30EeLaPy=5Ncw-Uz17bdKukg@mail.gmail.com>
Subject: Re: [PATCH] mm, slab, slub: clear the slab_cache field when freeing page
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 12=EC=9B=94 11=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:00, =
Vlastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The page allocator expects that page->mapping is NULL for a page being fr=
eed.
> SLAB and SLUB use the slab_cache field which is in union with mapping, bu=
t
> before freeing the page, the field is referenced with the "mapping" name =
when
> set to NULL.
>
> It's IMHO more correct (albeit functionally the same) to use the slab_cac=
he
> name as that's the field we use in SL*B, and document why we clear it in =
a
> comment (we don't clear fields such as s_mem or freelist, as page allocat=
or
> doesn't care about those). While using the 'mapping' name would automagic=
ally
> keep the code correct if the unions in struct page changed, such changes =
should
> be done consciously and needed changes evaluated - the comment should hel=
p with
> that.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

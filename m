Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76B62A1821
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 15:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgJaO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgJaO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 10:26:32 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1641C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:26:30 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id t8so2189562vsr.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHI3Q2fOLLrmm4wKuaWbsYixW7vlYPYxYs2uwmG193g=;
        b=MQ+2Nno/5EgRdUUjWKkb0/1gLXIdbUJ/gLkqb3dmOj2il0PyPjQEUxrEJBQlxTAE4Z
         2d3FT2s30oFvxAfmmeNRPPyqaxWLDLiCLkI4I1xjKlJCM7zWwcb6YKAkw4bcD3tu7zX4
         J6SvjzGXzY04o41b+DYFOOC9j43eBhuGqTlGubzVBETwXFeu9icVjt1xsIP3nA2KJFzY
         hhbXVrprrpENg8f1xtlcjb7Dcotqp4WK2DPLhiGK1+Oj2SXLOjynEJZLvYEUkLB1peFe
         KhFXNCEp8FNCSZSmpcdJNasHFDWgZj/Ges8sINyHxIS5JeF4p8oXJN6XhfiQ9Nhpzbcy
         2LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHI3Q2fOLLrmm4wKuaWbsYixW7vlYPYxYs2uwmG193g=;
        b=sC5yPn0Hl1QLTHrPJpd6ioWeDAGwK7RM82Kf2mNPTvpy0vyAV1CYkvyDnFz1EuJ8Ld
         HX7ES+DXRG5jUEDi8p0wRoL96R/wcnnZJatvzFsjRtNtP5AHq9Ut/K9eVmxvnxiM4jN8
         Xt1aUxw93utorKUEmoUzWv1Sa7P8FkZ2IE6oEB+E1j5SiBE4HXKnybcoc+HMcFn+N7wF
         9PK51MuyteVBv/xwUP6oiZodvgq2eils0FP5BVxZ2JVA/qwsKdH8Bd+weQ5/YhFAkGGK
         q8HUIqMi0vulULutErzAyctGx8h0RAucSqnMJTptEDEVpM3KrJp4oKQKun0oVSh1u+Jx
         yaAw==
X-Gm-Message-State: AOAM532huIFvemOqdEzCo4jHiDuA4RsNoaRT2FS72T2L+g8LnIIsvF3F
        SQ0fm/MbkRk781jWqca0x6qhwLvDpd0=
X-Google-Smtp-Source: ABdhPJybs9FfI3gqcGhhAx2y1Bys3s9vHl7eE4ef7W6l3fMFbDtlkBC/srNwD00J93PofnXh7Xm6IA==
X-Received: by 2002:a67:cb09:: with SMTP id b9mr10524053vsl.49.1604154388744;
        Sat, 31 Oct 2020 07:26:28 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id e125sm1120433vkh.44.2020.10.31.07.26.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 07:26:27 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id p12so132918uam.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:26:27 -0700 (PDT)
X-Received: by 2002:ab0:299a:: with SMTP id u26mr4227896uap.108.1604154387016;
 Sat, 31 Oct 2020 07:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201031004918.463475-1-xie.he.0141@gmail.com> <20201031004918.463475-5-xie.he.0141@gmail.com>
In-Reply-To: <20201031004918.463475-5-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 31 Oct 2020 10:25:49 -0400
X-Gmail-Original-Message-ID: <CA+FuTScDa4NEo0xh1Uu+cB8QZ5mbVs6QvP0=xkritTzS9U7TYw@mail.gmail.com>
Message-ID: <CA+FuTScDa4NEo0xh1Uu+cB8QZ5mbVs6QvP0=xkritTzS9U7TYw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/5] net: hdlc_fr: Improve the initial checks
 when we receive an skb
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Krzysztof Halasa <khc@pm.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 8:49 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> 1.
> Change the skb->len check from "<= 4" to "< 4".
> At first we only need to ensure a 4-byte header is present. We indeed
> normally need the 5th byte, too, but it'd be more logical and cleaner
> to check its existence when we actually need it.
>
> 2.
> Add an fh->ea2 check to the initial checks in fr_rx. fh->ea2 == 1 means
> the second address byte is the final address byte. We only support the
> case where the address length is 2 bytes. If the address length is not
> 2 bytes, the control field and the protocol field would not be the 3rd
> and 4th byte as we assume. (Say it is 3 bytes, then the control field
> and the protocol field would be the 4th and 5th byte instead.)
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>

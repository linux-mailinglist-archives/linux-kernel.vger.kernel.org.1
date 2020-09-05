Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263EC25E6A6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIEJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIEJPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 05:15:50 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC896C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 02:15:49 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b16so4929698vsl.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RoDZrCWPX9A0Bk3ax7/cbjBpHqEVKLKIuXHwkDH7VY=;
        b=jnRFSPOIWRG2Az8sol67J1hDxmLVRPM20yv2mennfOoWjr0SITUs8sjVw/xh0Me1KW
         Hl8chs6DT9V2oF1z7LooGgyWsEEDfhEFOW+/WahvIMtbrzegRR0lZbsUl0Ov44usDWj3
         vpwPKWIterWDkyKWo5gdP+OgOf41YthTPejZkD0nKoWa8Z8Vk1jJ2i98gbPFNz/+jZml
         vnrjVaZTV5omAlKp/t3O9gi0l6VrnpqlMXcDcS3yZ3WlaZOq/BCibtSf/XCN8siMeDyc
         Fjt8u+Cyf0PB4Q2wjArjU510CMelh7vqJ9HOd3oRXU1YOpy+23pqtyIuxpZgN8LDvn11
         pmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RoDZrCWPX9A0Bk3ax7/cbjBpHqEVKLKIuXHwkDH7VY=;
        b=q92Gflo9YVECo1MPdlftxbnbsoyLylV6/WhVT8BiaIl15yXf7eb+wx1ZjFZxXDR/f0
         vhUdFBz4N5p3wQVWuox881om7xw9lDfKKTmJtCYL9dXLGXZx2Tm1pNbCNzKR2GFW3MT4
         YjmmDbRzKvszgTSbWMCz/kZpjV5mZc6RhxRKfI+tS4NtS2HfG7/zDJhNT6Q+O/iLpz3x
         wfBOKSSyOt0tAa5UpuPo5QagrECY7RpyqWvzPPmi0LETrnJRkQXlNPzecsTQNjA951jy
         g+QJWi/oKAkykGgTNtvtxTFbWbLsY7x2RUEnyVMhnyCDbI8h5ODXrfH8eSLq4T3tKINj
         ccwg==
X-Gm-Message-State: AOAM533Lac+4DSSbCSowF/eMtkfLCDPGbVeT2bzj3GgLViEC824mq1Dz
        9gSCNih/JvHDByO6BZiSbvllSI74hbBmRw==
X-Google-Smtp-Source: ABdhPJw+elSb79pYQu/Uf0cZMpl8b/y9sIwWCLE3DleSbqdXqcQhny69v+bAIXiXeoSXVCutceLxWw==
X-Received: by 2002:a67:e0de:: with SMTP id m30mr7630784vsl.89.1599297344208;
        Sat, 05 Sep 2020 02:15:44 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id q74sm1454811vka.45.2020.09.05.02.15.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 02:15:43 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id y3so4949406vsn.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 02:15:43 -0700 (PDT)
X-Received: by 2002:a67:ebc4:: with SMTP id y4mr8214457vso.119.1599297342417;
 Sat, 05 Sep 2020 02:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200905085058.68312-1-wanghai38@huawei.com>
In-Reply-To: <20200905085058.68312-1-wanghai38@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 5 Sep 2020 11:15:05 +0200
X-Gmail-Original-Message-ID: <CA+FuTSfWP+=Lm8h_PLNsrAaV5s-ACbS=YMBqjy=UpCuDEMhzKA@mail.gmail.com>
Message-ID: <CA+FuTSfWP+=Lm8h_PLNsrAaV5s-ACbS=YMBqjy=UpCuDEMhzKA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/packet: Remove unused macro BLOCK_PRIV
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Mao Wenan <maowenan@huawei.com>, jrosen@cisco.com,
        Arnd Bergmann <arnd@arndb.de>,
        Colin King <colin.king@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 5, 2020 at 10:53 AM Wang Hai <wanghai38@huawei.com> wrote:
>
> BLOCK_PRIV is never used after it was introduced.
> So better to remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Acked-by: Willem de Bruijn <willemb@google.com>

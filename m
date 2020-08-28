Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3374C255CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgH1OgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 10:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgH1Of7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:35:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC7C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:35:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so1834250ejp.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obd2Zc0n5DWbUEzzD7kqNaHpie9Nx9kaG1EevQsqECs=;
        b=FGsI/0p1m5MAwISMfbO63e+nCOplHEUbxSgCKXheCymeRaYx7V+9Ftdmr/IQD241pe
         XXJEDfkE0iflNjucnCjTvbt2bDo2pWgLbT9Uwc5jCYTR3OcK3mGrkt0TbsbbqaFkIJYL
         bro0vw7HGvwT15minkx/TtjTcIKE08qB3Vj3YC53uvollDZbeu+6NSvU2E77GWVUukZQ
         yoeDG1laHDPpJ560BBMKWU1iq1Zr+HIasn5gM/oFm+F4Aea61RFzWQIWA/FCcZcVDikl
         jBROUmGrW4HiNJ+uHAdnxVKFaEhW4i3KwU4GyfAdNb/O8SFmqWeM8ferVcz3KwFkTB+T
         2pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obd2Zc0n5DWbUEzzD7kqNaHpie9Nx9kaG1EevQsqECs=;
        b=cbUZEWfxqMaBN+0ZcSZkuvd6Jq5lNyW8ETCsiTmvdQY/nm5BeQZgx7WUvMPwF0PI3g
         pLYnGL6P1tdlT7d7AM9SGLzFR/dJC8jzLbuTF6NlxFQtj/5eSU2tyX3DXUa656VIilmV
         ikBJBg3onkJCRBFuoIjGzKsJZFahrgf6vGj8VLMn3lw/JMkpTEYxM1r4cc6/pYG9igX5
         QZHk4Kph4VvVNSy77+pUFkwffXmPy0pPXBwVuB6ppm51U5wC6s75+W0jTNyDXv5sQU2q
         NT+dlxexaAn3fk00cD0/J0hXGAsjqozVV65tZFEAkoqZlO3ecX7y7UTMdUjI+wS/XMpX
         9nHA==
X-Gm-Message-State: AOAM533gS/g2V5QMWzdoEcSlv0LPsl+cqj9j/BfwGXwG5i/fGmxXyPNa
        +1WknPOix7qM3b/8HmzJVO6Bs9BGQlYIQwFbQnGv
X-Google-Smtp-Source: ABdhPJzz5lNpNpxvFaRpKv3gn84Ku8yr5VVSXLMhtrqrByBsncrWUIYtdGNZ//e3YabtiKup95M88KHvNBQiw49d1zg=
X-Received: by 2002:a17:906:5205:: with SMTP id g5mr2098362ejm.488.1598625356901;
 Fri, 28 Aug 2020 07:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRtTykJVze_93ed+n+v14Ai9J5Mbre9nGEc2rkqbqKc_g@mail.gmail.com>
 <20200828135523.12867-1-alex.dewar90@gmail.com>
In-Reply-To: <20200828135523.12867-1-alex.dewar90@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Aug 2020 10:35:45 -0400
Message-ID: <CAHC9VhSTqJ9YF4CP=U9xhP15j_-yEf5JnGFcxpu_NZfnxijP2w@mail.gmail.com>
Subject: Re: [PATCH v2] netlabel: remove unused param from audit_log_format()
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 9:56 AM Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> Commit d3b990b7f327 ("netlabel: fix problems with mapping removal")
> added a check to return an error if ret_val != 0, before ret_val is
> later used in a log message. Now it will unconditionally print "...
> res=1". So just drop the check.
>
> Addresses-Coverity: ("Dead code")
> Fixes: d3b990b7f327 ("netlabel: fix problems with mapping removal")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
> v2: Still print the res field, because it's useful (Paul)
>
>  net/netlabel/netlabel_domainhash.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thanks Alex.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_domainhash.c b/net/netlabel/netlabel_domainhash.c
> index f73a8382c275e..dc8c39f51f7d3 100644
> --- a/net/netlabel/netlabel_domainhash.c
> +++ b/net/netlabel/netlabel_domainhash.c
> @@ -612,9 +612,8 @@ int netlbl_domhsh_remove_entry(struct netlbl_dom_map *entry,
>         audit_buf = netlbl_audit_start_common(AUDIT_MAC_MAP_DEL, audit_info);
>         if (audit_buf != NULL) {
>                 audit_log_format(audit_buf,
> -                                " nlbl_domain=%s res=%u",
> -                                entry->domain ? entry->domain : "(default)",
> -                                ret_val == 0 ? 1 : 0);
> +                                " nlbl_domain=%s res=1",
> +                                entry->domain ? entry->domain : "(default)");
>                 audit_log_end(audit_buf);
>         }
>
> --
> 2.28.0
>


-- 
paul moore
www.paul-moore.com

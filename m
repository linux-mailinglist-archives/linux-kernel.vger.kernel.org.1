Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC382A0B48
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgJ3QfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3QfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:35:06 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4841FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:35:05 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id t67so1576096vkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rnjsk8TKQUAdnwhwPXz/u9B966+7wes/L6l2QbLyXdg=;
        b=q4e/hQc/N29fRXAYE3G4wTsy/UxTBUrcWIh/R8j8wcsjUJeq7bIHiiWs/M/OpgsETY
         wpGe/uyos13lkcL9uM/UZB62fiCuSVaSixMCfBHAXPuAXGI7LLpbSUIFp7dpqn2SIzqg
         EL+qKVq0PVv0qU21DJctbxqx+2cl7EKf7ogHdYfM7HednRek17cscQUDjWvnWjU9eSpe
         DqH+hqfEYDXgCugEKiiJhsXOlhJOhBysuyCobBn8j4jmsHrSZ+qyO0kSl3O2dsIwmOLk
         ayxNSplxahD7dvHSi0pTjoM0aZ5r4R3rrdkRnGtuPgxJPen48gVaa018ysjpCifRBIEO
         hZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rnjsk8TKQUAdnwhwPXz/u9B966+7wes/L6l2QbLyXdg=;
        b=BiFhu3oyXXHeqLVSdSIPm9XDFoTlE/ozlIaKlhXpx0hmVi4iJ2UF8io8/uTwdhQvl5
         mYkK+gNJlm5GaV8maUytuRCF2K8mW8sgJdOQ8WRqyGRObXw97UUi6/ksTWg9d7Jg6d7G
         nXeZmPJfzZ+hZpSlUOmzf8xjoFZjXGUsPtqPFYcx/UVB6lyT9e3buwnXd2bdPfFj7EP2
         z9PcaEPu83TC9BZAiidhxB/ZN3e3vbEnfWp14z+NcIKAZJj++ouS10tDt50uCPokdlzV
         M8ue/Xk1l7FQqpjEaeLoJkDPOc0FmUMjSbMkwLPYFCDAJ9WvnbWPz5/e2TS0XTLDXcR3
         22lg==
X-Gm-Message-State: AOAM531QcLSKHNTwbVQOZddV913RkUkRBlK6uJXgI2wM5ZF7vK3gqy6q
        RUiuTfnC/GFIr8FbEqA4GHRphUIC2nk=
X-Google-Smtp-Source: ABdhPJyjZAK/23BOz3vMvD3TLt61E+uGGBJWKCajszu64STczXq12VnC/TlLWyjGLrqUqeB4cnMgYw==
X-Received: by 2002:ac5:c84f:: with SMTP id g15mr7981505vkm.11.1604075703784;
        Fri, 30 Oct 2020 09:35:03 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id z1sm773822vka.37.2020.10.30.09.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 09:35:01 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id d19so3713408vso.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:35:01 -0700 (PDT)
X-Received: by 2002:a67:b607:: with SMTP id d7mr8309389vsm.28.1604075701177;
 Fri, 30 Oct 2020 09:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201030022839.438135-1-xie.he.0141@gmail.com> <20201030022839.438135-2-xie.he.0141@gmail.com>
In-Reply-To: <20201030022839.438135-2-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 30 Oct 2020 12:34:25 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdeP7n1eQU2L2qSCEdJVc=Ezs+PvCof+YJfDjiEFZeH_w@mail.gmail.com>
Message-ID: <CA+FuTSdeP7n1eQU2L2qSCEdJVc=Ezs+PvCof+YJfDjiEFZeH_w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/5] net: hdlc_fr: Simpify fr_rx by using
 "goto rx_drop" to drop frames
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

On Thu, Oct 29, 2020 at 10:31 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> 1.
> When the fr_rx function drops a received frame (because the protocol type
> is not supported, or because the PVC virtual device that corresponds to
> the DLCI number and the protocol type doesn't exist), the function frees
> the skb and returns.
>
> The code for freeing the skb and returning is repeated several times, this
> patch uses "goto rx_drop" to replace them so that the code looks cleaner.
>
> 2.
> Add code to increase the stats.rx_dropped count whenever we drop a frame.
> Increase the stats.rx_dropped count both after "goto rx_drop" and after
> "goto rx_error" because I think we should increase this value whenever an
> skb is dropped.

In general we try to avoid changing counter behavior like that, as
existing users
may depend on current behavior, e.g., in dashboards or automated monitoring.

I don't know how realistic that is in this specific case, no strong
objections. Use
good judgment.

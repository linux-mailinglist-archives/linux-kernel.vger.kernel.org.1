Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E12A0B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgJ3QaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3QaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:30:06 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A19AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:30:06 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b129so3730795vsb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4poLgQBGdsSGDvNJLaT7Dlzjhi4aYmy6o/Lmtq6/qVo=;
        b=G4SLnL2eYkkiwoS7P5qeqcyMAzOSrF7xu1naInh5Whz77s8PuMbGResfIRFeAqs5HJ
         /VkMR0vIeT4WKeSU1i4COT9QPAiSZ4oVvUpT2wzY7oixSMC9nmmkNaPHEF3CYQQy1Y47
         36G91EPoARQdMg1Uzu56UHpM8f3VUJfnB7DVvHmhR9LwZa4jq7xDB3fvj3fJwiPxqhBj
         CmSKk09dFWYW665Rs1FssjrE0KbkX0/+3HgMCpkTPo8JOU1nipMuFCAzAKXm1vz37/7N
         YQeOJ7+q4fp/5MMt3A/d4J9jWGHTVAgPe+18PHcL4VwRaVOAgvtwrNsknPAYCAiPh9dl
         H7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4poLgQBGdsSGDvNJLaT7Dlzjhi4aYmy6o/Lmtq6/qVo=;
        b=Ud9bKLlMM6M3Ill5KOm8SI3XXCNULm6yjjgtxLkkSdE9pR/1RTYJ5h8gjDzogWDDNt
         PqswrmL5TBm/YErrAIchMBEfDsOBACt4oqyIiwMPZHhJNUeHdM1tksDZNQinEVumxXpr
         VL4LPTmV0sso/YdSS+g9IdP93YHMYqmHOMU0j2irVDyAYDr7NtqbHZ8PWgnfDkBjBg4M
         1EP1NilUmrsbdE+zJCtW8sQlsJe+swi5BvhrJjAGfa7e0wrVDOUfRQQLetfCdW1Z9UaQ
         oPWcCqqdtqqcaUO7mOM7qHpeTJOa4R+CTtRxVS4cWTqnQijUMi9zOry0FVR01nTX1LFz
         6M7g==
X-Gm-Message-State: AOAM533dsCIeJaIhez6X58oNB6U9/icR4e4nXbKkGwL4hjcRxaB55TV+
        reTX0Hb6LTeEk005X2Fzp3uatULy/eE=
X-Google-Smtp-Source: ABdhPJwp/TDacnViK9926J9Hda584S66QFzj+UbZxeVQqVWvEweAKgRUrc+px944hx0/4EtmniFnow==
X-Received: by 2002:a67:7704:: with SMTP id s4mr7664609vsc.51.1604075405127;
        Fri, 30 Oct 2020 09:30:05 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id g123sm806830vsg.5.2020.10.30.09.30.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 09:30:04 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id 91so1897017uar.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:30:04 -0700 (PDT)
X-Received: by 2002:ab0:5447:: with SMTP id o7mr2256444uaa.37.1604075403498;
 Fri, 30 Oct 2020 09:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201030022839.438135-1-xie.he.0141@gmail.com> <20201030022839.438135-5-xie.he.0141@gmail.com>
In-Reply-To: <20201030022839.438135-5-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 30 Oct 2020 12:29:26 -0400
X-Gmail-Original-Message-ID: <CA+FuTSczR03KGNdksH2KyAyzoR9jc6avWNrD+UWyc7sXd44J4w@mail.gmail.com>
Message-ID: <CA+FuTSczR03KGNdksH2KyAyzoR9jc6avWNrD+UWyc7sXd44J4w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/5] net: hdlc_fr: Do skb_reset_mac_header for
 skbs received on normal PVC devices
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

On Thu, Oct 29, 2020 at 10:33 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> When an skb is received on a normal (non-Ethernet-emulating) PVC device,
> call skb_reset_mac_header before we pass it to upper layers.
>
> This is because normal PVC devices don't have header_ops, so any header we
> have would not be visible to upper layer code when sending, so the header
> shouldn't be visible to upper layer code when receiving, either.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Should this go to net if a bugfix though?

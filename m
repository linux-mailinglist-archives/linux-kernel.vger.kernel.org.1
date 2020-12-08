Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7722D2566
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgLHIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:08:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgLHIIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:08:06 -0500
X-Gm-Message-State: AOAM532Jgrpn7EJ0DVfFqdaQuSBQEhO+r35BuAEXcGLV4tkmo/+2Zk3X
        RfnNwc1Ygoj28LN8aXNcvl59gu/SC0mRZDKFwCc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607414844;
        bh=otTg+c7QAXplE6PaI0eJSpQO1lpgIBn9zZvXDfCTp7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r8m4HfisAwjB45X+LRbPQ9W/t+iLgz/0Z85RjYBwrevUpn09p96sNjrSM/oou5zPG
         SQAd+kkfVg0Sdof7okZnCo6MZtQwNgVuz0EVMSJUpcdvhOGjPKtGLQfBAM7vZ11rRr
         ePH0rfhKquOaJBfZQDa3JYWU5vmRZ02w9svCOuQwR3K5UCLYfIqJhx8WYSkn2P11si
         7+/6Z/mfr0ReT4+EgF8P5m/GdfuRGLy8tbr58HiI0HfT5DBHkLAOrlKdi80bKzfzxY
         dRAbVqNQoYX9C81ibekd/QOlczTzNNYGZkt92txyG5c/zbzryMfMxUhM+yNYcszGNJ
         SZM9ntjKBx41Q==
X-Google-Smtp-Source: ABdhPJyhseclVDLIl2PazioASpQ8u3nu109+YNAG72MwwAO2zS/lbV7787tNxCKpN2kQAyRBktlv/wagXIFcRq6Ua9c=
X-Received: by 2002:a50:ce48:: with SMTP id k8mr23429672edj.298.1607414843195;
 Tue, 08 Dec 2020 00:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20201208043700.23098-1-quan@os.amperecomputing.com>
 <20201208043700.23098-2-quan@os.amperecomputing.com> <CACPK8Xcs6ED5C_2RHrG0Bipn8sjPK7yBjcYvJ=UT6w2SRm0swQ@mail.gmail.com>
In-Reply-To: <CACPK8Xcs6ED5C_2RHrG0Bipn8sjPK7yBjcYvJ=UT6w2SRm0swQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 8 Dec 2020 09:07:10 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcu_KZq=e4DmerA_Td6ZHtmM=A6ShXfFzrQCasd8-Kxsg@mail.gmail.com>
Message-ID: <CAJKOXPcu_KZq=e4DmerA_Td6ZHtmM=A6ShXfFzrQCasd8-Kxsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add an entry for AmpereComputing.com
To:     Joel Stanley <joel@jms.id.au>
Cc:     Quan Nguyen <quan@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 05:41, Joel Stanley <joel@jms.id.au> wrote:
>
> Hello Rob,
>
> On Tue, 8 Dec 2020 at 04:37, Quan Nguyen <quan@os.amperecomputing.com> wrote:
> >
> > Add "ampere" entry for Ampere Computing LLC: amperecomputing.com
> >
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> > Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
> > Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>

It's the first version of the series already with Review tags. Please
post them on the list, not off-list.

Best regards,
Krzysztof

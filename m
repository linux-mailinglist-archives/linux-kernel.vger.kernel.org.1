Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAE204C31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgFWIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 04:20:35 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:25016 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:20:34 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 05N8KED6021639;
        Tue, 23 Jun 2020 17:20:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 05N8KED6021639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592900415;
        bh=2TgpWQTruL68H7/iYdgebre7YRp3EgzuK6hYjj7Ri1E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JKAbx5yQ2PFuDPV65HCXXGdLSyT/cYeUFMuvKDWOZvCcHk5emJIfKiV+v55otpg/S
         qz45yinqZdTgFnU8fhCqhMGu2f9pLXtmEMXqBD380IXHr+wDYayis8+V/DH7+OP6jn
         1YR/Yvx+HgxJx7zjL5NFWW6/oD6kPQGq7mGbc7KlWX4zRsigl8qImXpjtcYnaCZ2i6
         sDoC3Dp8oJcjMazSq7rCO8AUEY45oKkCOksVMua2Abp9kY5Cx1VUE0KVygIVXi9bvh
         MEv2JyPRKlcwhLDkQcaAPaMySlxLpT/aoLzmR/fMRSEmilLZgetISEQJt/5OCoYbVa
         ZbmLrJCWwDVbg==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id r1so6521923uam.6;
        Tue, 23 Jun 2020 01:20:15 -0700 (PDT)
X-Gm-Message-State: AOAM533uPN2zm6UAfQnbiPD9cxbVJ/uC3WWZXrhbFEZFBN6InCwkmGkE
        THVhknd90LPFhmZMkUpNpqcHm30Oo8ZDDdz+Lsg=
X-Google-Smtp-Source: ABdhPJy69sOd6U4zZ0b7Utt3iuVR5XBWumRclatWKTtVIvHx4q9Id+gbDjsNKoKm0ZAb2I8MM8C5vAqDDZEvI7oie8M=
X-Received: by 2002:ab0:156d:: with SMTP id p42mr14402383uae.121.1592900413813;
 Tue, 23 Jun 2020 01:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200622120320.454535-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200622120320.454535-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 Jun 2020 17:19:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqJZ2oJwxmvObcYGn2srwjENzc6nHSGHULyqWONbTWVA@mail.gmail.com>
Message-ID: <CAK7LNASqJZ2oJwxmvObcYGn2srwjENzc6nHSGHULyqWONbTWVA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ASoC: Convert UniPhier EVEA codec to json-schema
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        - <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 9:04 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Convert the UniPhier EVEA sound codec binding to DT schema format.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

'additionalProperties: false' is emitting a warning.

I will add patternProperties
to take care of sub-nodes.

I will submit v2.




-- 
Best Regards
Masahiro Yamada

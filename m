Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CA267AC2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgILOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 10:11:35 -0400
Received: from crapouillou.net ([89.234.176.41]:34372 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgILOL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 10:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599919885; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQijmfnvg3UR0Um86vQ7Wg9AGguLzSf/LgNFa86K0NI=;
        b=vcRL1wOSXm2t51tFJKBFmd88KxTrt9HW5cZ322xf8NX2fNlaKhEgKAd0RPf7n1OnlMUOYP
        tDraUvjJeLZtOAtEZKflsRKzYOw5WzlT8KrOC0Q71JRhA0oO7hc4+8w0PkV2x1mSIFm+gp
        +1A7jOj+k37hidqO3rb3R6Si3lMXagg=
Date:   Sat, 12 Sep 2020 16:11:15 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 0/3] pinctrl: Ingenic: Add support for SSI and I2S
 pins.
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-kernel@vger.kernel.org
Message-Id: <R2UJGQ.OBF3BSB45X872@crapouillou.net>
In-Reply-To: <CACRpkdYGg_w2wzw7T0PHjEomkqFn8Jw4bTzfovi5qT0qdScMvw@mail.gmail.com>
References: <20200912060425.30423-1-zhouyanjie@wanyeetech.com>
        <CACRpkdYGg_w2wzw7T0PHjEomkqFn8Jw4bTzfovi5qT0qdScMvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam. 12 sept. 2020 =C3=A0 12:31, Linus Walleij=20
<linus.walleij@linaro.org> a =C3=A9crit :
> On Sat, Sep 12, 2020 at 8:05 AM =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)
> <zhouyanjie@wanyeetech.com> wrote:
>=20
>>  1.Add SSI pins support for JZ4770 and JZ4780.
>>  2.Correct the pullup and pulldown parameters of JZ4780.
>>  3.Add I2S pins support for JZ4780, X1000, X1500, and X1830.
>>=20
>>  v2->v3:
>>  1.Add Paul Cercueil's Reviewed-by.
>>  2.Fix bug about PE15's pull-up parameter.
>=20
> This looks good to me, I'm just waiting for Paul to look at patches=20
> 2&3
> before applying.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
for the patchset.

Cheers,
-Paul



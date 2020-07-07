Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22604216AC2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGKtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 06:49:40 -0400
Received: from crapouillou.net ([89.234.176.41]:55324 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGKtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594118977; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmDFVd32HVWpn2fLFFX5aBkZfhcHoubKvi/z02gqnBE=;
        b=YPAO/bHbTjq1Sm6NWJD8vbC8leRKZZL/co7H4rMR+AnM+37r3oae3RMy+uH+OcA1rBYg8P
        9WH4Y0Qvg9vKpEU8UWt0zuX1MiDJh76iM5kL9ogH3jbYSWZvadOzV5qsGOmc1Q0iB5Ocu5
        CRije11Vqkq6KZB8MabZLVMumce5eJQ=
Date:   Tue, 07 Jul 2020 12:49:27 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/2] remoteproc: Address runtime PM issues
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <F2I3DQ.SZMCCDC0DNAD3@crapouillou.net>
In-Reply-To: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
References: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mar. 30 juin 2020 =E0 10:31, Mathieu Poirier=20
<mathieu.poirier@linaro.org> a =E9crit :
> This set follows the conversation that took place here[1] and provides
> the "two small patches" I alluded to at the end of the thread.
>=20
> Paul Cercueil: patch 1/2 is compile tested only - please see that it=20
> does what
> you want.

Still works fine, so
Tested-by: Paul Cercueil <paul@crapouillou.net>

for the patchset.

Cheers,
-Paul

> Suman Anna: Please test on your side and confirm that it addresses=20
> the Omap
> regression.
>=20
> Applies on top of rproc-next (7dcef3988eed)
>=20
> Thanks,
> Mathieu
>=20
> [1].=20
> https://lore.kernel.org/linux-remoteproc/20200515104340.10473-1-paul@crap=
ouillou.net/T/#t
>=20
> Mathieu Poirier (2):
>   remoteproc: ingenic: Move clock handling to prepare/unprepare
>     callbacks
>   Revert "remoteproc: Add support for runtime PM"
>=20
>  drivers/remoteproc/ingenic_rproc.c   | 84=20
> +++++++++-------------------
>  drivers/remoteproc/remoteproc_core.c | 17 +-----
>  2 files changed, 27 insertions(+), 74 deletions(-)
>=20
> --
> 2.25.1
>=20



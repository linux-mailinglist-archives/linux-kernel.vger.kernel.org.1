Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E624B9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgHTL4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 07:56:41 -0400
Received: from crapouillou.net ([89.234.176.41]:42706 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730390AbgHTKBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597917659; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZ1aMw4lvJahkoTFq2FFLEt9GQawdnpulWYLFZqCcMI=;
        b=UFZKro6KaDQ9ml70bbNu3O4Mjp2etrD66dnyQ312JOIm4c4mEybPicCWABORNGdkpKqzUL
        +UKYYSpHlCyPVqwAqaeBdavWinJaZDosLTXRKNV0sCQBhxdUkXUn7D9GwvUdSJVRzrZhEv
        wWd8deIFN08zwF24mWqdT9hEVjf1ubc=
Date:   Thu, 20 Aug 2020 12:00:49 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] irqchip: ingenic: Leave parent IRQ unmasked on suspend
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, od@zcrc.me,
        linux-kernel@vger.kernel.org
Message-Id: <D5XCFQ.0D6NUX6G5VQ3@crapouillou.net>
In-Reply-To: <b7b89ed757b6731198c14f8561696b20@kernel.org>
References: <20200819180602.136969-1-paul@crapouillou.net>
        <b7b89ed757b6731198c14f8561696b20@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Le jeu. 20 ao=FBt 2020 =E0 9:08, Marc Zyngier <maz@kernel.org> a =E9crit :
> On 2020-08-19 19:06, Paul Cercueil wrote:
>> All the wakeup sources we possibly want will go through the interrupt
>> controller, so the parent IRQ must not be masked during suspend, or
>> there won't be any way to wake up the system.
>>=20
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Do you have a Fixes: tag? Does it need to be Cc: to stable?

The driver never had it since its creation, so I'm not sure it needs a=20
Fixes: tag.

Cheers,
-Paul

> Thanks,
>=20
>         M.
> --
> Jazz is not dead. It just smells funny...



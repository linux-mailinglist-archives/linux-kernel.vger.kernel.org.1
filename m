Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36764302C16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbhAYT5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:57:11 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:61744 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732217AbhAYTvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:51:51 -0500
Date:   Mon, 25 Jan 2021 19:51:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1611604266;
        bh=1i50DHdnjoUdfBxl3eUpbTkwSSkXROepRq6IW5akcvI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=yCMOmDP5+Bt8/JHfaO127wOhTOFBmtU77nwYq0c95kEGOgRMnB88aOpT1KJBaPEmA
         XiRrxkQrDjwqGmKEmHmbBSO5I/BcjPaZPU8AAJFRnmhBb9l3qCZLt6U0kgXbMyPHQm
         ipNPSHrbdrJ2ISF9/UmwPa8faoEgJ1rzB9cFsJsk=
To:     Lee Jones <lee.jones@linaro.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH] mfd: max8997: Replace 8998 with 8997
Message-ID: <20210125205059.4773adfc.timon.baetz@protonmail.com>
In-Reply-To: <20210125084347.GU4903@dell>
References: <20210124170528.1230932-1-timon.baetz@protonmail.com> <20210125084347.GU4903@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 08:43:47 +0000, Lee Jones wrote:
> On Sun, 24 Jan 2021, Timon Baetz wrote:
>=20
> > Replace occurrences of 8998 with 8997. =20
>=20
> Because ...

... it is the max8997 header. Do you want me to extend the commit
message?

Thanks,
Timon


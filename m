Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8441B2B16E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgKMIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgKMIDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:03:14 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B6620857;
        Fri, 13 Nov 2020 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605254593;
        bh=wtJt7F4vlmce/drFU3S1eZEo8CDrUYp19bWjAusZv6w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZEe502JBSE7qHDdEPozczkESUGdTlv1PgE+53xICs34OJ7bBp4hJc0k1aiUbJ39FZ
         lUjxBIxmVL4gwzxX0qkHPMo5V/PGDO+PJlRQOqeFG3G8TEMhRAmeXlvVQQfe7jhA5k
         9X7YQPKCdseRfzGBWjKYE5wKpofYR53zZ69cUU40=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b18625cf-7dd0-db96-9460-bb0ff920b5db@topic.nl>
References: <20201103141741.2511-1-mike.looijmans@topic.nl> <160454088987.3965362.6147280271557523496@swboyd.mtv.corp.google.com> <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.e888d4ad-6d00-4e78-a0c7-083be5e86c8e@emailsignatures365.codetwo.com> <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.9c2cb1f3-6c6b-4005-b459-f71a0d72128e@emailsignatures365.codetwo.com> <b18625cf-7dd0-db96-9460-bb0ff920b5db@topic.nl>
Subject: Re: [PATCH] clk-si5341: Support NVM programming through sysfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-kernel@vger.kernel.org
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
Date:   Fri, 13 Nov 2020 00:03:12 -0800
Message-ID: <160525459234.60232.7901604955432682238@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2020-11-05 01:06:54)
> On 05-11-2020 02:48, Stephen Boyd wrote:
> > Quoting Mike Looijmans (2020-11-03 06:17:41)
> >> Export an attribute program_nvm_bank that when read reports the current
> >> bank value. To program the chip's current state into NVM, write the
> >> magic value 0xC7 into this attribute.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >> ---
> >=20
> > Any chance this can be done through the nvmem framework?
>=20
> This part doesn't fit. The purpose is to store the current state of the c=
lock=20
> chip into its non-volatile storage so it boots up with that configuration=
 the=20
> next POR. Main use case is that some vendors initialize PLLs only in a=20
> bootloader and thus need the clock running at boot. Or it might just be t=
o=20
> save on that 300ms initialization time.

Can these details be put in the commit text? It would go a long way
towards helping reviewers understand the motivation if it is to speed up
boot and stash away clk configuration across resets. Why is userspace
involved? Why can't the driver write to the non-volatile storage with
shutdown or reboot driver hooks instead of implementing a bespoke sysfs
ABI?

>=20
> Having said that, the clock chip does have some "scratch" areas that'd be=
=20
> useful as NVMEM storage. That'd be for a separate patch.
>=20
> For this device to be NVMEM compatible, nvmem would need to have a sort o=
f=20
> transaction model, where you write several values and then "commit" them =
all=20
> to NVM in one call. The nvmem framework wasn't intended for that I think.

I suppose patches could be written to support that if desired.

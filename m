Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4461A7ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501898AbgDNM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 08:26:21 -0400
Received: from dd10228.kasserver.com ([85.13.133.23]:55672 "EHLO
        dd10228.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440100AbgDNMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:25:43 -0400
Received: from devpool17.fritz.box (ip1f107c11.dynamic.kabel-deutschland.de [31.16.124.17])
        by dd10228.kasserver.com (Postfix) with ESMTPSA id 0940F6CC00F4;
        Tue, 14 Apr 2020 14:25:41 +0200 (CEST)
From:   Philipp Puschmann <p.puschmann@pironex.de>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, cernekee@chromium.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        nhuck@google.com, p.puschmann@pironex.de, tglx@linutronix.de
Subject: Re: Re: [PATCH] ASoC: tas571x: disable regulators on failed probe
Date:   Tue, 14 Apr 2020 14:25:40 +0200
Message-Id: <20200414122540.3367658-1-p.puschmann@pironex.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414113635.GD5412@sirena.org.uk>
References: <20200414113635.GD5412@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> If probe fails after enabling the regulators regulator_put is called for
>> each supply without having them disabled before. This produces some
>> warnings like
>>=20
>> WARNING: CPU: 0 PID: 90 at drivers/regulator/core.c:2044 _regulator_put.part.0+0x154/0x15c
>> [<c010f7a8>] (unwind_backtrace) from [<c010c544>] (show_stack+0x10/0x14)
>> [<c010c544>] (show_stack) from [<c012b640>] (__warn+0xd0/0xf4)
>> [<c012b640>] (__warn) from [<c012b9b4>] (warn_slowpath_fmt+0x64/0xc4)
>> [<c012b9b4>] (warn_slowpath_fmt) from [<c04c4064>] (_regulator_put.part.0+0x154/0x15c)
>
>Please think hard before including complete backtraces in upstream
>reports, they are very large and contain almost no useful information
>relative to their size so often obscure the relevant content in your
>message. If part of the backtrace is usefully illustrative (it often is
>for search engines if nothing else) then it's usually better to pull out
>the relevant sections.

You are right. I will take care next time.

Regards,
Philipp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD51E127F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgEYQR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 12:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgEYQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:17:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63127C061A0E;
        Mon, 25 May 2020 09:17:27 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DD40A2DC;
        Mon, 25 May 2020 16:17:26 +0000 (UTC)
Date:   Mon, 25 May 2020 10:17:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/features: Refresh the arch support status
 files
Message-ID: <20200525101725.346088a7@lwn.net>
In-Reply-To: <20200523191135.21889-1-bjorn.topel@gmail.com>
References: <20200523191135.21889-1-bjorn.topel@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 May 2020 21:11:35 +0200
Björn Töpel <bjorn.topel@gmail.com> wrote:

> I was manually editing the arch-support.txt for eBPF-JIT, when I
> realized the refresh script [1] has not been run for a while. Let's
> fix that, so that the entries are more up-to-date.
> 
> [1] Documentation/features/scripts/features-refresh.sh
> 
> Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>

Applied, thanks.

jon

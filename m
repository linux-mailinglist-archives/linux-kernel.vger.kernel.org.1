Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADB82B27E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKMWI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:08:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:50976 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgKMWIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:08:54 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 26D8B734;
        Fri, 13 Nov 2020 22:08:54 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:08:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: mtd: spi-nor: Fix formatting of text vs. diagrams
Message-ID: <20201113150853.37224ca1@lwn.net>
In-Reply-To: <20201107183902.1182809-1-j.neuschaefer@gmx.net>
References: <20201107183902.1182809-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Nov 2020 19:39:01 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Corrently, all diagrams below "Before this framework, the layer is like"
> and the text in between are rendered as one monospace text block.
> Instead, each individual diagram should be a monospace text block.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/driver-api/mtd/spi-nor.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

jon

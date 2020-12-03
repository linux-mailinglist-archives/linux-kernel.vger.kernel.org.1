Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B6F2CE23C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgLCW4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLCW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:56:00 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03896C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:55:20 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BFF2D24D3;
        Thu,  3 Dec 2020 22:55:19 +0000 (UTC)
Date:   Thu, 3 Dec 2020 15:55:18 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix typos found in process, dev-tools,
 and doc-guide subdirectories
Message-ID: <20201203155518.1d7bd1ac@lwn.net>
In-Reply-To: <20201202075438.GA35516@spblnx124.lan>
References: <20201202075438.GA35516@spblnx124.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 10:54:38 +0300
Andrew Klychkov <andrew.a.klychkov@gmail.com> wrote:

> Fix four typos in kcov.rst, sphinx.rst, clang-format.rst, and embargoed-hardware-issues.rst
> 
> Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
> ---
>  Documentation/dev-tools/kcov.rst                    | 2 +-
>  Documentation/doc-guide/sphinx.rst                  | 2 +-
>  Documentation/process/clang-format.rst              | 2 +-
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon

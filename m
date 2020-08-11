Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88249241EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgHKQwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgHKQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:52:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF21C06174A;
        Tue, 11 Aug 2020 09:52:04 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F13E131A;
        Tue, 11 Aug 2020 16:52:03 +0000 (UTC)
Date:   Tue, 11 Aug 2020 10:52:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-doc@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc/zh_CN: resolve undefined label warning in
 admin-guide index
Message-ID: <20200811105202.058c5068@lwn.net>
In-Reply-To: <20200802161956.18268-1-lukas.bulwahn@gmail.com>
References: <20200802161956.18268-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  2 Aug 2020 18:19:56 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Documentation generation warns:
> 
>   Documentation/translations/zh_CN/admin-guide/index.rst:3:
>   WARNING: undefined label: documentation/admin-guide/index.rst
> 
> Use doc reference for .rst files to resolve the warning.
> 
> Fixes: 37a607cf2318 ("doc/zh_CN: add admin-guide index")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied, thanks.

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ECD21DA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgGMPk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:40:56 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99D3C061755;
        Mon, 13 Jul 2020 08:40:56 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8887E60C;
        Mon, 13 Jul 2020 15:40:56 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:40:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: yama: Swap HTTP for HTTPS and replace dead link
Message-ID: <20200713094055.2fa4d033@lwn.net>
In-Reply-To: <202007091141.C008B89EC@keescook>
References: <202007091141.C008B89EC@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 11:51:35 -0700
Kees Cook <keescook@chromium.org> wrote:

> Replace one dead link for the same person's original presentation on the
> topic and swap an HTTP URL with HTTPS. While here, linkify the text to
> make it more readable when rendered.
> 
> Link: https://lore.kernel.org/lkml/20200708073346.13177-1-grandmaster@al2klimov.de/
> Co-developed-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
> - replace storm.net.nz url (kees)
> - refactor with descriptive text (kees)
> v1: https://lore.kernel.org/lkml/20200708073346.13177-1-grandmaster@al2klimov.de/
> ---
>  Documentation/admin-guide/LSM/Yama.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

jon

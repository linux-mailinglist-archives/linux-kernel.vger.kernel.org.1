Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927C4214F25
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 22:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGEUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 16:05:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:51496 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgGEUFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:05:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9B4A92E2;
        Sun,  5 Jul 2020 20:05:03 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:05:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Clarify f_cred vs current_cred() use
Message-ID: <20200705140502.07bfc8bc@lwn.net>
In-Reply-To: <202007031038.8833A35DE4@keescook>
References: <202007031038.8833A35DE4@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 10:44:22 -0700
Kees Cook <keescook@chromium.org> wrote:

> When making access control choices from a file-based context, f_cred
> must be used instead of current_cred() to avoid confused deputy attacks
> where an open file may get passed to a more privileged process. Add a
> short paragraph to explicitly state the rationale.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I forgot to include this patch in my kallsyms_show_value() f_cred series:
> https://lore.kernel.org/lkml/20200702232638.2946421-1-keescook@chromium.org/
> I can either take this in that series, or it can go via docs?
> ---
>  Documentation/security/credentials.rst | 4 ++++
>  1 file changed, 4 insertions(+)

I've applied it, thanks.

jon

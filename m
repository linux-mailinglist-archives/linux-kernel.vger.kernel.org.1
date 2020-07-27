Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D2822FC35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 00:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgG0WcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 18:32:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:58038 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0WcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:32:10 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 22D8C2E7;
        Mon, 27 Jul 2020 22:32:10 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:32:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] Input: fix typo in function name documentation
Message-ID: <20200727163208.4e956816@lwn.net>
In-Reply-To: <20200724084025.GB31930@amd>
References: <20200724084025.GB31930@amd>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 10:40:25 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Fix non-existing constant in documentation.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> 
> diff --git a/Documentation/input/uinput.rst b/Documentation/input/uinput.rst
> index b8e90b6a126c..10c62e62a0a6 100644
> --- a/Documentation/input/uinput.rst
> +++ b/Documentation/input/uinput.rst
> @@ -99,7 +99,7 @@ the sake of simplicity.
>  
>        /*
>         * Give userspace some time to read the events before we destroy the
> -       * device with UI_DEV_DESTOY.
> +       * device with UI_DEV_DESTROY.
>         */
>        sleep(1);

Seems good...Dmitry, do you want this, or would you rather I picked it up?

Thanks,

jon
